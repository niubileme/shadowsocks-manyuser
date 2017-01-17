

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for Bill
-- ----------------------------
DROP TABLE IF EXISTS `Bill`;
CREATE TABLE `Bill` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Amount` decimal(10,2) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `Type` varchar(20) NOT NULL COMMENT '提现方式',
  `UserId` int(11) NOT NULL,
  `Status` tinyint(2) NOT NULL DEFAULT '0',
  `TransferAccount` varchar(255) NOT NULL COMMENT '提现账号',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Bill
-- ----------------------------

-- ----------------------------
-- Table structure for CouponCode
-- ----------------------------
DROP TABLE IF EXISTS `CouponCode`;
CREATE TABLE `CouponCode` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(50) NOT NULL,
  `Des` varchar(255) NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `ExpirationTime` datetime NOT NULL,
  `MaxCount` int(11) NOT NULL,
  `Status` tinyint(4) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of CouponCode
-- ----------------------------
INSERT INTO `CouponCode` VALUES ('1', 'YmYwZTEwMGE1ZjM5NzNjZjY5ZGM4Y2JjNTBlNzQzZGM', 'aaa', '1.00', '2017-01-16 17:40:18', '2017-01-23 17:40:18', '0', '1');
INSERT INTO `CouponCode` VALUES ('2', 'ODNkMDY5YmYxZWY1NzdkNGEwZjViM2NjNGQ0ZWMwOTI', '免费体验', '5.00', '2017-01-17 00:59:42', '2017-01-24 00:59:42', '0', '1');
INSERT INTO `CouponCode` VALUES ('3', 'NDMxZGE2ZTg5NzRlZWNiNTM0MjdiMTE4NThhMTQyOWE', '1元体验', '4.00', '2017-01-17 01:00:02', '2017-01-24 01:00:02', '0', '1');

-- ----------------------------
-- Table structure for Notice
-- ----------------------------
DROP TABLE IF EXISTS `Notice`;
CREATE TABLE `Notice` (
  `Id` varchar(32) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Contents` text NOT NULL,
  `IsDelete` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Notice
-- ----------------------------
INSERT INTO `Notice` VALUES ('26a8a45ae20744b29e8ff5cdf5e9d028', '2017-01-05 17:33:35', '测试标题111111', '测试内容11111111111', '0');
INSERT INTO `Notice` VALUES ('c0d61bc1f5ba4ad9a3560b42ea90f911', '2017-01-06 16:51:43', '公告2222222', '公告内容2222222\n&lt;br/&gt;\n公告内容2222222\n&lt;br/&gt;\n公告内容2222222\n&lt;br/&gt;', '0');
INSERT INTO `Notice` VALUES ('724089e2642a447fbfdfdbd3109fbdae', '2017-01-06 16:52:26', '公告测试2333333', '呢哦让阿斯顿a&lt;br/&gt;\n&lt;strong&gt;哈好好&lt;/strong&gt;', '0');

-- ----------------------------
-- Table structure for Order
-- ----------------------------
DROP TABLE IF EXISTS `Order`;
CREATE TABLE `Order` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TradeNumber` varchar(50) NOT NULL COMMENT '交易单号',
  `ProductId` varchar(32) NOT NULL,
  `ProductName` varchar(255) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `Status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '订单状态',
  `Type` varchar(10) NOT NULL COMMENT '支付类型',
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Order
-- ----------------------------
INSERT INTO `Order` VALUES ('1', '2017011600484214191514070', '62f3f631d46a4db0954882a256d20cf7', '体验套餐', '1.00', '0.00', '2017-01-16 00:48:42', '1', '账户余额', '1');

-- ----------------------------
-- Table structure for Product
-- ----------------------------
DROP TABLE IF EXISTS `Product`;
CREATE TABLE `Product` (
  `Id` varchar(32) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL COMMENT '流量大小',
  `Traffic` int(11) NOT NULL,
  `ExpirationDay` int(11) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `IsRest` tinyint(2) NOT NULL,
  `SortNum` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Product
-- ----------------------------
INSERT INTO `Product` VALUES ('a644a4fc0ffb429291563eaac6ff2158', '包月套餐', '每月20G流量。&lt;br/&gt;&lt;br/&gt;\n30天后自动重置。&lt;br/&gt;&lt;br/&gt;\n美国/日本/香港/韩国&lt;br/&gt;&lt;br/&gt;\n有效时期30天。', '20', '30', '20.00', '1', '0');
INSERT INTO `Product` VALUES ('62f3f631d46a4db0954882a256d20cf7', '体验套餐', '1G流量，使用优惠码，1元体验。&lt;br/&gt;&lt;br/&gt;\n美国/日本/香港/韩国&lt;br/&gt;&lt;br/&gt;\n有效时期3天。', '1', '3', '5.00', '0', '9');
INSERT INTO `Product` VALUES ('35c5cdcb17d546ab8a71adef06b7a548', '包季套餐', '每月20G流量。&lt;br/&gt;&lt;br/&gt;\n30天后自动重置。&lt;br/&gt;&lt;br/&gt;\n美国/日本/香港/韩国&lt;br/&gt;&lt;br/&gt;\n有效时期90天。', '20', '90', '60.00', '1', '0');
INSERT INTO `Product` VALUES ('cf2b6de8ff6444fc91dbc2bfbbba431e', '半年套餐', '每月20G流量。&lt;br/&gt;&lt;br/&gt;\n30天后自动重置。&lt;br/&gt;&lt;br/&gt;\n美国/日本/香港/韩国&lt;br/&gt;&lt;br/&gt;\n有效时期180天。', '20', '180', '120.00', '1', '0');

-- ----------------------------
-- Table structure for Recharge
-- ----------------------------
DROP TABLE IF EXISTS `Recharge`;
CREATE TABLE `Recharge` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Amount` decimal(10,2) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `Type` varchar(20) NOT NULL,
  `Status` tinyint(2) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Recharge
-- ----------------------------

-- ----------------------------
-- Table structure for ServerNode
-- ----------------------------
DROP TABLE IF EXISTS `ServerNode`;
CREATE TABLE `ServerNode` (
  `Id` varchar(32) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `IP` varchar(255) NOT NULL,
  `CNAME` varchar(255) DEFAULT NULL,
  `Description` varchar(255) NOT NULL,
  `Status` tinyint(2) NOT NULL DEFAULT '1',
  `SortNum` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ServerNode
-- ----------------------------
INSERT INTO `ServerNode` VALUES ('644b6f638c28493f92d2d60bbad24b28', '美西线路1', '127.0.0.1', 'mx1.autumnss.com', '美国西部线路1', '1', '8');
INSERT INTO `ServerNode` VALUES ('eb54faed10ef41029b9f42b912c13a6d', '韩国线路1', '127.0.0.1', 'h1.autumnss.com', '韩国线路', '1', '0');

-- ----------------------------
-- Table structure for Setting
-- ----------------------------
DROP TABLE IF EXISTS `Setting`;
CREATE TABLE `Setting` (
  `Key` varchar(255) NOT NULL,
  `Value` text NOT NULL,
  PRIMARY KEY (`Key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Setting
-- ----------------------------
INSERT INTO `Setting` VALUES ('WebSiteTitle', '秋名山 — 科学上网，老司机带你体验最佳的上网姿势。');
INSERT INTO `Setting` VALUES ('WebSiteKeywords', 'VPN，SS，科学上网，翻墙');
INSERT INTO `Setting` VALUES ('WebSiteDescription', '老司机科学上网。');
INSERT INTO `Setting` VALUES ('StatisticalCode', '&lt;script&gt;\nvar _hmt = _hmt || [];\n(function() {\n  var hm = document.createElement(\"script\");\n  hm.src = \"https://hm.baidu.com/hm.js?43a75b46558d2646fb5b2355106edadd\";\n  var s = document.getElementsByTagName(\"script\")[0]; \n  s.parentNode.insertBefore(hm, s);\n})();\n&lt;/script&gt;');
INSERT INTO `Setting` VALUES ('AlipayAccount', 'lhlcoopf@qq.com  (*空)');
INSERT INTO `Setting` VALUES ('AlipayTradeNoSearchApi', 'http://127.0.0.1?query=交易号');
INSERT INTO `Setting` VALUES ('AlipayRemarkSearchApi', 'http://127.0.0.1?query1');
INSERT INTO `Setting` VALUES ('SSPortRange', '12000&65535');

-- ----------------------------
-- Table structure for SS
-- ----------------------------
DROP TABLE IF EXISTS `SS`;
CREATE TABLE `SS` (
  `id` varchar(32) NOT NULL,
  `t` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `u` bigint(20) NOT NULL COMMENT '上传流量',
  `d` bigint(20) NOT NULL COMMENT '下载流量',
  `transfer_enable` bigint(20) NOT NULL COMMENT '总流量',
  `port` int(11) NOT NULL COMMENT '端口',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `switch` tinyint(4) NOT NULL DEFAULT '1',
  `enable` tinyint(4) NOT NULL DEFAULT '1',
  `isrest` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否重置流量',
  `last_rest_time` int(11) NOT NULL COMMENT '下次重置流量时间',
  `expiration_time` int(11) NOT NULL COMMENT '过期时间',
  `create_time` int(11) NOT NULL COMMENT '开始时间',
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of SS
-- ----------------------------
INSERT INTO `SS` VALUES ('2017011600484214191514070', '1484498922', '0', '0', '3221225472', '12000', '123456', '1', '1', '0', '1484498922', '1487090922', '1484498922', '1');

-- ----------------------------
-- Table structure for User
-- ----------------------------
DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户Id',
  `UserName` varchar(255) NOT NULL COMMENT '用户名',
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL COMMENT '用户密码',
  `QQ` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '账号状态',
  `Balance` decimal(10,2) NOT NULL COMMENT '账户余额',
  `CreateTime` datetime NOT NULL,
  `IsManager` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否为管理员',
  `AffCode` varchar(255) NOT NULL COMMENT '邀请码',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of User
-- ----------------------------
INSERT INTO `User` VALUES ('1', 'admin', 'admin@autumnss.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', '1', '0.00', '2017-01-03 14:57:56', '1', '2cc85119bfc949da90d891390b26f06a');
