#!/usr/bin/python
# -*- coding: UTF-8 -*-

import json
import logging
import socket
import sys
import time
import urllib
import urllib2

import config
import cymysql


class DbTransfer(object):
    instance = None

    def __init__(self):
        self.last_get_transfer = {}

    @staticmethod
    def get_instance():
        if DbTransfer.instance is None:
            DbTransfer.instance = DbTransfer()
        return DbTransfer.instance

    @staticmethod
    def send_command(cmd):
        data = ''
        try:
            cli = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            cli.settimeout(1)
            cli.sendto(cmd, ('%s' % (config.MANAGE_BIND_IP), config.MANAGE_PORT))
            data, addr = cli.recvfrom(1500)
            cli.close()
            # TODO: bad way solve timed out
            time.sleep(0.05)
        except:
            logging.warn('send_command response')
        return data

    @staticmethod
    def get_servers_transfer():
        dt_transfer = {}
        cli = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        cli.settimeout(2)
        cli.sendto('transfer: {}', ('%s' % (config.MANAGE_BIND_IP), config.MANAGE_PORT))
        bflag = False
        while True:
            data, addr = cli.recvfrom(1500)
            if data == 'e':
                break
            data = json.loads(data)
            # print data
            dt_transfer.update(data)
        cli.close()
        return dt_transfer

    def push_db_all_user(self):
        dt_transfer = self.get_servers_transfer()

        if config.PANEL_VERSION == 'V2':
            import time
            query_head = 'UPDATE SS'
            query_sub_when = ''
            query_sub_when2 = ''
            query_sub_in = None
            last_time = time.time()
            for id in dt_transfer.keys():
                query_sub_when += ' WHEN %s THEN u+%s' % (id, 0)  # all in d
                query_sub_when2 += ' WHEN %s THEN d+%s' % (id, dt_transfer[id])
                if query_sub_in is not None:
                    query_sub_in += ',%s' % id
                else:
                    query_sub_in = '%s' % id
            if query_sub_when == '':
                return
            query_sql = query_head + ' SET u = CASE port' + query_sub_when + \
                        ' END, d = CASE port' + query_sub_when2 + \
                        ' END, t = ' + str(int(last_time)) + \
                        ' WHERE port IN (%s)' % query_sub_in
            # print query_sql
            conn = cymysql.connect(host=config.MYSQL_HOST, port=config.MYSQL_PORT, user=config.MYSQL_USER,
                                   passwd=config.MYSQL_PASS, db=config.MYSQL_DB, charset='utf8')
            cur = conn.cursor()
            cur.execute(query_sql)
            cur.close()
            conn.commit()
            conn.close()
        else:
            if config.PANEL_VERSION == 'V3':
                i = 0
                for id in dt_transfer.keys():
                    string = ' WHERE `port` = %s' % id
                    conn = cymysql.connect(host=config.MYSQL_HOST, port=config.MYSQL_PORT, user=config.MYSQL_USER,
                                           passwd=config.MYSQL_PASS, db=config.MYSQL_DB, charset='utf8')
                    cur = conn.cursor()
                    cur.execute('SELECT id FROM SS %s '
                                % (string))
                    rows = []
                    for r in cur.fetchall():
                        rows.append(list(r))
                    cur.close()
                    conn.close()
                    logging.info('port:%s ----> id:%s' % (id, rows[0][0]))
                    tran = str(dt_transfer[id])
                    data = {'d': tran, 'node_id': config.NODE_ID, 'u': '0'}
                    url = config.API_URL + '/users/' + str(rows[0][0]) + '/traffic?key=' + config.API_PASS
                    data = urllib.urlencode(data)
                    req = urllib2.Request(url, data)
                    response = urllib2.urlopen(req)
                    the_page = response.read()
                    logging.info('%s - %s - %s' % (url, data, the_page))
                    i += 1
                # online user count
                data = {'count': i}
                url = config.API_URL + '/nodes/' + config.NODE_ID + '/online_count?key=' + config.API_PASS
                data = urllib.urlencode(data)
                req = urllib2.Request(url, data)
                response = urllib2.urlopen(req)
                the_page = response.read()
                logging.info('%s - %s - %s' % (url, data, the_page))

                # load info
                url = config.API_URL + '/nodes/' + config.NODE_ID + '/info?key=' + config.API_PASS
                f = open("/proc/loadavg")
                load = f.read().split()
                f.close()
                loadavg = load[0]+' '+load[1]+' '+load[2]+' '+load[3]+' '+load[4]
                f = open("/proc/uptime")
                t = f.read().split()
                uptime = t[0]
                f.close()
                data = {'load': loadavg, 'uptime': uptime}
                data = urllib.urlencode(data)
                req = urllib2.Request(url, data)
                response = urllib2.urlopen(req)
                the_page = response.read()
                logging.info('%s - %s - %s' % (url, data, the_page))
            else:
                logging.warn('Not support panel version %s' % (config.PANEL_VERSION))
                return


    @staticmethod
    def pull_db_all_user():
        conn = cymysql.connect(host=config.MYSQL_HOST, port=config.MYSQL_PORT, user=config.MYSQL_USER,
                               passwd=config.MYSQL_PASS, db=config.MYSQL_DB, charset='utf8')
        cur = conn.cursor()
        cur.execute("SELECT port, u, d, transfer_enable, password, switch, enable, isrest, last_rest_time, expiration_time FROM SS")
        rows = []
        for r in cur.fetchall():
            rows.append(list(r))
        cur.close()
        conn.close()
        return rows

    @staticmethod
    def del_server_out_of_bound_safe(rows):
        import time
        for row in rows:
            server = json.loads(DbTransfer.get_instance().send_command('stat: {"server_port":%s}' % row[0]))
            now_time = time.time()
            if server['stat'] != 'ko':
                if row[5] == 0 or row[6] == 0:
                    # 状态检查
                    logging.info('db stop server at port [%s] reason: disable' % (row[0]))
                    DbTransfer.send_command('remove: {"server_port":%s}' % row[0])
                elif row[1] + row[2] >= row[3]:
                    # 流量检查
                    logging.info('db stop server at port [%s] reason: out bandwidth' % (row[0]))
                    DbTransfer.send_command('remove: {"server_port":%s}' % row[0])
                if server['password'] != row[4]:
                    # 密码更改
                    logging.info('db stop server at port [%s] reason: password changed' % (row[0]))
                    DbTransfer.send_command('remove: {"server_port":%s}' % row[0])
                if now_time > row[9]:
                    # 过期检查
                    logging.info('db stop server at port [%s] reason: expiration time' % (row[0]))
                    DbTransfer.send_command('remove: {"server_port":%s}' % row[0])
            else:
                if row[5] == 1 and row[6] == 1 and row[1] + row[2] < row[3]:
                    logging.info('db start server at port [%s] pass [%s]' % (row[0], row[4]))
                    DbTransfer.send_command('add: {"server_port": %s, "password":"%s"}' % (row[0], row[4]))

    @staticmethod
    def server_reset_traffic(rows):
        import time
        import datetime
        for row in rows:
            server = json.loads(DbTransfer.get_instance().send_command('stat: {"server_port":%s}' % row[0]))
            now_time = time.time()
            if server['stat'] != 'ko':
                if row[5] == 1 and row[6] == 1 and row[1] + row[2] < row[3] and server['password'] == row[4] and now_time > row[9] and row[7] == 1 and now_time > row[8]:
                    # 流量重置
                    last = datetime.datetime.now() + datetime.timedelta(days = 30)
                    last_time = time.mktime(last.timetuple())
                    conn = cymysql.connect(host=config.MYSQL_HOST, port=config.MYSQL_PORT, user=config.MYSQL_USER,
                               passwd=config.MYSQL_PASS, db=config.MYSQL_DB, charset='utf8')
                    cur = conn.cursor()
                    sql = 'UPDATE SS Set d = 0, last_rest_time = %s WHERE port = %s' % (last_time, row[0])
                    cur.execute(sql)
                    cur.close()
                    conn.close()
                    logging.info('reset traffic at port [%s] ' % (row[0]))
                      

    @staticmethod
    def thread_db():
        import socket
        import time
        timeout = 30
        socket.setdefaulttimeout(timeout)
        while True:
            logging.info('db loop')
            try:
                rows = DbTransfer.get_instance().pull_db_all_user()
                DbTransfer.del_server_out_of_bound_safe(rows) # 校验服务
            except Exception as e:
                import traceback
                traceback.print_exc()
                logging.warn('db thread except:%s' % e)
            finally:
                time.sleep(config.CHECKTIME)

    @staticmethod
    def thread_push():
        import socket
        import time
        timeout = 30
        socket.setdefaulttimeout(timeout)
        while True:
            logging.info('db loop2')
            try:
                DbTransfer.get_instance().push_db_all_user() # 同步流量
            except Exception as e:
                import traceback
                traceback.print_exc()
                logging.warn('db thread except:%s' % e)
            finally:
                time.sleep(config.SYNCTIME)
                
    @staticmethod
    def thread_reset():
        import socket
        import time
        timeout = 30
        socket.setdefaulttimeout(timeout)
        while True:
            logging.info('db loop3')
            try:
                rows = DbTransfer.get_instance().pull_db_all_user()
                DbTransfer.server_reset_traffic(rows) # 重置流量
            except Exception as e:
                import traceback
                traceback.print_exc()
                logging.warn('db thread except:%s' % e)
            finally:
                time.sleep(config.RESETTIME)
