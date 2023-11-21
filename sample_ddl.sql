DDL for wechat_authorizer
CREATE TABLE `wechat_authorizer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `platform_app_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '平台appId',
  `app_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '授权人APPID',
  `app_type` int DEFAULT NULL COMMENT '授权方类型,0-第三发开发者,1-微信服务号,2-微信订阅号''',
  `access_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权人接口调用凭据',
  `access_token_expiretime` datetime DEFAULT NULL COMMENT '授权人访问令牌过期时间',
  `refresh_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权人接口调用凭据刷新令牌',
  `func_info` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权人权限集列表',
  `authorization_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权码',
  `authorization_code_expiretime` datetime DEFAULT NULL COMMENT '授权码过期时间',
  `status` int DEFAULT '1' COMMENT '1-正常',
  `authorizeurl` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权跳转地址',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_appid` (`app_id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE,
  KEY `idx_status_appid` (`app_id`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
