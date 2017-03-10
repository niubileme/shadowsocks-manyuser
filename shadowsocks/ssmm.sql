/*
Navicat MySQL Data Transfer

Source Server         : 47.88.26.60
Source Server Version : 50173
Source Host           : 47.88.26.60:3306
Source Database       : SSMM

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2017-03-09 17:24:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `CouponCode`
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of CouponCode
-- ----------------------------

-- ----------------------------
-- Table structure for `Log`
-- ----------------------------
DROP TABLE IF EXISTS `Log`;
CREATE TABLE `Log` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CreateTime` datetime NOT NULL,
  `Type` varchar(20) NOT NULL COMMENT '提现方式',
  `Message` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Log
-- ----------------------------


-- ----------------------------
-- Table structure for `Notice`
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

-- ----------------------------
-- Table structure for `Order`
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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Order
-- ----------------------------

-- ----------------------------
-- Table structure for `Product`
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
INSERT INTO `Product` VALUES ('62f3f631d46a4db0954882a256d20cf7', '体验套餐', '1G流量，使用优惠码，1元体验。&lt;br/&gt;&lt;br/&gt;\n美国/日本/香港/韩国&lt;br/&gt;&lt;br/&gt;\n有效时期3天。', '10', '30', '10.00', '0', '9');

-- ----------------------------
-- Table structure for `Record`
-- ----------------------------
DROP TABLE IF EXISTS `Record`;
CREATE TABLE `Record` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Amount` decimal(10,2) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `Type` varchar(20) NOT NULL COMMENT '1充值 2提现 3返佣',
  `Info` varchar(255) NOT NULL COMMENT '详细信息',
  `UserId` int(11) NOT NULL,
  `Remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Record
-- ----------------------------

-- ----------------------------
-- Table structure for `ServerNode`
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
INSERT INTO `ServerNode` VALUES ('e2e1d94176fe43429fa6d7856f49e02c', '美国西部1', '47.88.26.60', '', '美国西部1', '1', '10');

-- ----------------------------
-- Table structure for `Setting`
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
INSERT INTO `Setting` VALUES ('AlipayAccount', 'lhlcoopf@sina.com');
INSERT INTO `Setting` VALUES ('AlipayTradeNoSearchApi', 'http://127.0.0.1?query=交易号');
INSERT INTO `Setting` VALUES ('AlipayRemarkSearchApi', 'http://123.57.241.196:8999/Api/Alipay/QueryRemark/');
INSERT INTO `Setting` VALUES ('SSPortRange', '20000&65535');
INSERT INTO `Setting` VALUES ('WebSiteUrl', 'http://localhost:4777/');
INSERT INTO `Setting` VALUES ('RebateNum', '15');

-- ----------------------------
-- Table structure for `SS`
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


-- ----------------------------
-- Table structure for `User`
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
  `ParentId` int(11) DEFAULT NULL COMMENT '父Id',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of User
-- ----------------------------
INSERT INTO `User` VALUES ('1', 'admin', 'admin@autumnss.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', '1', '0.00', '2017-01-03 14:57:56', '1', '2cc85119bfc949da90d891390b26f06a', null);
