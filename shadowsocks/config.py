import logging

#Config
MYSQL_HOST = '127.0.0.1'
MYSQL_PORT = 3306
MYSQL_USER = 'root'
MYSQL_PASS = 'oppzk'
MYSQL_DB = 'SSMM'

MANAGE_PASS = 'passwd'
#if you want manage in other server you should set this value to global ip
MANAGE_BIND_IP = '127.0.0.1'
#make sure this port is idle
MANAGE_PORT = 10001

PANEL_VERSION = 'V2' # V2 or V3. V2 not support API
API_URL = 'http://domain/mu'
API_PASS = 'mupass'
NODE_ID = '1'

CHECKTIME = 30 # check service time
SYNCTIME = 300 # sync traffic time
RESETTIME = 300 # reset traffic time

#BIND IP
#if you want bind ipv4 and ipv6 '[::]'
#if you want bind all of ipv4 if '0.0.0.0'
#if you want bind all of if only '4.4.4.4'
SS_BIND_IP = '0.0.0.0'
SS_METHOD = 'rc4-md5'

#LOG CONFIG
LOG_ENABLE = False
LOG_LEVEL = logging.DEBUG
LOG_FILE = '/var/log/shadowsocks.log'

