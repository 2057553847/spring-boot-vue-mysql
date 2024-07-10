/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80035
 Source Host           : localhost:3306
 Source Schema         : engineering

 Target Server Type    : MySQL
 Target Server Version : 80035
 File Encoding         : 65001

 Date: 10/07/2024 20:52:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '注册时间',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '状态',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `roleId` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_ibfk_1`(`roleId` ASC) USING BTREE,
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'root', '张三', '2024-06-22 23:22:18', 'root', '123', 1);
INSERT INTO `admin` VALUES (3, '爱吃香菜', '王五', '2024-06-22 23:22:35', 'supervisor', '333', 2);
INSERT INTO `admin` VALUES (5, '用户', '吴彦祖1', '2024-06-26 13:32:25', 'user', '1', 3);
INSERT INTO `admin` VALUES (83, '88', NULL, '2024-06-27 20:00:37', 'user', '123', 3);
INSERT INTO `admin` VALUES (89, '55', NULL, '2024-06-27 20:20:24', 'user', '55', 92);
INSERT INTO `admin` VALUES (92, 'nb', NULL, '2024-06-28 13:52:22', 'user', 'nb', 3);
INSERT INTO `admin` VALUES (93, '888', NULL, '2024-06-28 19:32:02', 'user', '888', 3);
INSERT INTO `admin` VALUES (94, '草草草草', NULL, '2024-06-29 01:20:20', 'user', '123', 3);
INSERT INTO `admin` VALUES (95, 'ggg', NULL, '2024-07-03 20:07:26', 'user', '123', 3);
INSERT INTO `admin` VALUES (96, 'user', NULL, '2024-07-04 11:23:03', 'user', '321', 3);
INSERT INTO `admin` VALUES (97, '牛逼', NULL, '2024-07-07 18:39:53', 'user', '123', 3);
INSERT INTO `admin` VALUES (98, '999', '99999', '2024-07-07 19:13:52', '999', '123', 3);
INSERT INTO `admin` VALUES (103, '牛逼66', '王五', '2024-07-07 23:37:36', 'user', '123', 3);
INSERT INTO `admin` VALUES (104, '277', '772', '2024-07-09 23:57:24', 'user', '123', 3);

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录时间',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名登录日志',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 313 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (145, '登录用户系统', '2024-06-26 17:57:56', 'root', 'Windows');
INSERT INTO `log` VALUES (146, '登录用户系统', '2024-06-26 19:48:53', 'root', 'Windows');
INSERT INTO `log` VALUES (147, '登录用户系统', '2024-06-26 19:59:30', 'root', 'Windows');
INSERT INTO `log` VALUES (148, '登录用户系统', '2024-06-26 20:03:10', 'root', 'Windows');
INSERT INTO `log` VALUES (149, '登录用户系统', '2024-06-26 23:37:23', 'root', 'Windows');
INSERT INTO `log` VALUES (150, '登录用户系统', '2024-06-26 23:54:01', 'root', 'Windows');
INSERT INTO `log` VALUES (151, '登录用户系统', '2024-06-27 00:09:25', 'root', 'Windows');
INSERT INTO `log` VALUES (152, '登录用户系统', '2024-06-27 00:11:59', 'root', 'Windows');
INSERT INTO `log` VALUES (153, '登录用户系统', '2024-06-27 00:12:55', 'root', 'Windows');
INSERT INTO `log` VALUES (154, '登录用户系统', '2024-06-27 00:14:18', 'root', 'Windows');
INSERT INTO `log` VALUES (155, '登录用户系统', '2024-06-27 00:20:09', 'root', 'Windows');
INSERT INTO `log` VALUES (156, '登录用户系统', '2024-06-27 00:23:26', 'root', 'Windows');
INSERT INTO `log` VALUES (157, '登录用户系统', '2024-06-27 01:17:32', 'root', 'Windows');
INSERT INTO `log` VALUES (158, '登录用户系统', '2024-06-27 01:22:18', 'root', 'Windows');
INSERT INTO `log` VALUES (159, '更新用户数据', '2024-06-27 01:22:37', 'root', 'Windows');
INSERT INTO `log` VALUES (160, '登录用户系统', '2024-06-27 01:22:44', 'root', 'Windows');
INSERT INTO `log` VALUES (161, '登录用户系统', '2024-06-27 01:52:13', 'root', 'Windows');
INSERT INTO `log` VALUES (162, '登录用户系统', '2024-06-27 01:52:43', '用户', 'Windows');
INSERT INTO `log` VALUES (163, '登录用户系统', '2024-06-27 12:55:05', 'root', 'Windows');
INSERT INTO `log` VALUES (164, '登录用户系统', '2024-06-27 13:34:38', 'root', 'Windows');
INSERT INTO `log` VALUES (165, '登录用户系统', '2024-06-27 13:35:58', 'root', 'Windows');
INSERT INTO `log` VALUES (166, '登录用户系统', '2024-06-27 16:21:02', 'root', 'Windows');
INSERT INTO `log` VALUES (167, '登录用户系统', '2024-06-27 16:31:55', 'root', 'Windows');
INSERT INTO `log` VALUES (168, '更新用户数据', '2024-06-27 16:32:33', 'root', 'Windows');
INSERT INTO `log` VALUES (169, '更新用户数据', '2024-06-27 16:32:46', 'root', 'Windows');
INSERT INTO `log` VALUES (170, '登录用户系统', '2024-06-27 16:43:15', 'root', 'Windows');
INSERT INTO `log` VALUES (171, '登录用户系统', '2024-06-27 17:06:15', 'root', 'Windows');
INSERT INTO `log` VALUES (172, '登录用户系统', '2024-06-27 17:18:12', 'root', 'Windows');
INSERT INTO `log` VALUES (173, '更新用户数据', '2024-06-27 17:18:25', 'root', 'Windows');
INSERT INTO `log` VALUES (174, '登录用户系统', '2024-06-27 17:20:11', 'ss', 'Windows');
INSERT INTO `log` VALUES (175, '登录用户系统', '2024-06-27 18:20:57', 'root', 'Windows');
INSERT INTO `log` VALUES (176, '批量删除用户数据', '2024-06-27 18:21:03', 'root', 'Windows');
INSERT INTO `log` VALUES (177, '批量删除用户数据', '2024-06-27 18:21:08', 'root', 'Windows');
INSERT INTO `log` VALUES (178, '更新用户数据', '2024-06-27 18:22:26', 'root', 'Windows');
INSERT INTO `log` VALUES (179, '删除用户数据', '2024-06-27 18:22:40', 'root', 'Windows');
INSERT INTO `log` VALUES (180, '登录用户系统', '2024-06-27 19:23:14', 'root', 'Windows');
INSERT INTO `log` VALUES (181, '登录用户系统', '2024-06-27 20:00:02', '爱吃香菜', 'Windows');
INSERT INTO `log` VALUES (182, '登录用户系统', '2024-06-27 20:00:41', '88', 'Windows');
INSERT INTO `log` VALUES (183, '登录用户系统', '2024-06-27 20:09:07', 'root', 'Windows');
INSERT INTO `log` VALUES (184, '更新用户数据', '2024-06-27 20:09:15', 'root', 'Windows');
INSERT INTO `log` VALUES (185, '更新用户数据', '2024-06-27 20:09:35', 'root', 'Windows');
INSERT INTO `log` VALUES (186, '登录用户系统', '2024-06-27 20:18:54', '77', 'Windows');
INSERT INTO `log` VALUES (187, '登录用户系统', '2024-06-27 20:20:28', '55', 'Windows');
INSERT INTO `log` VALUES (188, '登录用户系统', '2024-06-27 23:01:36', 'root', 'Windows');
INSERT INTO `log` VALUES (189, '登录用户系统', '2024-06-27 23:02:37', '55', 'Windows');
INSERT INTO `log` VALUES (190, '登录用户系统', '2024-06-27 23:54:35', 'root', 'Windows');
INSERT INTO `log` VALUES (191, '登录用户系统', '2024-06-27 23:55:18', '444', 'Windows');
INSERT INTO `log` VALUES (192, '登录用户系统', '2024-06-28 00:46:59', 'root', 'Windows');
INSERT INTO `log` VALUES (193, '登录用户系统', '2024-06-28 00:47:10', 'root', 'Windows');
INSERT INTO `log` VALUES (194, '登录用户系统', '2024-06-28 13:36:02', 'root', 'Windows');
INSERT INTO `log` VALUES (195, '登录用户系统', '2024-06-28 13:40:26', '66666', 'Windows');
INSERT INTO `log` VALUES (196, '登录用户系统', '2024-06-28 13:46:54', 'root', 'Windows');
INSERT INTO `log` VALUES (197, '登录用户系统', '2024-06-28 13:52:25', 'nb', 'Windows');
INSERT INTO `log` VALUES (198, '登录用户系统', '2024-06-28 14:09:29', 'root', 'Windows');
INSERT INTO `log` VALUES (199, '登录用户系统', '2024-06-28 14:20:17', 'root', 'Windows');
INSERT INTO `log` VALUES (200, '登录用户系统', '2024-06-28 19:09:02', 'root', 'Windows');
INSERT INTO `log` VALUES (201, '登录用户系统', '2024-06-28 19:22:53', 'root', 'Windows');
INSERT INTO `log` VALUES (202, '登录用户系统', '2024-06-28 19:32:15', '888', 'Windows');
INSERT INTO `log` VALUES (203, '登录用户系统', '2024-06-28 21:11:16', 'root', 'Windows');
INSERT INTO `log` VALUES (204, '登录用户系统', '2024-06-28 21:14:18', 'root', 'Windows');
INSERT INTO `log` VALUES (205, '登录用户系统', '2024-06-28 22:33:21', 'root', 'Windows');
INSERT INTO `log` VALUES (206, '登录用户系统', '2024-06-29 01:01:53', 'root', 'Windows');
INSERT INTO `log` VALUES (207, '登录用户系统', '2024-06-29 01:08:01', 'root', 'Windows');
INSERT INTO `log` VALUES (208, '更新用户数据', '2024-06-29 01:20:20', 'root', 'Windows');
INSERT INTO `log` VALUES (209, '登录用户系统', '2024-06-29 11:24:22', 'root', 'Windows');
INSERT INTO `log` VALUES (210, '登录用户系统', '2024-06-29 11:25:35', 'root', 'Windows');
INSERT INTO `log` VALUES (211, '登录用户系统', '2024-06-29 11:26:16', 'root', 'Windows');
INSERT INTO `log` VALUES (212, '登录用户系统', '2024-06-29 13:28:20', 'root', 'Windows');
INSERT INTO `log` VALUES (213, '登录用户系统', '2024-06-29 13:36:46', 'root', 'Windows');
INSERT INTO `log` VALUES (214, '登录用户系统', '2024-06-29 13:41:13', 'root', 'Windows');
INSERT INTO `log` VALUES (215, '登录用户系统', '2024-06-29 17:22:57', 'root', 'Windows');
INSERT INTO `log` VALUES (216, '登录用户系统', '2024-06-29 17:28:30', 'root', 'Windows');
INSERT INTO `log` VALUES (217, '登录用户系统', '2024-06-29 17:29:42', 'root', 'Windows');
INSERT INTO `log` VALUES (218, '登录用户系统', '2024-06-30 12:11:56', 'root', 'Windows');
INSERT INTO `log` VALUES (219, '登录用户系统', '2024-06-30 12:12:27', 'root', 'Windows');
INSERT INTO `log` VALUES (220, '登录用户系统', '2024-07-02 12:08:25', 'root', 'Windows');
INSERT INTO `log` VALUES (221, '登录用户系统', '2024-07-03 14:09:35', 'root', 'Windows');
INSERT INTO `log` VALUES (222, '登录用户系统', '2024-07-03 14:12:58', 'root', 'Windows');
INSERT INTO `log` VALUES (223, '登录用户系统', '2024-07-03 18:48:39', 'root', 'Windows');
INSERT INTO `log` VALUES (224, '登录用户系统', '2024-07-03 19:06:30', 'root', 'Windows');
INSERT INTO `log` VALUES (225, '登录用户系统', '2024-07-03 19:06:35', 'root', 'Windows');
INSERT INTO `log` VALUES (226, '登录用户系统', '2024-07-03 19:06:40', 'root', 'Windows');
INSERT INTO `log` VALUES (227, '登录用户系统', '2024-07-03 19:11:32', 'root', 'Windows');
INSERT INTO `log` VALUES (228, '登录用户系统', '2024-07-03 19:11:51', 'root', 'Windows');
INSERT INTO `log` VALUES (229, '登录用户系统', '2024-07-03 19:28:39', 'root', 'Windows');
INSERT INTO `log` VALUES (230, '登录用户系统', '2024-07-03 19:28:59', 'root', 'Windows');
INSERT INTO `log` VALUES (231, '更新用户数据', '2024-07-03 19:41:33', 'root', 'Windows');
INSERT INTO `log` VALUES (232, '登录用户系统', '2024-07-03 19:59:58', 'root', 'Windows');
INSERT INTO `log` VALUES (233, '更新用户数据', '2024-07-03 20:02:18', 'root', 'Windows');
INSERT INTO `log` VALUES (234, '更新用户数据', '2024-07-03 20:07:26', 'root', 'Windows');
INSERT INTO `log` VALUES (235, '登录用户系统', '2024-07-03 22:34:59', 'root', 'Windows');
INSERT INTO `log` VALUES (236, '更新用户数据', '2024-07-03 22:35:23', 'root', 'Windows');
INSERT INTO `log` VALUES (237, '登录用户系统', '2024-07-03 22:46:54', '88', 'Windows');
INSERT INTO `log` VALUES (238, '登录用户系统', '2024-07-03 23:02:34', 'root', 'Windows');
INSERT INTO `log` VALUES (239, '登录用户系统', '2024-07-03 23:09:44', '66666', 'Windows');
INSERT INTO `log` VALUES (240, '登录用户系统', '2024-07-03 23:09:50', 'root', 'Windows');
INSERT INTO `log` VALUES (241, '登录用户系统', '2024-07-03 23:16:14', 'root', 'Windows');
INSERT INTO `log` VALUES (242, '登录用户系统', '2024-07-03 23:21:56', 'root', 'Windows');
INSERT INTO `log` VALUES (243, '登录用户系统', '2024-07-03 23:25:00', 'root', 'Windows');
INSERT INTO `log` VALUES (244, '登录用户系统', '2024-07-03 23:25:00', 'root', 'Windows');
INSERT INTO `log` VALUES (245, '登录用户系统', '2024-07-03 23:25:00', 'root', 'Windows');
INSERT INTO `log` VALUES (246, '登录用户系统', '2024-07-03 23:25:59', 'root', 'Windows');
INSERT INTO `log` VALUES (247, '更新用户数据', '2024-07-03 23:28:43', 'root', 'Windows');
INSERT INTO `log` VALUES (248, '更新用户数据', '2024-07-03 23:54:35', 'root', 'Windows');
INSERT INTO `log` VALUES (249, '更新用户数据', '2024-07-04 00:03:54', 'root', 'Windows');
INSERT INTO `log` VALUES (250, '登录用户系统', '2024-07-04 00:05:50', 'root', 'Windows');
INSERT INTO `log` VALUES (251, '登录用户系统', '2024-07-04 00:08:16', '爱吃香菜', 'Windows');
INSERT INTO `log` VALUES (252, '登录用户系统', '2024-07-04 00:08:54', 'root', 'Windows');
INSERT INTO `log` VALUES (253, '更新用户数据', '2024-07-04 00:09:29', 'root', 'Windows');
INSERT INTO `log` VALUES (254, '登录用户系统', '2024-07-04 00:10:03', 'root', 'Windows');
INSERT INTO `log` VALUES (255, '登录用户系统', '2024-07-04 00:35:59', '55', 'Windows');
INSERT INTO `log` VALUES (256, '登录用户系统', '2024-07-04 00:37:04', 'root', 'Windows');
INSERT INTO `log` VALUES (257, '更新用户数据', '2024-07-04 00:37:28', 'root', 'Windows');
INSERT INTO `log` VALUES (258, '登录用户系统', '2024-07-04 00:37:55', 'root', 'Windows');
INSERT INTO `log` VALUES (259, '更新用户数据', '2024-07-04 00:38:01', 'root', 'Windows');
INSERT INTO `log` VALUES (260, '登录用户系统', '2024-07-04 00:38:07', '55', 'Windows');
INSERT INTO `log` VALUES (261, '登录用户系统', '2024-07-04 00:38:19', 'root', 'Windows');
INSERT INTO `log` VALUES (262, '登录用户系统', '2024-07-04 00:56:44', '55', 'Windows');
INSERT INTO `log` VALUES (263, '登录用户系统', '2024-07-04 10:07:46', 'root', 'Windows');
INSERT INTO `log` VALUES (264, '更新用户数据', '2024-07-04 10:08:08', 'root', 'Windows');
INSERT INTO `log` VALUES (265, '登录用户系统', '2024-07-04 10:08:35', 'root', 'Windows');
INSERT INTO `log` VALUES (266, '更新用户数据', '2024-07-04 10:09:35', 'root', 'Windows');
INSERT INTO `log` VALUES (267, '登录用户系统', '2024-07-04 10:28:19', '55', 'Windows');
INSERT INTO `log` VALUES (268, '登录用户系统', '2024-07-04 10:29:24', '55', 'Windows');
INSERT INTO `log` VALUES (269, '登录用户系统', '2024-07-04 10:30:04', '55', 'Windows');
INSERT INTO `log` VALUES (270, '登录用户系统', '2024-07-04 10:40:14', 'root', 'Windows');
INSERT INTO `log` VALUES (271, '登录用户系统', '2024-07-04 10:41:15', '55', 'Windows');
INSERT INTO `log` VALUES (272, '登录用户系统', '2024-07-04 10:41:23', 'root', 'Windows');
INSERT INTO `log` VALUES (273, '登录用户系统', '2024-07-04 10:43:02', 'root', 'Windows');
INSERT INTO `log` VALUES (274, '登录用户系统', '2024-07-04 11:10:12', 'root', 'Windows');
INSERT INTO `log` VALUES (275, '登录用户系统', '2024-07-04 11:11:21', 'root', 'Windows');
INSERT INTO `log` VALUES (276, '登录用户系统', '2024-07-04 11:11:27', 'root', 'Windows');
INSERT INTO `log` VALUES (277, '登录用户系统', '2024-07-04 11:11:48', 'root', 'Windows');
INSERT INTO `log` VALUES (278, '登录用户系统', '2024-07-04 11:12:25', 'root', 'Windows');
INSERT INTO `log` VALUES (279, '登录用户系统', '2024-07-04 11:23:09', 'user', 'Windows');
INSERT INTO `log` VALUES (280, '登录用户系统', '2024-07-04 11:23:46', 'user', 'Windows');
INSERT INTO `log` VALUES (281, '登录用户系统', '2024-07-04 11:30:44', 'user', 'Windows');
INSERT INTO `log` VALUES (282, '登录用户系统', '2024-07-04 11:35:47', 'root', 'Windows');
INSERT INTO `log` VALUES (283, '登录用户系统', '2024-07-04 11:37:04', 'root', 'Windows');
INSERT INTO `log` VALUES (284, '登录用户系统', '2024-07-04 11:40:16', 'user', 'Windows');
INSERT INTO `log` VALUES (285, '登录用户系统', '2024-07-04 11:44:07', 'root', 'Windows');
INSERT INTO `log` VALUES (286, '登录用户系统', '2024-07-04 11:45:16', 'root', 'Windows');
INSERT INTO `log` VALUES (287, '登录用户系统', '2024-07-04 11:45:28', 'root', 'Windows');
INSERT INTO `log` VALUES (288, '登录用户系统', '2024-07-04 11:45:38', 'root', 'Windows');
INSERT INTO `log` VALUES (289, '登录用户系统', '2024-07-04 11:48:00', 'root', 'Windows');
INSERT INTO `log` VALUES (290, '登录用户系统', '2024-07-04 21:07:41', 'root', 'Windows');
INSERT INTO `log` VALUES (291, '登录用户系统', '2024-07-04 23:08:12', 'root', 'Windows');
INSERT INTO `log` VALUES (292, '登录用户系统', '2024-07-05 00:38:58', 'root', 'Windows');
INSERT INTO `log` VALUES (293, '登录用户系统', '2024-07-05 00:44:20', 'root', 'Windows');
INSERT INTO `log` VALUES (294, '登录用户系统', '2024-07-05 00:44:38', 'user', 'Windows');
INSERT INTO `log` VALUES (295, '登录用户系统', '2024-07-05 00:44:45', 'root', 'Windows');
INSERT INTO `log` VALUES (296, '登录用户系统', '2024-07-07 17:10:44', 'root', 'Windows');
INSERT INTO `log` VALUES (297, '登录用户系统', '2024-07-07 17:51:25', 'root', 'Windows');
INSERT INTO `log` VALUES (298, '登录用户系统', '2024-07-07 18:40:00', '牛逼', 'Windows');
INSERT INTO `log` VALUES (299, '登录用户系统', '2024-07-07 18:40:07', 'root', 'Windows');
INSERT INTO `log` VALUES (300, '登录用户系统', '2024-07-07 23:12:30', 'root', 'Windows');
INSERT INTO `log` VALUES (301, '登录用户系统', '2024-07-09 01:23:36', 'root', 'Windows');
INSERT INTO `log` VALUES (302, '更新用户数据', '2024-07-09 01:25:08', 'root', 'Windows');
INSERT INTO `log` VALUES (303, '更新用户数据', '2024-07-09 01:25:35', 'root', 'Windows');
INSERT INTO `log` VALUES (304, '登录用户系统', '2024-07-09 01:34:38', 'root', 'Windows');
INSERT INTO `log` VALUES (305, '更新用户数据', '2024-07-09 01:34:59', 'root', 'Windows');
INSERT INTO `log` VALUES (306, '登录用户系统', '2024-07-09 23:32:30', 'root', 'Windows');
INSERT INTO `log` VALUES (307, '登录用户系统', '2024-07-10 00:06:50', 'root', 'Windows');
INSERT INTO `log` VALUES (308, '登录用户系统', '2024-07-10 00:07:47', 'root', 'Windows');
INSERT INTO `log` VALUES (309, '登录用户系统', '2024-07-10 00:09:42', '277', 'Windows');
INSERT INTO `log` VALUES (310, '登录用户系统', '2024-07-10 00:53:04', 'root', 'Windows');
INSERT INTO `log` VALUES (311, '登录用户系统', '2024-07-10 00:57:08', 'root', 'Windows');
INSERT INTO `log` VALUES (312, '登录用户系统', '2024-07-10 01:06:08', 'root', 'Windows');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告名称',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '公告内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (24, '企业系统规则', '尊敬的所有员工，\r\n\r\n为了确保企业信息系统的安全性和高效运行，我们制定了以下系统规则，请各位员工严格遵守：\r\n\r\n账号和密码安全：\r\n\r\n请妥善保管个人账号和密码，不要将其泄露给他人。\r\n定期更新密码，并确保密码强度足够，避免使用简单的常见密码。\r\n访问权限管理：\r\n\r\n每位员工仅可访问其工作职责所需的系统和数据。\r\n未经授权禁止访问、修改或传输公司数据和系统。\r\n数据安全和备份：\r\n\r\n重要数据必须存储在公司指定的安全服务器上，并进行定期备份。\r\n离开工作岗位前，请关闭并锁定计算机，确保公司数据不被未经授权的访问。\r\n合规和法律责任：\r\n\r\n在使用企业系统时，必须遵守公司的电子通信政策和法律法规。\r\n禁止使用公司资源进行任何违法活动或者侵犯他人隐私的行为。\r\n软件和应用程序安全：\r\n\r\n禁止在公司设备上安装未经批准的软件或应用程序。\r\n如有需要使用新的软件或应用程序，请先向IT部门申请并获得授权。\r\n请每位员工务必理解并遵守以上系统规则，确保公司信息系统的安全和稳定运行。如有任何疑问或发现安全问题，请及时联系公司IT支持团队。\r\n\r\n谢谢大家的合作！\r\n\r\n此致，\r\n\r\n[公司名]信息技术部', '2024-06-26 13:58:02');
INSERT INTO `notice` VALUES (25, '用户守则', '用户守则公告\n\n一、账号注册与使用\n\n1. 用户注册：用户需使用真实有效的身份信息和联系方式进行账号注册。平台将依法对用户提供的信息进行核实，用户应保证提供的信息真实、准确、完整、合法。\n\n2. 账号安全：用户应妥善保管账号及密码，不得将账号转让、出租或借给他人使用。因账号丢失或密码被盗引起的任何损失，由用户自行承担。\n\n3. 账号使用：用户应遵守平台的使用规则，不得利用账号进行任何违法、违规或损害他人利益的行为。\n\n二、行为规范\n\n1. 用户在使用平台时，应遵守国家法律法规，不得发布任何违反法律、法规、政策、公序良俗的内容。\n\n2. 用户不得发布虚假信息、恶意广告或未经证实的言论，不得散播谣言、诽谤他人或侵犯他人隐私。\n\n3. 用户应尊重知识产权，不得发布侵犯他人版权、商标权、专利权等知识产权的内容。', '2024-06-26 14:35:01');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `routing` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `state` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role_prm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, '系统管理', '/admin', 'pem_admin', '1', 'os');
INSERT INTO `permissions` VALUES (2, '新增权限', '/add', 'pem_add', '1', 'add');
INSERT INTO `permissions` VALUES (3, '修改权限', '/update', 'pem_update', '1', 'update');
INSERT INTO `permissions` VALUES (4, '删除权限', '/delete', 'pem_delete', '1', 'del');
INSERT INTO `permissions` VALUES (31, '查询权限', NULL, NULL, '1', 'select');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色描述',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色代码',
  `permissions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色权限',
  `permissionsId` int NULL DEFAULT NULL COMMENT '权限分类',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `permissionsId`(`permissionsId` ASC) USING BTREE,
  CONSTRAINT `role_ibfk_1` FOREIGN KEY (`permissionsId`) REFERENCES `permissions` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', '功能全部开放', 'root', '最高', 1);
INSERT INTO `role` VALUES (2, '组长', '仅查看', 'Leader', '组长级', 31);
INSERT INTO `role` VALUES (3, '用户', '仅查看', 'user', '组长级', 31);
INSERT INTO `role` VALUES (92, '经理', NULL, 'user', NULL, 31);

SET FOREIGN_KEY_CHECKS = 1;
