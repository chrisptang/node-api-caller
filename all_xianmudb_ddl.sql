[ 'xianmu' ]
Connected to MySQL server
DDL for table: account
CREATE TABLE `account` (
  `account_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `mname` varchar(255) DEFAULT NULL COMMENT '商户名称',
  `amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '金额',
  PRIMARY KEY (`account_id`) USING BTREE,
  KEY `idx` (`mname`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='金额变动表'
---
DDL for table: account_change
CREATE TABLE `account_change` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `m_id` bigint(11) DEFAULT NULL,
  `account_id` bigint(30) DEFAULT NULL,
  `old_phone` varchar(50) DEFAULT NULL,
  `old_contact` varchar(50) DEFAULT NULL,
  `new_phone` varchar(50) DEFAULT NULL,
  `new_contact` varchar(50) DEFAULT NULL,
  `mname` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `status` int(3) DEFAULT NULL COMMENT '1待审核 2审核通过 3审核失败',
  `openid` varchar(100) DEFAULT NULL,
  `unionid` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `m_id_index` (`m_id`) USING BTREE,
  KEY `idx_accountid` (`account_id`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: action
CREATE TABLE `action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(36) DEFAULT NULL COMMENT '埋点名称',
  `instruction` varchar(255) DEFAULT NULL COMMENT '埋点介绍',
  `on_watch` int(1) DEFAULT '0' COMMENT '是否启用，0否，1启用',
  `update_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='埋点点位表'
---
DDL for table: active_sku_purchase_quantity
CREATE TABLE `active_sku_purchase_quantity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户id',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动id',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `order_item_id` bigint(20) DEFAULT NULL COMMENT '订单项id',
  `purchase_quantity` int(11) DEFAULT NULL COMMENT '用户购买数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `new_activity_id` bigint(20) DEFAULT NULL COMMENT '新营销活动id',
  PRIMARY KEY (`id`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_quantity` (`m_id`,`order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3958 DEFAULT CHARSET=utf8 COMMENT='用户已购特价sku数量表'
---
DDL for table: activity
CREATE TABLE `activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `start_job` text,
  `end_job` text,
  `priority` int(2) NOT NULL DEFAULT '99',
  `info` varchar(200) DEFAULT NULL,
  `in_logo` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT '0',
  `advance` tinyint(1) DEFAULT '0' COMMENT '是否预告:0否 1是',
  `banner_show` tinyint(1) DEFAULT '1' COMMENT 'banner是否展示',
  `activity_type` tinyint(1) DEFAULT '0' COMMENT '临保活动1 非临保活动0',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_area_no` (`area_no`,`type`,`status`) USING BTREE,
  KEY `idx_status_areano` (`status`,`area_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4873 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: activity_basic_info
CREATE TABLE `activity_basic_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) DEFAULT NULL COMMENT '活动名称',
  `start_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `is_permanent` tinyint(4) DEFAULT '0' COMMENT '是否永久，0 否，1 是',
  `status` tinyint(4) DEFAULT '0' COMMENT '活动状态，0 暂停，1 开启',
  `need_pre` tinyint(4) DEFAULT '0' COMMENT '是否需要预热，0 否，1 是',
  `pre_start_time` datetime DEFAULT NULL COMMENT '预热开始时间',
  `pre_end_time` datetime DEFAULT NULL COMMENT '预热结束时间',
  `type` int(11) DEFAULT NULL COMMENT '活动类型，0 特价活动，1 临保活动，2 换购，3 拓展购买，4 秒杀，5 多人拼团，6 满减，7 满返，8 预售，9 省心送',
  `tag` tinyint(4) DEFAULT NULL COMMENT '活动目的(标签)，0 滞销促销，1 临保清仓，2 新品推广，3 用户召回，4 潜力品推广',
  `remark` varchar(64) DEFAULT NULL COMMENT '活动备注',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次修改人id',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_permanent_flag` (`del_flag`,`is_permanent`,`type`),
  KEY `idx_start_end_flag` (`del_flag`,`start_time`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=8229 DEFAULT CHARSET=utf8 COMMENT='活动基本信息表'
---
DDL for table: activity_black_and_white_list
CREATE TABLE `activity_black_and_white_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `sku` varchar(50) NOT NULL COMMENT 'sku',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `warehouse_name` varchar(255) DEFAULT NULL COMMENT '库存仓名称',
  `area_name` varchar(50) DEFAULT NULL COMMENT '城市名称',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `type` tinyint(4) NOT NULL COMMENT '类型 1-黑名单  2-白名单',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `warehouse_sku_index` (`warehouse_no`,`sku`) COMMENT '库存仓和sku普通索引',
  KEY `area_sku_index` (`area_no`,`sku`,`sort`) COMMENT '城市sku普通索引'
) ENGINE=InnoDB AUTO_INCREMENT=71454 DEFAULT CHARSET=utf8mb4 COMMENT='活动黑/白名单配置'
---
DDL for table: activity_info_ext
CREATE TABLE `activity_info_ext` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `basic_info_id` bigint(20) NOT NULL COMMENT '基本信息id',
  `limit_type` tinyint(4) DEFAULT '0' COMMENT '活动限购类型，0 不限购，1 每人，2 每人每天',
  `limit_num` int(11) DEFAULT '0' COMMENT '活动限购数量',
  `rule_detail` varchar(1024) DEFAULT NULL COMMENT '活动特殊规则json',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次修改人id',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_basic_info_id` (`basic_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动信息扩展配置表'
---
DDL for table: activity_item_config
CREATE TABLE `activity_item_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `basic_info_id` bigint(20) NOT NULL COMMENT '基本信息id',
  `good_select_way` tinyint(4) NOT NULL DEFAULT '0' COMMENT '商品选择方式，0 sku，1 类目，2 全部上架sku，3 标签商品，4 其他',
  `pricing_type` tinyint(4) DEFAULT '0' COMMENT '商品定价类型，0 单品定价，1 满金额阶梯，2 满金额重复，3 满数量重复，4 满数量阶梯，5 其他',
  `pricing_type_ext` varchar(1024) DEFAULT NULL COMMENT '商品定价类型扩展，目前主要是满减、满返的具体规则',
  `discount_percentage` int(11) DEFAULT NULL COMMENT '每件商品优惠幅度等于毛利的百分之X',
  `discount` decimal(10,2) DEFAULT NULL COMMENT '每件商品最多优惠X元',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次修改人id',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_info_id` (`basic_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8225 DEFAULT CHARSET=utf8 COMMENT='活动商品配置表'
---
DDL for table: activity_item_detail
CREATE TABLE `activity_item_detail` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `item_config_id` bigint(20) NOT NULL COMMENT '商品配置id',
  `category_id` int(11) DEFAULT NULL COMMENT '叶子节点类目id',
  `tag_name` varchar(64) DEFAULT NULL COMMENT '标签名称',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_item_category` (`item_config_id`,`category_id`),
  UNIQUE KEY `idx_item_tag` (`item_config_id`,`tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动商品配置信息表'
---
DDL for table: activity_scene_config
CREATE TABLE `activity_scene_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `basic_info_id` bigint(20) NOT NULL COMMENT '基本信息id',
  `platform` tinyint(4) DEFAULT '0' COMMENT '生效平台，0 商城，1 直播，2 其他',
  `place` tinyint(4) DEFAULT NULL COMMENT '投放区域',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_basic_info_id` (`basic_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8227 DEFAULT CHARSET=utf8 COMMENT='活动场景配置表'
---
DDL for table: activity_scope_config
CREATE TABLE `activity_scope_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `basic_info_id` bigint(20) NOT NULL COMMENT '基础信息id',
  `scope_id` bigint(20) NOT NULL COMMENT '范围id',
  `scope_type` tinyint(4) DEFAULT NULL COMMENT '活动范围类型，1 人群包，2 运营城市，3 运营大区',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次修改人id',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_basic_info_scope_id` (`basic_info_id`,`scope_type`,`scope_id`),
  KEY `idx_scope_id_type` (`scope_id`,`scope_type`)
) ENGINE=InnoDB AUTO_INCREMENT=9790 DEFAULT CHARSET=utf8 COMMENT='活动生效范围配置表'
---
DDL for table: activity_sku
CREATE TABLE `activity_sku` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `sku_name` varchar(50) DEFAULT NULL,
  `activity_price` decimal(10,2) DEFAULT '0.00',
  `sale_price` decimal(10,2) DEFAULT NULL,
  `ladder_price` varchar(500) DEFAULT NULL,
  `unit` varchar(5) DEFAULT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `sku_status` int(11) DEFAULT '1' COMMENT '表示活动商品作废，1表示存在',
  `activity_stock` int(11) DEFAULT NULL COMMENT '活动库存',
  `limited_quantity` int(11) DEFAULT NULL COMMENT '限购数量',
  `activity_stock_record` int(11) DEFAULT NULL COMMENT '活动库存设置值',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_activity_id` (`activity_id`,`sku`,`sku_status`) USING BTREE,
  KEY `index_activity_sku` (`sku`,`sku_status`)
) ENGINE=InnoDB AUTO_INCREMENT=12959 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: activity_sku_detail
CREATE TABLE `activity_sku_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `item_config_id` bigint(20) NOT NULL COMMENT '商品配置id',
  `sku` varchar(64) DEFAULT NULL COMMENT '活动sku',
  `rounding_mode` tinyint(4) DEFAULT NULL COMMENT '小数处理逻辑：0、四舍五入保留两位小数 1、向上取整',
  `adjust_type` tinyint(4) DEFAULT NULL COMMENT '价格调整方式：0：指定价 1：百分比 2：定额减 3:毛利百分比',
  `amount` decimal(12,4) DEFAULT NULL COMMENT '价格或百分比分子',
  `sort` int(11) DEFAULT '0' COMMENT '展示排序，数字越小，排序值最高',
  `plan_quantity` int(11) DEFAULT '0' COMMENT '计划数量，首次添加的活动库存',
  `actual_quantity` int(10) unsigned DEFAULT '0' COMMENT '实际数量，最终添加的活动库存',
  `lock_quantity` int(11) DEFAULT '0' COMMENT '冻结数量，已使用的活动库存',
  `account_limit` tinyint(4) NOT NULL DEFAULT '0' COMMENT '账号限购类型，0 不限购，1 件数，2 件/日',
  `limit_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '限购数量，0表示不限制',
  `min_sale_num` int(11) NOT NULL DEFAULT '0' COMMENT '起购数量，0表示不限制',
  `single_deposit` decimal(4,2) DEFAULT NULL COMMENT '每件订金',
  `expansion_ratio` decimal(6,2) DEFAULT NULL COMMENT '膨胀倍数',
  `hide_price` tinyint(4) DEFAULT '0' COMMENT '是否隐价，0 否，1 是',
  `timing_config` varchar(256) DEFAULT NULL COMMENT '省心送配置json',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_support_timing` tinyint(4) DEFAULT '0' COMMENT '活动是否支持省心送，0 否，1 是',
  `auto_price` tinyint(4) DEFAULT '1' COMMENT '是否开启自动定价  1：开启    0：关闭',
  PRIMARY KEY (`id`),
  KEY `idx_basic_info_sku` (`item_config_id`,`sku`),
  KEY `idx_sku` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=4404 DEFAULT CHARSET=utf8 COMMENT='活动sku配置表'
---
DDL for table: activity_sku_price
CREATE TABLE `activity_sku_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sku_detail_id` bigint(20) NOT NULL COMMENT 'sku配置明细id',
  `sku` varchar(64) DEFAULT NULL COMMENT '活动sku',
  `area_no` int(11) DEFAULT NULL COMMENT '运营城市',
  `sale_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `ladder_price` varchar(500) DEFAULT NULL COMMENT '阶梯价',
  `activity_price` decimal(10,2) DEFAULT NULL COMMENT '活动价',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次修改人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `basic_info_id` bigint(20) NOT NULL COMMENT '基本信息id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uqx_detail_sku_area` (`sku_detail_id`,`sku`,`area_no`),
  KEY `idx_sku_area` (`sku`,`sale_price`),
  KEY `idx_info_id_sku_area` (`basic_info_id`,`sku`,`area_no`)
) ENGINE=InnoDB AUTO_INCREMENT=14425 DEFAULT CHARSET=utf8 COMMENT='城市活动sku价格信息表'
---
DDL for table: ad_code_msg
CREATE TABLE `ad_code_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_code` varchar(50) DEFAULT NULL COMMENT '区域编码',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `level` varchar(50) DEFAULT NULL COMMENT '等级',
  `gd_id` varchar(50) DEFAULT NULL COMMENT '高德id',
  `add_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT NULL COMMENT '状态 0 正常 1 失效',
  `fence_id` int(11) DEFAULT NULL COMMENT '围栏id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_fence_id` (`fence_id`),
  KEY `idx_status_city_area` (`status`,`city`,`area`)
) ENGINE=InnoDB AUTO_INCREMENT=2571 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='围栏对应的区域信息'
---
DDL for table: admin
CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `login_fail_times` int(1) DEFAULT '0' COMMENT '登录失败次数，若到达五次则锁定账户；',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `phone` varchar(18) DEFAULT NULL,
  `kp` varchar(20) DEFAULT NULL,
  `saler_id` int(11) DEFAULT NULL,
  `saler_name` varchar(20) DEFAULT NULL,
  `contract` varchar(50) DEFAULT NULL,
  `contract_method` varchar(200) DEFAULT NULL,
  `name_remakes` varchar(50) DEFAULT NULL COMMENT '名称备注',
  `operate_id` int(11) DEFAULT NULL COMMENT '运营',
  `major_cycle` int(2) DEFAULT NULL COMMENT '报价周期： 0周报价, 1半月报价, 2月报价，3日报价',
  `close_order_type` int(11) DEFAULT '0' COMMENT '大客户是否提前截单 0 不是 1 是',
  `cooperation_stage` smallint(6) DEFAULT '0' COMMENT '标识ka大客户状态0（默认）非ka客户或是，1:试样，2:报价，3:试配，4:合作稳定期，5:合作困难期，6:流失，7:暂不合作',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `close_order_time` varchar(50) DEFAULT NULL COMMENT '大客户提前截单时间',
  `update_close_order_time` varchar(50) DEFAULT NULL COMMENT '修改后大客户提前截单时间',
  `low_price_remainder` tinyint(1) DEFAULT '0' COMMENT '是否开启低价监控：t、开启 f、关闭',
  `not_included_area` varchar(1000) DEFAULT NULL COMMENT '低价监控排除城市',
  `sku_sorting` tinyint(1) DEFAULT '1' COMMENT '是否是特殊捡货大客户',
  `admin_type` int(11) DEFAULT NULL COMMENT '客户类别 0大客户 1普通 2批发客户',
  `admin_chain` int(11) DEFAULT NULL COMMENT '连锁范围0（NKA）1(LKA) 2(其他连锁)',
  `admin_grade` int(11) DEFAULT NULL COMMENT '品牌等级 0普通 1KA',
  `admin_switch` int(11) DEFAULT '1' COMMENT '充送开关 0 开启，1 关闭',
  `credit_code` varchar(255) DEFAULT NULL COMMENT '统一社会信用代码',
  `business_license_address` varchar(100) DEFAULT NULL COMMENT '营业执照地址',
  `bill_to_pay` int(11) DEFAULT '1' COMMENT '票到付款 0 是 1 否',
  `base_user_id` bigint(20) DEFAULT NULL COMMENT 'auth中base_user_id',
  PRIMARY KEY (`admin_id`) USING BTREE,
  KEY `idx_username` (`username`) USING BTREE,
  KEY `idx_name_remakes` (`name_remakes`),
  KEY `idx_realname` (`realname`),
  KEY `idx_base_user_id` (`base_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11728 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='核心管理员表'
---
DDL for table: admin_auth_extend
CREATE TABLE `admin_auth_extend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `type` int(11) DEFAULT '0' COMMENT '认证类型：0、钉钉 1、CRM小程序',
  `admin_id` int(11) DEFAULT NULL COMMENT '后台账号id',
  `user_id` varchar(255) DEFAULT NULL COMMENT '钉钉userId',
  `openid` varchar(255) DEFAULT NULL COMMENT 'openid',
  `union_id` varchar(255) DEFAULT NULL COMMENT 'unionId',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 有效 1 失效',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uniod_index` (`type`,`status`,`union_id`) USING BTREE,
  KEY `user_index` (`type`,`status`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11423 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台授权登录表'
---
DDL for table: admin_data_permission
CREATE TABLE `admin_data_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `permission_value` varchar(45) DEFAULT NULL,
  `permission_name` varchar(45) DEFAULT NULL,
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `type` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21661 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据权限表'
---
DDL for table: admin_role
CREATE TABLE `admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '管理员id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色Id',
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ar__fk_admin_id` (`admin_id`) USING BTREE,
  KEY `ar__fk_role_id` (`role_id`) USING BTREE,
  CONSTRAINT `ar__fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2930 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员-角色关联表'
---
DDL for table: admin_role_pro
CREATE TABLE `admin_role_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '管理员id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色Id',
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5609 DEFAULT CHARSET=utf8mb4 COMMENT='管理员-角色关联表'
---
DDL for table: admin_skin
CREATE TABLE `admin_skin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `admin_id` int(11) DEFAULT NULL COMMENT 'admin表id',
  `show_flag` tinyint(1) DEFAULT NULL COMMENT '是否展示',
  `logo` varchar(255) DEFAULT NULL COMMENT 'logo图片',
  `background_image` varchar(255) DEFAULT NULL COMMENT '背景图',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='大客户logo和背景图表'
---
DDL for table: admin_sku_mapping
CREATE TABLE `admin_sku_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `sku` varchar(500) DEFAULT NULL,
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: admin_test
CREATE TABLE `admin_test` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `login_fail_times` int(1) DEFAULT '0' COMMENT '登录失败次数，若到达五次则锁定账户；',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用1',
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `phone` varchar(18) DEFAULT NULL,
  `kp` varchar(20) DEFAULT NULL,
  `saler_id` int(11) DEFAULT NULL,
  `saler_name` varchar(20) DEFAULT NULL,
  `contract` varchar(50) DEFAULT NULL,
  `contract_method` varchar(200) DEFAULT NULL,
  `name_remakes` varchar(50) DEFAULT NULL COMMENT '名称备注',
  `operate_id` int(11) DEFAULT NULL COMMENT '运营',
  `major_cycle` int(2) DEFAULT NULL COMMENT '报价周期： 0周报价, 1半月报价, 2月报价',
  `close_order_type` int(11) DEFAULT '0' COMMENT '大客户是否提前截单 0 不是 1 是',
  `cooperation_stage` smallint(6) DEFAULT '0' COMMENT '标识ka大客户状态0（默认）非ka客户或是，1:试样，2:报价，3:试配，4:合作稳定期，5:合作困难期，6:流失，7:暂不合作',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `close_order_time` varchar(50) DEFAULT NULL COMMENT '大客户提前截单时间',
  `update_close_order_time` varchar(50) DEFAULT NULL COMMENT '修改后大客户提前截单时间',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=863 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='核心管理员表'
---
DDL for table: advance_amount_record
CREATE TABLE `advance_amount_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_no` varchar(50) DEFAULT NULL COMMENT '采购单编号',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '可用总金额',
  `use_amount` decimal(10,2) DEFAULT NULL COMMENT '本次使用金额',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(255) DEFAULT NULL COMMENT '供应商名称',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='采购单管理预购单金额信息'
---
DDL for table: advance_purchase
CREATE TABLE `advance_purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `use_amount` decimal(10,2) DEFAULT NULL COMMENT '可用金额',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `admin_id` int(11) DEFAULT NULL COMMENT '发起人',
  `add_time` datetime DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `certificate` varchar(255) DEFAULT NULL COMMENT '打款凭证',
  `content` varchar(255) DEFAULT NULL COMMENT '内容备注',
  `supplier_account_id` int(11) DEFAULT NULL COMMENT '支付方式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='预购单表'
---
DDL for table: advance_purchase_amount
CREATE TABLE `advance_purchase_amount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '添加时间',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '总金额',
  `use_amount` decimal(10,2) DEFAULT NULL COMMENT '可用金额',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='预购单供应商对应的总金额表'
---
DDL for table: advance_purchase_plan
CREATE TABLE `advance_purchase_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '变动金额',
  `advance_purchase_id` int(11) DEFAULT NULL COMMENT '预购单id',
  `purchase_no` varchar(50) DEFAULT NULL COMMENT '采购单号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='预购单关联采购单信息'
---
DDL for table: advance_purchase_record
CREATE TABLE `advance_purchase_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `advance_purchase_id` int(11) DEFAULT NULL COMMENT '预购单id',
  `status` int(11) DEFAULT NULL COMMENT '操作类型',
  `remake` varchar(255) DEFAULT NULL COMMENT '备注内容',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '操作人名称',
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '采购单号非空 操作金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='预购单操作记录表'
---
DDL for table: advance_sale
CREATE TABLE `advance_sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `type` int(11) DEFAULT '0' COMMENT '类型：0、普通 1、省心送',
  `bg_pic` varchar(100) DEFAULT NULL COMMENT '背景图',
  `head_pic` varchar(100) DEFAULT NULL COMMENT '顶部头图',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `deposit_start_time` datetime DEFAULT NULL COMMENT '定金开始支付时间',
  `deposit_end_time` datetime DEFAULT NULL COMMENT '定金结束支付时间',
  `balance_start_time` datetime DEFAULT NULL COMMENT '尾款开始支付时间',
  `balance_end_time` datetime DEFAULT NULL COMMENT '尾款结束支付时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` datetime DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `activity_name` varchar(50) DEFAULT NULL COMMENT '预售活动名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_activity_name` (`activity_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预售表'
---
DDL for table: advance_sale_config
CREATE TABLE `advance_sale_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `basic_info_id` bigint(20) NOT NULL COMMENT '基本信息id',
  `deposit_start_time` datetime DEFAULT NULL COMMENT '定金开始支付时间，预售',
  `deposit_end_time` datetime DEFAULT NULL COMMENT '定金结束支付时间，预售',
  `balance_start_time` datetime DEFAULT NULL COMMENT '尾款开始支付时间，预售',
  `balance_end_time` datetime DEFAULT NULL COMMENT '尾款结束支付时间，预售',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_basic_info_id` (`basic_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预售信息配置表'
---
DDL for table: advance_sale_detail
CREATE TABLE `advance_sale_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `advance_id` int(11) DEFAULT NULL COMMENT '预售id',
  `sku` varchar(33) DEFAULT NULL COMMENT 'sku',
  `timing_id` int(11) DEFAULT NULL COMMENT '省心送id',
  `plan_limit_quantity` int(11) DEFAULT NULL COMMENT '计划上限',
  `actual_limit_quantity` int(11) DEFAULT NULL COMMENT '实际上限',
  `per_limit_quantity` int(11) DEFAULT NULL COMMENT '客户限购',
  `single_deposit` decimal(4,2) DEFAULT NULL COMMENT '每件订金',
  `expansion_ratio` decimal(6,2) DEFAULT NULL COMMENT '膨胀倍数',
  `sort` int(11) DEFAULT NULL COMMENT '排序值（从大到小）',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `advance_sale_detail_sku_index` (`advance_id`,`sku`) USING BTREE,
  KEY `advance_sale_detail_t_index` (`advance_id`,`timing_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=494 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预售详情表'
---
DDL for table: advance_sale_detail_bak
CREATE TABLE `advance_sale_detail_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `advance_id` int(11) DEFAULT NULL COMMENT '预售id',
  `sku` varchar(33) DEFAULT NULL COMMENT 'sku',
  `timing_id` int(11) DEFAULT NULL COMMENT '省心送id',
  `plan_limit_quantity` int(11) DEFAULT NULL COMMENT '计划上限',
  `actual_limit_quantity` int(11) DEFAULT NULL COMMENT '实际上限',
  `per_limit_quantity` int(11) DEFAULT NULL COMMENT '客户限购',
  `single_deposit` decimal(4,2) DEFAULT NULL COMMENT '每件订金',
  `expansion_ratio` decimal(6,2) DEFAULT NULL COMMENT '膨胀倍数',
  `sort` int(11) DEFAULT NULL COMMENT '排序值（从大到小）',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `advance_sale_detail_sku_index` (`advance_id`,`sku`) USING BTREE,
  KEY `advance_sale_detail_t_index` (`advance_id`,`timing_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='预售详情表'
---
DDL for table: advance_sale_record
CREATE TABLE `advance_sale_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `advance_detail_id` int(11) DEFAULT NULL COMMENT '预售详情id',
  `order_no` varchar(33) DEFAULT NULL COMMENT '订单编号',
  `order_item_id` bigint(20) DEFAULT NULL COMMENT '订单项id',
  `quantity` int(11) DEFAULT NULL COMMENT '购买数量',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总价',
  `deposit_price` decimal(10,2) DEFAULT NULL COMMENT '订金总额',
  `balance_price` decimal(10,2) unsigned DEFAULT NULL COMMENT '尾款金额',
  `expansion_ratio` decimal(6,2) DEFAULT NULL COMMENT '膨胀倍数',
  `deposit_start_time` datetime DEFAULT NULL COMMENT '定金开始支付时间',
  `deposit_end_time` datetime DEFAULT NULL COMMENT '定金结束支付时间',
  `balance_start_time` datetime DEFAULT NULL COMMENT '尾款开始支付时间',
  `balance_end_time` datetime DEFAULT NULL COMMENT '尾款结束支付时间',
  `deposit_pay_time` datetime DEFAULT NULL COMMENT '订金支付时间',
  `balance_pay_time` datetime DEFAULT NULL COMMENT '尾款支付时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `advance_sale_record_oi_index` (`order_no`,`order_item_id`) USING BTREE,
  KEY `advance_sale_record_detail_index` (`advance_detail_id`,`order_no`,`order_item_id`) USING BTREE,
  KEY `idx_deposit_pay_time` (`deposit_pay_time`) USING BTREE,
  KEY `idx_banlance` (`balance_pay_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1546 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预售购买记录'
---
DDL for table: after_sale_delivery_detail
CREATE TABLE `after_sale_delivery_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `as_delivery_path_id` int(11) DEFAULT NULL COMMENT '售后配送信息id',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku信息',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `pd_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `type` int(11) DEFAULT NULL COMMENT '类型  0 配送 1 回收 ',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 失效 1 生效',
  `intercept_flag` int(11) DEFAULT '0' COMMENT '拦截状态 0 正常 1被拦截',
  `intercept_time` datetime DEFAULT NULL COMMENT '拦截时间',
  `show_flag` tinyint(4) DEFAULT '0' COMMENT '完成排线-展示标识 0 展示 1不展示',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `after_sale_delivery_detail_sku_index` (`sku`) USING BTREE,
  KEY `delivery_path_id_index` (`as_delivery_path_id`,`status`) USING BTREE,
  KEY `idx_type_status` (`type`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=11962 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='售后配送详情表'
---
DDL for table: after_sale_delivery_path
CREATE TABLE `after_sale_delivery_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `m_id` int(11) DEFAULT NULL COMMENT '用户id',
  `delivery_time` date DEFAULT NULL COMMENT '回收，配送时间',
  `concat_id` bigint(30) DEFAULT NULL COMMENT '配送地址id',
  `after_sale_no` varchar(20) DEFAULT NULL COMMENT '售后订单号',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 配送 1 回收 2 配送回收',
  `out_store_no` int(11) DEFAULT NULL COMMENT '出库仓',
  `status` int(11) DEFAULT '1' COMMENT '状态 0 失效 1 待完成 2 完成中 3 已完成',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `after_sale_delivery_path_time_index` (`delivery_time`) USING BTREE,
  KEY `after_sale_delivery_path_index` (`out_store_no`,`concat_id`,`delivery_time`) USING BTREE,
  KEY `after_sale_delivery_path_sale_index` (`after_sale_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9888 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='售后(换货,补发,退货退款)配送信息'
---
DDL for table: after_sale_order
CREATE TABLE `after_sale_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `after_sale_order_no` varchar(20) NOT NULL COMMENT '售后编号',
  `m_id` bigint(30) DEFAULT NULL COMMENT '售后用户',
  `order_no` varchar(36) DEFAULT NULL COMMENT '售后订单',
  `sku` varchar(30) DEFAULT NULL COMMENT '售后sku，为空则为整单退',
  `quantity` int(8) DEFAULT NULL COMMENT '售后数量',
  `after_sale_type` varchar(255) DEFAULT NULL COMMENT '售后原因',
  `proof_pic` varchar(1000) DEFAULT NULL COMMENT '照片凭证',
  `handle_type` int(11) DEFAULT NULL COMMENT '售后处理方式,0返券，1未知，2退款，3录入账单，4退货退款，5退货录入账单，6换货，7补发，8人工退款，9拒收退款，10拒收账单，11拦截退款，12拦截录入账单',
  `handle_num` decimal(10,2) DEFAULT '0.00' COMMENT '补偿数量',
  `handler` varchar(50) DEFAULT NULL COMMENT '处理人',
  `auditer` varchar(50) DEFAULT NULL COMMENT '审核人',
  `apply_remark` varchar(255) DEFAULT NULL COMMENT '补充说明',
  `status` int(2) DEFAULT NULL COMMENT '售后状态：0、审核中\n1、处理中\n2、成功\n3、失败\n4、补充凭证\n11、取消\n12、退款中',
  `handle_remark` varchar(255) DEFAULT NULL COMMENT '处理结果',
  `after_sale_unit` varchar(5) DEFAULT NULL COMMENT '售后单位',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `type` int(2) DEFAULT '0' COMMENT '0、普通售后 1、极速售后',
  `grade` int(11) DEFAULT '0',
  `deliveryed` int(11) DEFAULT NULL COMMENT '0 未到货售后 1 已到货售后',
  `times` int(11) DEFAULT '1',
  `suit_id` int(11) DEFAULT NULL,
  `view` int(11) DEFAULT NULL,
  `is_full` tinyint(2) DEFAULT '0' COMMENT '是否全额退款',
  `account_id` bigint(30) DEFAULT NULL COMMENT '售后发起子账号id',
  `delivery_id` int(11) DEFAULT NULL COMMENT '配送计划id',
  `recovery_type` int(11) DEFAULT '0' COMMENT '是否需要回收费 0 不需要 1 需要',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `after_sale_remark_type` tinyint(4) DEFAULT NULL COMMENT '售后类型',
  `after_sale_remark` varchar(255) DEFAULT NULL COMMENT '售后类型备注',
  `after_sale_order_status` tinyint(4) DEFAULT '0' COMMENT '售后单类型：0 普通售后单，1 拦截售后单',
  `refund_freight` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0为没退运费，1为退了运费',
  `closer` varchar(50) DEFAULT NULL COMMENT '关闭售后单操作者',
  `close_time` datetime DEFAULT NULL COMMENT '关单时间',
  `product_type` int(11) DEFAULT NULL COMMENT '商品类型：0、普通商品 1、赠品 2、换购商品',
  `carrying_goods` int(11) DEFAULT '0' COMMENT '补发是否带货回来：0没带，1带了',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `in_after_no` (`after_sale_order_no`),
  KEY `in_sku` (`sku`) USING BTREE,
  KEY `after_sale_order_index` (`m_id`,`type`,`status`,`add_time`) USING BTREE,
  KEY `in_order_no` (`order_no`,`suit_id`,`sku`) USING BTREE,
  KEY `idx_addtime` (`add_time`) USING BTREE,
  KEY `idx_status` (`status`,`after_sale_order_status`,`after_sale_order_no`),
  KEY `idx_dp_id` (`delivery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33318 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='售后订单表'
---
DDL for table: after_sale_order_view
undefined
---
DDL for table: after_sale_proof
CREATE TABLE `after_sale_proof` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `after_sale_order_no` varchar(30) DEFAULT NULL,
  `quantity` int(8) DEFAULT NULL,
  `handle_num` decimal(10,2) DEFAULT NULL,
  `proof_pic` varchar(1000) DEFAULT NULL,
  `after_sale_type` varchar(255) DEFAULT NULL,
  `refund_type` varchar(255) DEFAULT NULL,
  `handle_type` int(2) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `handle_remark` varchar(1000) DEFAULT NULL COMMENT '原因',
  `auditer` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `apply_remark` varchar(1000) DEFAULT NULL,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `applyer` varchar(50) DEFAULT NULL,
  `audite_remark` varchar(1000) DEFAULT NULL,
  `extra_remark` varchar(100) DEFAULT NULL COMMENT '审核备注',
  `auditetime` datetime DEFAULT NULL,
  `handletime` datetime DEFAULT NULL,
  `recovery_num` decimal(10,2) DEFAULT '0.00' COMMENT '回收废金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `handle_secondary_remark` varchar(1000) DEFAULT NULL COMMENT '二级审核原因',
  `apply_secondary_remark` varchar(100) DEFAULT NULL COMMENT '二级售后分类',
  `proof_video` varchar(1000) DEFAULT NULL COMMENT '售后视频',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_handle_order` (`handle_type`,`after_sale_order_no`),
  KEY `idx_after_no` (`after_sale_order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33318 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: after_sale_wo
CREATE TABLE `after_sale_wo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `type` int(4) NOT NULL COMMENT '工单类型：0、售前 1、售后',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT '工单状态：0、待跟进 1、已完成',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `mname` varchar(50) DEFAULT NULL COMMENT '客户名称',
  `call_phone` varchar(20) DEFAULT NULL COMMENT '来电号码',
  `desc` varchar(255) DEFAULT NULL COMMENT '问题描述',
  `finish_time` datetime DEFAULT NULL COMMENT '完结时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='售后工单'
---
DDL for table: after_sale_wo_process
CREATE TABLE `after_sale_wo_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `wo_id` int(11) NOT NULL COMMENT '售后工单id',
  `context` varchar(255) DEFAULT NULL COMMENT '跟进内容',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `in_wo_id` (`wo_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='售后工单跟进'
---
DDL for table: allocation_order_item_abnormal
CREATE TABLE `allocation_order_item_abnormal` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_allocation_item_id` int(11) DEFAULT NULL COMMENT '调拨单详情id',
  `list_no` varchar(45) DEFAULT NULL COMMENT '调拨单号',
  `quantity` int(11) DEFAULT NULL COMMENT '异常数量',
  `type` int(11) DEFAULT NULL COMMENT '18:调拨回库 59:调拨货损',
  `sku` varchar(45) DEFAULT NULL COMMENT 'sku',
  `relation_no` varchar(50) DEFAULT NULL COMMENT '关联单号',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `update_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  PRIMARY KEY (`id`),
  KEY `idx_stock_allocation_item_id` (`stock_allocation_item_id`),
  KEY `idx_listno_sku` (`list_no`,`sku`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=593 DEFAULT CHARSET=utf8mb4 COMMENT='调拨异常记录表'
---
DDL for table: allocation_order_item_act_quality_period
CREATE TABLE `allocation_order_item_act_quality_period` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_allocation_item_id` int(11) DEFAULT NULL COMMENT '调拨单详情id',
  `produce_period_start_time` date DEFAULT NULL COMMENT '保质期开始时间',
  `produce_period_end_time` date DEFAULT NULL COMMENT '保质期结束时间',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id',
  PRIMARY KEY (`id`),
  KEY `idx_stock_allocation_item_id` (`stock_allocation_item_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=594 DEFAULT CHARSET=utf8mb4 COMMENT='调拨实际出库保质期'
---
DDL for table: allocation_plan
CREATE TABLE `allocation_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `list_no` varchar(20) DEFAULT NULL COMMENT '调拨单号',
  `plan_list_no` varchar(100) DEFAULT NULL COMMENT '调拨计划单号',
  `out_warehouse_no` int(11) DEFAULT NULL COMMENT '出库仓库',
  `in_warehouse_no` int(11) DEFAULT NULL COMMENT '入库仓库',
  `out_warehouse_name` varchar(100) DEFAULT NULL COMMENT '出库仓库名称',
  `in_warehouse_name` varchar(100) DEFAULT NULL COMMENT '入库仓库名称',
  `status` int(11) DEFAULT NULL COMMENT '状态(5:草稿 10:待采购确认 15:待销售确认 20:待运营确认 25:已完成 30:已作废)',
  `expect_out_time` datetime DEFAULT NULL COMMENT '预计出库时间',
  `expect_in_time` datetime DEFAULT NULL COMMENT '预计入库时间',
  `in_store_admin` int(11) DEFAULT NULL COMMENT '入库仓库负责人id',
  `in_store_admin_name` varchar(100) DEFAULT NULL COMMENT '入库仓库负责人名称',
  `out_store_admin` int(11) DEFAULT NULL COMMENT '出库仓库负责人id',
  `out_store_admin_name` varchar(100) DEFAULT NULL COMMENT '出库仓库负责人名称',
  `out_time` datetime DEFAULT NULL COMMENT '出库时间',
  `order_type` int(11) DEFAULT NULL COMMENT '单据类型:1:手动创建,2:自动创建,3手动创建(自动计算)',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `trunk_flag` int(11) DEFAULT NULL COMMENT '干线调度(0:否 1:是)',
  PRIMARY KEY (`id`),
  KEY `idx_listno_status` (`list_no`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=945 DEFAULT CHARSET=utf8 COMMENT='调拨计划'
---
DDL for table: allocation_plan_blacklist
CREATE TABLE `allocation_plan_blacklist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pd_id` bigint(20) DEFAULT NULL COMMENT '商品名称',
  `pd_name` varchar(100) DEFAULT NULL COMMENT '商品id',
  `sku` varchar(100) DEFAULT NULL COMMENT '商品sku',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_sku` (`sku`,`is_delete`),
  KEY `idx_pd_name` (`pd_name`,`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COMMENT='调拨计划黑名单'
---
DDL for table: allocation_plan_blacklist_warehouse
CREATE TABLE `allocation_plan_blacklist_warehouse` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `allocation_plan_blacklist_id` bigint(20) DEFAULT NULL COMMENT '调拨计划黑名单id',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(100) DEFAULT NULL COMMENT '仓库名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_allocation_plan_blacklist_id` (`allocation_plan_blacklist_id`,`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8 COMMENT='调拨计划黑名单仓库'
---
DDL for table: allocation_plan_detail
CREATE TABLE `allocation_plan_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `allocation_plan_id` bigint(20) DEFAULT NULL COMMENT '调拨计划id',
  `sku` varchar(100) DEFAULT NULL COMMENT 'sku',
  `pd_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `pd_name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `system_adjust` int(11) DEFAULT NULL COMMENT '调拨建议量',
  `out_quantity` int(11) DEFAULT NULL COMMENT '实际调出数量',
  `purchaser_adjust` int(11) DEFAULT NULL COMMENT '采购建议量',
  `purchase_remark` varchar(100) DEFAULT NULL COMMENT '采购备注',
  `sale_adjust` int(11) DEFAULT NULL COMMENT '销售建议量',
  `sale_remark` varchar(100) DEFAULT NULL COMMENT '销售备注',
  `operate_adjust` int(11) DEFAULT NULL COMMENT '运营建议量',
  `operate_remark` varchar(100) DEFAULT NULL COMMENT '运营备注',
  `allocation_lock_quantity` int(11) DEFAULT '0' COMMENT '冻结库存',
  `is_direct` int(11) DEFAULT '0' COMMENT '是否直采',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_role` tinyint(4) DEFAULT NULL COMMENT '创建角色',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `source` tinyint(4) DEFAULT '0' COMMENT '0:日常调拨 1:补货计划',
  `replenishment_plan_allocation_task_id` bigint(20) DEFAULT NULL COMMENT '补货任务id',
  PRIMARY KEY (`id`),
  KEY `idx_allocation_plan_id_sku` (`allocation_plan_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=1949 DEFAULT CHARSET=utf8 COMMENT='调拨计划详情'
---
DDL for table: allocation_plan_detail_quality_period
CREATE TABLE `allocation_plan_detail_quality_period` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `allocation_plan_detail_id` bigint(20) DEFAULT NULL COMMENT '调拨计划详情id',
  `produce_period_start_time` date DEFAULT NULL COMMENT '保质期开始时间',
  `produce_period_end_time` date DEFAULT NULL COMMENT '保质期结束时间',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_allocation_detail_id` (`allocation_plan_detail_id`,`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8 COMMENT='调拨计划sku保质期'
---
DDL for table: allocation_plan_detail_transfer
CREATE TABLE `allocation_plan_detail_transfer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `allocation_plan_detail_id` bigint(20) DEFAULT NULL COMMENT '调拨计划详情id',
  `pd_id` int(11) DEFAULT NULL COMMENT '商品id',
  `pd_name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `sku` varchar(100) DEFAULT NULL COMMENT '商品sku',
  `system_adjust` decimal(10,2) DEFAULT NULL COMMENT '系统建议量',
  `sale_quantity` decimal(10,2) DEFAULT NULL COMMENT '销量预估',
  `road_quantity` int(11) DEFAULT NULL COMMENT '在途库存',
  `avl_quantity` decimal(10,2) DEFAULT NULL COMMENT '可用库存',
  `rates` varchar(10) DEFAULT NULL COMMENT '转换比例',
  `free_delivery_quantity` int(11) DEFAULT NULL COMMENT '省心送库存',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_allocation_plan_detail_id` (`allocation_plan_detail_id`,`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COMMENT='调拨小规格sku转化'
---
DDL for table: amount_record
CREATE TABLE `amount_record` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(30) NOT NULL COMMENT '账户id',
  `old_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '变化前金额',
  `new_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '变化后金额',
  `rule_id` int(11) NOT NULL COMMENT '年利率规则',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_AmountRecord` (`account_id`) USING BTREE,
  CONSTRAINT `fk_AmountRecord` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='金额变动表'
---
DDL for table: annual_personal_summary
CREATE TABLE `annual_personal_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` int(11) DEFAULT NULL COMMENT '用户id',
  `m_name` varchar(255) DEFAULT NULL COMMENT '客户店铺名称',
  `consume_amount` decimal(10,2) DEFAULT NULL COMMENT '消费金额',
  `order_number` int(11) DEFAULT NULL COMMENT '下单数',
  `area_no` int(11) DEFAULT NULL COMMENT '城市',
  `order_rate` decimal(10,2) DEFAULT NULL COMMENT '订单占比',
  `preferential_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠金额',
  `max_order_amount` decimal(10,2) DEFAULT NULL COMMENT '最大下单金额',
  `max_order_time` datetime DEFAULT NULL COMMENT '最大金额订单下单时间',
  `earliest_order_time` datetime DEFAULT NULL COMMENT '最早下单时间',
  `latest_order_time` datetime DEFAULT NULL COMMENT '最晚下单时间',
  `grade` int(11) DEFAULT NULL COMMENT '会员等级',
  `over_time_order` int(11) DEFAULT NULL COMMENT '超时下单次数',
  `speed_after_order_amount` decimal(10,2) DEFAULT NULL COMMENT '极速售后金额',
  `category_number` int(11) DEFAULT NULL COMMENT '购买过的种类总数',
  `category_name` varchar(255) DEFAULT NULL COMMENT '最多购买类目名',
  `category_rate` decimal(10,2) DEFAULT NULL COMMENT '购买最多种类占比',
  `like_pd_name` varchar(255) DEFAULT NULL COMMENT '最喜欢的spu名称',
  `like_sku_amount` int(11) DEFAULT NULL COMMENT '购买最多的sku金额',
  `like_sku_unit` varchar(30) DEFAULT NULL COMMENT 'sku包装单位',
  `area_name` varchar(50) DEFAULT NULL COMMENT '城市名称',
  `city` varchar(50) DEFAULT NULL COMMENT '所在市',
  `area` varchar(50) DEFAULT NULL COMMENT '所在区',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='2019年用户年度总结'
---
DDL for table: api_definition
CREATE TABLE `api_definition` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `api_name` varchar(64) DEFAULT NULL COMMENT '名称',
  `api_path` varchar(128) DEFAULT NULL COMMENT 'api路径',
  `call_define` varchar(1024) DEFAULT NULL COMMENT '服务信息',
  `parameter_define` varchar(1024) DEFAULT NULL COMMENT '参数信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_api_path` (`api_path`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='api定义'
---
DDL for table: app_definition
CREATE TABLE `app_definition` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `app_name` varchar(64) DEFAULT NULL COMMENT '名称',
  `app_key` varchar(64) DEFAULT NULL COMMENT 'key',
  `app_secret` varchar(64) DEFAULT NULL COMMENT '密钥',
  `status` varchar(32) DEFAULT NULL COMMENT '状态',
  `account_id` bigint(20) DEFAULT NULL COMMENT '关联账号id',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='app定义'
---
DDL for table: area
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `area_name` varchar(50) DEFAULT NULL COMMENT '城市名称',
  `admin_id` int(11) DEFAULT NULL COMMENT '城市负责人',
  `parent_no` int(11) DEFAULT NULL,
  `delivery_frequent` varchar(255) DEFAULT NULL COMMENT '配送频率',
  `status` tinyint(1) DEFAULT '0' COMMENT '是否开放，0不开放，1开放',
  `delivery_fee` decimal(12,2) DEFAULT '0.00',
  `info` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `express_fee` decimal(12,2) DEFAULT NULL COMMENT '快递费',
  `delivery_rule` varchar(255) DEFAULT NULL COMMENT '运费规则',
  `member_rule` varchar(255) DEFAULT '[]' COMMENT '会员规则',
  `company_account_id` int(11) DEFAULT '5' COMMENT '收款账号（默认5：杭州）',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德地图poi坐标',
  `type` int(2) DEFAULT '1' COMMENT '仓库类型:0本部仓、1外部仓、2合伙人仓',
  `free_day` varchar(255) DEFAULT NULL COMMENT '免配送费日期（结构同delivery_frequent）',
  `mail_to_address` varchar(255) DEFAULT NULL COMMENT '预约入库邮件接收人',
  `map_section` varchar(1000) DEFAULT NULL COMMENT '截单映射区域（形如 浙江/杭州市/西湖区，多个区域用“,”隔开，其他区域表示市级映射）',
  `origin_area_no` int(11) DEFAULT NULL COMMENT '同步城市',
  `next_delivery_date` date DEFAULT NULL COMMENT '开始/下次配送时间',
  `pay_channel` int(11) DEFAULT '0' COMMENT '支付通道，0微信 1中银 2招行',
  `change_flag` tinyint(1) DEFAULT '0' COMMENT '仓库切换标识：f、未预约切换 t、切换中',
  `change_store_no` int(11) DEFAULT NULL COMMENT '切换的城市编号（处理完后清空）',
  `change_status` int(11) DEFAULT '0' COMMENT '切换状态：0、默认 1、预约中 2、大客户停服 3、城市停服',
  `administrative_area` varchar(50) DEFAULT NULL COMMENT '根据国家行政区域划分，精确到市',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `support_add_order` tinyint(4) DEFAULT NULL COMMENT '是否支持加单 0 支持加单 1 不支持加单',
  `update_support_add_order` tinyint(4) DEFAULT NULL COMMENT '更新是否支持加单',
  `large_area_no` int(11) DEFAULT NULL COMMENT '运营大区编号',
  `grade` char(2) NOT NULL DEFAULT 'S' COMMENT '区域等级:S.A.B.C.D',
  `wxlite_pay_channel` int(11) NOT NULL DEFAULT '0' COMMENT '微信小程序是否使用招行收款：0、不使用（默认）1、使用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_area_name` (`area_name`) USING BTREE,
  UNIQUE KEY `index_area_no` (`area_no`) USING BTREE,
  KEY `idx_parent` (`parent_no`)
) ENGINE=InnoDB AUTO_INCREMENT=420 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='服务城市表'
---
DDL for table: area_bak
CREATE TABLE `area_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `area_name` varchar(50) DEFAULT NULL COMMENT '城市名称',
  `level` int(3) DEFAULT NULL COMMENT '城市等级',
  `admin_id` int(11) DEFAULT NULL COMMENT '城市负责人',
  `parent_no` int(11) DEFAULT NULL,
  `delivery_frequent` varchar(255) DEFAULT NULL COMMENT '配送频率',
  `status` tinyint(1) DEFAULT '0' COMMENT '是否开放，0不开放，1开放',
  `delivery_fee` decimal(12,2) DEFAULT '0.00',
  `info` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `express_fee` decimal(12,2) DEFAULT NULL COMMENT '快递费',
  `delivery_rule` varchar(255) DEFAULT NULL COMMENT '运费规则',
  `member_rule` varchar(255) DEFAULT '[]' COMMENT '会员规则',
  `company_account_id` int(11) DEFAULT '5' COMMENT '收款账号（默认5：杭州）',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德地图poi坐标',
  `type` int(2) DEFAULT '1' COMMENT '仓库类型:0本部仓、1外部仓、2合伙人仓',
  `area_manage_id` int(10) DEFAULT NULL COMMENT '仓库所属合伙人',
  `area_nature` int(2) DEFAULT '0' COMMENT '调配性质：0城市仓 1中心仓',
  `free_day` varchar(255) DEFAULT NULL COMMENT '免配送费日期（结构同delivery_frequent）',
  `mail_to_address` varchar(255) DEFAULT NULL COMMENT '预约入库邮件接收人',
  `map_section` varchar(2000) DEFAULT NULL COMMENT '截单映射区域（形如 浙江/杭州市/西湖区，多个区域用“,”隔开，其他区域表示市级映射）',
  `allocation_time` varchar(255) DEFAULT NULL COMMENT '调拨周期',
  `allocation_time_type` int(11) DEFAULT NULL COMMENT '是否调拨 0 不调拨 1 调拨',
  `origin_area_no` int(11) DEFAULT NULL COMMENT '同步城市',
  `next_delivery_date` date DEFAULT NULL COMMENT '开始/下次配送时间',
  `close_order_type` int(11) DEFAULT '0' COMMENT '是否提前截单 0 否 1是',
  `pay_channel` int(11) DEFAULT '1' COMMENT '支付通道，0微信 1中银',
  `change_flag` tinyint(1) DEFAULT '0' COMMENT '仓库切换标识：f、未预约切换 t、切换中',
  `change_store_no` int(11) DEFAULT NULL COMMENT '切换的城市编号（处理完后清空）',
  `change_status` int(11) DEFAULT '0' COMMENT '切换状态：0、默认 1、预约中 2、大客户停服 3、城市停服',
  `sot_finish_time` datetime DEFAULT NULL COMMENT '销售出库任务完成时间',
  `sort_expire_time` datetime DEFAULT NULL COMMENT '排序到期时间',
  `administrative_area` varchar(50) DEFAULT NULL COMMENT '根据国家行政区域划分，精确到市',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_area_no` (`area_no`) USING BTREE,
  UNIQUE KEY `index_area_name` (`area_name`) USING BTREE,
  KEY `index_parent_no` (`parent_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='服务城市表'
---
DDL for table: area_collocation
CREATE TABLE `area_collocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collocation_id` int(11) DEFAULT NULL COMMENT '搭配购主键',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `area_name` varchar(45) DEFAULT NULL COMMENT '城市名称',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `area_collocation_uq` (`area_no`,`collocation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5904 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='搭配购-分城市信息'
---
DDL for table: area_copy
CREATE TABLE `area_copy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `source_area_no` int(11) NOT NULL DEFAULT '0' COMMENT '源城市编号',
  `target_area_no` int(11) NOT NULL DEFAULT '0' COMMENT '目标(应用)城市编号',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态:0-确认中 1-执行中(暂时未使用) 2-已生效',
  `creator` int(11) NOT NULL DEFAULT '0' COMMENT '创建人(admin.admin_id)',
  `updater` int(11) NOT NULL DEFAULT '0' COMMENT '确认人(admin.admin_id)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_target_area_no` (`target_area_no`),
  KEY `idx_creator` (`creator`),
  KEY `idx_source_area_no` (`source_area_no`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 COMMENT='运营区域复制单'
---
DDL for table: area_copy_detail
CREATE TABLE `area_copy_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `copy_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '复制单号',
  `sku` varchar(30) NOT NULL DEFAULT '' COMMENT '商品编号(inventory.sku)',
  `original_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '原价格',
  `new_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '新价格',
  `origin_interest_rate` decimal(10,4) DEFAULT '0.0000' COMMENT '原始毛利率',
  `new_interest_rate` decimal(10,4) DEFAULT NULL COMMENT '新毛利率',
  `auto_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '新毛利率开关(自动调整标识)：0、否 1、是',
  `on_sale` tinyint(4) DEFAULT '0' COMMENT '上下架状态 0-下架 1-上架',
  `home_show` int(11) DEFAULT '0' COMMENT '是否展示在首页 0-否 1-是',
  `close_sale` int(11) DEFAULT NULL COMMENT '下架操作: 0下架、1售罄下架、2定时下架',
  `close_sale_time` datetime DEFAULT NULL COMMENT '定时下架时间',
  `open_sale` int(11) DEFAULT NULL COMMENT '上架操作: 0上架、1有库存时上架、2定时上架 3有库存时上架(永久生效)',
  `open_sale_time` datetime DEFAULT NULL COMMENT '定时上架时间',
  `sales_mode` int(11) DEFAULT '0' COMMENT '销售模式；0-普通，1-团购，2日限购，3-永久限购，4新手限购，5订单限购',
  `corner_status` int(11) DEFAULT '1' COMMENT '角标状态 0-关闭 1-开启',
  `corner_open_time` datetime DEFAULT NULL COMMENT '角标生效时间',
  `m_type` int(11) NOT NULL DEFAULT '0' COMMENT '是否是大客户 0-不是 1-是',
  `interest_rate_fluctuation` decimal(10,4) DEFAULT NULL COMMENT '毛利波动',
  `price_fluctuation` decimal(10,4) DEFAULT NULL COMMENT '价格波动',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态:0-确认中 1-执行中 2-已生效',
  `limited_quantity` int(11) DEFAULT NULL COMMENT '限购数量',
  PRIMARY KEY (`id`),
  KEY `idx_sku` (`sku`),
  KEY `idx_copy_id` (`copy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32650 DEFAULT CHARSET=utf8 COMMENT='运营区域复制详情'
---
DDL for table: area_manage
CREATE TABLE `area_manage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manage` varchar(30) DEFAULT NULL COMMENT '合伙人名称',
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='仓库所属管理员表'
---
DDL for table: area_market_rule
CREATE TABLE `area_market_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_id` int(11) DEFAULT NULL COMMENT '营销主键',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `area_name` varchar(45) DEFAULT NULL COMMENT '城市名称',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `area_market_rule_uq` (`area_no`,`rule_id`) USING BTREE,
  KEY `idx_rule_id` (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8016 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='营销规则-分城市信息'
---
DDL for table: area_sku
CREATE TABLE `area_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `quantity` int(10) DEFAULT '0' COMMENT '可售库存',
  `share` tinyint(1) DEFAULT '1' COMMENT '1使用虚拟库存0不',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `price` decimal(10,2) DEFAULT NULL COMMENT '销售价',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `on_sale` tinyint(1) DEFAULT '0' COMMENT '0下架 1上架',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `priority` int(11) DEFAULT '99' COMMENT '越小排序越靠前',
  `pd_priority` int(11) DEFAULT '99',
  `ladder_price` varchar(500) DEFAULT NULL,
  `limited_quantity` int(11) DEFAULT NULL,
  `sales_mode` int(2) DEFAULT '0',
  `show` int(11) DEFAULT '0',
  `info` varchar(255) DEFAULT '',
  `m_type` int(2) NOT NULL DEFAULT '0' COMMENT '是否是大客户0 不是 1是',
  `show_advance` tinyint(1) DEFAULT '0' COMMENT '是否展示预告:0否 1是',
  `advance` varchar(50) DEFAULT NULL COMMENT '预告信息',
  `corner_status` int(11) DEFAULT '1' COMMENT '角标状态 0、关闭 1、开启',
  `corner_open_time` datetime DEFAULT NULL,
  `open_sale` int(11) DEFAULT NULL COMMENT '上架操作: 0上架、1有库存时上架、2定时上架 3有库存时上架(永久生效)',
  `open_sale_time` datetime DEFAULT NULL COMMENT '定时上架时间',
  `close_sale` int(11) DEFAULT NULL COMMENT '下架操作: 0下架、1售罄下架、2定时下架',
  `close_sale_time` datetime DEFAULT NULL COMMENT '定时下架时间',
  `fix_flag` int(11) DEFAULT '0' COMMENT '固定排序标识 0、关闭 1、开启',
  `fix_num` int(11) DEFAULT NULL COMMENT '固定排序值',
  `updater` varchar(64) DEFAULT NULL COMMENT '上下架更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_sku` (`sku`,`area_no`) USING BTREE,
  KEY `idx_area_sku_pd_priority` (`area_no`,`on_sale`,`show`,`pd_priority`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77034 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: area_sku_bak
CREATE TABLE `area_sku_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `sku` varchar(30) DEFAULT NULL COMMENT '商品编号',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `quantity` int(11) DEFAULT '0' COMMENT '可售库存',
  `share` tinyint(4) DEFAULT '1' COMMENT '1使用虚拟库存0不',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `price` decimal(10,2) DEFAULT NULL COMMENT '销售价',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `on_sale` tinyint(4) DEFAULT '0' COMMENT '0下架 1上架',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `priority` int(11) DEFAULT '99' COMMENT '越小排序越靠前',
  `pd_priority` int(11) DEFAULT '99' COMMENT '排序',
  `ladder_price` varchar(500) DEFAULT NULL COMMENT '阶梯价',
  `limited_quantity` int(11) DEFAULT NULL COMMENT '限购数量',
  `sales_mode` int(11) DEFAULT '0' COMMENT '销售模式；0普通，1团购，2日限购，3永久限购，4新手限购，5订单限购',
  `show` int(11) DEFAULT '0' COMMENT '是否展示在首页',
  `info` varchar(255) DEFAULT '' COMMENT '介绍',
  `m_type` int(11) NOT NULL DEFAULT '0' COMMENT '是否是大客户0 不是 1是',
  `show_advance` tinyint(4) DEFAULT '0' COMMENT '是否展示预告:0否 1是',
  `advance` varchar(50) DEFAULT NULL COMMENT '预告信息',
  `corner_status` int(11) DEFAULT '1' COMMENT '角标状态 0、关闭 1、开启',
  `corner_open_time` datetime DEFAULT NULL COMMENT '角标生效时间',
  `fix_num` int(11) DEFAULT NULL COMMENT '固定排序值',
  `fix_flag` int(11) DEFAULT '0' COMMENT '固定排序标识 0、关闭 1、开启',
  `close_sale_time` datetime DEFAULT NULL COMMENT '定时下架时间',
  `close_sale` int(11) DEFAULT NULL COMMENT '下架操作: 0下架、1售罄下架、2定时下架',
  `open_sale_time` datetime DEFAULT NULL COMMENT '定时上架时间',
  `open_sale` int(11) DEFAULT NULL COMMENT '上架操作: 0上架、1有库存时上架、2定时上架 3有库存时上架(永久生效)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_sku` (`sku`,`area_no`) USING BTREE,
  KEY `index_area_no` (`area_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28087 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='城市商品数据备份表'
---
DDL for table: area_sku_record
CREATE TABLE `area_sku_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recorder` varchar(36) DEFAULT NULL COMMENT '记录人',
  `sku` varchar(30) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `type_name` varchar(50) DEFAULT NULL COMMENT '记录操作类型:上下架',
  `result_status` tinyint(1) DEFAULT '0' COMMENT '操作结果',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `area_sku_record_index_index` (`type_name`,`area_no`,`sku`,`result_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49704 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='城市sku操作记录表'
---
DDL for table: area_sku_temp
CREATE TABLE `area_sku_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `on_sale` tinyint(1) DEFAULT '0' COMMENT '0下架 1上架',
  `show` tinyint(1) DEFAULT '0' COMMENT '是否展示在首页 0、不展示 1、展示',
  `m_type` int(2) DEFAULT '0' COMMENT '是否是大客户0 不是 1是',
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='城市sku临时记录'
---
DDL for table: area_store
CREATE TABLE `area_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku编号',
  `quantity` int(10) unsigned DEFAULT '0' COMMENT '仓库库存数量',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `admin_id` int(11) DEFAULT NULL COMMENT '采购负责人ID',
  `lead_time` int(3) DEFAULT '0' COMMENT '采购提前期',
  `market_price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  `cost_price` decimal(10,2) DEFAULT NULL COMMENT '采购价',
  `price_status` int(2) NOT NULL DEFAULT '0',
  `online_quantity` int(10) unsigned DEFAULT '0' COMMENT '线上库存',
  `sale_lock_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '销售冻结',
  `lock_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '锁定库存',
  `road_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '在途库存',
  `sync` int(2) NOT NULL DEFAULT '1' COMMENT '是否同步',
  `safe_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '安全库存',
  `change` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '变化值',
  `status` int(2) DEFAULT '0' COMMENT 'sku状态,0正常,1采购入库中,2出入库中,3盘点中',
  `auto_transfer` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否自动生成转换任务',
  `support_reserved` int(11) DEFAULT '0' COMMENT '是否支持 预留库存',
  `reserve_max_quantity` int(11) DEFAULT '0' COMMENT '预留库存最大值',
  `reserve_min_quantity` int(11) DEFAULT '0' COMMENT '预留库存最小值',
  `reserve_use_quantity` int(11) DEFAULT '0' COMMENT '预留库存使用值',
  `warning_quantity` int(11) DEFAULT NULL COMMENT '预警库存',
  `send_warning_flag` int(11) DEFAULT '0' COMMENT '0 未提醒预警 1 已提醒预警',
  `advance_quantity` int(10) unsigned DEFAULT '0' COMMENT '采购预售库存',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)，鲜沐为1',
  `warehouse_tenant_id` bigint(20) DEFAULT '1' COMMENT '仓库租户id(saas品牌方)，鲜沐为1',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_sku` (`area_no`,`sku`) USING BTREE,
  KEY `area_store_sku_index` (`sku`) USING BTREE,
  KEY `idx_wno_quantity` (`area_no`,`quantity`)
) ENGINE=InnoDB AUTO_INCREMENT=6789066 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='城市实际库存表'
---
DDL for table: area_store_bak
CREATE TABLE `area_store_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku编号',
  `quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '仓库库存数量',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `admin_id` int(11) DEFAULT NULL COMMENT '采购负责人ID',
  `lead_time` int(3) DEFAULT '0' COMMENT '采购提前期',
  `cost_price` decimal(10,2) DEFAULT NULL,
  `market_price` decimal(10,2) DEFAULT NULL,
  `price_status` int(2) DEFAULT '0',
  `online_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '线上库存',
  `sale_lock_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '销售冻结',
  `lock_quantity` int(11) unsigned NOT NULL DEFAULT '0',
  `road_quantity` int(11) unsigned NOT NULL DEFAULT '0',
  `sync` int(2) NOT NULL DEFAULT '1',
  `safe_quantity` int(11) NOT NULL DEFAULT '0',
  `change` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(2) DEFAULT '0' COMMENT 'sku状态,0正常,1采购入库中,2出入库中,3盘点中',
  `trust_store_no` int(11) DEFAULT NULL COMMENT '城市仓的托管中心仓编号',
  `trust_store_name` varchar(50) DEFAULT NULL,
  `auto_transfer` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否自动生成转换任务',
  `support_reserved` int(11) DEFAULT '0' COMMENT '是否支持 预留库存 0 不支持 1 支持',
  `reserve_max_quantity` int(11) DEFAULT '0' COMMENT '预留库存最大值',
  `reserve_min_quantity` int(11) DEFAULT '0' COMMENT '预留库存最小值',
  `reserve_use_quantity` int(11) DEFAULT '0' COMMENT '预留库存使用值',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `area_store_unique_index` (`area_no`,`sku`) USING BTREE,
  KEY `area_store_trust_index` (`trust_store_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36994 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='城市实际库存表'
---
DDL for table: area_store_status
CREATE TABLE `area_store_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku编号',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` int(2) DEFAULT '0' COMMENT 'sku状态,0正常,1采购入库中,2出入库中,3盘点中',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_sku` (`warehouse_no`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='仓库sku状态表'
---
DDL for table: area_suit
CREATE TABLE `area_suit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) DEFAULT NULL COMMENT '套装名称',
  `status` tinyint(1) DEFAULT '0' COMMENT '0下架，1上架',
  `quantity` int(10) DEFAULT '0' COMMENT '组合包数量',
  `sales_mode` int(5) DEFAULT '0' COMMENT '售卖方式：0正常，1，2日限购',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `area_name` varchar(45) DEFAULT NULL COMMENT '城市名称',
  `limited_quantity` int(10) DEFAULT NULL,
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `updatetime` datetime DEFAULT NULL,
  `priority` int(11) DEFAULT '99' COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `area_suit_uq` (`suit_id`,`area_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1664 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='组合包-分城市信息'
---
DDL for table: area_top
CREATE TABLE `area_top` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `top_id` int(11) DEFAULT NULL COMMENT '置顶购物车主键',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `area_name` varchar(45) DEFAULT NULL COMMENT '城市名称',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `area_top_uq` (`area_no`,`top_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=294 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='置顶购物车-分城市信息'
---
DDL for table: area_warehouse
CREATE TABLE `area_warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` date DEFAULT NULL COMMENT '添加时间',
  `update_time` date DEFAULT NULL COMMENT '修改时间',
  `area_no` int(11) DEFAULT NULL COMMENT '配送仓编号',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 失效 1生效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='配送仓对应的库存使用仓'
---
DDL for table: arrival_notice
CREATE TABLE `arrival_notice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `m_id` int(11) DEFAULT NULL,
  `mname` varchar(100) DEFAULT NULL,
  `add_time` datetime DEFAULT NULL,
  `sku` varchar(200) DEFAULT NULL,
  `pd_name` varchar(200) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `store_no` int(11) DEFAULT NULL,
  `store_name` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1通知中 2已通知',
  `type` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0' COMMENT '订阅数量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `arrival_notice_sms_index` (`store_no`,`sku`,`m_id`,`status`),
  KEY `idx_mid_status_type` (`m_id`,`type`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=560 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: attr_item
CREATE TABLE `attr_item` (
  `ait_id` int(10) NOT NULL AUTO_INCREMENT,
  `attr_id` int(10) DEFAULT NULL,
  `specification` varchar(20) DEFAULT NULL COMMENT '属性值',
  `priority` int(5) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ait_id`) USING BTREE,
  KEY `FK_attribute` (`attr_id`) USING BTREE,
  CONSTRAINT `FK_attribute` FOREIGN KEY (`attr_id`) REFERENCES `attribute` (`attr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品属性'
---
DDL for table: attribute
CREATE TABLE `attribute` (
  `attr_id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute` varchar(255) DEFAULT NULL COMMENT '名称',
  `field` varchar(255) DEFAULT NULL COMMENT '字段名称',
  PRIMARY KEY (`attr_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品属性集'
---
DDL for table: auth_menu_purview_copy
CREATE TABLE `auth_menu_purview_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限Id',
  `menu_name` varchar(128) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限对应资源(URL)',
  `description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `son_purview` varchar(200) DEFAULT NULL COMMENT '关联权限',
  `system_origin` tinyint(4) DEFAULT NULL COMMENT '系统来源，0：srm 1:tms 2:admin 3:crm 4:cosfomanage 5:cosfo ',
  `type` tinyint(4) DEFAULT '0' COMMENT '0 菜单 1模块 2按钮 ',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_updater` varchar(64) DEFAULT NULL COMMENT '最后操作人ID',
  `update_time` datetime DEFAULT NULL COMMENT '最后更改时间',
  `purview_name` varchar(255) DEFAULT NULL COMMENT '权限 名称',
  `weight` int(10) DEFAULT NULL COMMENT '权重',
  `default_type` int(10) DEFAULT '0' COMMENT '0 默认 1超级管理员的',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_origin` (`system_origin`),
  KEY `idx_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104325 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表'
---
DDL for table: auth_menu_purview_copy_copy1
CREATE TABLE `auth_menu_purview_copy_copy1` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限Id',
  `menu_name` varchar(128) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限对应资源(URL)',
  `description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `son_purview` varchar(200) DEFAULT NULL COMMENT '关联权限',
  `system_origin` tinyint(4) DEFAULT NULL COMMENT '系统来源，0：srm 1:tms 2:admin 3:crm 4:cosfomanage 5:cosfo ',
  `type` tinyint(4) DEFAULT '0' COMMENT '0 菜单 1模块 2按钮 ',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_updater` varchar(64) DEFAULT NULL COMMENT '最后操作人ID',
  `update_time` datetime DEFAULT NULL COMMENT '最后更改时间',
  `purview_name` varchar(255) DEFAULT NULL COMMENT '权限 名称',
  `weight` int(10) DEFAULT NULL COMMENT '权重',
  `default_type` int(10) DEFAULT '0' COMMENT '0 默认 1超级管理员的',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_origin` (`system_origin`),
  KEY `idx_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104325 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表'
---
DDL for table: auth_menu_purview_pro
CREATE TABLE `auth_menu_purview_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限Id',
  `menu_name` varchar(128) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限对应资源(URL)',
  `description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `son_purview` varchar(200) DEFAULT NULL COMMENT '关联权限',
  `system_origin` tinyint(4) DEFAULT NULL COMMENT '系统来源，0：srm 1:tms 2:admin 3:crm 4:cosfomanage 5:cosfo ',
  `type` tinyint(4) DEFAULT '0' COMMENT '0 菜单 1模块 2按钮 ',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_updater` varchar(64) DEFAULT NULL COMMENT '最后操作人ID',
  `update_time` datetime DEFAULT NULL COMMENT '最后更改时间',
  `purview_name` varchar(255) DEFAULT NULL COMMENT '权限 名称',
  `weight` int(10) DEFAULT NULL COMMENT '权重',
  `default_type` int(10) DEFAULT '0' COMMENT '0 默认 1超级管理员的',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_origin` (`system_origin`),
  KEY `idx_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=200862 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表'
---
DDL for table: auth_role_purview_copy
CREATE TABLE `auth_role_purview_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色',
  `purview_id` int(11) NOT NULL COMMENT '权限',
  `tenant_id` int(11) DEFAULT '0' COMMENT '租户id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `weight` int(11) DEFAULT NULL COMMENT '权重',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_purview_id` (`purview_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32261 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色-权限关联表'
---
DDL for table: auth_role_purview_pro
CREATE TABLE `auth_role_purview_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色',
  `purview_id` int(11) NOT NULL COMMENT '权限',
  `tenant_id` int(11) DEFAULT '0' COMMENT '租户id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `weight` int(11) DEFAULT NULL COMMENT '权重',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_purview_id` (`purview_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210152 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色-权限关联表'
---
DDL for table: auth_role_purview_pro_copy1
CREATE TABLE `auth_role_purview_pro_copy1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色',
  `purview_id` int(11) NOT NULL COMMENT '权限',
  `tenant_id` int(11) DEFAULT '0' COMMENT '租户id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `weight` int(11) DEFAULT NULL COMMENT '权重',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_purview_id` (`purview_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59803 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色-权限关联表'
---
DDL for table: auth_user_role_copy
CREATE TABLE `auth_user_role_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色Id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10367 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员-角色关联表'
---
DDL for table: auth_user_role_pro
CREATE TABLE `auth_user_role_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色Id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25140 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理员-角色关联表'
---
DDL for table: banner
CREATE TABLE `banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) DEFAULT NULL COMMENT 'banner名称',
  `type` varchar(36) DEFAULT NULL COMMENT 'banner类型',
  `url` varchar(255) DEFAULT NULL COMMENT 'banner地址',
  `link` varchar(500) DEFAULT NULL COMMENT 'banner超链接地址',
  `status` tinyint(1) DEFAULT '0' COMMENT 'banner状态：0不展示，1展示 ',
  `position` int(3) DEFAULT '99' COMMENT 'banner位置',
  `updateTime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `area_no` int(11) DEFAULT '0',
  `group_id` int(11) DEFAULT NULL,
  `show_rule` tinyint(1) DEFAULT NULL COMMENT '展示规则',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `word` varchar(32) DEFAULT NULL COMMENT '投放文字',
  `color` varchar(16) DEFAULT NULL COMMENT '投放文字颜色',
  `link_type` tinyint(4) DEFAULT '0' COMMENT '跳转类型,0 无跳转，1 商品，2 省心送，3 抽奖，4 专题，5 频道',
  `link_biz_id` varchar(16) DEFAULT NULL COMMENT '跳转业务id，需要结合跳转类型',
  `weight` tinyint(4) DEFAULT '0' COMMENT '权重值，值越大权重越高',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `old_link_biz_id` varchar(16) DEFAULT NULL COMMENT '老的跳转业务id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_type_area` (`type`,`area_no`,`show_rule`) USING BTREE,
  KEY `idx_groupid` (`group_id`),
  KEY `idx_area` (`status`,`show_rule`,`area_no`)
) ENGINE=InnoDB AUTO_INCREMENT=55452 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='banner图片'
---
DDL for table: batch_prove
CREATE TABLE `batch_prove` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `batch` varchar(50) DEFAULT NULL COMMENT '批次号',
  `sku` varchar(50) DEFAULT NULL COMMENT '转出sku',
  `quality_inspection_report` varchar(255) DEFAULT NULL COMMENT '质检报告',
  `customs_declaration_certificate` varchar(255) DEFAULT NULL COMMENT '报关证明',
  `nucleic_acid_detection` varchar(255) DEFAULT NULL COMMENT '核酸检测',
  `disinfection_certificate` varchar(255) DEFAULT NULL COMMENT '消毒证明',
  `supervision_warehouse_certificate` varchar(255) DEFAULT NULL COMMENT '监管仓证明',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=495 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: batch_relation
CREATE TABLE `batch_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `current_batch_id` bigint(20) unsigned DEFAULT NULL COMMENT '新成本批次id',
  `origin_batch_id` bigint(20) unsigned DEFAULT NULL COMMENT '新成本批次id来源',
  `source_id` bigint(20) unsigned DEFAULT NULL COMMENT '业务id',
  `source_type` tinyint(4) DEFAULT NULL COMMENT '业务类型',
  `cost_formula` varchar(1024) DEFAULT NULL COMMENT '新成本批次id物流总成本计算公式',
  `ratio` decimal(10,2) DEFAULT '1.00' COMMENT '比例',
  PRIMARY KEY (`id`),
  KEY `ndx_batch_id` (`current_batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3604 DEFAULT CHARSET=utf8 COMMENT='成本批次关系表'
---
DDL for table: bd_ext
CREATE TABLE `bd_ext` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `admin_name` varchar(50) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL,
  `area_name` varchar(50) DEFAULT NULL,
  `private_num` int(11) DEFAULT NULL,
  `gmv_target` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `private_quota` decimal(10,2) DEFAULT '0.00' COMMENT '客情额度上限',
  `visit_target` int(11) DEFAULT NULL COMMENT '每日计划目标数',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind_admin_id` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: bi_day_cost
CREATE TABLE `bi_day_cost` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `store_no` int(11) DEFAULT NULL,
  `sku_cost` decimal(12,2) DEFAULT '0.00',
  `adddate` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `add_date_index` (`adddate`) USING BTREE,
  KEY `store_no_index` (`store_no`) USING BTREE,
  KEY `sku_index` (`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210152 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: bi_day_quantity
CREATE TABLE `bi_day_quantity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) DEFAULT NULL,
  `store_no` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `new_quantity` int(11) DEFAULT NULL,
  `adddate` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `in_ssa` (`sku`(191),`store_no`,`adddate`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1253 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: bi_on_sale_time
CREATE TABLE `bi_on_sale_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL,
  `on_sale_time` decimal(10,2) DEFAULT '0.00' COMMENT '上架时长(小时)',
  `result` tinyint(2) DEFAULT NULL COMMENT '最终状态',
  `add_date` date DEFAULT NULL COMMENT '日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `bi_onsale_index` (`sku`,`area_no`,`add_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1424977 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='每日上架时长'
---
DDL for table: bi_purchases_config
CREATE TABLE `bi_purchases_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchases_config_id` int(11) NOT NULL,
  `thirty_avg_quantity` decimal(10,2) DEFAULT NULL COMMENT '30天平均销量',
  `seven_quantity` int(10) DEFAULT NULL COMMENT '7天销量',
  `seven_avg_quantity` decimal(10,2) DEFAULT NULL COMMENT '7天平均销量',
  `last_seven_quantity` int(10) DEFAULT NULL COMMENT '上个7天销量',
  `turn_over_day` int(10) DEFAULT NULL COMMENT '周转天数',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_purchases_config_id` (`purchases_config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14050355 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购信息配置bi表'
---
DDL for table: bi_stock_up
CREATE TABLE `bi_stock_up` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) NOT NULL,
  `area_no` int(10) DEFAULT NULL,
  `seven_avg_quantity` int(10) DEFAULT '0' COMMENT '7天平均销量',
  `stock_up_quantity` int(10) DEFAULT '0' COMMENT '备货量',
  `add_date` date DEFAULT NULL COMMENT '有效日期',
  `seven_other_quantity` int(11) DEFAULT '0' COMMENT '七天其他平均出库量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_sku_areaNo_date` (`sku`,`area_no`,`add_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12930 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='备货量表'
---
DDL for table: bi_stock_up_config
CREATE TABLE `bi_stock_up_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL,
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='中心仓预测配置表'
---
DDL for table: big_financial_invoice_sku
CREATE TABLE `big_financial_invoice_sku` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单号',
  `batch_no` varchar(36) DEFAULT NULL COMMENT '批次号',
  `sku` varchar(64) DEFAULT NULL COMMENT 'sku',
  `price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `order_sku_amount` int(11) DEFAULT NULL COMMENT 'sku个数',
  `bill_number` varchar(50) DEFAULT NULL COMMENT '账单编号',
  `invoice_id` bigint(20) DEFAULT NULL COMMENT '发票id',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0正常  1已完成 2失败 -1废弃',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建该发票时提交时间',
  `red_sku_amount` int(11) DEFAULT '0' COMMENT '已经红冲的sku个数',
  `pd_name` varchar(128) DEFAULT NULL COMMENT '名称',
  `weight` varchar(64) DEFAULT NULL COMMENT '规格',
  PRIMARY KEY (`id`),
  KEY `idx_order_no_batch_no` (`order_no`,`batch_no`),
  KEY `idx_invoice_id` (`invoice_id`),
  KEY `idx_order_no_sku` (`order_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8 COMMENT='大发票sku详情'
---
DDL for table: bms_calculation_details
CREATE TABLE `bms_calculation_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `type` int(11) DEFAULT NULL COMMENT '类型 0为系统固定',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `source_id` int(11) DEFAULT NULL COMMENT '来源id',
  `calculate_cost_id` int(11) DEFAULT NULL COMMENT '报价结算id',
  `source_type` tinyint(4) DEFAULT NULL COMMENT '来原类型 0 城配结算',
  `calculate_cost_name` varchar(255) DEFAULT NULL COMMENT '费用项名称',
  PRIMARY KEY (`id`),
  KEY `idx_source_id` (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34702 DEFAULT CHARSET=utf8 COMMENT='账单详情'
---
DDL for table: bms_calculation_details_record
CREATE TABLE `bms_calculation_details_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_settle_accounts_detail_id` int(11) DEFAULT NULL COMMENT '路线结算单详情id',
  `delivery_quotation_detail_id` int(11) DEFAULT NULL COMMENT '配送单报价详情id',
  `amount` varchar(50) DEFAULT NULL COMMENT '金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统结算项信息记录'
---
DDL for table: bms_calculation_item
CREATE TABLE `bms_calculation_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `quote_name` varchar(255) DEFAULT NULL COMMENT '报价清单名称',
  `type` tinyint(4) DEFAULT '1' COMMENT '类型， 0系统报价，1自定义报价',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位（已废弃）',
  `source_type` tinyint(4) DEFAULT NULL COMMENT '来源类型 0报价详情 1 计算模型 2 计量类目)',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  PRIMARY KEY (`id`),
  KEY `idx_quote_name_type` (`quote_name`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8 COMMENT='计算项'
---
DDL for table: bms_calculation_item_detail
CREATE TABLE `bms_calculation_item_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `item_id` bigint(20) unsigned DEFAULT NULL COMMENT '父表（bms_calculation_item）',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `system_load` int(11) DEFAULT NULL COMMENT '系统取值（0 没选中 1选中）',
  `manual_load` int(11) DEFAULT NULL COMMENT '人工录入（0 没选中 1选中）',
  PRIMARY KEY (`id`),
  KEY `item_index` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8 COMMENT='报价类目/计量类目 单位配置'
---
DDL for table: bms_cost_adjustment
CREATE TABLE `bms_cost_adjustment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `applicant_admin_id` int(11) DEFAULT NULL COMMENT '发起人id',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态0审批中 1撤销 2审核失败 3审核成功',
  `approved_admin_id` int(11) DEFAULT NULL COMMENT '审批人id',
  `approved_time` datetime DEFAULT NULL COMMENT '通过时间',
  `settle_accounts_detail_id` int(11) DEFAULT NULL COMMENT '路线结算单详情id',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型:DELIVERY_BUSINESS城配，TRUNK_BUSINESS干线',
  `applicant_admin_name` varchar(255) DEFAULT NULL COMMENT '发起人名称',
  `approved_admin_name` varchar(255) DEFAULT NULL COMMENT '审批人名称',
  PRIMARY KEY (`id`),
  KEY `idx_settle_accounts_detail_id` (`settle_accounts_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=628 DEFAULT CHARSET=utf8 COMMENT='结算单详情费用调整单'
---
DDL for table: bms_cost_adjustment_detail
CREATE TABLE `bms_cost_adjustment_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `cost_adjustment_id` int(11) DEFAULT NULL COMMENT '调整单id',
  `source_id` int(11) DEFAULT NULL COMMENT '来源id',
  `old_amount` decimal(10,2) DEFAULT NULL COMMENT '原金额',
  `new_amount` decimal(10,2) DEFAULT NULL COMMENT '调整后金额',
  `remake` varchar(255) DEFAULT NULL COMMENT '备注',
  `source_type` int(11) DEFAULT '0' COMMENT '来源类型 0结算单',
  `expense_name` varchar(255) DEFAULT NULL COMMENT '费用项名称',
  PRIMARY KEY (`id`),
  KEY `idx_cost_adjustment_id` (`cost_adjustment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1621 DEFAULT CHARSET=utf8 COMMENT='费用调整单详情'
---
DDL for table: bms_delivery_quota_calculate_cost
CREATE TABLE `bms_delivery_quota_calculate_cost` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `bms_delivery_quotation_id` int(11) DEFAULT NULL COMMENT '报价单id',
  `calculate_name` varchar(255) DEFAULT NULL COMMENT '计算名',
  `formula` varchar(2000) DEFAULT NULL COMMENT '计算公式',
  `calculate_type` tinyint(4) DEFAULT '0' COMMENT '计费逻辑0线路计费，1区域计费',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态0正常，-1已删除',
  `calculate_method` varchar(255) DEFAULT 'SYSTEM_CALCULATE' COMMENT '计算方式（系统计算，直接取值）',
  PRIMARY KEY (`id`),
  KEY `idx_quotation_id` (`bms_delivery_quotation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28583 DEFAULT CHARSET=utf8 COMMENT='报价单计费模型'
---
DDL for table: bms_delivery_quota_calculate_cost_range
CREATE TABLE `bms_delivery_quota_calculate_cost_range` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `quote_calculate_cost_id` bigint(20) unsigned NOT NULL COMMENT '计费模型主键',
  `item_detail_id` bigint(20) unsigned NOT NULL COMMENT '类目id',
  `lower_limit` decimal(20,2) unsigned NOT NULL COMMENT '下限',
  `upper_limit` decimal(20,2) unsigned NOT NULL COMMENT '上限',
  `formula` varchar(255) NOT NULL COMMENT '公式',
  `quote_calculate_cost_name` varchar(255) NOT NULL COMMENT '计量类目名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8 COMMENT='区间计费模型'
---
DDL for table: bms_delivery_quotation
CREATE TABLE `bms_delivery_quotation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `last_update_id` int(11) DEFAULT NULL COMMENT '最后一次操作人',
  `status` int(11) DEFAULT '0' COMMENT '状态 0正常 -1作废',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `province` varchar(120) DEFAULT NULL COMMENT '省',
  `city` varchar(120) DEFAULT NULL COMMENT '市',
  `quota_type` int(11) DEFAULT NULL COMMENT '报价类型0内区 1外区',
  `service_area_id` int(11) DEFAULT NULL COMMENT '服务区域',
  `carrier_id` int(11) DEFAULT NULL COMMENT '承运商id',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `quota_form` tinyint(4) DEFAULT '0' COMMENT '报价形式0择优报价，1组合报价',
  `service_area_name` varchar(255) DEFAULT NULL COMMENT '服务区域名称',
  `bidder_id` bigint(20) DEFAULT NULL COMMENT '报价方主键 (承运商/供应商)',
  `bidder_name` varchar(255) DEFAULT NULL COMMENT '报价方',
  `quota_target_id` bigint(20) DEFAULT NULL COMMENT '报价对象主键(城配仓/承运商)',
  `quota_target_name` varchar(255) DEFAULT NULL COMMENT '报价对象名称',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型(DELIVERY_BUSINESS/TRUNK_BUSINESS)',
  `create_user_name` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `update_user_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `trunk_batch_type` int(11) DEFAULT NULL COMMENT '干线用车类型',
  `car_type` int(11) DEFAULT NULL COMMENT '车型',
  `storage_type` int(11) DEFAULT NULL COMMENT '存储类型',
  `path_feature` varchar(1024) DEFAULT NULL COMMENT '干线站点列表',
  `start_path_id` bigint(20) DEFAULT NULL COMMENT '开始点位',
  `start_path_type` int(11) DEFAULT NULL COMMENT '开始点位',
  `end_path_id` bigint(20) DEFAULT NULL COMMENT '终点点位',
  `end_path_type` int(11) DEFAULT NULL COMMENT '终点点位',
  PRIMARY KEY (`id`),
  KEY `idx_store_no_province_city_carrier_id` (`store_no`,`province`,`city`,`carrier_id`),
  KEY `idx_province_city_carrier_id` (`province`,`city`,`carrier_id`),
  KEY `idx_carrier_id` (`carrier_id`),
  KEY `bidder_index` (`bidder_id`),
  KEY `target_index` (`quota_target_id`),
  KEY `business_index` (`business_type`,`car_type`,`trunk_batch_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1639 DEFAULT CHARSET=utf8 COMMENT='城配报价单'
---
DDL for table: bms_delivery_quotation_area
CREATE TABLE `bms_delivery_quotation_area` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `area` varchar(255) DEFAULT NULL COMMENT '区域',
  PRIMARY KEY (`id`),
  KEY `idx_area` (`area`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='服务区域'
---
DDL for table: bms_delivery_quotation_detail
CREATE TABLE `bms_delivery_quotation_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `bms_calculation_item_id` int(11) DEFAULT NULL COMMENT '计算项id',
  `bms_delivery_quotation_id` int(11) DEFAULT NULL COMMENT '报价单id',
  `amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '金额/点位',
  `bms_calculation_item_name` varchar(255) DEFAULT NULL COMMENT '计算项名称',
  `unit` varchar(255) DEFAULT NULL COMMENT '计费单位',
  `bms_calculation_item_detail_id` bigint(20) unsigned DEFAULT NULL COMMENT '计算项详情id',
  `backup_calculation_item_id` int(11) DEFAULT NULL COMMENT '计算项id(备份)',
  PRIMARY KEY (`id`),
  KEY `idx_bms_delivery_quotation_id` (`bms_delivery_quotation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2898 DEFAULT CHARSET=utf8 COMMENT='配送报价单报价详情'
---
DDL for table: bms_delivery_quotation_region
CREATE TABLE `bms_delivery_quotation_region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_quotation_id` bigint(20) DEFAULT NULL COMMENT '报价单id',
  `area` varchar(120) DEFAULT NULL COMMENT '区/县',
  PRIMARY KEY (`id`),
  KEY `idx_area` (`area`)
) ENGINE=InnoDB AUTO_INCREMENT=4025 DEFAULT CHARSET=utf8 COMMENT='城配报价单区域表'
---
DDL for table: bms_delivery_quote_calculate_cost_relation
CREATE TABLE `bms_delivery_quote_calculate_cost_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `quote_calculate_cost_id` bigint(20) unsigned DEFAULT NULL COMMENT '计费模型id',
  `item_detail_id` bigint(20) unsigned DEFAULT NULL COMMENT '类目详情id',
  `item_name` varchar(255) DEFAULT NULL COMMENT '类目名称',
  `item_unit` varchar(255) DEFAULT NULL COMMENT '类目单位',
  `item_source_type` int(11) DEFAULT NULL COMMENT '来源类型',
  `quota_calculate_cost_range_id` bigint(20) unsigned DEFAULT NULL COMMENT '区间id',
  PRIMARY KEY (`id`),
  KEY `quote_index` (`quote_calculate_cost_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2552 DEFAULT CHARSET=utf8 COMMENT='计费模型 选中的类目集合'
---
DDL for table: bms_delivery_reconciliation
CREATE TABLE `bms_delivery_reconciliation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `reconciliation_no` varchar(30) DEFAULT NULL COMMENT '对账单编号',
  `service_area_id` int(11) DEFAULT NULL COMMENT '服务区域id',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `carrier_id` int(11) DEFAULT NULL COMMENT '承运商id',
  `payable_amount` decimal(10,2) DEFAULT NULL COMMENT '应付金额',
  `actual_amount` decimal(10,2) DEFAULT NULL COMMENT '实际付款金额',
  `deduction_amount` decimal(10,2) DEFAULT '0.00' COMMENT '扣减金额',
  `payment_documents_id` int(11) DEFAULT NULL COMMENT '打款单id',
  `remake` varchar(255) DEFAULT NULL COMMENT '备注',
  `reconciliation_proof_url` varchar(500) DEFAULT NULL COMMENT '明细对账凭证',
  `status` int(11) DEFAULT '0' COMMENT '状态 0待对账  1已对账  2审批中      3 审批失败',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `advance_warehouse_amount` decimal(10,2) DEFAULT '0.00' COMMENT '前置仓应付金额',
  `updater` int(11) DEFAULT NULL COMMENT '最后更新人',
  `overhead` decimal(10,2) DEFAULT '0.00' COMMENT '管理费用',
  `tax` decimal(10,2) DEFAULT '0.00' COMMENT '税费',
  `settle_month` varchar(255) DEFAULT NULL COMMENT '结算月份',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `reconciliation_dimension_key` varchar(255) DEFAULT NULL COMMENT '对账维度主键（城配仓编号/干线用车类型）',
  `service_area_name` varchar(255) DEFAULT NULL COMMENT '服务区域',
  `create_user_name` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_user_name` varchar(255) DEFAULT NULL COMMENT '更新人',
  `payment_doc_no` varchar(255) DEFAULT NULL COMMENT '对账单编号',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '商户',
  PRIMARY KEY (`id`),
  KEY `idx_payment_documents_id` (`payment_documents_id`),
  KEY `idx_carrier_id_reconciliation_no_store_no` (`carrier_id`,`reconciliation_no`,`store_no`),
  KEY `idx_reconciliation_no_store_no` (`reconciliation_no`,`store_no`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8 COMMENT='配送对账单'
---
DDL for table: bms_delivery_reconciliation_adjustment
CREATE TABLE `bms_delivery_reconciliation_adjustment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `applicant_admin_id` int(11) DEFAULT NULL COMMENT '发起人',
  `approved_admin_id` int(11) DEFAULT NULL COMMENT '审批人',
  `approves_time` datetime DEFAULT NULL COMMENT '审批通过时间',
  `source_id` int(11) DEFAULT NULL COMMENT '来源id',
  `source_type` tinyint(4) DEFAULT NULL COMMENT '来源类型 0对账单 1结算单',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态0审批中 1撤销 2审核失败 3审核成功',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型:DELIVERY_BUSINESS城配，TRUNK_BUSINESS干线',
  `applicant_admin_name` varchar(255) DEFAULT NULL COMMENT '发起人名称',
  `approved_admin_name` varchar(255) DEFAULT NULL COMMENT '审批人名称',
  PRIMARY KEY (`id`),
  KEY `idx_source_id_type` (`source_id`,`source_type`)
) ENGINE=InnoDB AUTO_INCREMENT=625 DEFAULT CHARSET=utf8 COMMENT='配送对账单调整单信息'
---
DDL for table: bms_delivery_reconciliation_adjustment_detail
CREATE TABLE `bms_delivery_reconciliation_adjustment_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `reconciliation_adjustment_id` int(11) DEFAULT NULL COMMENT '调整单id',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型 0 应付 1 扣减 2 卸货',
  `old_amount` decimal(10,2) DEFAULT NULL COMMENT '原金额',
  `new_amount` decimal(10,2) DEFAULT NULL COMMENT '调整后金额',
  `remake` varchar(255) DEFAULT NULL COMMENT '调整原因',
  `expense_name` varchar(255) DEFAULT NULL COMMENT '费用项名称',
  PRIMARY KEY (`id`),
  KEY `idx_reconciliation_adjustment_id` (`reconciliation_adjustment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=946 DEFAULT CHARSET=utf8 COMMENT='配送对账单费用调整单详情'
---
DDL for table: bms_delivery_reconciliation_payment
CREATE TABLE `bms_delivery_reconciliation_payment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `reconciliation_id` bigint(20) unsigned DEFAULT NULL COMMENT '对账单主键',
  `payment_type` varchar(255) DEFAULT NULL COMMENT '打款方式',
  `payable_amount` decimal(10,2) DEFAULT NULL COMMENT '应付金额',
  PRIMARY KEY (`id`),
  KEY `reconciliation_index` (`reconciliation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=362 DEFAULT CHARSET=utf8 COMMENT='对账单 打款方式'
---
DDL for table: bms_delivery_settle_accounts_detail
CREATE TABLE `bms_delivery_settle_accounts_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `path` varchar(20) DEFAULT NULL COMMENT '路线',
  `have_spanned_area` tinyint(4) DEFAULT '0' COMMENT '是否存在跨区 0否 1是',
  `have_quotation_conflict` tinyint(4) DEFAULT '0' COMMENT '是否存在报价冲突 0否 1是',
  `total_position` int(10) unsigned DEFAULT NULL COMMENT '总点位数',
  `taxi_position` int(10) unsigned DEFAULT NULL COMMENT '打车点位',
  `no_delivery_time_position` int(11) DEFAULT NULL COMMENT '非当日配送点位数',
  `system_kilometers` decimal(10,2) unsigned DEFAULT NULL COMMENT '系统公里数',
  `actual_kilometers` decimal(10,2) unsigned DEFAULT NULL COMMENT '实际公里数',
  `load_factor` decimal(10,4) unsigned DEFAULT NULL COMMENT '满载率',
  `starting_kilometers` decimal(10,2) unsigned DEFAULT NULL COMMENT '起步公里数',
  `sku_quantity` int(10) unsigned DEFAULT NULL COMMENT '商品数量',
  `quotation_id` int(11) DEFAULT NULL COMMENT '报价单id',
  `driver` varchar(32) DEFAULT NULL COMMENT '司机',
  `starting_positions` decimal(10,0) unsigned DEFAULT NULL COMMENT '起步点位数',
  `car_type` int(11) DEFAULT NULL COMMENT '用车类型',
  `quotation_feature` text COMMENT '报价单快照',
  `fulfill_feature` varchar(1024) DEFAULT NULL COMMENT '履约快照',
  `fulfill_id` bigint(20) DEFAULT NULL COMMENT '履约主键',
  `weight` decimal(10,2) unsigned DEFAULT NULL COMMENT '重量',
  `volume` decimal(10,2) unsigned DEFAULT NULL COMMENT '体积',
  `product_quantity` int(11) DEFAULT NULL COMMENT '商品数量',
  `area` varchar(255) DEFAULT NULL COMMENT '区域',
  `shift_type` varchar(255) DEFAULT NULL COMMENT '班次类型',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `passing_area` varchar(255) DEFAULT NULL COMMENT '途径区/县',
  `province` varchar(255) DEFAULT NULL COMMENT '省',
  `city` varchar(255) DEFAULT NULL COMMENT '市',
  `system_recommended_kilometers` decimal(10,2) unsigned DEFAULT NULL COMMENT '系统推荐公里数',
  `fulfill_type` varchar(255) DEFAULT NULL COMMENT '履约类型',
  `volume_load_factor` decimal(10,2) DEFAULT NULL COMMENT '体积满载率',
  `weight_load_factor` decimal(10,2) DEFAULT NULL COMMENT '重量满载率',
  `quantity_load_factor` decimal(10,2) DEFAULT NULL COMMENT '件数满载率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4079 DEFAULT CHARSET=utf8 COMMENT='结算单详情'
---
DDL for table: bms_expense_item
CREATE TABLE `bms_expense_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `name` varchar(255) DEFAULT NULL COMMENT '费用项名称',
  `parent_id` bigint(20) unsigned DEFAULT NULL COMMENT '父节点',
  `item_type` varchar(255) DEFAULT NULL COMMENT '节点(LEAF_NODE :叶子节点, NORMAL_NODE：常规节点)',
  `level` int(11) DEFAULT NULL COMMENT '层级',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  PRIMARY KEY (`id`),
  KEY `business_level_index` (`business_type`,`level`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8 COMMENT='费用项'
---
DDL for table: bms_payee_adjust
CREATE TABLE `bms_payee_adjust` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_user_id` int(11) NOT NULL COMMENT '创建人id',
  `create_user_name` varchar(255) NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_user_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `update_user_name` varchar(255) DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `batch_no` varchar(255) NOT NULL COMMENT '变更收款方批次号（与子表bms_payee_adjust_record关联）',
  `business_type` varchar(255) NOT NULL COMMENT '业务类型:DELIVERY_BUSINESS城配TRUNK_BUSINESS干线',
  `old_payee_id` bigint(20) unsigned NOT NULL COMMENT '旧收款方id',
  `old_payee_name` varchar(255) NOT NULL COMMENT '旧收款方名称',
  `new_payee_id` bigint(20) unsigned NOT NULL COMMENT '新收款方id',
  `new_payee_name` varchar(255) NOT NULL COMMENT '新收款方名称',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `store_name` varchar(255) DEFAULT NULL COMMENT '城配仓名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` varchar(255) NOT NULL COMMENT '审批结果：APPROVING：审批中，APPROVAL_SUCCESS：审批成功，\\nTERMINATE：撤销，APPROVAL_FAIL：审批失败',
  `source_type` varchar(255) NOT NULL COMMENT '业务类型:SETTLE_ACCOUNT结算明细单,RECONCILIATION结算对账单',
  `reason` varchar(255) DEFAULT NULL COMMENT '申请原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='收款方变更表'
---
DDL for table: bms_payee_adjust_record
CREATE TABLE `bms_payee_adjust_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `source_id` bigint(20) unsigned NOT NULL COMMENT '来源id(结算单id/对账单id)',
  `source_type` varchar(255) NOT NULL COMMENT '类型, SETTLE_ACCOUNT结算单，RECONCILIATION对账单',
  `batch_no` varchar(255) NOT NULL COMMENT '雪花算法，这批变更数据的唯一标识',
  `status` varchar(255) NOT NULL COMMENT '审批结果：APPROVING：审批中，APPROVAL_SUCCESS：审批成功，\nTERMINATE：撤销，APPROVAL_FAIL：审批失败',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型:DELIVERY_BUSINESS城配TRUNK_BUSINESS干线',
  PRIMARY KEY (`id`),
  KEY `idx_source_id_type_status` (`source_id`,`source_type`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8 COMMENT='收款方变更记录表'
---
DDL for table: bms_payment_document
CREATE TABLE `bms_payment_document` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `payment_no` varchar(50) DEFAULT NULL COMMENT '打款单号',
  `payment_type` varchar(50) DEFAULT NULL COMMENT '付款方式',
  `payment_amount` decimal(10,2) unsigned DEFAULT '10.00' COMMENT '付款金额',
  `payment_status` tinyint(4) DEFAULT '0' COMMENT '打款状态 0待打款、1打款中、2打款失败、3打款成功',
  `invoice_status` tinyint(4) DEFAULT '0' COMMENT '任务状态 0待开票、1审核中、2审核失败、3已开票',
  `settle_account_url` varchar(255) DEFAULT NULL COMMENT '结算对账凭证',
  `creator` int(11) DEFAULT NULL COMMENT '创建人id',
  `remake` varchar(255) DEFAULT NULL COMMENT '备注',
  `invoice_id` int(11) DEFAULT NULL COMMENT '发票id',
  `status` tinyint(4) DEFAULT '0' COMMENT '打款单状态：0审核中 1审核失败 2审核成功',
  `carrier_id` int(11) DEFAULT NULL COMMENT '承运商id',
  `carrier_account_id` int(11) DEFAULT NULL COMMENT '打款方式id',
  `settle_month` varchar(50) DEFAULT NULL COMMENT '结算月份(数据来源是对应对账单创建时间的月份）',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `finance_payment_order_id` int(11) DEFAULT NULL COMMENT '财务付款单id',
  `business_type` varchar(255) DEFAULT NULL COMMENT '打款单类型(DELIVERY_BUSINESS（城配）,TRUNK_BUSINESS(干线))',
  `payment_account_feature` varchar(255) DEFAULT NULL COMMENT '支付账户快照',
  `payee_id` bigint(20) DEFAULT NULL COMMENT '收款人',
  `payee_name` varchar(255) DEFAULT NULL COMMENT '收款人',
  `payment_settle_feature` varchar(255) DEFAULT NULL COMMENT '结算方式快照',
  `total_amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '打款单总金额',
  PRIMARY KEY (`id`),
  KEY `idx_payment_no` (`payment_no`),
  KEY `idx_invoice_id` (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=451 DEFAULT CHARSET=utf8 COMMENT='结算打款单'
---
DDL for table: bms_payment_invoice_rel
CREATE TABLE `bms_payment_invoice_rel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `bms_payment_document_id` bigint(20) NOT NULL COMMENT '结算打款单id',
  `purchase_invoice_id` bigint(20) NOT NULL COMMENT '采购发票id',
  PRIMARY KEY (`id`),
  KEY `idx_payment_invoice` (`bms_payment_document_id`,`purchase_invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8 COMMENT='BMS打款发票关联表'
---
DDL for table: bms_position_relation
CREATE TABLE `bms_position_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `path_id` bigint(20) DEFAULT NULL COMMENT '点位id',
  `path_name` varchar(255) DEFAULT NULL COMMENT '点位名称',
  `path_type` int(11) DEFAULT NULL COMMENT '点位类型',
  `sequence` int(11) DEFAULT NULL COMMENT '点位下标',
  `sequence_type` varchar(32) DEFAULT NULL COMMENT '下标类型（START：起点  WAY：途中  END：终点）',
  `relation_id` bigint(20) DEFAULT NULL COMMENT '关联主键',
  `relation_type` varchar(64) DEFAULT NULL COMMENT '关联类型（TRUNK_QUOTE：干线报价单）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2526 DEFAULT CHARSET=utf8 COMMENT='bms路线信息关联表'
---
DDL for table: bms_quotation_process
CREATE TABLE `bms_quotation_process` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `creator` varchar(30) DEFAULT NULL COMMENT '操作人',
  `source_id` int(11) DEFAULT NULL COMMENT '来源id',
  `type` int(11) DEFAULT NULL COMMENT '账单类型：0结算明细单 1结算对账单 2结算打款单',
  `operation_content` varchar(30) DEFAULT NULL COMMENT '操作事项',
  `remark` varchar(1024) DEFAULT NULL COMMENT '审批备注',
  PRIMARY KEY (`id`),
  KEY `idx_source_id_type` (`source_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=15528 DEFAULT CHARSET=utf8 COMMENT='bms报价结算操作记录表'
---
DDL for table: bms_settle_account
CREATE TABLE `bms_settle_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态 0待核对 1已核对',
  `delivery_start_date` date DEFAULT NULL COMMENT '结算开始日期',
  `quotation_area_id` int(11) DEFAULT NULL COMMENT '服务区域id',
  `carrier_id` int(11) DEFAULT NULL COMMENT '承运商id',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `province` varchar(120) DEFAULT NULL COMMENT '省',
  `city` varchar(120) DEFAULT NULL COMMENT '市',
  `delivery_end_date` date DEFAULT NULL COMMENT '结算结束日期',
  `reconciliation_id` int(11) DEFAULT NULL COMMENT '对账单id',
  `discharge_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '卸货费用',
  `bidder_name` varchar(255) DEFAULT NULL COMMENT '报价方',
  `settle_target_id` bigint(20) DEFAULT NULL COMMENT '结算对象',
  `settle_target_name` varchar(255) DEFAULT NULL COMMENT '结算对象',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `settle_account_no` varchar(255) DEFAULT NULL COMMENT '明细单号',
  `quotation_area_name` varchar(255) DEFAULT NULL COMMENT '服务区域名称',
  `bidder_id` int(11) DEFAULT NULL COMMENT '报价方',
  `reconciliation_no` varchar(255) DEFAULT NULL COMMENT '对账单编号',
  PRIMARY KEY (`id`),
  KEY `idx_start_end_carrier_province_city` (`delivery_start_date`,`delivery_end_date`,`carrier_id`,`province`,`city`),
  KEY `idx_carrier_province_city` (`carrier_id`,`province`,`city`),
  KEY `idx_province_city` (`province`,`city`)
) ENGINE=InnoDB AUTO_INCREMENT=2545 DEFAULT CHARSET=utf8 COMMENT='结算单'
---
DDL for table: bms_settle_account_item
CREATE TABLE `bms_settle_account_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `settle_accounts_details_id` int(11) DEFAULT NULL COMMENT '结算单路线详情id',
  `settle_account_id` int(11) DEFAULT NULL COMMENT '结算单id',
  PRIMARY KEY (`id`),
  KEY `acc_id_index` (`settle_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4076 DEFAULT CHARSET=utf8 COMMENT='结算单条目'
---
DDL for table: board_position_info
CREATE TABLE `board_position_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `storage_type` int(11) DEFAULT NULL COMMENT '储存类别（整件/拆包）10-整件 20-拆包',
  `warehouse_no` bigint(20) unsigned NOT NULL COMMENT '仓库号',
  `layer_height` int(10) unsigned DEFAULT NULL COMMENT '层高',
  `storage_num` int(10) unsigned DEFAULT NULL COMMENT '箱入数',
  `layer_total` int(10) unsigned DEFAULT NULL COMMENT '层码放数量',
  `sku` varchar(128) NOT NULL COMMENT 'sku',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_warehouse_no_sku` (`warehouse_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=1871 DEFAULT CHARSET=utf8 COMMENT='板位需求'
---
DDL for table: brand
CREATE TABLE `brand` (
  `brand_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `alias` varchar(255) DEFAULT NULL COMMENT '别名',
  `logo_path` varchar(255) DEFAULT NULL COMMENT 'LOGO',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `firstcharacter` varchar(255) DEFAULT NULL COMMENT '品牌首字母',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`brand_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='品牌'
---
DDL for table: business_mission
CREATE TABLE `business_mission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmv` double DEFAULT NULL,
  `year` int(4) DEFAULT '1970' COMMENT '年份',
  `month` int(2) DEFAULT '1' COMMENT '月份',
  `update_time` datetime DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL COMMENT '二级城市',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='BD团队阅读GMV指标'
---
DDL for table: card
CREATE TABLE `card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '优惠卡名称',
  `code` varchar(36) DEFAULT NULL COMMENT '优惠卡代码',
  `card_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '优惠卡类型：0运费卡',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '优惠额度',
  `threshold` decimal(10,2) DEFAULT '0.00' COMMENT '使用阈值',
  `type` tinyint(2) DEFAULT '0' COMMENT '到期类型：0指固定时间间隔到期，1固定时间点到期',
  `vaild_date` datetime DEFAULT NULL COMMENT '有效日期',
  `vaild_time` int(11) DEFAULT NULL COMMENT '有效时间,单位：天',
  `grouping` int(5) DEFAULT '0' COMMENT '红包分组0活动1售后2新人3权益',
  `times` int(10) DEFAULT NULL COMMENT '使用次数',
  `remark` varchar(255) DEFAULT NULL,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(11) DEFAULT '1' COMMENT '1未删除 2已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_card_type` (`card_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='优惠卡'
---
DDL for table: card_rule
CREATE TABLE `card_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_id` int(11) NOT NULL COMMENT '优惠卡id',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `area_no` int(11) DEFAULT NULL COMMENT '所属城市',
  `merchant_type` tinyint(2) DEFAULT NULL COMMENT '客户类型:0新客户、1沉睡客户、2老客户',
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_area_no` (`area_no`) USING BTREE,
  KEY `index_merchant_type` (`merchant_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='优惠卡发放规则'
---
DDL for table: carrier
CREATE TABLE `carrier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `carrier_name` varchar(30) DEFAULT NULL COMMENT '承运商名称',
  `director` varchar(10) DEFAULT NULL COMMENT '负责人',
  `director_phone` char(11) DEFAULT NULL COMMENT '负责人电话',
  `address` varchar(50) DEFAULT NULL COMMENT '地址',
  `cooperation_agreement` varchar(50) DEFAULT NULL COMMENT '合作协议地址',
  `business_type` tinyint(4) DEFAULT '1' COMMENT '业务类型 0干线 1城配 2干线、城配',
  `social_credit_code` varchar(80) DEFAULT NULL COMMENT '社会信用代码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_carrier_name` (`carrier_name`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='承运商'
---
DDL for table: carrier_account
CREATE TABLE `carrier_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `carrier_id` bigint(20) DEFAULT NULL COMMENT '承运商id',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付方式 1、银行卡 2、现金',
  `account_name` varchar(50) DEFAULT NULL COMMENT '账户名称',
  `account_bank` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `account_ascription` varchar(50) DEFAULT NULL COMMENT '银行卡归属地',
  `account` varchar(50) DEFAULT NULL COMMENT '账号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_carrier_id` (`carrier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='承运商账户表'
---
DDL for table: carrier_invoice
CREATE TABLE `carrier_invoice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `carrier_id` bigint(20) DEFAULT NULL COMMENT '承运商id',
  `invoice_head` varchar(100) DEFAULT NULL COMMENT '发票抬头',
  `tax_no` varchar(80) DEFAULT NULL COMMENT '税号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_carrier_id` (`carrier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='承运商发票表'
---
DDL for table: carrier_quotation
CREATE TABLE `carrier_quotation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `creator` varchar(10) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(10) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `carrier_id` bigint(20) NOT NULL COMMENT '承运商id',
  `service_area` varchar(30) DEFAULT NULL COMMENT '服务区域',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `type` int(11) DEFAULT NULL COMMENT '0点位 1公里',
  `start_price` decimal(10,2) DEFAULT NULL COMMENT '起步价',
  `start_point_num` int(11) DEFAULT NULL COMMENT '起步点数',
  `exceed_point_price` decimal(10,2) DEFAULT NULL COMMENT '超点价',
  `subsidy_price` decimal(10,2) DEFAULT NULL COMMENT '补贴价',
  `printing_fee` decimal(10,2) DEFAULT NULL COMMENT '打印费',
  `front_warehouse_fee` decimal(10,2) DEFAULT NULL COMMENT '前置仓费',
  `km_price` decimal(10,2) DEFAULT NULL COMMENT '公里价',
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除状态 1是 0否',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_carrier_id` (`carrier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='承运商报价单'
---
DDL for table: carrier_quotation_area
CREATE TABLE `carrier_quotation_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `carrier_quotation_id` bigint(20) NOT NULL COMMENT '承运商报价单id',
  `province` varchar(30) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(20) DEFAULT NULL COMMENT '区',
  `county` varchar(20) DEFAULT NULL COMMENT '县',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_carrier_quotation_id` (`carrier_quotation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='承运商报价单区域表'
---
DDL for table: carrier_statement
CREATE TABLE `carrier_statement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_time` date DEFAULT NULL COMMENT '配送日期',
  `store_no` int(11) DEFAULT NULL COMMENT '服务城配仓',
  `path` varchar(10) DEFAULT NULL COMMENT '路线',
  `driver` varchar(30) DEFAULT NULL COMMENT '配送司机姓名',
  `carrier_name` varchar(30) DEFAULT NULL COMMENT '承运商名称',
  `service_area` varchar(30) DEFAULT NULL COMMENT '服务区域',
  `province_city` varchar(30) DEFAULT NULL COMMENT '服务省市',
  `area_county` varchar(255) DEFAULT NULL COMMENT '服务区县',
  `point_num` int(11) DEFAULT NULL COMMENT '点数',
  `start_point_num` int(11) DEFAULT NULL COMMENT '起步点数',
  `start_price` decimal(10,2) DEFAULT NULL COMMENT '起步价',
  `exceed_point_price` decimal(10,2) DEFAULT NULL COMMENT '超点价',
  `subsidy_price` decimal(10,2) DEFAULT NULL COMMENT '补贴费',
  `km` decimal(10,2) DEFAULT NULL COMMENT '预估公里数',
  `km_price` decimal(10,2) DEFAULT NULL COMMENT '预估公里价',
  `printing_fee` decimal(10,2) DEFAULT NULL COMMENT '打印费',
  `front_warehouse_fee` decimal(10,2) DEFAULT NULL COMMENT '前置仓费',
  `help_order_fee` decimal(10,2) DEFAULT NULL COMMENT '帮采费',
  `taxi_fare` decimal(10,2) DEFAULT NULL COMMENT '打车费',
  `exceed_point_num` int(11) DEFAULT NULL COMMENT '超点数',
  `carrier_quotation_id` bigint(20) DEFAULT NULL COMMENT '承运商报价单ID',
  `extra` decimal(10,2) DEFAULT NULL COMMENT '杂费',
  `delivery_car_id` int(11) DEFAULT NULL COMMENT '司机ID',
  `real_km` decimal(10,2) DEFAULT NULL COMMENT '实际公里数',
  `real_km_price` decimal(10,2) DEFAULT NULL COMMENT '实际公里价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='承运商结算单表'
---
DDL for table: carrier_statement_extras
CREATE TABLE `carrier_statement_extras` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(10) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater` varchar(10) DEFAULT NULL COMMENT '更新人',
  `delivery_car_path_id` bigint(20) DEFAULT NULL COMMENT '配送路线ID',
  `delivery_time` date DEFAULT NULL COMMENT '配送日期',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `path` varchar(10) DEFAULT NULL COMMENT '配送路线',
  `money` decimal(10,2) DEFAULT NULL COMMENT '费用',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_delivery_car_path_id` (`delivery_car_path_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='承运商结算单杂费表'
---
DDL for table: cash
CREATE TABLE `cash` (
  `cash_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `m_id` bigint(30) DEFAULT NULL COMMENT '商户ID',
  `account_id` bigint(30) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL COMMENT '提现金额',
  `status` int(11) DEFAULT NULL COMMENT '提现状态 0、审核失败 1、审核中 2、审核成功/支付中 3、支付成功 4、支付失败',
  `audit_admin` int(11) DEFAULT NULL COMMENT '审核人ID',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_remark` varchar(50) DEFAULT NULL COMMENT '审核备注',
  `response` varchar(500) DEFAULT NULL COMMENT '微信支付响应',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`cash_id`) USING BTREE,
  KEY `cash_mid_index` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='提现表'
---
DDL for table: cash_record
CREATE TABLE `cash_record` (
  `cr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `m_id` bigint(30) DEFAULT NULL COMMENT '商户ID',
  `account_id` bigint(30) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `business_id` int(11) DEFAULT NULL COMMENT '红包ID/提现ID',
  `type` int(11) DEFAULT NULL COMMENT '流水类型 0、红包入账增加金额 1、红包失效减少金额 2、提现减少金额 3、提现失败增加金额',
  `remark` varchar(50) DEFAULT NULL COMMENT '流水备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`cr_id`) USING BTREE,
  KEY `cash_record_mid_index` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流水记录表'
---
DDL for table: cash_to_rp
CREATE TABLE `cash_to_rp` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `cash_id` int(11) DEFAULT NULL COMMENT '提现ID',
  `rp_id` int(11) DEFAULT NULL COMMENT '红包ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `rp_to_cash_rpcash_index` (`cash_id`,`rp_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='红包提现中间表'
---
DDL for table: category
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `outdated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记位-过时的品类  1代表过时，商品被删除',
  `icon` varchar(255) DEFAULT NULL,
  `type` int(2) DEFAULT NULL COMMENT '1 全部,2乳制品,3非乳制品,4水果',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_outdated` (`outdated`,`type`),
  KEY `idx_parent_id` (`parent_id`,`outdated`)
) ENGINE=InnoDB AUTO_INCREMENT=2118 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='品类'
---
DDL for table: category_bak
CREATE TABLE `category_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `outdated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记位-过时的品类  1代表过时，商品被删除',
  `icon` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='品类'
---
DDL for table: category_coupon_quota
CREATE TABLE `category_coupon_quota` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` bigint(20) NOT NULL COMMENT 'bd id',
  `admin_name` varchar(50) NOT NULL COMMENT 'bd name',
  `quota` decimal(12,2) DEFAULT '0.00' COMMENT '额度',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='品类券额度表'
---
DDL for table: category_coupon_quota_change
CREATE TABLE `category_coupon_quota_change` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `admin_id` bigint(20) NOT NULL COMMENT '被分配的bd id',
  `admin_name` varchar(50) NOT NULL COMMENT 'bd name',
  `quota` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '变化金额',
  `base_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '底价',
  `reward_rule` int(11) DEFAULT '0' COMMENT '返现比例,需要 除以100',
  `type` tinyint(4) NOT NULL COMMENT '操作类型: 0设置;1:划分;2:发券;3:返还;4:品类拓宽',
  `merchant_coupon_id` int(11) DEFAULT NULL COMMENT '用户-券关联id',
  `dingtalk_biz_id` int(11) DEFAULT NULL COMMENT '业务数据id',
  `creator` bigint(20) DEFAULT NULL COMMENT '操作人',
  `creator_name` varchar(35) DEFAULT NULL COMMENT '操作人名称',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_dingtalk_biz_id` (`dingtalk_biz_id`),
  KEY `idx_admin_id_type` (`admin_id`,`type`),
  KEY `uk_merchant_coupon_id` (`merchant_coupon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=utf8 COMMENT='品类券额度变化表'
---
DDL for table: cbd_merchant
CREATE TABLE `cbd_merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` bigint(10) DEFAULT NULL COMMENT '门店编码',
  `name` varchar(255) DEFAULT NULL COMMENT '门店名称',
  `consignee_name` varchar(30) DEFAULT NULL COMMENT '收货人姓名',
  `receiving_address` varchar(255) DEFAULT NULL COMMENT '收货地址',
  `detailed_address` varchar(255) DEFAULT NULL COMMENT '详细收货地址',
  `consignee_phone` varchar(30) DEFAULT NULL COMMENT '收货电话',
  `contact_person` varchar(30) DEFAULT NULL COMMENT '联系人',
  `type` smallint(2) DEFAULT NULL COMMENT '0 新增 1 更新',
  `mark` smallint(2) DEFAULT NULL COMMENT '0 失败 1 成功',
  `count` int(11) DEFAULT NULL COMMENT '重试次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: change_fence
CREATE TABLE `change_fence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT '类型 0 切仓 1 切围栏',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 生效 1 失效 2 成功',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `fence_id` int(11) DEFAULT NULL COMMENT '围栏id',
  `change_to_fence_id` int(11) DEFAULT NULL COMMENT '切换到的围栏id',
  `change_to_store_no` int(11) DEFAULT NULL COMMENT '切换到配送仓',
  `change_acm_id` varchar(500) DEFAULT NULL COMMENT '区域id 多个区域 '',''分割',
  `exe_time` datetime DEFAULT NULL COMMENT '执行时间',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `operator` int(11) DEFAULT NULL COMMENT '操作人adminId',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: circle_people_relation
CREATE TABLE `circle_people_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `type` tinyint(1) DEFAULT NULL COMMENT '0秒杀、1严选',
  `rule_id` int(11) DEFAULT NULL COMMENT '具体规则id',
  `type_id` int(11) DEFAULT NULL COMMENT '营销活动id',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_type_id` (`type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1102 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='规则关系表'
---
DDL for table: circle_people_rule
CREATE TABLE `circle_people_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(30) DEFAULT NULL COMMENT '名称',
  `type` tinyint(1) DEFAULT NULL COMMENT '0上传execl',
  `file_id` varchar(255) DEFAULT NULL COMMENT '文件id',
  `error_report` varchar(255) DEFAULT NULL COMMENT '错误报告',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='规则明细'
---
DDL for table: circle_people_rule_admin
CREATE TABLE `circle_people_rule_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `rule_id` int(11) DEFAULT NULL COMMENT '具体规则id',
  `m_id` bigint(30) DEFAULT NULL COMMENT '客户id',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `circle_people_rule_admin_rule_id_m_id_index` (`rule_id`,`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106335 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='具体的圈人'
---
DDL for table: city_group
CREATE TABLE `city_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT '城市组名称',
  `content` text COMMENT '运营大区编号:城市编号集合',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0：禁用 1：启用',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `group_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: cms_component_content_detail
CREATE TABLE `cms_component_content_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `component_info_id` bigint(20) DEFAULT NULL COMMENT '组件基础信息id',
  `component_launch_id` bigint(20) DEFAULT NULL COMMENT '投放id',
  `priority` int(11) DEFAULT NULL COMMENT '排序值',
  `biz_info` varchar(128) DEFAULT NULL COMMENT '业务信息，图片地址/sku/优惠券id/tab名称',
  `link_type` tinyint(4) DEFAULT '0' COMMENT '跳转类型,0 无跳转，1 商品，2 省心送，3 抽奖，4 专题，5 频道，6 直播间',
  `link_biz_id` varchar(16) DEFAULT NULL COMMENT '跳转业务id，需要结合跳转类型',
  `relation_ids` varchar(256) DEFAULT NULL COMMENT 'tab标签关联的组件id,多个用逗号隔开',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_launch_id` (`component_launch_id`),
  KEY `idx_component_id` (`component_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45067 DEFAULT CHARSET=utf8mb4 COMMENT='单体组件投放内容明细表'
---
DDL for table: cms_component_info
CREATE TABLE `cms_component_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `page_info_id` bigint(20) DEFAULT NULL COMMENT '专题页id',
  `root` tinyint(4) DEFAULT '1' COMMENT '是否根组件，0 否，1 是',
  `component_type` tinyint(4) DEFAULT '0' COMMENT '是否容器组件，0 内容组件，1 容器组件',
  `priority` int(11) DEFAULT NULL COMMENT '楼层号()',
  `title` varchar(16) DEFAULT NULL COMMENT '组件标题',
  `type` tinyint(4) DEFAULT NULL COMMENT '组件类型，0 图片，1 商品，2 优惠券，3 tab',
  `style_type` tinyint(4) DEFAULT NULL COMMENT '组件模板样式',
  `style` varchar(1024) DEFAULT NULL COMMENT '组件样式json',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `updater_id` bigint(20) DEFAULT NULL COMMENT '修改人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_page_info_id` (`page_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9839 DEFAULT CHARSET=utf8 COMMENT='专题组件基础信息表'
---
DDL for table: cms_component_launch
CREATE TABLE `cms_component_launch` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `component_info_id` bigint(20) DEFAULT NULL COMMENT '组件基础信息id',
  `scope_id` bigint(20) DEFAULT '0' COMMENT '默认全部人群(子组件继承父组件的人群)',
  `scope_type` tinyint(4) DEFAULT NULL COMMENT '范围类型，0 全部，1 人群包，2 运营城市，3 运营大区',
  `priority` tinyint(4) DEFAULT NULL COMMENT '投放排序值(子组件只能是一个投放)',
  `filter_type` varchar(16) DEFAULT NULL COMMENT '过滤项，0 不过滤，1 （商品无库存、优惠券已抢光）',
  `show_limit` tinyint(4) DEFAULT NULL COMMENT '最多展示数量(只有商品组件需要)',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `updater_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_component_id` (`component_info_id`),
  KEY `idx_scope_id_type` (`scope_id`,`scope_type`)
) ENGINE=InnoDB AUTO_INCREMENT=11369 DEFAULT CHARSET=utf8 COMMENT='组件投放基础信息表'
---
DDL for table: cms_page_info
CREATE TABLE `cms_page_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) NOT NULL COMMENT '页面名称',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `publish_status` tinyint(4) DEFAULT '0' COMMENT '发布状态，0 草稿，1 已发布',
  `published` tinyint(4) DEFAULT '0' COMMENT '是否有发布版本，0 无，1 有',
  `publish_id` bigint(20) DEFAULT NULL COMMENT '关联的已发布专题页id',
  `background_color` varchar(16) DEFAULT NULL COMMENT '背景颜色',
  `button_type` varchar(64) DEFAULT NULL COMMENT '悬浮按钮位置，0 无， 1 首页， 2 购物车(可多选)',
  `page_share` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否允许页面分享，0 不允许，1 允许',
  `share_picture` varchar(64) DEFAULT NULL COMMENT '分享图地址',
  `share_title` varchar(32) DEFAULT NULL COMMENT '分享标题',
  `share_desc` varchar(64) DEFAULT NULL COMMENT '分享描述',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `updater_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_starttime_endtime` (`start_time`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=713 DEFAULT CHARSET=utf8 COMMENT='专题页信息表'
---
DDL for table: cms_tab_sub_component
CREATE TABLE `cms_tab_sub_component` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `content_detail_id` bigint(20) DEFAULT NULL COMMENT 'tab明细id',
  `component_info_id` bigint(20) DEFAULT NULL COMMENT '子组件基础信息id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_detail_id` (`content_detail_id`),
  KEY `idx_component_id` (`component_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3935 DEFAULT CHARSET=utf8 COMMENT='tab标签关联子组件表'
---
DDL for table: collocation
CREATE TABLE `collocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collocation_name` varchar(45) NOT NULL COMMENT '搭配购名称',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '搭配状态 0：禁用 1：启用',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `collocation_name_unique` (`collocation_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3492 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='搭配购包'
---
DDL for table: collocation_item
CREATE TABLE `collocation_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collocation_id` int(11) NOT NULL COMMENT '搭配购id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'skuId',
  `pd_name` varchar(45) DEFAULT NULL COMMENT '商品名称',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `collocation_id_index` (`collocation_id`) USING BTREE,
  KEY `sku_index` (`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7852 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='搭配购包下商品内容'
---
DDL for table: company_account
CREATE TABLE `company_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL COMMENT '企业名称',
  `wx_account_info` varchar(1000) NOT NULL COMMENT '微信支付账号信息',
  `admin_id` int(11) NOT NULL COMMENT '记录人id',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `channel` int(11) DEFAULT '1' COMMENT '账号渠道 0微信 1中银 2招行',
  `mch_app_id` varchar(50) DEFAULT NULL COMMENT '微信APPID',
  `mchx_app_id` varchar(50) DEFAULT NULL COMMENT '公众号APPID字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='企业支付账号信息'
---
DDL for table: complete_delivery
CREATE TABLE `complete_delivery` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '物流中心编号（配送仓编号）',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `complete_delivery_time` varchar(11) DEFAULT NULL COMMENT '配送完成时间',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 正常 1 暂停',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `region` varchar(50) DEFAULT NULL COMMENT '区域',
  `city` varchar(50) DEFAULT NULL COMMENT '城市名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='complete_delivery完成配送提醒表'
---
DDL for table: complete_delivery_ad_code_mapping
CREATE TABLE `complete_delivery_ad_code_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `ad_code` varchar(50) DEFAULT NULL COMMENT '区域编码',
  `complete_delivery_id` int(11) DEFAULT NULL COMMENT '完成配送提醒id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=810 DEFAULT CHARSET=utf8 COMMENT='配送提醒对应行政区域表'
---
DDL for table: complete_delivery_customer
CREATE TABLE `complete_delivery_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `complete_delivery_id` int(11) DEFAULT NULL COMMENT '完成配送提醒表id',
  `admin_id` int(11) DEFAULT NULL COMMENT '大客户id',
  `name_remakes` varchar(50) DEFAULT NULL COMMENT '大客户名称备注',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='complete_delivery_customer完成配送特殊客户表'
---
DDL for table: config
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(45) NOT NULL COMMENT '''配置键值''',
  `value` text COMMENT '''配置名称''',
  `remark` varchar(255) DEFAULT NULL COMMENT '''备注''',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_UNIQUE` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商城配置表'
---
DDL for table: contact
CREATE TABLE `contact` (
  `contact_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(30) DEFAULT NULL COMMENT ' 商户id',
  `contact` varchar(200) DEFAULT NULL COMMENT '联系人',
  `position` varchar(100) DEFAULT NULL COMMENT '职位',
  `gender` tinyint(1) DEFAULT '0' COMMENT '性别',
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `weixincode` varchar(30) DEFAULT NULL COMMENT '微信号',
  `province` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `area` varchar(50) DEFAULT '',
  `address` varchar(255) DEFAULT NULL,
  `delivery_car` varchar(20) DEFAULT NULL COMMENT '配送车',
  `status` int(11) DEFAULT '3' COMMENT '状态(1正常或审核通过、2删除、3待审核、4审核不通过)',
  `remark` varchar(255) DEFAULT NULL,
  `is_default` int(3) DEFAULT '0' COMMENT '1默认地址 与merchat中一致',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德地图poi坐标',
  `distance` decimal(10,2) DEFAULT '0.00' COMMENT '与仓库的距离',
  `path` varchar(20) DEFAULT NULL COMMENT '路线',
  `house_number` varchar(255) DEFAULT NULL COMMENT '门牌号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `store_no` int(11) DEFAULT NULL COMMENT '配送仓编号',
  `acm_id` int(11) DEFAULT NULL COMMENT '归属区域id adCodeMsg表',
  `back_store_no` int(11) DEFAULT NULL COMMENT '配送仓编号 备注',
  `delivery_frequent` varchar(30) DEFAULT NULL COMMENT '配送周期',
  `delivery_rule` varchar(255) DEFAULT NULL COMMENT '运费规则',
  `delivery_fee` decimal(12,2) DEFAULT NULL COMMENT '运费',
  `address_remark` varchar(255) DEFAULT NULL COMMENT '地址备注',
  PRIMARY KEY (`contact_id`) USING BTREE,
  KEY `FK_merchant` (`m_id`) USING BTREE,
  KEY `IN_phone` (`phone`) USING BTREE,
  KEY `idx_status` (`status`),
  KEY `idx_city_area` (`city`,`area`)
) ENGINE=InnoDB AUTO_INCREMENT=342656 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='联系人'
---
DDL for table: contact_adjust
CREATE TABLE `contact_adjust` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` date DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `m_id` int(11) DEFAULT NULL COMMENT '用户id',
  `contact_id` int(11) DEFAULT NULL COMMENT '地址表id',
  `new_poi` varchar(50) DEFAULT NULL COMMENT '新poi',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 待审核, 1 审核通过 ,2 拒绝重新交, 3 审核失败',
  `new_province` varchar(50) DEFAULT NULL COMMENT '省',
  `new_city` varchar(50) DEFAULT NULL COMMENT '市',
  `new_area` varchar(50) DEFAULT NULL COMMENT '区域',
  `new_address` varchar(500) DEFAULT NULL COMMENT '详细地址',
  `new_house_number` varchar(500) DEFAULT NULL COMMENT '门牌号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_contact_id` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户地址调整表'
---
DDL for table: contact_delivery_log
CREATE TABLE `contact_delivery_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `contact_id` bigint(20) DEFAULT NULL COMMENT '地址id',
  `delivery_frequent` varchar(20) DEFAULT NULL COMMENT '配送周期',
  `effect_flag` tinyint(4) DEFAULT NULL COMMENT '标识是否执行 0未执行 1已执行',
  `delete_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_contact_id` (`contact_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='地址配送调整日志表'
---
DDL for table: contact_operate_log
CREATE TABLE `contact_operate_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `contact_id` bigint(20) DEFAULT NULL COMMENT '联系人id',
  `m_id` bigint(20) DEFAULT NULL COMMENT '店铺id',
  `operate_name` varchar(32) DEFAULT NULL COMMENT '操作人名称',
  `operate_source` tinyint(4) DEFAULT NULL COMMENT '0鲜沐 1商城',
  `operate_type` tinyint(4) DEFAULT NULL COMMENT '操作类型 0新增 1修改 2删除 3自动审批',
  `context` varchar(255) DEFAULT NULL COMMENT '操作内容',
  PRIMARY KEY (`id`),
  KEY `idx_contact_id` (`contact_id`),
  KEY `idx_m_id` (`m_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2033 DEFAULT CHARSET=utf8 COMMENT='联系人/日志操作日志表'
---
DDL for table: contact_record
CREATE TABLE `contact_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `contact_adjust_id` int(11) DEFAULT NULL COMMENT '申请记录',
  `old_poi_note` varchar(255) DEFAULT NULL COMMENT '原地址信息',
  `old_province` varchar(255) DEFAULT NULL COMMENT '省',
  `old_city` varchar(255) DEFAULT NULL COMMENT '市',
  `old_area` varchar(255) DEFAULT NULL COMMENT '区',
  `old_address` varchar(500) DEFAULT NULL COMMENT '详细地址',
  `old_house_number` varchar(500) DEFAULT NULL COMMENT '原门牌号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='tms提交修改地址记录表'
---
DDL for table: conversion_sku_config
CREATE TABLE `conversion_sku_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `pd_id` int(11) DEFAULT NULL COMMENT '商品表id',
  `in_sku` varchar(50) DEFAULT NULL COMMENT '转入sku',
  `out_sku` varchar(50) DEFAULT NULL COMMENT '转出sku',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `status` int(11) DEFAULT NULL COMMENT '状态 0生效 1 失效',
  `rates` varchar(10) DEFAULT NULL COMMENT '比例 例 1:2',
  `create_id` int(11) DEFAULT NULL COMMENT '创建人Id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pd_id_index` (`pd_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: conversion_sku_quantity
CREATE TABLE `conversion_sku_quantity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '配送仓编号',
  `min_sale_cnt` decimal(10,2) DEFAULT NULL COMMENT '昨天订单最小值',
  `sale_cnt_fifteen` decimal(10,2) DEFAULT NULL COMMENT '前15天平均销量',
  `sale_cnt_seven` decimal(10,2) DEFAULT NULL COMMENT '前7天平均销量',
  `date` date DEFAULT NULL COMMENT '计算时间',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `max_sale_seven` decimal(10,2) DEFAULT NULL COMMENT '前七天每日总销量峰值',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uni_sku_warehouse_date` (`sku`,`warehouse_no`,`date`),
  KEY `conversion_sku_quantity_sku_date_warehouse_no_index` (`sku`,`date`,`warehouse_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3631 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='sku转换配置数量'
---
DDL for table: core_product_base_price
CREATE TABLE `core_product_base_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `large_area_no` int(11) NOT NULL COMMENT '运营大区编号',
  `large_area_name` varchar(50) NOT NULL COMMENT '名称',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `pd_id` bigint(20) NOT NULL COMMENT '商品id',
  `pd_name` varchar(255) NOT NULL COMMENT '商品名称',
  `weight` varchar(100) DEFAULT NULL COMMENT '重量',
  `base_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '底价',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_large_area_no_sku` (`large_area_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='核心品类底价配置表'
---
DDL for table: count_result
CREATE TABLE `count_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '测试计划名称',
  `job_id` varchar(255) DEFAULT NULL COMMENT '任务id',
  `result` int(255) DEFAULT NULL COMMENT '0 成功，1 失败,2 构建中或队列中',
  `finally_result` int(11) DEFAULT NULL COMMENT '经测试验证后的结果,0 成功，1 失败',
  `reason` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '原因',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `report_url` varchar(255) DEFAULT NULL COMMENT '报告地址',
  `projectId` varchar(255) DEFAULT NULL COMMENT '归属项目ID',
  `test_case_count` varchar(255) DEFAULT NULL COMMENT '执行场景用例总数',
  `success_case` varchar(255) DEFAULT NULL COMMENT '成功数',
  `fail_case` varchar(255) DEFAULT NULL COMMENT '失败数',
  PRIMARY KEY (`id`),
  KEY `index_job_name` (`job_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6082 DEFAULT CHARSET=utf8mb4 COMMENT='测试用统计自动化执行结果'
---
DDL for table: coupon
CREATE TABLE `coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '红包名称',
  `code` varchar(36) DEFAULT NULL COMMENT '优惠券代码',
  `money` decimal(10,2) DEFAULT NULL COMMENT '额度',
  `threshold` decimal(10,2) DEFAULT '0.00' COMMENT '使用阈值',
  `type` tinyint(2) DEFAULT '0' COMMENT '优惠券类型，0指固定时间间隔到期，1固定时间点到期',
  `vaild_date` datetime DEFAULT NULL COMMENT '有效日期',
  `vaild_time` int(11) DEFAULT NULL COMMENT '有效时间，单位：天',
  `grouping` int(11) DEFAULT '0' COMMENT '卡券分组 0-平台活动券 1-售后补偿券 2-区域拉新券 3-会员权益券 4-销售客情券 5-销售月活券 6-行业活动券 8-员工福利券 9-销售囤货券 10-区域活动券 11-销售品类券 20-市场活动券 13-销售现货券 19-区域召回券 21-其他 16-功能测试券 17-平台补偿券 18-配送补偿券',
  `new_hand` tinyint(1) DEFAULT '0' COMMENT '是否仅新手，0不，1是',
  `category_id` text COMMENT '可用的品类',
  `sku` text COMMENT '可用sku',
  `reamrk` varchar(255) DEFAULT NULL COMMENT '备注',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(11) DEFAULT '1' COMMENT '1 存在 2默认删除',
  `agio_type` int(11) NOT NULL DEFAULT '1' COMMENT '1、普通商品优惠券 2、普通运费优惠券 3、精准送优惠券 \n 4、红包 5、商品兑换券',
  `start_date` datetime DEFAULT NULL COMMENT '开始生效时间',
  `start_time` int(11) DEFAULT NULL COMMENT '开始生效间隔日期',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `limit_flag` int(11) DEFAULT NULL COMMENT '是否限制发放一个 0(否）1（是）',
  `activity_scope` int(11) DEFAULT NULL COMMENT '1:预售尾款,2:除省心送,秒杀,预售外的活动可用,3:全部,4:仅省心送',
  `task_tag` tinyint(3) unsigned DEFAULT '0' COMMENT '任务标识:0(否),1(是)',
  `delete_tag` tinyint(3) unsigned DEFAULT '0' COMMENT '任务作废标识:0(否),1(是)',
  `auto_created` tinyint(4) DEFAULT '0' COMMENT '是否系统创建',
  `quantity_claimed` int(11) DEFAULT '0' COMMENT '领取次数  等于0不限  大于0就是实际限制领取次数',
  `grant_amount` int(10) unsigned DEFAULT NULL COMMENT '剩余总量',
  `grant_limit` int(11) DEFAULT '0' COMMENT '领取限制 0-不限  大于0实际限制多少张',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_normal` (`status`,`agio_type`,`grouping`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18774 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='优惠券表'
---
DDL for table: coupon_black_and_white
CREATE TABLE `coupon_black_and_white` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '优惠劵ID',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `type` tinyint(4) NOT NULL COMMENT '名单类型 1-黑名单 2-白名单',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `sku_coupon_index` (`coupon_id`,`sku`,`type`) COMMENT 'sku、卡劵联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COMMENT='优惠劵黑白名单列表'
---
DDL for table: coupon_config
CREATE TABLE `coupon_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) DEFAULT NULL COMMENT '购卡金额级别0 1 2 3 4 5，0为不满足充送的情况',
  `buy_money` decimal(11,2) DEFAULT NULL COMMENT '购卡金额',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '0 存在 1 失效',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=581 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='优惠券配置表'
---
DDL for table: coupon_config_detail
CREATE TABLE `coupon_config_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) DEFAULT NULL COMMENT '优惠券id',
  `coupon_config_id` int(11) DEFAULT NULL COMMENT '优惠券配置id',
  `name` int(11) DEFAULT NULL COMMENT '优惠券类别 1 全品类，2 水果券，3 乳制品券，4 不赠券',
  `money` decimal(10,2) DEFAULT NULL COMMENT '额度',
  `threshold` decimal(10,2) DEFAULT '0.00' COMMENT '使用阈值',
  `number` int(11) DEFAULT NULL COMMENT '优惠券数量',
  `effective_time` int(11) DEFAULT NULL COMMENT '有效天数',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '0 存在 1 失效',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_coupon_config_id` (`coupon_config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=715 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='优惠券配置详情表'
---
DDL for table: coupon_receive_log
CREATE TABLE `coupon_receive_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `coupon_id` int(11) DEFAULT NULL COMMENT '优惠劵id',
  `coupon_sender_id` int(11) DEFAULT NULL COMMENT '发放设置id',
  `m_id` bigint(30) DEFAULT NULL COMMENT '客户id',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sender` (`coupon_sender_id`,`m_id`),
  KEY `idx_coupon_merchant` (`m_id`,`coupon_id`),
  KEY `idx_m_id` (`m_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2342 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='优惠卷领取日志表'
---
DDL for table: coupon_sender_relation
CREATE TABLE `coupon_sender_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `coupon_id` int(11) DEFAULT NULL COMMENT '优惠劵id',
  `coupon_sender_id` int(11) DEFAULT NULL COMMENT '发放设置id',
  `number` int(11) DEFAULT NULL COMMENT '领取数量',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2440 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='优惠卷关联表'
---
DDL for table: coupon_sender_rule
CREATE TABLE `coupon_sender_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `coupon_sender_id` int(11) DEFAULT NULL COMMENT '发放设置ID',
  `scope_id` bigint(20) DEFAULT NULL COMMENT '范围ID',
  `scope_type` tinyint(4) DEFAULT NULL COMMENT '范围类型，1 人群包，2 运营城市，3 运营大区',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `union_index` (`coupon_sender_id`,`scope_type`) COMMENT '发放设置和范围类型联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=708 DEFAULT CHARSET=utf8mb4 COMMENT='发放设置-发放规则（圈人2.0）'
---
DDL for table: coupon_sender_setup
CREATE TABLE `coupon_sender_setup` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '设置名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `type` tinyint(4) DEFAULT NULL COMMENT '配置规则类型 0-全部用户(废弃) 1-圈人 2-城市规则 3-大区',
  `sender_type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '发放方式 1-需用户领取 2-新人注册后立即发放 3-推荐好友下单，确定收货后立即发放',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '有效状态 0-未生效 1-有效 2-已失效(过期失效) 3-已失效(人工关闭) ',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `union_index` (`sender_type`,`status`,`start_time`) COMMENT '发放类型状态以及开始时间联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=1222 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='优惠劵发放设置表'
---
DDL for table: coverage_excludes_config
CREATE TABLE `coverage_excludes_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) DEFAULT NULL COMMENT '项目工程名',
  `module` varchar(255) DEFAULT NULL COMMENT '模块名',
  `files` varchar(255) DEFAULT NULL COMMENT '文件名,多个需要以；号隔开',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci DEFAULT NULL COMMENT '0-排除模块，1排除文件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='覆盖率排除项配置表'
---
DDL for table: crm_bd_area
CREATE TABLE `crm_bd_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `admin_id` int(11) DEFAULT NULL COMMENT 'bd id',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9286 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='销售城市对应表'
---
DDL for table: crm_bd_city
CREATE TABLE `crm_bd_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `bd_id` int(11) NOT NULL COMMENT 'bd id',
  `bd_name` varchar(55) NOT NULL COMMENT 'bd名称',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT '' COMMENT '地区',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `updater` int(11) DEFAULT NULL COMMENT '更新人adminId',
  `creator` varchar(55) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_bd_id` (`bd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6574 DEFAULT CHARSET=utf8mb4 COMMENT='bd负责城市'
---
DDL for table: crm_bd_config
CREATE TABLE `crm_bd_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `admin_id` int(11) DEFAULT NULL COMMENT 'bd id',
  `gmv_base` decimal(12,2) DEFAULT NULL COMMENT 'gmv基础值(220225弃用)',
  `gmv_target` decimal(12,2) DEFAULT NULL COMMENT 'gmv目标值',
  `month_order_target` int(11) DEFAULT NULL COMMENT '月活目标',
  `private_sea_limit` int(11) DEFAULT NULL COMMENT '私海上限',
  `quota_limit` int(11) DEFAULT NULL COMMENT '客情上限',
  `type` int(11) DEFAULT NULL COMMENT '1(自定义) 2（上月销售值）',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `core_merchant_amount` int(10) unsigned DEFAULT '0' COMMENT '核心客户数基础值',
  `administrative_city` varchar(20) NOT NULL DEFAULT '' COMMENT '所属行政城市',
  `brand_gmv_target` decimal(12,0) unsigned NOT NULL DEFAULT '0' COMMENT '自营gmv目标',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `crm_bd_config_index` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=314 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='销售配置表'
---
DDL for table: crm_bd_org
CREATE TABLE `crm_bd_org` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `bd_id` bigint(20) NOT NULL COMMENT 'bd id',
  `bd_name` varchar(255) NOT NULL COMMENT 'bd 名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id',
  `parent_name` varchar(255) DEFAULT NULL COMMENT '上级名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `rank` int(11) NOT NULL COMMENT '级别:4:bd;3:m1;2:m2;1:m3',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bd_id_rank` (`bd_id`,`rank`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=utf8mb4 COMMENT='销售组织信息'
---
DDL for table: crm_bd_team
CREATE TABLE `crm_bd_team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL COMMENT 'bd_id',
  `admin_name` varchar(255) NOT NULL COMMENT 'bd姓名',
  `type` int(2) NOT NULL DEFAULT '1' COMMENT '1:平台销售，2:大客户销售',
  `is_locked` int(2) NOT NULL DEFAULT '1' COMMENT '1:正常，2:锁定',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_lock_type` (`is_locked`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='销售团队表'
---
DDL for table: crm_clue
CREATE TABLE `crm_clue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_source` tinyint(4) NOT NULL COMMENT '客户来源 0 鲜沐大客户 1新增品牌',
  `customer_name` varchar(128) NOT NULL COMMENT '客户名称 可以做唯一索引',
  `kp` varchar(32) DEFAULT NULL COMMENT 'kp名称',
  `phone` varchar(32) DEFAULT NULL COMMENT '手机电话',
  `dept` varchar(32) DEFAULT NULL COMMENT '部门',
  `post` varchar(32) DEFAULT NULL COMMENT '职务',
  `clue_status` varchar(16) DEFAULT NULL COMMENT '线索状态',
  `clue_source` varchar(32) DEFAULT NULL COMMENT '线索来源',
  `want_business` varchar(128) DEFAULT NULL COMMENT '意向业务',
  `area_code` int(11) DEFAULT NULL COMMENT '总部所在地code码',
  `purpose_remark` varchar(1000) DEFAULT NULL COMMENT '需求情况',
  `business_type` varchar(16) DEFAULT NULL COMMENT '经营类型',
  `shop_type` varchar(16) DEFAULT NULL COMMENT '门店类型',
  `shop_size` varchar(16) DEFAULT NULL COMMENT '门店规模',
  `customer_type` varchar(16) DEFAULT NULL COMMENT '客户类型',
  `shop_system` varchar(16) DEFAULT NULL COMMENT '店铺系统',
  `head_system` varchar(16) DEFAULT NULL COMMENT '总部系统',
  `send_remark` varchar(1000) DEFAULT NULL COMMENT '物料备注',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `bd_id` int(11) DEFAULT NULL COMMENT 'bd id',
  `b_id` bigint(20) DEFAULT '0' COMMENT '品牌id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_bd_id` int(11) DEFAULT NULL COMMENT '创建bd id',
  `assist_bd_id` int(11) DEFAULT NULL COMMENT '协助bdid',
  `last_follow_time` datetime DEFAULT NULL COMMENT '最近跟进时间',
  `area_code_name` varchar(64) DEFAULT NULL COMMENT '地区名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_customer_name` (`customer_name`),
  KEY `index_bd_id` (`bd_id`),
  KEY `index_m_id` (`b_id`),
  KEY `index_area_code` (`area_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11001 DEFAULT CHARSET=utf8 COMMENT='crm线索'
---
DDL for table: crm_clue_delete
CREATE TABLE `crm_clue_delete` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `shop_id` varchar(64) DEFAULT NULL COMMENT '店铺id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_shop_id` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='要删除的线索信息'
---
DDL for table: crm_commission_category
CREATE TABLE `crm_commission_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `proportion` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '提点比例',
  `category_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '品类:0自有品牌,1全部,2乳制品,3非乳制品,4水果',
  `delete_flag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除标识:0否1是',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_name` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',
  `create_name` varchar(50) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='销售按品类提成'
---
DDL for table: crm_commission_core_merchant
CREATE TABLE `crm_commission_core_merchant` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '等级:0王者,1钻石,2金牌,3银牌,4铜牌',
  `minimum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级最低值',
  `maximum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级最高值',
  `proportion` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '该等级奖励系数',
  `delete_flag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除标识:0否1是',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `create_name` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',
  `update_name` varchar(50) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='核心客户净增长奖励系数表'
---
DDL for table: crm_commission_merchant
CREATE TABLE `crm_commission_merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `zone_name` varchar(20) DEFAULT NULL COMMENT '区域名称',
  `new_bd_reward` decimal(12,2) DEFAULT NULL COMMENT '新销售提成',
  `normal_bd_reward` decimal(12,2) DEFAULT NULL COMMENT '其他销售提成',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `crm_commission_merchant_index` (`zone_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='销售拉新提成'
---
DDL for table: crm_commission_merchant_level
CREATE TABLE `crm_commission_merchant_level` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `grade` char(2) NOT NULL DEFAULT 'S' COMMENT '城市等级:S.A.B.C.D',
  `gmv_minimum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级gmv最低值',
  `gmv_maximum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级gmv最高值',
  `price_minimum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级客单价最低值',
  `price_maximum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该等级客单价最高值',
  `gmv_proportion` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '该等级gmv奖励系数',
  `price_proportion` decimal(8,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '该等级客单价奖励系数',
  `merchant_level_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '商户等级类型:0普通1核心',
  `delete_flag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除标识:0否1是',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `create_name` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',
  `update_name` varchar(50) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户等级表'
---
DDL for table: crm_commission_ration
CREATE TABLE `crm_commission_ration` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `zone_name` varchar(20) DEFAULT NULL COMMENT '区域名称',
  `lower_below` decimal(6,2) DEFAULT NULL COMMENT '低于-低于部分目标',
  `lower_finish` decimal(6,2) DEFAULT NULL COMMENT '低于-完成部分目标',
  `lower_beyond` decimal(6,2) DEFAULT NULL COMMENT '低于-超出目标',
  `lower_new_bd` decimal(6,2) DEFAULT NULL COMMENT '低于-新销售加成',
  `lower_new_area` decimal(6,2) DEFAULT NULL COMMENT '低于-新城市加成',
  `base_below` decimal(6,2) DEFAULT NULL COMMENT '基础-低于部分目标',
  `base_finish` decimal(6,2) DEFAULT NULL COMMENT '基础-完成部分目标',
  `base_beyond` decimal(6,2) DEFAULT NULL COMMENT '基础-超出部分目标',
  `base_new_bd` decimal(6,2) DEFAULT NULL COMMENT '基础-新销售加成',
  `base_new_area` decimal(6,2) DEFAULT NULL COMMENT '基础-新城市加成',
  `excess_below` decimal(6,2) DEFAULT NULL COMMENT '超出-低于部分目标',
  `excess_finish` decimal(6,2) DEFAULT NULL COMMENT '超出-完成部分目标',
  `excess_beyond` decimal(6,2) DEFAULT NULL COMMENT '超出-超出目标',
  `excess_new_bd` decimal(6,2) DEFAULT NULL COMMENT '超出-新销售加成',
  `excess_new_area` decimal(6,2) DEFAULT NULL COMMENT '超出-新城市加成',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `crm_commission_ration_zone_name_uindex` (`zone_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='销售提成比例表'
---
DDL for table: crm_commission_sku
CREATE TABLE `crm_commission_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `zone_name` varchar(20) DEFAULT NULL COMMENT '区域名称',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `reward` decimal(6,2) DEFAULT NULL COMMENT '提成金额',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `crm_commission_sku_index` (`zone_name`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='销售按件提成表'
---
DDL for table: crm_config_change_record
CREATE TABLE `crm_config_change_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `type` int(11) DEFAULT NULL COMMENT '操作类型：0、新增 1、修改 2、删除',
  `pm_id` int(11) DEFAULT NULL COMMENT '主键ID',
  `handle_name` varchar(50) DEFAULT NULL COMMENT '具体操作名称',
  `new_value` varchar(1500) DEFAULT NULL COMMENT '新值',
  `old_value` varchar(1500) DEFAULT NULL COMMENT '原值',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1057 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='crm配置变更记录'
---
DDL for table: crm_escort_visit_plan
CREATE TABLE `crm_escort_visit_plan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `admin_id` int(10) unsigned NOT NULL COMMENT '陪访人id',
  `visit_plan_id` bigint(20) unsigned NOT NULL COMMENT '拜访计划id',
  `expected_time` datetime NOT NULL COMMENT '计划拜访时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态:0待拜访,1已拜访,2取消,3未完成',
  `expected_content` varchar(255) NOT NULL DEFAULT '' COMMENT '陪访原因',
  `cancel_content` varchar(255) DEFAULT NULL COMMENT '取消原因',
  `creator` varchar(20) NOT NULL COMMENT '创建人',
  `updater` varchar(20) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  PRIMARY KEY (`id`),
  KEY `idx_visit_plan_id` (`visit_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8 COMMENT='陪访计划表'
---
DDL for table: crm_follow
CREATE TABLE `crm_follow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id 自增',
  `type` varchar(8) DEFAULT NULL COMMENT 'clue 线索',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '主题id',
  `bd_id` int(11) DEFAULT NULL COMMENT 'bd id',
  `follow_time` datetime DEFAULT NULL COMMENT '跟进时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `follow_goal` varchar(16) DEFAULT NULL COMMENT '跟进目的',
  `customer_feedback` varchar(500) DEFAULT NULL COMMENT '客户反馈',
  `next_follow` varchar(500) DEFAULT NULL COMMENT '下次跟进',
  `images` varchar(600) DEFAULT NULL COMMENT '图片',
  `follow_model` varchar(64) DEFAULT NULL COMMENT '跟进方式',
  PRIMARY KEY (`id`),
  KEY `index_type_bd_id` (`type`,`bd_id`),
  KEY `index_subject_id` (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COMMENT='crm 跟进'
---
DDL for table: crm_manage_administrative_city
CREATE TABLE `crm_manage_administrative_city` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `mb_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '区域id',
  `administrative_city` varchar(20) NOT NULL COMMENT '行政城市名',
  `creator` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建人id',
  `delete_flag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '删除标识:0否1是',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mb_id_city` (`mb_id`,`administrative_city`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='区域对应行政城市'
---
DDL for table: crm_manage_area
CREATE TABLE `crm_manage_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `mb_id` int(11) DEFAULT NULL COMMENT '区域配置id',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `creator` int(11) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_area_no` (`area_no`),
  KEY `crm_manage_area_mb_id_index` (`mb_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1350 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='销售负责区域'
---
DDL for table: crm_manage_bd
CREATE TABLE `crm_manage_bd` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `parent_admin_id` int(11) DEFAULT NULL COMMENT '区域负责人（M2）',
  `manage_admin_id` int(11) DEFAULT NULL COMMENT '城市负责人（M1）',
  `department_admin_id` int(11) DEFAULT NULL COMMENT '部门负责人（M3）',
  `zone_name` varchar(20) DEFAULT NULL COMMENT '区域名称',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=911 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='负责人-区域负责人'
---
DDL for table: crm_news
CREATE TABLE `crm_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL COMMENT '标题',
  `type` tinyint(4) NOT NULL COMMENT '类型:省心送(1),补货通知(2)',
  `content` varchar(1000) NOT NULL COMMENT '消息内容',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态：0:未读 1：已读',
  `warning_type` tinyint(3) NOT NULL COMMENT '警示类型 1：普通 2：一般紧急 3：非常紧急',
  `admin_id` int(11) NOT NULL COMMENT 'adminId',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `creat_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `admin_id_index` (`admin_id`) USING BTREE,
  KEY `type_index` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=778 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='crm消息'
---
DDL for table: crm_relation_record
CREATE TABLE `crm_relation_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户ID',
  `admin_id` int(11) DEFAULT NULL COMMENT '跟进人',
  `admin_name` varchar(255) DEFAULT NULL COMMENT '管理员名称',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `reassign` tinyint(4) DEFAULT '0' COMMENT '重新指派标志，0没有，1已重新指派跟进人',
  `last_follow_up_time` datetime DEFAULT NULL COMMENT '最近跟进时间',
  `reassign_time` datetime DEFAULT NULL COMMENT '重新指派时间',
  `reason` varchar(100) DEFAULT NULL COMMENT '释放或跟进原因',
  `follow_type` int(11) DEFAULT '0' COMMENT '新购买标签,无(0)新购买(1)由定时任务处理取消新购买标签(2)',
  `danger_day` int(11) DEFAULT NULL COMMENT '自动释放倒计时',
  `timing_follow_type` int(11) DEFAULT '0' COMMENT '省心送标签:无(0)省心送(1)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mid_reassign_adminname` (`m_id`,`reassign`,`admin_name`) USING BTREE,
  KEY `in_add_time` (`add_time`) USING BTREE,
  KEY `in_danger` (`danger_day`) USING BTREE,
  KEY `follow_up_relation_admin_index` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22909 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户对应负责人'
---
DDL for table: crm_sales_area
CREATE TABLE `crm_sales_area` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `bd_org_id` bigint(20) DEFAULT NULL COMMENT '销售组织 id',
  `sales_area_name` varchar(255) DEFAULT NULL COMMENT '销售区域',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_bd_org_id` (`bd_org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COMMENT='区域配置销售区域'
---
DDL for table: crm_sales_city
CREATE TABLE `crm_sales_city` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `sales_area_id` bigint(20) DEFAULT NULL COMMENT '销售区域 id',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_province_city_area` (`province`,`city`,`area`),
  KEY `idx_sales_area_id` (`sales_area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=685 DEFAULT CHARSET=utf8mb4 COMMENT='销售主管负责城市'
---
DDL for table: crm_task
CREATE TABLE `crm_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `task_name` varchar(50) NOT NULL COMMENT '任务名称',
  `type` tinyint(4) NOT NULL COMMENT '0: 发券;1:拜访',
  `source_id` varchar(30) DEFAULT NULL COMMENT '卡券 id',
  `start_time` datetime NOT NULL COMMENT '任务结束时间',
  `end_time` datetime NOT NULL COMMENT '任务开始时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `creator` bigint(20) unsigned DEFAULT NULL COMMENT '创建人',
  `updator` bigint(20) unsigned DEFAULT NULL COMMENT '修改人',
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '作废标记:0:正常;1:作废;',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_source_id` (`source_id`),
  KEY `idx_task_name` (`task_name`)
) ENGINE=InnoDB AUTO_INCREMENT=18855 DEFAULT CHARSET=utf8 COMMENT='crm 任务中心'
---
DDL for table: crm_task_detail
CREATE TABLE `crm_task_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `m_id` bigint(20) NOT NULL COMMENT '门店 id',
  `bd_id` bigint(20) NOT NULL COMMENT '销售 adminid',
  `bd_name` varchar(50) NOT NULL COMMENT 'bd 名称',
  `source_id` varchar(20) DEFAULT NULL COMMENT '门店卡券 id',
  `task_id` bigint(20) NOT NULL COMMENT '任务 id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_task_id_m_id_source_id` (`task_id`,`m_id`,`source_id`),
  KEY `task_id` (`task_id`),
  KEY `source_id` (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8 COMMENT='任务详情'
---
DDL for table: custom_product
CREATE TABLE `custom_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(20) NOT NULL COMMENT '商品名称',
  `front_img` varchar(200) NOT NULL COMMENT '正面图片',
  `back_img` varchar(200) DEFAULT NULL COMMENT '背面图片',
  `barcode` varchar(100) DEFAULT NULL COMMENT '条形码',
  `brand` varchar(100) DEFAULT NULL COMMENT '品牌',
  `net_weight` float DEFAULT NULL COMMENT '净含量',
  `unit` varchar(20) DEFAULT NULL COMMENT '单位',
  `price` decimal(10,2) unsigned DEFAULT NULL COMMENT '参考价格',
  `group_id` bigint(20) unsigned NOT NULL COMMENT '进货单分组id',
  `m_id` bigint(20) NOT NULL COMMENT '店铺id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 COMMENT='非平台商品'
---
DDL for table: cycle_inventory_cost
CREATE TABLE `cycle_inventory_cost` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `first_cycle_cost` decimal(10,4) DEFAULT NULL COMMENT 'c1周期成本',
  `first_cycle_cost_time` datetime DEFAULT NULL COMMENT 'c1周期成本时间',
  `end_cycle_cost` decimal(10,4) DEFAULT NULL COMMENT 'C2周期成本',
  `end_cycle_cost_time` datetime DEFAULT NULL COMMENT 'c2周期成本时间',
  `creater` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku_warehouseno` (`warehouse_no`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=725293 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='周期库存成本表'
---
DDL for table: data_bury_sku
CREATE TABLE `data_bury_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `type` int(11) DEFAULT NULL COMMENT '数据埋点类型 1、浏览 2、点击 3、加购 4、生成 5、支付',
  `add_time` datetime DEFAULT NULL COMMENT '请求时间',
  `m_id` bigint(32) DEFAULT NULL COMMENT '店铺id',
  `account_id` bigint(32) DEFAULT NULL COMMENT '账号id',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `ext1` varchar(50) DEFAULT NULL,
  `ext2` varchar(50) DEFAULT NULL,
  `ext3` varchar(50) DEFAULT NULL,
  `ext4` varchar(50) DEFAULT NULL,
  `ext5` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=638546 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='sku数据埋点'
---
DDL for table: data_temp
CREATE TABLE `data_temp` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `jsessionid` varchar(255) DEFAULT NULL,
  `m_id` bigint(30) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `data_temp_index` (`jsessionid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17116 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: database_handle_record
CREATE TABLE `database_handle_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `status` int(11) DEFAULT '0' COMMENT '状态：0、创建还原点 1、已还原',
  `handle_desc` varchar(255) DEFAULT NULL COMMENT '操作描述',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=645 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据库更新记录（一键还原功能）'
---
DDL for table: database_handle_record_detail
CREATE TABLE `database_handle_record_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `record_id` int(11) NOT NULL COMMENT '还原记录id',
  `handle_table` varchar(50) DEFAULT NULL COMMENT '数据库表',
  `handle_columns` varchar(50) DEFAULT NULL COMMENT '数据库字段',
  `handle_pk` varchar(33) DEFAULT NULL COMMENT '主键字段',
  `handle_id` varchar(33) DEFAULT NULL COMMENT '操作id',
  `type` int(11) DEFAULT '0' COMMENT '类型：0、修改 1、新增 2、删除',
  `old_value` varchar(50) DEFAULT NULL COMMENT '原值',
  `new_value` varchar(50) DEFAULT NULL COMMENT '新值',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `database_update_record_detail_record_id_index` (`record_id`,`handle_table`,`handle_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=821 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据详情'
---
DDL for table: datacollection
CREATE TABLE `datacollection` (
  `id` bigint(30) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) DEFAULT NULL COMMENT 'ip地址',
  `uri` text COMMENT '访问的接口',
  `param_data` text COMMENT '请求参数',
  `method` varchar(10) DEFAULT NULL COMMENT '请求方式',
  `interview_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '插入时间',
  `source` int(2) DEFAULT NULL COMMENT '数据来源，0：后台管理，1：商城',
  `jsessionid` varchar(255) DEFAULT NULL,
  `m_id` bigint(30) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `in_m_id` (`m_id`) USING BTREE,
  KEY `in_interview_time` (`interview_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: day_sale_rank
CREATE TABLE `day_sale_rank` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编码',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku名称',
  `rank_id` int(11) DEFAULT NULL COMMENT '某个区域下的品牌内的sku的排名',
  `brand_name` varchar(50) DEFAULT NULL COMMENT '品牌名',
  `sales` int(11) DEFAULT NULL COMMENT '该sku在某个地区下的销量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku_areano_sales` (`sku`,`area_no`,`sales`)
) ENGINE=InnoDB AUTO_INCREMENT=83622 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: delivery_car
CREATE TABLE `delivery_car` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `no` int(4) DEFAULT NULL COMMENT '一级城市区域',
  `area_no` int(11) DEFAULT NULL COMMENT '区域',
  `number` varchar(10) DEFAULT NULL COMMENT '编号',
  `plate_number` varchar(20) DEFAULT NULL COMMENT '车牌号',
  `driver` varchar(30) DEFAULT NULL COMMENT '司机',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `pic` varchar(255) DEFAULT NULL COMMENT '图片 ; 分割',
  `status` int(3) DEFAULT '1' COMMENT '默认1，',
  `driver_pic` varchar(255) DEFAULT NULL COMMENT '驾驶证照片',
  `driving_pic` varchar(255) DEFAULT NULL COMMENT '行驶证照片',
  `store_name` varchar(45) DEFAULT NULL COMMENT '仓名',
  `area_name` varchar(45) DEFAULT NULL COMMENT '城市名称',
  `account_type` int(11) DEFAULT NULL COMMENT '账号类型',
  `passwd` varchar(255) DEFAULT NULL COMMENT '密码',
  `mp_openid` varchar(100) DEFAULT NULL COMMENT '小程序id',
  `account_name` varchar(20) DEFAULT NULL COMMENT '配送车师傅账号，唯一不重复',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `volume` varchar(30) DEFAULT NULL COMMENT '体积',
  `load_volume` decimal(10,4) DEFAULT NULL COMMENT '车辆可装载体积',
  `model` int(2) DEFAULT NULL COMMENT '车型0、微型轿车 1、两厢轿车 2、三厢轿车 3、小型SUV 4、中型SUV 5、大型SUV 6、商务车',
  `carrier_id` bigint(20) DEFAULT NULL COMMENT '承运商id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `delivery_car_openid_index` (`mp_openid`) USING BTREE,
  KEY `idx_carrier_id` (`carrier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=362 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: delivery_car_path
CREATE TABLE `delivery_car_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_car_id` int(11) DEFAULT NULL COMMENT '配送司机id(tms_driver)',
  `store_no` int(11) NOT NULL COMMENT '仓库编号',
  `delivery_time` date NOT NULL COMMENT '配送时间',
  `path` varchar(20) NOT NULL COMMENT '配送路线',
  `addtime` datetime DEFAULT NULL,
  `total_distance` decimal(10,2) DEFAULT '0.00' COMMENT '总距离',
  `path_name` varchar(25) DEFAULT NULL COMMENT '路线名称',
  `type` int(11) DEFAULT NULL,
  `tms_car_id` bigint(20) DEFAULT NULL COMMENT '配送车辆id',
  `carrier_id` int(11) DEFAULT NULL COMMENT '承运商id',
  `real_total_distance` decimal(10,2) DEFAULT '0.00' COMMENT '实际总距离',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `delivery_car_id_index` (`delivery_car_id`,`delivery_time`) USING BTREE,
  KEY `delivery_car_index` (`store_no`,`delivery_time`,`path`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=563453 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='配送师傅-配送路线'
---
DDL for table: delivery_car_warehouse_fee
CREATE TABLE `delivery_car_warehouse_fee` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_car_id` int(11) DEFAULT NULL COMMENT '配送司机ID',
  `front_warehouse_fee` decimal(10,2) DEFAULT NULL COMMENT '前置仓费',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_deluvery_car_id` (`delivery_car_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='司机前置仓费表'
---
DDL for table: delivery_evaluation
CREATE TABLE `delivery_evaluation` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(45) DEFAULT NULL COMMENT '订单号',
  `delivery_plan_id` int(11) NOT NULL COMMENT '配送计划id',
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `contact_id` bigint(11) DEFAULT NULL COMMENT '联系人',
  `satisfaction_level` tinyint(4) NOT NULL COMMENT '满意级别',
  `tag` varchar(50) NOT NULL COMMENT '评价标签',
  `remark` varchar(50) DEFAULT NULL COMMENT '评价描述',
  `operator_account_id` bigint(30) NOT NULL COMMENT '子账号id',
  `operator` varchar(50) NOT NULL COMMENT '操作人',
  `operator_phone` varchar(11) NOT NULL COMMENT '手机',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '评价类型：0配送评价 1商品评价',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`),
  KEY `idx_delivery_plan_id` (`delivery_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='订单配送评价表'
---
DDL for table: delivery_path
CREATE TABLE `delivery_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store_no` int(11) NOT NULL COMMENT '仓库编号',
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `contact_id` int(11) NOT NULL COMMENT '联系人id',
  `time_frame` varchar(1000) DEFAULT NULL COMMENT '精准送时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '订单备注',
  `total_volume` decimal(15,2) NOT NULL COMMENT '总体积',
  `path` varchar(20) DEFAULT NULL COMMENT '路线',
  `sort` int(11) DEFAULT NULL COMMENT '顺序id',
  `addtime` datetime DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT '0.00' COMMENT '总货值',
  `type` int(11) DEFAULT NULL,
  `path_status` int(2) DEFAULT NULL COMMENT '任务状态 0 待捡货、1 捡货完成(配送中)、2完成配送 ',
  `finish_poi` varchar(45) DEFAULT NULL COMMENT '结束任务时的定位',
  `finish_poi_name` varchar(100) DEFAULT NULL,
  `finish_distance` int(11) DEFAULT NULL COMMENT '距离偏差',
  `delivery_pic` varchar(255) DEFAULT NULL COMMENT '配送照片',
  `finish_time` datetime DEFAULT NULL COMMENT '配送结束时间',
  `sign_for_status` int(11) DEFAULT NULL COMMENT '是否正常签收',
  `sign_for_remarks` varchar(50) DEFAULT NULL COMMENT '签收备注',
  `delivery_type` int(11) DEFAULT '0' COMMENT '配送类型 0 配送 1 回收 2 配送/回收',
  `intercept_type` int(11) DEFAULT '0' COMMENT '拦截类型 0正常 1部分拦截 2全部拦截',
  `brand_type` int(11) DEFAULT '0' COMMENT '品牌类型 0内部，1外部',
  `out_distance` tinyint(4) DEFAULT '0' COMMENT '是否超出距离 0 正常 1超出',
  `out_remark` varchar(50) DEFAULT NULL COMMENT '超出距离备注',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `contact_id_index` (`contact_id`) USING BTREE,
  KEY `delivery_time_index` (`delivery_time`) USING BTREE,
  KEY `store_no_index` (`store_no`) USING BTREE,
  KEY `path__index` (`path`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9687235 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='配送路线记录'
---
DDL for table: delivery_path_intercept_sku
CREATE TABLE `delivery_path_intercept_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `contact_id` int(11) NOT NULL COMMENT '联系人',
  `sku` varchar(45) NOT NULL COMMENT '商品sku',
  `quantity` int(11) NOT NULL COMMENT '拦截数量',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `dtime_cid_sku_ct_index` (`delivery_time`,`contact_id`,`sku`,`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4907 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='拦截sku表'
---
DDL for table: delivery_path_return_sku
CREATE TABLE `delivery_path_return_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `delivery_path_id` int(11) NOT NULL COMMENT '路线id',
  `sku` varchar(45) NOT NULL COMMENT '商品sku',
  `quantity` int(11) NOT NULL COMMENT '退回数量',
  `remark` varchar(255) DEFAULT NULL COMMENT '退货原因',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='拒收sku表'
---
DDL for table: delivery_path_short_sku
CREATE TABLE `delivery_path_short_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_path_id` int(11) DEFAULT NULL,
  `sku` varchar(45) DEFAULT NULL,
  `short_cnt` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `type` int(11) DEFAULT '0' COMMENT '配送类型 0 配送 1 回收',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `delivery_path_short_sku_delivery_path_id_index` (`delivery_path_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2416 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='配送单缺损sku数量'
---
DDL for table: delivery_plan
CREATE TABLE `delivery_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(45) DEFAULT NULL COMMENT '订单号',
  `status` smallint(2) DEFAULT '2' COMMENT '配送状态',
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `quantity` int(11) DEFAULT NULL COMMENT '配送数量',
  `master_order_no` varchar(36) DEFAULT NULL COMMENT '随单配送时对应的普通订单订单号',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `contact_id` int(11) DEFAULT NULL COMMENT '联系人',
  `deliverytype` tinyint(1) DEFAULT '0' COMMENT '配送方式',
  `time_frame` varchar(50) DEFAULT NULL COMMENT '配送时间区间',
  `account_id` bigint(30) DEFAULT NULL COMMENT '子帐号id',
  `admin_id` int(11) DEFAULT NULL COMMENT '管理员id',
  `order_store_no` int(11) DEFAULT NULL COMMENT '下单仓编号',
  `put_off_time` date DEFAULT NULL COMMENT '省心送推迟订单时间',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `ord_delivery_time` date DEFAULT NULL COMMENT '旧配送时间',
  `old_delivery_time` date DEFAULT NULL COMMENT '旧配送时间',
  `intercept_flag` int(11) DEFAULT '0' COMMENT '拦截状态 0 正常 1被拦截',
  `intercept_time` datetime DEFAULT NULL COMMENT '拦截时间',
  `show_flag` tinyint(4) DEFAULT '0' COMMENT '完成排线-展示标识 0 展示 1不展示',
  `delivery_evaluation_status` tinyint(4) DEFAULT '0' COMMENT '0:未评价，1:已评价',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind_order_no` (`order_no`) USING BTREE,
  KEY `ind_master_order_no` (`master_order_no`) USING BTREE,
  KEY `ind_delivery_time` (`delivery_time`,`status`,`order_store_no`),
  KEY `ind_time_contact` (`contact_id`,`delivery_time`),
  KEY `ind_order_store_no_status` (`order_store_no`,`status`),
  KEY `idx_put_off_time` (`put_off_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5649248 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='配送计划表'
---
DDL for table: delivery_plan_copy1
CREATE TABLE `delivery_plan_copy1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(45) DEFAULT NULL COMMENT '订单号',
  `status` smallint(2) DEFAULT '2' COMMENT '配送状态',
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `quantity` int(11) DEFAULT NULL COMMENT '配送数量',
  `master_order_no` varchar(36) DEFAULT NULL COMMENT '随单配送时对应的普通订单订单号',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `contact_id` int(11) DEFAULT NULL COMMENT '联系人',
  `deliverytype` tinyint(1) DEFAULT '0' COMMENT '配送方式',
  `time_frame` varchar(50) DEFAULT NULL COMMENT '配送时间区间',
  `account_id` bigint(30) DEFAULT NULL COMMENT '子帐号id',
  `admin_id` int(11) DEFAULT NULL COMMENT '管理员id',
  `order_store_no` int(11) DEFAULT NULL COMMENT '下单仓编号',
  `put_off_time` date DEFAULT NULL COMMENT '省心送推迟订单时间',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `ord_delivery_time` date DEFAULT NULL COMMENT '旧配送时间',
  `old_delivery_time` date DEFAULT NULL COMMENT '旧配送时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind_order_no` (`order_no`) USING BTREE,
  KEY `ind_master_order_no` (`master_order_no`) USING BTREE,
  KEY `ind_delivery_time` (`delivery_time`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='配送计划表'
---
DDL for table: delivery_plan_extend
CREATE TABLE `delivery_plan_extend` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `order_no` varchar(45) DEFAULT NULL COMMENT '订单号',
  `delivery_plan_id` int(11) DEFAULT NULL COMMENT '配送计划id',
  `operator_type` int(11) DEFAULT NULL COMMENT '操作人类型：0 用户 1内部员工',
  `operator` varchar(255) DEFAULT NULL COMMENT '操作人',
  `type` int(11) DEFAULT NULL COMMENT '操作类型：10 新增，11删除，12修改，13查询',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_delivery_plan_id` (`delivery_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1160 DEFAULT CHARSET=utf8 COMMENT='配送计划拓展表'
---
DDL for table: delivery_plan_remark_snapshot
CREATE TABLE `delivery_plan_remark_snapshot` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `business_id` varchar(64) DEFAULT NULL COMMENT '样品审核表id/售后表No/配送计划 id',
  `type` tinyint(4) NOT NULL COMMENT '0样品申请,1售后单,2配送计划',
  `address_remark` varchar(255) DEFAULT NULL COMMENT '地址备注json',
  `contact` varchar(200) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT '' COMMENT '地区',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `status` int(11) DEFAULT '3' COMMENT '状态(1正常或审核通过、2删除、3待审核、4审核不通过)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_default` int(11) DEFAULT '0' COMMENT '1默认地址 与merchat中一致',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德地图poi坐标',
  `distance` decimal(10,2) DEFAULT '0.00' COMMENT '与仓库的距离',
  `house_number` varchar(255) DEFAULT NULL COMMENT '门牌号',
  `store_no` int(11) DEFAULT NULL COMMENT '配送仓编号',
  `acm_id` int(11) DEFAULT NULL COMMENT '归属区域id adCodeMsg表',
  `back_store_no` int(11) DEFAULT NULL COMMENT '配送仓编号 备注',
  `delivery_frequent` varchar(30) DEFAULT NULL COMMENT '配送周期',
  `delivery_rule` varchar(255) DEFAULT NULL COMMENT '运费规则',
  `delivery_fee` decimal(12,2) DEFAULT NULL COMMENT '运费',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_business_id_type` (`business_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=19431 DEFAULT CHARSET=utf8 COMMENT='配送计划地址快照表'
---
DDL for table: department_details
CREATE TABLE `department_details` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '部门名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父部门ID',
  `status` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '部门状态， 0：不存在，1：存在',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1538 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: department_staff
CREATE TABLE `department_staff` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` bigint(11) DEFAULT NULL COMMENT '部门id',
  `user_id` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户的userid',
  `union_id` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户在当前开发者企业账号范围内的唯一标识',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '员工姓名',
  `mobile` varchar(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '手机号',
  `leader` bit(1) DEFAULT NULL COMMENT '是否为主管',
  `status` varchar(50) DEFAULT NULL COMMENT '状态 1为在职，0为离职',
  `create_time` datetime DEFAULT NULL COMMENT ' 创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7124 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: department_staff_test
CREATE TABLE `department_staff_test` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` bigint(11) DEFAULT NULL COMMENT '部门id',
  `user_id` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户的userid',
  `union_id` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户在当前开发者企业账号范围内的唯一标识',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '员工姓名',
  `mobile` varchar(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '手机号',
  `leader` bit(1) DEFAULT NULL COMMENT '是否为主管',
  `status` varchar(50) DEFAULT NULL COMMENT '状态 1为在职，0为离职',
  `create_time` datetime DEFAULT NULL COMMENT ' 创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=359 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: ding_talk_auth
CREATE TABLE `ding_talk_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL COMMENT '钉钉昵称',
  `openid` varchar(255) DEFAULT NULL COMMENT '钉钉openid',
  `union_id` varchar(255) DEFAULT NULL COMMENT '用户在当前开放应用所属企业内的唯一标识',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 有效 1 失效',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='钉钉应用免登用户信息表'
---
DDL for table: dingding_process_flow
CREATE TABLE `dingding_process_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `process_instance_id` varchar(64) NOT NULL DEFAULT '' COMMENT '钉钉审批实例id',
  `process_code` varchar(64) NOT NULL DEFAULT '' COMMENT '钉钉审批模版code',
  `biz_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前审批所属业务 1-CRM-客户倒闭申请',
  `biz_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '业务数据id',
  `process_status` int(11) NOT NULL DEFAULT '0' COMMENT '审批状态 1-审批中 2-审批通过 3-审批拒绝 4-审批终止 5-审批撤销中',
  `process_url` varchar(512) NOT NULL DEFAULT '' COMMENT '钉钉审批详情url',
  `remark` varchar(1024) DEFAULT '' COMMENT '备注',
  `creator` int(11) NOT NULL DEFAULT '0' COMMENT '创建人id(admin.admin_id)',
  `updater` varchar(64) NOT NULL DEFAULT '' COMMENT '修改人id(admin.admin_id或钉钉用户id)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `form_data` text NOT NULL COMMENT '审批表单数据',
  `platform_type` varchar(32) DEFAULT NULL COMMENT '平台类型',
  `env` varchar(32) DEFAULT NULL COMMENT '环境',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_process_instance_id` (`process_instance_id`) USING BTREE,
  KEY `idx_biz_id_biz_type` (`biz_id`,`biz_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20947 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='钉钉审批表'
---
DDL for table: direct_purchase_info
CREATE TABLE `direct_purchase_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `m_id` bigint(30) DEFAULT NULL COMMENT '用户id',
  `purchase_no` varchar(36) NOT NULL COMMENT '采购类型为直发采购批次',
  `order_no` varchar(30) NOT NULL COMMENT '采购类型为直发采购对应的订单',
  `send_time` datetime DEFAULT NULL COMMENT '供应商发货时间',
  `receive_place` varchar(500) DEFAULT NULL COMMENT '采购用户收货地址',
  `logistics_info` varchar(500) DEFAULT NULL COMMENT '供应商给用户发货对应的一些物流信息',
  `addtime` datetime DEFAULT NULL COMMENT '添加信息时间',
  `contact_id` bigint(30) DEFAULT NULL COMMENT 'mId对应的contact表内的contact_id',
  `contact_phone` varchar(11) DEFAULT NULL COMMENT 'mId对应的contact表内的contact_phone',
  `one_click_ship_time` datetime DEFAULT NULL COMMENT '一键直发时间',
  `delivery_date` date DEFAULT NULL COMMENT '配送日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=488 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='直发采购的下单信息'
---
DDL for table: direct_purchase_recharge
CREATE TABLE `direct_purchase_recharge` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '做为主键的同时也用作充值编号',
  `m_id` bigint(30) DEFAULT NULL COMMENT '充值用户id',
  `recharge_num` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `picture_paths` varchar(300) DEFAULT NULL COMMENT '审核时的凭证图片url，用 , 隔开',
  `applicant` varchar(50) DEFAULT NULL COMMENT '申请人',
  `addtime` datetime DEFAULT NULL COMMENT '申请审核时间',
  `handler` varchar(50) DEFAULT NULL COMMENT '处理人',
  `processingtime` datetime DEFAULT NULL COMMENT 'null(默认), 不为null则为处理人审批时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '0（默认），待审批状态；1 审批通过状态； 2 审批失败状态',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注信息',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='直发采购业务用户充值审核表'
---
DDL for table: direct_purchase_recharge_record
CREATE TABLE `direct_purchase_recharge_record` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '做为主键的同时也用作充值记录编号',
  `m_id` bigint(30) DEFAULT NULL COMMENT '用户id',
  `type` tinyint(4) DEFAULT NULL COMMENT '0:扣款，1:充值，2:退款, 3:取消订单的扣款（普通扣款取消后得到)',
  `order_no` varchar(36) DEFAULT NULL COMMENT '充值时为null,扣款和退款则对应相应的订单',
  `recharge_id` bigint(30) DEFAULT NULL COMMENT 'direct_purchase_recharge表内的id,充值审核表记录id',
  `pre_amount` decimal(10,2) DEFAULT '0.00' COMMENT '充值流水号对应的资金上次可用总金额,对应上一条记录的left_amount',
  `left_amount` decimal(10,2) DEFAULT '0.00' COMMENT '充值流水号对应的资金扣除本次使用金额后的可用总金额',
  `status` tinyint(4) DEFAULT '0' COMMENT '0对应充值流水号最后一次记录,1非最后一条记录',
  `addtime` datetime DEFAULT NULL COMMENT '记录生成的时间',
  `operator` varchar(20) NOT NULL COMMENT '操作人，充值时为收款发起人，扣款和退款时为生成、取消结算单或生成、取消订单的操作人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='直发采购业务用户充值金额流水变动表'
---
DDL for table: discount_card
CREATE TABLE `discount_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `name` varchar(50) DEFAULT NULL COMMENT '优惠卡名称',
  `price` decimal(6,2) DEFAULT NULL COMMENT '优惠卡价格',
  `discount` decimal(6,2) DEFAULT NULL COMMENT '折扣金额',
  `vaild_days` int(11) DEFAULT NULL COMMENT '有效天数',
  `vaild_times` int(11) DEFAULT NULL COMMENT '可用次数',
  `updator` varchar(50) DEFAULT NULL COMMENT '更新人员',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `card_type` int(11) DEFAULT NULL COMMENT '到期类型 0 间隔时间到期 1 指定时间到期(到期后此卡不能再被购买)',
  `appoint_time` date DEFAULT NULL COMMENT '卡到期时间 type = 1时生效',
  `area_nos` varchar(2000) DEFAULT NULL COMMENT '适用城市 ","分割',
  `url` varchar(255) DEFAULT NULL COMMENT '优惠卡图片url',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='折扣卡'
---
DDL for table: discount_card_available
CREATE TABLE `discount_card_available` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `discount_card_id` int(11) DEFAULT NULL COMMENT '优惠卡id',
  `sku` varchar(33) DEFAULT NULL COMMENT '可用sku',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_card_id_sku` (`discount_card_id`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='优惠卡可用范围'
---
DDL for table: discount_card_to_merchant
CREATE TABLE `discount_card_to_merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户id',
  `discount_card_id` int(11) DEFAULT NULL COMMENT '折扣卡id',
  `status` int(11) DEFAULT NULL COMMENT '状态：0、失效 1、有效',
  `total_times` int(11) DEFAULT NULL COMMENT '总次数',
  `used_times` int(11) unsigned DEFAULT NULL COMMENT '已用次数',
  `deadline` date DEFAULT NULL COMMENT '截至日期',
  `updator` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `discount_card_to_merchant_mid_index` (`m_id`) USING BTREE,
  KEY `discount_card_to_merchant_dis_index` (`discount_card_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品优惠卡映射'
---
DDL for table: discount_card_use_record
CREATE TABLE `discount_card_use_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `suit_id` int(11) DEFAULT NULL COMMENT '组合包id',
  `use_times` int(11) DEFAULT NULL COMMENT '生效次数',
  `total_discount` decimal(6,2) DEFAULT NULL COMMENT '折扣总金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `discount_card_merchant_id` int(11) DEFAULT NULL COMMENT '优惠卡id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `discount_card_use_record_order_index` (`order_no`) USING BTREE,
  KEY `idx_discount_card_merchant_id_order_no` (`discount_card_merchant_id`,`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3536 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='优惠卡使用记录'
---
DDL for table: distribution_fee
CREATE TABLE `distribution_fee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号 0代表全部城市',
  `delivery_fee` decimal(12,2) DEFAULT NULL COMMENT '配送费金额(单位:元)',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 生效 1 不生效',
  `admin_id` int(11) DEFAULT NULL COMMENT '所属大客户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=959 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='大客户配送费表'
---
DDL for table: distribution_rules
CREATE TABLE `distribution_rules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `type` tinyint(4) DEFAULT NULL COMMENT '规则类型  1：门店管理  2：品牌管理  3：服务区域',
  `type_id` bigint(20) DEFAULT NULL COMMENT '类型ID  服务区域、地址、品牌主键ID',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号-针对品牌管理类型   0代表全部城市',
  `ageing` tinyint(4) DEFAULT NULL COMMENT '履约时效  0：T+1    1：T+N',
  `product_type` tinyint(4) DEFAULT NULL COMMENT '商品类目  1：全部商品 2：乳制品商品  3：非乳制品商品',
  `sill_type` tinyint(4) DEFAULT NULL COMMENT '门槛类型 1：金额  2：件数',
  `number` int(11) DEFAULT NULL COMMENT '件数  针对门槛类型为件数',
  `amount` decimal(12,2) DEFAULT NULL COMMENT '金额 针对门槛类型为金额',
  `delivery_fee` decimal(12,2) DEFAULT NULL COMMENT '配送费',
  `express_fee` decimal(12,2) DEFAULT NULL COMMENT '快递费',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `type_index` (`type_id`) COMMENT '类型ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=4550 DEFAULT CHARSET=utf8mb4 COMMENT='配送规则'
---
DDL for table: download_center_record_mapping
CREATE TABLE `download_center_record_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `res_id` bigint(20) DEFAULT NULL COMMENT '新下载中心主键id',
  `saas_res_id` bigint(20) DEFAULT NULL COMMENT 'saas下载中心id',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COMMENT='新下载中心数据映射关系表'
---
DDL for table: download_center_type_config
CREATE TABLE `download_center_type_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `app_name` varchar(64) NOT NULL COMMENT '所属应用',
  `type` int(11) NOT NULL COMMENT '任务类型',
  `remark` varchar(255) NOT NULL COMMENT '业务描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态,0禁用；1启用',
  `source` varchar(64) DEFAULT 'xianmu' COMMENT '系统来源，xianmu；saas',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_source_type` (`source`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COMMENT='新下载中心业务类型配置表'
---
DDL for table: dws_trd_orderdetail_d
CREATE TABLE `dws_trd_orderdetail_d` (
  `order_no` varchar(45) NOT NULL,
  `dateid` varchar(45) DEFAULT NULL,
  `order_type` varchar(45) DEFAULT NULL COMMENT '订单类型，普通、省心送、预购',
  `sku` varchar(45) DEFAULT NULL,
  `spu_name` varchar(45) DEFAULT NULL COMMENT '商品名称spu',
  `m_id` int(11) DEFAULT NULL,
  `mname` varchar(45) DEFAULT NULL COMMENT '商户名称',
  `relation_id` varchar(45) DEFAULT NULL COMMENT '这里统计口径有问题，销售按计算归属销售划分订单（当时是谁，前面的就是谁的',
  `bd_name` varchar(45) DEFAULT NULL COMMENT '销售名称',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `area_name` varchar(45) DEFAULT NULL COMMENT '城市名称',
  `store_no` int(11) DEFAULT NULL COMMENT '所属仓库编码',
  `store_name` varchar(45) DEFAULT NULL COMMENT '所属仓库编码',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `pay_same_day` tinyint(4) DEFAULT NULL COMMENT '是否当天下单',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `delivery_same_day` varchar(45) DEFAULT NULL COMMENT '是否当日送达，这个值的意义？',
  `delivery_time` datetime DEFAULT NULL COMMENT '配送时间',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认收货时间',
  `confirm_same_day` varchar(45) DEFAULT NULL COMMENT '确认收货与配送日是否同一天',
  `promotion_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单详情事务表_每日更新'
---
DDL for table: dynamic_price_field
CREATE TABLE `dynamic_price_field` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `field_name` varchar(128) DEFAULT NULL COMMENT '字段名称',
  `field_alias` varchar(64) DEFAULT NULL COMMENT '字段别名',
  `x_comment` varchar(128) DEFAULT NULL COMMENT 'X值含义备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='动态定价-可配置字段表'
---
DDL for table: dynamic_price_field_config
CREATE TABLE `dynamic_price_field_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `field_id` bigint(20) NOT NULL COMMENT '字段id',
  `model_config_id` bigint(20) NOT NULL COMMENT '定价模型配置id',
  `lower_limit` decimal(10,2) DEFAULT NULL COMMENT '下限值',
  `upper_limit` decimal(10,2) DEFAULT NULL COMMENT '上限值',
  `formula` varchar(256) DEFAULT NULL COMMENT '含X值计算公式，英文逗号分割符号、数字',
  `binding_value` decimal(10,2) DEFAULT NULL COMMENT '绑定值',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_modelconfigid` (`model_config_id`),
  KEY `idx_fieldid` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1157 DEFAULT CHARSET=utf8 COMMENT='动态定价-计算字段规则配置表'
---
DDL for table: dynamic_price_model_config
CREATE TABLE `dynamic_price_model_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `category_type` tinyint(4) DEFAULT NULL COMMENT '类目类型，0 鲜果 1非鲜果',
  `exe_time` varchar(16) DEFAULT NULL COMMENT '定时任务执行时间，比如 10:00',
  `upper_limit` decimal(10,2) DEFAULT NULL COMMENT '毛利率上限',
  `formula` varchar(512) NOT NULL COMMENT '定价公式，英文逗号分割字段、符号、数字',
  `fields` varchar(512) DEFAULT NULL COMMENT '公式中配置字段，用逗号隔开',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次操作人id',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否已被删除，0 否，1 是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_exetime` (`exe_time`)
) ENGINE=InnoDB AUTO_INCREMENT=605 DEFAULT CHARSET=utf8 COMMENT='动态定价-定价模型配置表'
---
DDL for table: dynamic_price_record
CREATE TABLE `dynamic_price_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sku_task_id` bigint(20) NOT NULL COMMENT 'sku任务id',
  `sku` varchar(64) NOT NULL COMMENT 'sku',
  `area_no` int(11) NOT NULL COMMENT '运营服务区域',
  `old_sale_price` decimal(10,2) DEFAULT NULL COMMENT '原售价',
  `old_gross_profit_rate` decimal(10,4) DEFAULT NULL COMMENT '原毛利率',
  `new_sale_price` decimal(10,2) DEFAULT NULL COMMENT '预计售价',
  `new_gross_profit_rate` decimal(10,4) DEFAULT NULL COMMENT '预计毛利率',
  `status` tinyint(4) NOT NULL COMMENT '状态，0 失败，1 成功',
  `reason` varchar(128) DEFAULT NULL COMMENT '成功失败的原因',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_skutaskid` (`sku_task_id`),
  KEY `idx_sku_areano` (`sku`,`area_no`)
) ENGINE=InnoDB AUTO_INCREMENT=5378 DEFAULT CHARSET=utf8 COMMENT='动态调价sku定价记录表'
---
DDL for table: dynamic_price_sku_task
CREATE TABLE `dynamic_price_sku_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `sku` varchar(64) NOT NULL COMMENT 'sku',
  `field_value_json` varchar(256) DEFAULT NULL COMMENT '定价因子key-value json',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_taskid_sku` (`task_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=1815 DEFAULT CHARSET=utf8 COMMENT='动态定价-任务执行sku表'
---
DDL for table: dynamic_price_task
CREATE TABLE `dynamic_price_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `model_config_id` bigint(20) NOT NULL COMMENT '定价模型配置id(执行那一刻)',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `category_type` tinyint(4) DEFAULT NULL COMMENT '类型，0 鲜果 1 非鲜果',
  `task_exe_time` datetime DEFAULT NULL COMMENT '任务创建时间点，执行日期+定时任务时间点拼接，如2023-01-01 + 09:30',
  `status` tinyint(4) DEFAULT NULL COMMENT '任务执行状态，0 执行中，1 成功，2 失败',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_configid_warehouseno_type` (`model_config_id`,`warehouse_no`,`category_type`),
  KEY `idx_exetime` (`task_exe_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1588 DEFAULT CHARSET=utf8 COMMENT='动态定价-任务执行记录表'
---
DDL for table: dynamic_price_white_list
CREATE TABLE `dynamic_price_white_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sku` varchar(64) NOT NULL COMMENT 'sku',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `category_type` tinyint(4) DEFAULT NULL COMMENT '类目类型，0 鲜果 1 非鲜果',
  `updater_id` int(11) DEFAULT NULL COMMENT '最新操作人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sku_warehouseno` (`sku`,`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=22145 DEFAULT CHARSET=utf8 COMMENT='动态定价商品白名单表'
---
DDL for table: enterprise_information
CREATE TABLE `enterprise_information` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `reg_number` varchar(31) DEFAULT NULL COMMENT '注册号',
  `reg_status` varchar(31) DEFAULT NULL COMMENT '经营状态',
  `credit_code` varchar(255) DEFAULT NULL COMMENT '统一社会信用代码',
  `estiblish_time` varchar(50) DEFAULT NULL COMMENT '成立日期',
  `reg_capital` varchar(50) DEFAULT NULL COMMENT '注册资本',
  `company_type` smallint(6) DEFAULT NULL COMMENT '公司类型 1-公司，2-香港公司，3-社会组织，4-律所，5-事业单位，6-基金会，9-新机构',
  `name` varchar(255) DEFAULT NULL COMMENT '公司名',
  `org_number` varchar(31) DEFAULT NULL COMMENT '组织机构代码',
  `type` int(11) DEFAULT NULL COMMENT '1-公司 2-人',
  `base` varchar(255) DEFAULT NULL COMMENT '省份',
  `legal_person_name` varchar(255) DEFAULT NULL COMMENT '法人',
  `match_type` varchar(255) DEFAULT NULL COMMENT '匹配原因',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 存在，1 作废',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name_credit_code` (`name`,`credit_code`),
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52331 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='企业信息表'
---
DDL for table: enterprise_wechat_user_relation
CREATE TABLE `enterprise_wechat_user_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `auth_id` bigint(20) DEFAULT NULL COMMENT 'auth 用户id',
  `biz_user_id` bigint(20) DEFAULT NULL COMMENT 'admin  id',
  `third_party_id` varchar(64) DEFAULT NULL COMMENT '微信 user_id',
  PRIMARY KEY (`id`),
  KEY `idex_auth_id_third_id` (`auth_id`,`third_party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业微信用户关系表'
---
DDL for table: etl_oss
CREATE TABLE `etl_oss` (
  `id` bigint(20) NOT NULL COMMENT '主键自增',
  `res_id` varchar(20) DEFAULT NULL COMMENT '资源id',
  `bucket` varchar(64) DEFAULT NULL COMMENT 'Oss bucket',
  `domain` varchar(64) DEFAULT NULL COMMENT '域名',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Etl文件管理'
---
DDL for table: etl_pod_cache_log
CREATE TABLE `etl_pod_cache_log` (
  `id` bigint(20) NOT NULL COMMENT '自增主键',
  `task_code` varchar(32) DEFAULT NULL COMMENT 'etl任务',
  `cache_version` int(4) DEFAULT NULL COMMENT '缓存版本',
  `pod_refresh` varchar(16) DEFAULT NULL COMMENT '节点刷新标识',
  `cache_status` tinyint(1) DEFAULT NULL COMMENT '缓存状态,0不一致,1一致;',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Pod本地缓存记录'
---
DDL for table: etl_task
CREATE TABLE `etl_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `biz_id` varchar(32) DEFAULT NULL COMMENT '业务线',
  `app_name` varchar(32) DEFAULT NULL COMMENT '应用名称',
  `task_type` tinyint(1) DEFAULT NULL COMMENT '任务类型,0导入；1导出',
  `task_name` varchar(64) DEFAULT NULL COMMENT '任务名称',
  `task_code` varchar(128) DEFAULT NULL COMMENT '任务编码',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `scence_desc` varchar(255) DEFAULT NULL COMMENT '应用场景描述',
  `env` varchar(32) DEFAULT NULL COMMENT '环境',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态，0禁用；1启用',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(32) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='etl任务主表'
---
DDL for table: etl_task_detail
CREATE TABLE `etl_task_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务ID',
  `import_max_num` int(10) DEFAULT NULL COMMENT '导入最大数量',
  `export_page_size` int(10) DEFAULT NULL COMMENT '导出获取每页数量',
  `export_max_num` int(10) DEFAULT NULL COMMENT '导出最大数量',
  `jar` varchar(255) DEFAULT NULL COMMENT 'Jar包信息',
  `jar_update_time` datetime DEFAULT NULL COMMENT 'Jar包更新时间',
  `dubbo_service` varchar(255) DEFAULT NULL COMMENT 'dubbo服务',
  `param_class` varchar(255) DEFAULT NULL COMMENT '方法入参class',
  `return_class` varchar(255) DEFAULT NULL COMMENT '返回class',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='etl任务详情'
---
DDL for table: etl_task_record
CREATE TABLE `etl_task_record` (
  `id` bigint(20) NOT NULL COMMENT '主键自增',
  `task_id` bigint(20) DEFAULT NULL COMMENT 'etl任务id',
  `task_type` tinyint(1) DEFAULT NULL COMMENT '任务类型',
  `res_id` varchar(20) DEFAULT NULL COMMENT '资源id',
  `status` varchar(16) DEFAULT NULL COMMENT '状态,ING(进行中)；FINISH(完成)；ERROR(失败)；TRY_ERROR(重试失败）',
  `error_num` int(10) DEFAULT NULL COMMENT '失败次数',
  `error_msg` varchar(255) DEFAULT NULL COMMENT '错误原因',
  `operator` varchar(32) DEFAULT NULL COMMENT '操作人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='etl任务记录'
---
DDL for table: excel_mapping
CREATE TABLE `excel_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(255) DEFAULT NULL COMMENT '模版名称',
  `target` varchar(255) DEFAULT NULL COMMENT 'domain名称',
  `columns` varchar(255) DEFAULT NULL COMMENT '字段名，多个用，分割',
  `foreign_key` varchar(255) DEFAULT NULL COMMENT '需要的关联外键',
  `show_name` varchar(255) DEFAULT NULL COMMENT 'excel字段显示名称,多个用,分隔',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='导入导出映射表'
---
DDL for table: exchange_base_info
CREATE TABLE `exchange_base_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) NOT NULL COMMENT '活动名称',
  `remark` varchar(64) DEFAULT NULL COMMENT '备注',
  `trigger_num` int(11) DEFAULT NULL COMMENT '勾选多少件可以参与',
  `purchase_limit` int(11) DEFAULT NULL COMMENT '每件商品限购数量-单位：件',
  `discount_percentage` int(11) DEFAULT NULL COMMENT '每件商品优惠幅度等于毛利的百分之X',
  `discount` decimal(10,2) DEFAULT NULL COMMENT '每件商品最多优惠金额，元',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '活动类型',
  `status` tinyint(4) NOT NULL COMMENT '活动状态，0 未生效 ，1 生效中',
  `effect_time_type` tinyint(4) NOT NULL COMMENT '生效时间类型，0 固定时间， 1 长期有效',
  `start_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `is_delete` tinyint(4) DEFAULT NULL COMMENT '是否已删除，0 否， 1 是',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8 COMMENT='活动基础信息表'
---
DDL for table: exchange_base_info_copy1
CREATE TABLE `exchange_base_info_copy1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) NOT NULL COMMENT '活动名称',
  `remark` varchar(64) DEFAULT NULL COMMENT '备注',
  `trigger_num` int(11) DEFAULT NULL COMMENT '勾选多少件可以参与',
  `purchase_limit` int(11) DEFAULT NULL COMMENT '每件商品限购数量-单位：件',
  `discount_percentage` int(11) DEFAULT NULL COMMENT '每件商品优惠幅度等于毛利的百分之X',
  `discount` decimal(10,2) DEFAULT NULL COMMENT '每件商品最多优惠金额，元',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '活动类型',
  `status` tinyint(3) unsigned NOT NULL COMMENT '活动状态，0 未生效 ，1 生效中',
  `effect_time_type` tinyint(3) unsigned NOT NULL COMMENT '生效时间类型，0 固定时间， 1 长期有效',
  `start_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `is_delete` tinyint(3) unsigned DEFAULT NULL COMMENT '是否已删除，0 否， 1 是',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动基础信息表'
---
DDL for table: exchange_item_config
CREATE TABLE `exchange_item_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `scope_config_id` bigint(20) NOT NULL COMMENT '范围配置id',
  `sku` varchar(50) NOT NULL COMMENT 'sku',
  `adjust_type` tinyint(4) NOT NULL COMMENT '价格调整方式：0：指定价 1：百分比 2：定额减 3:毛利百分比',
  `amount` decimal(12,4) NOT NULL COMMENT '价格或百分比分子',
  `priority` int(11) DEFAULT NULL COMMENT '排序',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_scope_id_sku` (`scope_config_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8 COMMENT='活动商品配置表'
---
DDL for table: exchange_scope_config
CREATE TABLE `exchange_scope_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `base_info_id` bigint(20) NOT NULL COMMENT '活动基础信息id',
  `scope_id` bigint(20) NOT NULL COMMENT '范围id',
  `type` tinyint(4) DEFAULT NULL COMMENT '范围类型，0 人群包，1 运营城市',
  `status` tinyint(4) DEFAULT NULL COMMENT '生效状态，0 停用， 1 启用',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_base_pool_id` (`base_info_id`,`scope_id`)
) ENGINE=InnoDB AUTO_INCREMENT=426 DEFAULT CHARSET=utf8 COMMENT='活动范围配置表'
---
DDL for table: expand_activity
CREATE TABLE `expand_activity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(50) DEFAULT NULL COMMENT '活动名称',
  `status` int(11) DEFAULT NULL COMMENT '状态 0未生效，1已生效，2已结束',
  `type` tinyint(4) DEFAULT NULL COMMENT '0指固定时间间隔到期，1长期有效',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `validity_period` int(11) DEFAULT NULL COMMENT '特惠有效期-单位：分钟',
  `trigger_times` tinyint(4) DEFAULT NULL COMMENT '触发条件-0首次 1每次',
  `pending_delivery` tinyint(4) DEFAULT NULL COMMENT '触发条件-T+1有带配送的省心送计划',
  `churn_risk` tinyint(4) DEFAULT NULL COMMENT '活动商品枚举-流失风险商品',
  `recall` tinyint(4) DEFAULT NULL COMMENT '活动商品枚举-召回商品',
  `pull_new` tinyint(4) DEFAULT NULL COMMENT '活动商品枚举-拉新商品',
  `purchase_limit` int(11) DEFAULT NULL COMMENT '每件商品限购数量-单位：件',
  `discount_percentage` decimal(10,2) DEFAULT NULL COMMENT '每件商品优惠幅度等于毛利的百分之X',
  `discount` decimal(10,2) DEFAULT NULL COMMENT '每件商品最多优惠X元',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '删除标记,0未删除，1已删除',
  PRIMARY KEY (`id`),
  KEY `idx_time` (`start_time`,`end_time`),
  KEY `idx_status` (`status`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='拓展购买配置表'
---
DDL for table: expand_activity_quantity
CREATE TABLE `expand_activity_quantity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `expand_activity_id` bigint(20) unsigned DEFAULT NULL COMMENT '活动id',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户id',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `order_item_id` bigint(20) DEFAULT NULL COMMENT '订单项id',
  `purchase_quantity` int(11) DEFAULT NULL COMMENT '用户购买数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_mid` (`m_id`),
  KEY `idx_m_orderid` (`m_id`,`order_no`),
  KEY `idx_m_sku` (`m_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='拓展购买用户购买数量表'
---
DDL for table: expand_activity_tag
CREATE TABLE `expand_activity_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `expand_activity_id` bigint(20) unsigned DEFAULT NULL COMMENT '活动id',
  `m_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `order_no` varchar(50) DEFAULT NULL COMMENT '生效活动关联订单号',
  `effective_time` datetime DEFAULT NULL COMMENT '生效时间',
  `validity_period` int(11) DEFAULT NULL COMMENT '特惠有效期-单位：分钟',
  `delivery_time` datetime DEFAULT NULL COMMENT '当次触发省心送配送计划时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_m_id_acid` (`m_id`,`expand_activity_id`),
  KEY `idx_mid` (`m_id`),
  KEY `idx_m_time` (`m_id`,`effective_time`)
) ENGINE=InnoDB AUTO_INCREMENT=24779 DEFAULT CHARSET=utf8 COMMENT='拓展购买用户活动标记表'
---
DDL for table: expand_area
CREATE TABLE `expand_area` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `expand_id` bigint(20) unsigned DEFAULT NULL COMMENT '拓展购买关联id',
  `large_area_no` int(11) DEFAULT NULL COMMENT '运营服务大区',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_expand` (`expand_id`),
  KEY `idx_expand_area` (`expand_id`,`large_area_no`)
) ENGINE=InnoDB AUTO_INCREMENT=748 DEFAULT CHARSET=utf8 COMMENT='拓展购买城市表'
---
DDL for table: expense
CREATE TABLE `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `driver_id` int(20) DEFAULT NULL COMMENT '司机id',
  `delivery_path_id` int(11) DEFAULT NULL COMMENT '配送信息id',
  `delivery_time` datetime DEFAULT NULL COMMENT '配送时间',
  `type` int(2) DEFAULT NULL COMMENT '报销类型',
  `state` int(2) DEFAULT '0' COMMENT '报销状态',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `is_review` int(2) DEFAULT '0' COMMENT '是否复核',
  `m_id` bigint(30) DEFAULT NULL COMMENT '店铺id',
  `mname` varchar(300) DEFAULT NULL COMMENT '店铺名称',
  `updater` varchar(20) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(20) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '审核状态',
  `reason` varchar(55) DEFAULT NULL COMMENT '审核失败原因',
  `tms_delivery_site_id` bigint(20) DEFAULT NULL COMMENT '运输单id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `delivery_path_id` (`delivery_path_id`) USING BTREE,
  KEY `idx_driver_id` (`driver_id`) USING BTREE,
  KEY `idx_m_id` (`m_id`) USING BTREE,
  KEY `idx_delivery_site_id` (`tms_delivery_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='报销单表'
---
DDL for table: expense_detail
CREATE TABLE `expense_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_id` int(11) DEFAULT NULL COMMENT '报销单id',
  `type` int(2) DEFAULT '0' COMMENT '报销类型',
  `state` int(2) DEFAULT '0' COMMENT '状态',
  `is_review` int(2) DEFAULT '0' COMMENT '是否复核',
  `photos` varchar(500) DEFAULT NULL COMMENT '照片',
  `start_address` varchar(255) DEFAULT NULL COMMENT '报销起点',
  `end_address` varchar(255) DEFAULT NULL COMMENT '报销终点',
  `mileage` decimal(10,2) DEFAULT NULL COMMENT '报销里程',
  `amount` decimal(10,2) DEFAULT '0.00' COMMENT '报销金额',
  `remark` varchar(255) DEFAULT NULL COMMENT '报销明细',
  `updater` varchar(20) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `expense_id` (`expense_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=290 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='报销明细表'
---
DDL for table: feedback_wo
CREATE TABLE `feedback_wo` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键，自增长',
  `wo_type` tinyint(4) NOT NULL COMMENT '工单类型分为0(普通类型)和 1(ka大客户)',
  `feedback_channel` tinyint(4) NOT NULL COMMENT ' 0 :公众号， 1：电话, 2.CRM,3.后台: ( 0、1：普通类型，2，3： ka大客户类型 )',
  `wo_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0(默认)待解决,1:解决中,2已解决',
  `stage` smallint(6) NOT NULL DEFAULT '0' COMMENT ' ka大客户的标识状态 ( 1-7 )来自 admin表内的cooperation_stage,普通类型为 8 :售前， 9售后,0 :暂无',
  `m_id` bigint(30) DEFAULT NULL COMMENT 'type为普通用户时对应的用户id,关联merchant表的m_id',
  `phone` varchar(20) DEFAULT NULL COMMENT 'type为普通用户，feedback_channel为电话时 填入',
  `customer_id` bigint(30) DEFAULT NULL COMMENT 'type为ka大客户时的用户id, 关联admin表内的id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '普通用户或是 ka大客户门店下的订单或是售后订单',
  `description` varchar(500) DEFAULT NULL COMMENT '描述的问题内容',
  `description_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0.其它（默认值）1.价格，2.商品，3.质量, 4.售后，5.配送，6.系统',
  `creator_id` bigint(30) DEFAULT NULL COMMENT '工单创建人，对admin表内的admin_id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '工单提交时间',
  `updater_id` bigint(30) DEFAULT NULL COMMENT '工单更新人对应的admin表内的admin_id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户问题反馈工单表'
---
DDL for table: feedback_wo_process
CREATE TABLE `feedback_wo_process` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键、自增长',
  `wo_id` bigint(30) NOT NULL COMMENT '用户问题反馈工单id',
  `content` varchar(500) DEFAULT NULL COMMENT '回复或反馈的内容',
  `content_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0表示回复类型，1表示反馈类型',
  `creator_id` bigint(30) DEFAULT NULL COMMENT '工单创建人，对admin表内的admin_id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `woid_index` (`wo_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户反馈工单处理记录表'
---
DDL for table: fence
CREATE TABLE `fence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fence_name` varchar(50) DEFAULT NULL COMMENT '围栏名称',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `area_no` int(11) DEFAULT NULL COMMENT '运营范围',
  `status` int(11) DEFAULT NULL COMMENT '状态 0正常 1失效',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `admin_id` int(11) DEFAULT NULL,
  `pack_id` int(11) DEFAULT NULL COMMENT '打包id',
  `type` int(11) DEFAULT '0' COMMENT '0 新建 1 拆分',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fence_area_index` (`area_no`) USING BTREE,
  KEY `fence_store_index` (`store_no`) USING BTREE,
  KEY `idx_fence` (`store_no`,`area_no`,`type`,`status`) USING BTREE,
  KEY `idx_status` (`status`,`area_no`,`store_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3552 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='围栏表'
---
DDL for table: fence_area
CREATE TABLE `fence_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fence_id` int(11) NOT NULL COMMENT '围栏ID',
  `name` varchar(64) NOT NULL COMMENT '区域名称',
  `area_type` tinyint(4) NOT NULL COMMENT '区域类型，0：省市区，1：自定义',
  `polyline` longtext NOT NULL COMMENT 'poi坐标边界',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(64) NOT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `idx_fence_id` (`fence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='围栏区域表'
---
DDL for table: fence_area_cross
CREATE TABLE `fence_area_cross` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `fence_id` int(11) NOT NULL COMMENT '围栏ID',
  `fence_area_id` bigint(20) NOT NULL COMMENT '围栏区域ID',
  `ad_code` varchar(50) DEFAULT NULL COMMENT '区域编码',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `level` varchar(50) DEFAULT NULL COMMENT '等级',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_fence_area_id` (`fence_area_id`),
  KEY `idx_city_area` (`city`,`area`),
  KEY `idx_fence_id` (`fence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='围栏区域跨行政区表'
---
DDL for table: fence_delivery
CREATE TABLE `fence_delivery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `fence_id` int(11) DEFAULT NULL COMMENT '围栏id',
  `delivery_frequent` varchar(30) DEFAULT NULL COMMENT '配送周期',
  `next_delivery_date` date DEFAULT NULL COMMENT '首配日',
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '逻辑删除 0否 1是',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `frequent_method` int(11) DEFAULT '1' COMMENT '周期方案 1周计算 2间隔计算',
  `delivery_frequent_interval` int(11) DEFAULT NULL COMMENT '配送间隔周期',
  `begin_calculate_date` date DEFAULT NULL COMMENT '开始计算日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_fence_id` (`fence_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4742 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='围栏配送表'
---
DDL for table: fence_delivery_log
CREATE TABLE `fence_delivery_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `fence_id` int(11) DEFAULT NULL COMMENT '围栏id',
  `delivery_frequent` varchar(30) DEFAULT NULL COMMENT '配送周期',
  `next_delivery_date` datetime DEFAULT NULL COMMENT '首配日',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `frequent_method` int(11) DEFAULT '0' COMMENT '周期方案 1周计算 2间隔计算',
  `delivery_frequent_interval` int(11) DEFAULT NULL COMMENT '配送间隔周期',
  `begin_calculate_date` date DEFAULT NULL COMMENT '开始计算日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5667 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='配送调整记录表'
---
DDL for table: file_download_record
CREATE TABLE `file_download_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 未上传（待计算） 1 已上传（可下载） 2 上传数据失败 3、文件失效（已过期）',
  `file_name` varchar(200) DEFAULT NULL COMMENT '文件名称',
  `admin_id` int(11) DEFAULT NULL COMMENT '导出人id',
  `params` text COMMENT '查询参数',
  `type` tinyint(4) NOT NULL COMMENT '模块类型:大客户对账单(1),账单(2),卡券(3),销售数据(4)，优惠券发放详情（5），采购发票（6），拜访记录（7）,业财现结收入(8),业财资金收入(9),业财账期收入(10),业财账期资金(11),批量下载开票记录处发票信息（12）,配送计划(13), 下载招银收款流水（14）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `u_id` varchar(36) DEFAULT NULL COMMENT 'uid标识',
  `start_time` date DEFAULT NULL COMMENT '（废弃）业务开始时间。',
  `end_time` date DEFAULT NULL COMMENT '（废弃）业务结束时间。',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `name_detail` varchar(200) DEFAULT NULL COMMENT '（废弃）文件名2',
  `expiration_time` int(11) DEFAULT '1' COMMENT '过期时间（天）',
  `file_name_address` varchar(255) DEFAULT NULL COMMENT '文件名1，oss存储地址（不展示，下载用）',
  `name_detail_address` varchar(200) DEFAULT NULL COMMENT '（废弃）文件名2，oss存储地址（不展示，下载用）',
  `oss_type` int(11) DEFAULT '0' COMMENT '0、七牛云存储 ，1、oss存储',
  `biz_status` int(11) DEFAULT '1' COMMENT '业务状态,0失败；1成功',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID',
  `source` varchar(64) DEFAULT 'xianmu' COMMENT '系统来源,xianmu；saas',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_id` (`admin_id`) USING BTREE,
  KEY `idx_end_time` (`end_time`) USING BTREE,
  KEY `idx_start_time` (`start_time`) USING BTREE,
  KEY `idx_expiration_time` (`expiration_time`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=9764 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文件导出记录表'
---
DDL for table: finance_account_adjust
CREATE TABLE `finance_account_adjust` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `finance_account_statement_id` bigint(20) NOT NULL COMMENT '对账单id',
  `finance_account_statement_detail_id` bigint(20) NOT NULL COMMENT '对账单明细id',
  `adjust_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '调整金额',
  `adjust_type` varchar(32) NOT NULL COMMENT '调整类型',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '删除标记 0:未删除 1:已删除',
  PRIMARY KEY (`id`),
  KEY `idx_finance_account_statement_id` (`finance_account_statement_id`),
  KEY `idx_finance_account_statement_detail_id` (`finance_account_statement_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1299 DEFAULT CHARSET=utf8 COMMENT='对账调整明细'
---
DDL for table: finance_account_statement
CREATE TABLE `finance_account_statement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `estimate_amount` decimal(10,2) DEFAULT NULL COMMENT '暂估总成本',
  `total_bill_amount` decimal(10,2) DEFAULT NULL COMMENT '账单总额（调整后总额）',
  `wallets_id` bigint(20) DEFAULT NULL COMMENT '票夹id/为空则没被匹配',
  `write_off_amount` decimal(10,2) DEFAULT NULL COMMENT '核销总额',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `tax_number` varchar(50) DEFAULT NULL COMMENT '税号',
  `supplier_account_id` int(11) DEFAULT NULL COMMENT '支付方式',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `pd_type` int(11) DEFAULT NULL COMMENT '1 生鲜 2 品牌',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `status` int(11) DEFAULT NULL COMMENT '对账单状态 0、付款审核中 1、待审核（账单审核） 2、待供应商确认  5、待付款 6、待开票 7、待复核发票 8、已完成 9、作废',
  `advanced_order_id` varchar(200) DEFAULT NULL COMMENT '预付单id',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_reason` int(11) DEFAULT NULL COMMENT '作废原因：0：审核失败 1：供应商驳回 2：账单审核失败 3：撤回申请 4：付款审核失败',
  `current_processor` varchar(50) DEFAULT NULL COMMENT '当前状态处理人',
  `creator_admin_id` int(11) DEFAULT NULL COMMENT '发起人adminId',
  `supplier_confirm_status` int(11) DEFAULT '1' COMMENT '供应商确认状态 1、未确认 2、已通过 3、已拒绝',
  `confirm_user` int(11) DEFAULT '0' COMMENT '确认人 0：采购代确认 1：供应商确认',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付方式 1、银行卡 2、现金',
  `account_name` varchar(50) DEFAULT NULL COMMENT '账户名称',
  `account_bank` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `account_ascription` varchar(50) DEFAULT NULL COMMENT '银行卡归属地',
  `account` varchar(50) DEFAULT NULL COMMENT '账号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE,
  KEY `idx_tax_number` (`tax_number`) USING BTREE,
  KEY `idx_wallets_id` (`wallets_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2653 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='财务对账单表'
---
DDL for table: finance_account_statement_detail
CREATE TABLE `finance_account_statement_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `finance_account_statement_id` bigint(20) DEFAULT NULL COMMENT '采购对账单id',
  `type` int(11) DEFAULT NULL COMMENT '出入库类型 56、采购退货任务 11、采购入库任务',
  `stock_task_process_id` int(11) DEFAULT NULL COMMENT '出入库任务单表id',
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `sku` varchar(30) DEFAULT NULL COMMENT '产品编号',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '调整后成本',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `adjust_amount` decimal(10,2) DEFAULT NULL COMMENT '调整金额',
  `stock_task_process_detail_id` int(11) DEFAULT NULL COMMENT '出入库任务单详情表id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_task_process_id` (`stock_task_process_id`) USING BTREE,
  KEY `idx_purchase_no` (`purchase_no`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE,
  KEY `idx_statement_id` (`finance_account_statement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3695 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='财务对账单详情表'
---
DDL for table: finance_account_verification
CREATE TABLE `finance_account_verification` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `verification_id` varchar(100) NOT NULL COMMENT '核销单号',
  `finance_account_statement_id` bigint(20) NOT NULL COMMENT '采购对账单id',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `pay_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应付金额',
  `write_off_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '核销金额',
  `input_amount_total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '入总额',
  `input_source_id` varchar(100) NOT NULL COMMENT '入单据号',
  `input_type` int(11) NOT NULL DEFAULT '1' COMMENT '入单类型：1=采购单入库',
  `output_amount_total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '出总额',
  `output_source_id` varchar(100) NOT NULL COMMENT '出单据号',
  `output_type` int(11) NOT NULL COMMENT '出单类型：1=采购单出库 2=供应商预付 3=付款单',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `del_flag` tinyint(4) NOT NULL COMMENT '删除标记 0:未删除 1:已删除',
  `input_stock_task_id` varchar(100) DEFAULT NULL COMMENT '入库单任务详情ID',
  `output_stock_task_id` varchar(100) DEFAULT NULL COMMENT '出库单任务详情ID',
  PRIMARY KEY (`id`),
  KEY `idx_finance_account_statement_id` (`finance_account_statement_id`),
  KEY `idx_input_source_id` (`input_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=567 DEFAULT CHARSET=utf8 COMMENT='对账核销流水表'
---
DDL for table: finance_account_verification_temp
CREATE TABLE `finance_account_verification_temp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `verification_id` varchar(100) NOT NULL COMMENT '核销单号',
  `finance_account_statement_id` bigint(20) NOT NULL COMMENT '采购对账单id',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `pay_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应付金额',
  `write_off_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '核销金额',
  `input_amount_total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '入总额',
  `input_source_id` varchar(100) NOT NULL COMMENT '入单据号',
  `input_type` int(11) NOT NULL DEFAULT '1' COMMENT '入单类型：1=采购单入库',
  `output_amount_total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '出总额',
  `output_source_id` varchar(100) NOT NULL COMMENT '出单据号',
  `output_type` int(11) NOT NULL COMMENT '出单类型：1=采购单出库 2=供应商预付 3=付款单',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `del_flag` tinyint(4) NOT NULL COMMENT '删除标记 0:未删除 1:已删除',
  `input_stock_task_id` varchar(100) DEFAULT NULL COMMENT '入库单任务详情ID',
  `output_stock_task_id` varchar(100) DEFAULT NULL COMMENT '出库单任务详情ID',
  PRIMARY KEY (`id`),
  KEY `idx_finance_account_statement_id` (`finance_account_statement_id`),
  KEY `idx_input_source_id` (`input_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=825 DEFAULT CHARSET=utf8 COMMENT='对账核销流水表'
---
DDL for table: finance_accounting_audit_record
CREATE TABLE `finance_accounting_audit_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `bill_no` char(22) NOT NULL COMMENT '账单编号',
  `creator` varchar(255) NOT NULL COMMENT '发起人',
  `creator_id` bigint(20) NOT NULL COMMENT '发起人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发起时间',
  `auditor` varchar(255) DEFAULT NULL COMMENT '审核人',
  `auditor_id` bigint(20) DEFAULT NULL COMMENT '审核人id',
  `audit_time` datetime DEFAULT NULL COMMENT '审核通过时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:待确认;1:已确认;2:已驳回',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_bill_no` (`bill_no`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='账单确认审核记录'
---
DDL for table: finance_accounting_period_order
CREATE TABLE `finance_accounting_period_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '账期订单表id',
  `bill_generation_time` datetime DEFAULT NULL COMMENT '账单生成日',
  `bill_number` char(22) DEFAULT NULL COMMENT '账单编号',
  `invoice_id` bigint(20) DEFAULT NULL COMMENT '发票抬头id',
  `invoice_title` varchar(50) DEFAULT NULL COMMENT '企业工商名称',
  `name_remakes` varchar(50) DEFAULT NULL COMMENT '品牌名称',
  `bill_confirmation_time` datetime DEFAULT NULL COMMENT '账单确认时间',
  `type` int(11) DEFAULT NULL COMMENT '账单状态： 0、待确认 1、已确认 2、合并后的账单（作废不展示）',
  `admin_id` int(11) DEFAULT NULL COMMENT '品牌adminId',
  `saler_name` varchar(255) DEFAULT NULL COMMENT '所属销售/地推人员',
  `after_sale_amount` decimal(10,2) DEFAULT '0.00' COMMENT '售后总金额',
  `delivery_fee` decimal(12,2) DEFAULT '0.00' COMMENT '配送费用',
  `total_price` decimal(12,2) DEFAULT '0.00' COMMENT '实付价格',
  `store_quantity` int(11) DEFAULT NULL COMMENT '门店数量',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `bill_cycle` varchar(50) DEFAULT NULL COMMENT '账单起止日',
  `out_times_fee` decimal(12,2) DEFAULT '0.00' COMMENT '超时加单费用',
  `receipt_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '收款状态；0-未收款；1-部分收款；2-已收款;3-超额收款',
  `customer_confirm_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '客户确认状态；0-客户待确认；1-客户已确认；',
  `write_off_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '核销金额',
  `saler_id` int(11) DEFAULT NULL COMMENT '销售id',
  `financial_audit` int(11) DEFAULT '0' COMMENT '财务审核状态  0-未审核；1-审核通过；2-驳回',
  `sales_invoicing` int(11) DEFAULT '0' COMMENT '销售申请开票 0 未申请 1 申请中 2 申请成功 3 驳回',
  `remarks` varchar(50) DEFAULT NULL COMMENT '财务审核备注',
  `customer_type` tinyint(4) DEFAULT NULL COMMENT '客户类型:0:品牌;1:门店',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_bill_number` (`bill_number`) USING BTREE,
  KEY `idx_bill_generation_time` (`bill_generation_time`) USING BTREE,
  KEY `idx_update_time` (`update_time`) USING BTREE,
  KEY `idx_saler_name` (`saler_name`) USING BTREE,
  KEY `idx_saler_id` (`saler_id`) USING BTREE,
  KEY `idx_type` (`type`) USING BTREE,
  KEY `idx_name_remakes` (`name_remakes`)
) ENGINE=InnoDB AUTO_INCREMENT=5118 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='账期订单表'
---
DDL for table: finance_accounting_store
CREATE TABLE `finance_accounting_store` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '账期订单门店表id',
  `finance_order_id` bigint(20) NOT NULL COMMENT '账期订单表id',
  `m_id` bigint(20) NOT NULL COMMENT '门店id',
  `saler_name` varchar(255) DEFAULT NULL COMMENT '地推人员',
  `area_no` int(11) DEFAULT NULL COMMENT '门店所在运营区域',
  `mname` varchar(255) DEFAULT NULL COMMENT '门店名称',
  `phone` varchar(11) DEFAULT NULL COMMENT '门店注册手机号',
  `after_sale_money` decimal(10,2) DEFAULT '0.00' COMMENT '门店售后总金额',
  `delivery_fee` decimal(12,2) DEFAULT '0.00' COMMENT '配送费用',
  `total_price` decimal(12,2) DEFAULT '0.00' COMMENT '实付价格',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `out_times_fee` decimal(12,2) DEFAULT '0.00' COMMENT '超时加单费用',
  `saler_id` int(11) DEFAULT NULL COMMENT '销售id',
  `bill_start_time` datetime DEFAULT NULL COMMENT '门店账单开始时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_m_id` (`m_id`) USING BTREE,
  KEY `idx_mname` (`mname`) USING BTREE,
  KEY `idx_area_no` (`area_no`) USING BTREE,
  KEY `idx_finance_order_id` (`finance_order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2492 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='账期订单门店表'
---
DDL for table: finance_accounting_store_detail
CREATE TABLE `finance_accounting_store_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '账期订单门店订单表id',
  `finance_accounting_store_id` bigint(20) NOT NULL COMMENT '账期订单门店表id',
  `after_sale_amount` decimal(12,2) DEFAULT '0.00' COMMENT '售后总金额',
  `delivery_fee` decimal(12,2) DEFAULT '0.00' COMMENT '配送费用',
  `total_price` decimal(12,2) DEFAULT '0.00' COMMENT '实付价格',
  `total_amount_receivable` decimal(12,2) DEFAULT '0.00' COMMENT '应收总金额',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `out_times_fee` decimal(12,2) DEFAULT '0.00' COMMENT '超时加单费用',
  `bill_number` char(22) DEFAULT NULL COMMENT '账单编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_finance_accounting_store_id` (`finance_accounting_store_id`) USING BTREE,
  KEY `idx_bill_number` (`bill_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14996 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='账期订单门店订单表'
---
DDL for table: finance_accounting_store_detail_view
undefined
---
DDL for table: finance_adjustment
CREATE TABLE `finance_adjustment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `adjust_no` char(11) NOT NULL COMMENT '调整单号',
  `bill_number` char(22) NOT NULL COMMENT '账单编号',
  `type` tinyint(4) NOT NULL COMMENT '分配方式 0 所有订单 1 指定订单',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 待审批 1 审批通过 2 审批失败',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '调整实付总金额',
  `total_delivery` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '调整运费总金额',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '调整总金额（调整实付 + 调整运费总金额）',
  `average_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 未均摊明细  1 已均摊明细',
  `attachment` varchar(80) DEFAULT NULL COMMENT '附件',
  `reason` varchar(255) DEFAULT NULL COMMENT '调整原因',
  `note` varchar(255) DEFAULT NULL COMMENT '审批备注',
  `creator` int(11) NOT NULL COMMENT '创建人adminId',
  `approver` int(11) DEFAULT NULL COMMENT '审批人adminId',
  `approve_time` datetime DEFAULT NULL COMMENT '审批时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `receivable_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '调整发起时应收金额',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_adjust_no` (`adjust_no`) USING BTREE,
  KEY `idx_bill_number` (`bill_number`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='调整单'
---
DDL for table: finance_adjustment_detail
CREATE TABLE `finance_adjustment_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `adjust_no` char(11) DEFAULT NULL COMMENT '调整单号',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `order_item_id` bigint(20) DEFAULT NULL COMMENT '订单明细id',
  `adjust_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '调整实付金额',
  `adjust_delivery` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '调整运费金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `m_id` bigint(20) NOT NULL COMMENT '门店id',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE,
  KEY `idx_adjust_no` (`adjust_no`) USING BTREE,
  KEY `idx_order_item_id` (`order_item_id`,`adjust_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1071 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='调整单明细表'
---
DDL for table: finance_advanced_refund
CREATE TABLE `finance_advanced_refund` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT '' COMMENT '供应商名称',
  `refund_amount` decimal(10,2) DEFAULT '0.00' COMMENT '退款金额',
  `status` int(11) DEFAULT NULL COMMENT '付款单状态  1、待退款 2、已退款 3、作废',
  `payment_voucher` varchar(255) DEFAULT '' COMMENT '凭证',
  `creator` varchar(50) DEFAULT '' COMMENT '发起人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(50) DEFAULT '' COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `refund_type` int(11) DEFAULT '1' COMMENT '退款单类型:1-预付款退款 2-账期已付款退款',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE,
  KEY `idx_creator` (`creator`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预付退款单表'
---
DDL for table: finance_audit_record
CREATE TABLE `finance_audit_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `additional_id` bigint(20) DEFAULT NULL COMMENT '预付单/对账单id',
  `type` int(11) DEFAULT NULL COMMENT '单据类型 1、预付单 2、对账单',
  `creator` varchar(50) DEFAULT '' COMMENT '发起人',
  `creator_admin_id` int(11) DEFAULT NULL COMMENT '发起人adminId',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `auditor` varchar(30) DEFAULT '' COMMENT '审核人',
  `auditor_admin_id` int(11) DEFAULT NULL COMMENT '审核人adminId',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `approver` varchar(50) DEFAULT '' COMMENT '审批人',
  `approver_admin_id` int(11) DEFAULT NULL COMMENT '审批人adminId',
  `approve_time` datetime DEFAULT NULL COMMENT '审批时间',
  `payer` varchar(30) DEFAULT '' COMMENT '打款人',
  `payer_admin_id` int(11) DEFAULT NULL COMMENT '打款人adminId',
  `pay_time` datetime DEFAULT NULL COMMENT '打款时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '撤销时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_additional_id` (`additional_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1439 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='财务审核记录表'
---
DDL for table: finance_bank_flowing_water
CREATE TABLE `finance_bank_flowing_water` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `trading_day` varchar(50) DEFAULT NULL COMMENT '交易日',
  `trading_time` varchar(50) DEFAULT NULL COMMENT '交易时间',
  `value_date` varchar(50) DEFAULT NULL COMMENT '起息日',
  `trading_type` varchar(50) DEFAULT NULL COMMENT '交易类型',
  `abstract_text` varchar(80) DEFAULT NULL COMMENT '摘要',
  `transaction_amount` decimal(10,2) DEFAULT NULL COMMENT '交易金额',
  `mark` varchar(50) DEFAULT NULL COMMENT '借贷标记 C:贷；D:借',
  `serial_number` varchar(50) DEFAULT NULL COMMENT '流水号 银行会计系统交易流水号,可以和回单命名中的流水号关联',
  `process_instance_number` varchar(50) DEFAULT NULL COMMENT '流程实例号 企业银行交易序号，唯一标示企业银行客户端发起的一笔交易',
  `business_name` varchar(50) DEFAULT NULL COMMENT '业务名称',
  `purpose` varchar(70) DEFAULT NULL COMMENT '用途',
  `business_reference_number` varchar(50) DEFAULT NULL COMMENT '业务参考号',
  `business_summary` varchar(200) DEFAULT NULL COMMENT '业务摘要',
  `other_summaries` varchar(70) DEFAULT NULL COMMENT '其他摘要',
  `bank_area_no` varchar(70) DEFAULT NULL COMMENT '收/付方开户地区分行号',
  `user_name` varchar(50) DEFAULT NULL COMMENT '收/付方名称',
  `account_number` varchar(200) DEFAULT NULL COMMENT '收/付方帐号',
  `bank_no` varchar(50) DEFAULT NULL COMMENT '收/付方开户行行号',
  `bank_name` varchar(70) DEFAULT NULL COMMENT '收/付方开户行名',
  `bank_address` varchar(70) DEFAULT NULL COMMENT '收/付方开户行地址',
  `company_division` varchar(50) DEFAULT NULL COMMENT '母/子公司所在地区分行',
  `company_account` varchar(70) DEFAULT NULL COMMENT '母/子公司帐号',
  `company_name` varchar(70) DEFAULT NULL COMMENT '母/子公司名称',
  `information_signs` varchar(70) DEFAULT NULL COMMENT '信息标志',
  `information_existence` varchar(10) DEFAULT NULL COMMENT '有否附件信息标志 Y：是 N：否',
  `bill_no` varchar(30) DEFAULT NULL COMMENT '票据号',
  `reversal_flag` varchar(10) DEFAULT NULL COMMENT '冲帐标志 N	*为冲帐，X为补帐（冲账交易与原交易借贷相反）',
  `extended_summary` varchar(70) DEFAULT NULL COMMENT '扩展摘要 有效位数为16',
  `transaction_analysis_code` varchar(6) DEFAULT NULL COMMENT '交易分析码 1-2位取值含义见附录A.8交易分析码，3-6位取值含义见trscod字段说明。',
  `payment_order_no` varchar(50) DEFAULT NULL COMMENT '商务支付订单号 由商务支付订单产生',
  `enterprise_identification_code` varchar(10) DEFAULT NULL COMMENT '企业识别码 开通收方识别功能的账户可以通过此码识别付款方',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `claim_status` int(11) DEFAULT NULL COMMENT '认领状态；0-待认领；1-部分认领；2-全部认领 3-已撤销',
  `pay_type` int(11) DEFAULT NULL COMMENT '收款类型 0 账期账单 1 鲜沐卡',
  PRIMARY KEY (`id`),
  KEY `idx_serial_number` (`serial_number`),
  KEY `idx_user_name` (`user_name`),
  KEY `idx_trading_day` (`trading_day`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8 COMMENT='招银收款流水表'
---
DDL for table: finance_bank_flowing_water_config
CREATE TABLE `finance_bank_flowing_water_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `trading_day` varchar(50) DEFAULT NULL COMMENT '交易日',
  `random_number` varchar(50) DEFAULT NULL COMMENT '当日时间戳/每次调用接口唯一标识',
  `transfer_mark` varchar(50) DEFAULT NULL COMMENT '未传完标记，Y则表示查询交易日在本次查询完成后，还有数据未查，为N则表示已查完交易日的所有交易',
  `last_serial_number` int(11) DEFAULT NULL COMMENT '末位记账序号,每天从0开始',
  `number_of_debits` varchar(50) DEFAULT NULL COMMENT '借方笔数',
  `debit_amount` varchar(15) DEFAULT NULL COMMENT '借方金额',
  `number_of_credits` varchar(50) DEFAULT NULL COMMENT '贷方笔数',
  `credit_amount` varchar(10) DEFAULT NULL COMMENT '贷方金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `bank_no` varchar(25) DEFAULT '571909646710706' COMMENT '银行账号',
  PRIMARY KEY (`id`),
  KEY `idx_trading_day` (`trading_day`),
  KEY `idx_transfer_mark` (`transfer_mark`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='招银收款流水配置表'
---
DDL for table: finance_invoice_expand
CREATE TABLE `finance_invoice_expand` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `financial_invoice_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发票id',
  `preferential_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品金额(实付含税)',
  `delivery_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送费',
  `delivery_preferential_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送费优惠金额',
  `out_times_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '超时加单金额',
  `time_frame_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '精准送金额',
  `refund_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '退款金额',
  `sku_adjust_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'sku调整金额',
  `delivery_fee_adjust_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '运费调整金额',
  PRIMARY KEY (`id`),
  KEY `idx_financical_invoice_id` (`financial_invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1075 DEFAULT CHARSET=utf8 COMMENT='票据信息拓展表'
---
DDL for table: finance_invoice_partner
CREATE TABLE `finance_invoice_partner` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `supplier_id` int(11) NOT NULL COMMENT '合作方id',
  `supplier_type` int(11) DEFAULT '0' COMMENT '合作方类型 0、供应商 1、承运商',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `creator_admin_id` int(11) DEFAULT NULL COMMENT '发起人adminId',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_supplier_id` (`supplier_id`),
  KEY `idx_supplier_type` (`supplier_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2081 DEFAULT CHARSET=utf8 COMMENT='发票来源公司中间表'
---
DDL for table: finance_operator_log
CREATE TABLE `finance_operator_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `additional_id` bigint(20) DEFAULT NULL COMMENT '预付单/对账单id',
  `type` int(11) DEFAULT NULL COMMENT '单据类型 1、预付单 2、对账单',
  `status` int(11) DEFAULT NULL COMMENT '状态 0、有效 1、失效',
  `personnel_type` int(11) DEFAULT NULL COMMENT '操作人类型 0、发票复核人 1、账单/预付审核人 2、付款审核人 3、供应商 4、打款人 5、撤销人 6、创建人 7、采购员（SRM） 8、财务（取消付款）',
  `operator` varchar(50) DEFAULT NULL COMMENT '操作人',
  `operator_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `operator_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '操作人创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `operation_results` int(11) DEFAULT NULL COMMENT '操作结果 0 通过 1 拒绝',
  PRIMARY KEY (`id`),
  KEY `idx_additional_id` (`additional_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19232 DEFAULT CHARSET=utf8 COMMENT='财务应付操作人日志'
---
DDL for table: finance_payment_order
CREATE TABLE `finance_payment_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `additional_id` bigint(20) DEFAULT NULL COMMENT '来源单号 预付单/对账单id/打款单id',
  `type` int(11) DEFAULT NULL COMMENT '来源类型 1预付单 2 对账单 3 打款单',
  `amount` decimal(10,2) DEFAULT '0.00' COMMENT '付款金额',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `status` int(11) DEFAULT NULL COMMENT '付款单状态 0、已作废 1、待付款 2、已付款（已完成） 3、付款审核中',
  `creator` varchar(50) DEFAULT '' COMMENT '发起人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(50) DEFAULT '' COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `payment_voucher` varchar(255) DEFAULT '' COMMENT '付款凭证',
  `application_time` datetime DEFAULT NULL COMMENT '申请时间',
  `approval_time` datetime DEFAULT NULL COMMENT '审批通过时间',
  `supplier_id` int(11) DEFAULT NULL COMMENT '发票销售方id',
  `supplier_name` varchar(50) DEFAULT NULL COMMENT '发票销售方名称',
  `delete_reason` int(11) DEFAULT NULL COMMENT '作废原因：0：付款审核失败 1：财务拒绝2:预付单撤回',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_update_time` (`update_time`) USING BTREE,
  KEY `idx_additional_id` (`additional_id`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4655 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='付款单表'
---
DDL for table: finance_purchase_invoice_wallets
CREATE TABLE `finance_purchase_invoice_wallets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `wallets_no` varchar(50) DEFAULT NULL COMMENT '票夹编号',
  `invoice_quantity` int(11) DEFAULT NULL COMMENT '票夹下发票数量',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT NULL COMMENT '发票销售方名称名称',
  `manager` varchar(50) DEFAULT NULL COMMENT '供应商管理人（采购负责人）',
  `total_included_tax` decimal(10,2) DEFAULT NULL COMMENT '含税总金额',
  `status` int(11) DEFAULT NULL COMMENT '状态：2 待复核，3 已归档 4、待归档',
  `file_time` varchar(50) DEFAULT NULL COMMENT '归档月份',
  `remakes` varchar(150) DEFAULT NULL COMMENT '备注',
  `delete_status` int(11) DEFAULT NULL COMMENT '删除状态：0 有效，1 失效',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `accounting_period_amount` decimal(10,2) DEFAULT NULL COMMENT '账单账期金额',
  `accounting_period_type` int(11) DEFAULT NULL COMMENT '有无账期 0 有 1 无',
  `invoice_review` varchar(50) DEFAULT NULL COMMENT '复核时间',
  `invoice_review_time` datetime DEFAULT NULL COMMENT '复核人',
  `expense_type` int(11) DEFAULT '0' COMMENT '费用类型 0、采购 1、城配',
  `creator_admin_id` int(11) DEFAULT NULL COMMENT '发起人adminId',
  `creator_role_type` varchar(255) DEFAULT NULL COMMENT '提交角色',
  `bill_feature` varchar(255) DEFAULT NULL COMMENT '账单快照',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE,
  KEY `idx_wallets_no` (`wallets_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1675 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购发票票夹表'
---
DDL for table: finance_receipt
CREATE TABLE `finance_receipt` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `admin_id` bigint(20) DEFAULT NULL COMMENT '品牌id/门店id',
  `invoice_id` bigint(20) DEFAULT NULL COMMENT '企业工商名称id',
  `invoice_title` varchar(50) DEFAULT NULL COMMENT '企业工商名称',
  `saler_id` bigint(20) DEFAULT NULL COMMENT '所属销售',
  `receipt_amount` decimal(10,2) DEFAULT NULL COMMENT '本次核销金额',
  `bill_number` int(11) NOT NULL DEFAULT '0' COMMENT '匹配账单数量',
  `receipt_voucher` varchar(500) DEFAULT '' COMMENT '收款凭证',
  `write_off_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '核销状态；0-待核销；1-已核销；2-已撤销; 3驳回',
  `remarks` varchar(255) DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater` varchar(50) NOT NULL DEFAULT '' COMMENT '更新人',
  `saler_name` varchar(50) DEFAULT NULL COMMENT '所属销售名称',
  `creator_id` bigint(20) NOT NULL COMMENT '创建人id',
  `name_remakes` varchar(50) NOT NULL DEFAULT '' COMMENT '品牌名称/门店名称/供应商名称',
  `customer_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '客户类型：0-大客户；1-单店',
  `finance_bank_flowing_water_id` bigint(20) DEFAULT NULL COMMENT '招银流水表id',
  `pay_type` int(11) DEFAULT '0' COMMENT '收款类型 0 账期账单 1 鲜沐卡 2 供应商退款',
  `receipt_no` char(11) DEFAULT NULL COMMENT '核销单号',
  `auditor` varchar(50) DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `auditor_id` bigint(20) DEFAULT NULL COMMENT '审核人id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_id` (`admin_id`) USING BTREE,
  KEY `idx_invoice_id` (`invoice_id`) USING BTREE,
  KEY `idx_update_time` (`update_time`) USING BTREE,
  KEY `idx_receipt_no` (`receipt_no`)
) ENGINE=InnoDB AUTO_INCREMENT=458 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收款单表'
---
DDL for table: finance_receipt_bill
CREATE TABLE `finance_receipt_bill` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `finance_receipt_id` bigint(20) NOT NULL COMMENT 'finance_receipt收款单表id',
  `finance_order_id` bigint(20) NOT NULL COMMENT '业务表id:账单id/充值id/退款id',
  `receipt_amount` decimal(10,2) NOT NULL COMMENT '收款金额',
  `other_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '其他金额',
  `receipt_voucher` varchar(500) NOT NULL DEFAULT '' COMMENT '收款凭证',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `receivable_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'finance_accounting_period_order对账单表应收总额',
  `source_no` varchar(36) DEFAULT NULL COMMENT '来源单据号:账单编号/充值单号/退款单号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_finance_receipt_id` (`finance_receipt_id`) USING BTREE,
  KEY `idx_finance_order_id` (`finance_order_id`) USING BTREE,
  KEY `idx_source_no` (`source_no`)
) ENGINE=InnoDB AUTO_INCREMENT=533 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收款单-账单表'
---
DDL for table: finance_receipt_bill_flowing_water
CREATE TABLE `finance_receipt_bill_flowing_water` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `finance_receipt_id` bigint(20) NOT NULL COMMENT 'finance_receipt收款单表id',
  `finance_order_id` bigint(20) NOT NULL COMMENT 'finance_accounting_period_order对账单表id',
  `type` tinyint(4) NOT NULL COMMENT '流水类型：0-待核销；1-已核销；2-已撤销',
  `receivable_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账单应收总额',
  `un_written_off_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账单未核销金额',
  `receipt_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '收款金额',
  `other_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '其他金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_finance_receipt_id` (`finance_receipt_id`) USING BTREE,
  KEY `idx_finance_order_id` (`finance_order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收款单-账单表-流水表'
---
DDL for table: finance_receipt_voucher
CREATE TABLE `finance_receipt_voucher` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `finance_receipt_id` bigint(20) NOT NULL COMMENT 'finance_receipt收款单表id',
  `receipt_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '收款金额',
  `receipt_voucher` varchar(255) DEFAULT NULL COMMENT '收款凭证',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `customer_payment_time` datetime DEFAULT NULL COMMENT '客户打款日期。',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_finance_receipt_id` (`finance_receipt_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=564 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收款单-收款凭证表'
---
DDL for table: finance_settlement
CREATE TABLE `finance_settlement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '账期结算周期表id',
  `admin_id` int(11) NOT NULL COMMENT '品牌id',
  `settlement_method` int(11) DEFAULT '0' COMMENT '结算方式 0 半月结 1-28 每月X号月结',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 存在，1 作废',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_id` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='账期结算周期表'
---
DDL for table: financial_invoice
CREATE TABLE `financial_invoice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `invoice_id` bigint(30) NOT NULL COMMENT '取自invoice_config表内',
  `invoice_type` tinyint(4) NOT NULL COMMENT '0: 增值税电子发票, 1:增值税专用发票',
  `amount_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '合计金额',
  `invoice_result` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开票进度:0:开票中,1:已开票, 2:开票失败',
  `creator_id` bigint(20) NOT NULL COMMENT '取自admin表，发起人',
  `handler_id` bigint(20) DEFAULT NULL COMMENT '取自admin表，发票处理人',
  `creator_remark` varchar(500) DEFAULT NULL COMMENT '发起备注',
  `handler_remark` varchar(500) DEFAULT NULL COMMENT '审批备注(202209后为开票完成百旺回文)',
  `handle_time` datetime DEFAULT NULL COMMENT '处理人处理的时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建该发票时提交时间',
  `express` varchar(30) DEFAULT '' COMMENT '快递单号',
  `finance_order_id` bigint(20) DEFAULT NULL COMMENT '账期订单表id 来源于finance_accounting_period_order',
  `invoice_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '票据状态:0:正常,1:部分红冲, 2:全额红冲,3:作废',
  `serial_number` varchar(128) NOT NULL DEFAULT '' COMMENT '请求流水号',
  `pdf_url` varchar(512) DEFAULT NULL COMMENT '发票pdf的url路径',
  `tax_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '合计税额',
  `duty_free_good` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '免税品票:0 否,1 是',
  `invoice_code` varchar(32) DEFAULT NULL COMMENT '发票代码',
  `invoice_number` varchar(32) DEFAULT NULL COMMENT '发票号码',
  `belong_type` tinyint(4) DEFAULT '0' COMMENT '发票归属种类 0企业 1个人',
  `mail_address` varchar(128) DEFAULT NULL COMMENT '邮寄地址',
  `title` varchar(128) DEFAULT NULL COMMENT '抬头地址',
  `creator_name` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `time_result_type` (`create_time`,`invoice_result`,`invoice_type`) USING BTREE,
  KEY `idx_finance_accounting_period_order` (`finance_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2217 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='生成开票，和财务审核开票记录表'
---
DDL for table: financial_invoice_orderno_relation
CREATE TABLE `financial_invoice_orderno_relation` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `financial_invoice_id` bigint(30) NOT NULL COMMENT '取自financial_invoice表',
  `order_no` varchar(36) NOT NULL COMMENT '取自order表内',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建关联关系提交时间',
  `order_item_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单明细id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_item` (`order_item_id`),
  KEY `idx_fi_id` (`financial_invoice_id`),
  KEY `idx_order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3185 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='开票记录与选中的订单之间的关系'
---
DDL for table: focus_on
CREATE TABLE `focus_on` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户ID',
  `sku` varchar(30) DEFAULT NULL COMMENT 'SKU',
  `add_time` datetime DEFAULT NULL COMMENT '关注时间',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '逻辑删除：0：未删除，1：已删除',
  `is_remind` tinyint(4) DEFAULT NULL COMMENT '是否到货提醒：0:不提醒，1:提醒',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku_area` (`sku`,`area_no`) USING BTREE,
  KEY `idx_m_id` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='关注商品表'
---
DDL for table: follow_up_evaluation
CREATE TABLE `follow_up_evaluation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `follow_record_id` int(11) NOT NULL COMMENT '拜访记录ID',
  `satisfaction_level` tinyint(4) NOT NULL COMMENT '满意级别',
  `tag` varchar(50) NOT NULL COMMENT '评价标签',
  `remark` varchar(50) DEFAULT NULL COMMENT '评价描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_follow_record_id` (`follow_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='销售评价表'
---
DDL for table: follow_up_record
CREATE TABLE `follow_up_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(30) DEFAULT NULL COMMENT '商户id',
  `admin_id` int(11) DEFAULT NULL COMMENT 'BD id',
  `admin_name` varchar(36) DEFAULT NULL COMMENT '跟进人',
  `creator` varchar(36) DEFAULT NULL COMMENT '工单创建者',
  `m_lifecycle` tinyint(4) DEFAULT NULL COMMENT '生命周期(弃用)',
  `m_tag` varchar(50) DEFAULT NULL COMMENT '用户标签(弃用)',
  `m_last_order_time` datetime DEFAULT NULL COMMENT '工单生成前最近一次下单时间(弃用)',
  `follow_up_way` varchar(50) DEFAULT NULL COMMENT '跟进方式',
  `condition` text COMMENT '跟进情况描述',
  `follow_up_pic` varchar(3000) DEFAULT NULL COMMENT '跟进资料图片',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态:0未跟进,1已跟进,2已跟进',
  `priority` tinyint(4) DEFAULT NULL COMMENT '优先级(弃用)',
  `add_time` datetime DEFAULT NULL COMMENT '跟进时间',
  `contact_id` int(11) DEFAULT NULL,
  `next_follow_time` date DEFAULT NULL COMMENT '下次拜访时间',
  `expected_content` varchar(255) DEFAULT NULL COMMENT '期望内容',
  `visit_objective` tinyint(4) DEFAULT '2' COMMENT '拜访目的:0拉新,1催月活,2客户维护,3拓品,4售后处理,5催省心送',
  `whether_remark` int(11) DEFAULT '0' COMMENT '任务备注,0(否),卡券id(是)',
  `visit_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '拜访类型:0普通拜访,1陪访',
  `location` varchar(255) NOT NULL DEFAULT '' COMMENT '拜访定位',
  `kp_id` int(11) NOT NULL DEFAULT '0' COMMENT '拜访kp的id',
  `poi_note` varchar(255) NOT NULL DEFAULT '' COMMENT '定位腾讯地图坐标',
  `escort_admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '陪访人id(弃用)',
  `visit_plan_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '拜访计划id',
  `escort_visit_plan_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '陪访计划id',
  `account_id` bigint(20) DEFAULT NULL COMMENT '子账号id',
  `feedback` varchar(255) DEFAULT NULL COMMENT '客户反馈',
  `feedback_time` datetime DEFAULT NULL COMMENT '客户反馈时间',
  `poi_update_flag` tinyint(4) DEFAULT NULL COMMENT 'poi是否被更新 1:是;2:否',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind_contact_id` (`contact_id`) USING BTREE,
  KEY `rds_idx_3` (`status`,`m_id`,`add_time`) USING BTREE,
  KEY `fure_fk_m_id` (`m_id`) USING BTREE,
  KEY `idx_admin_time_id` (`add_time`,`admin_id`) USING BTREE,
  KEY `idx_adminid_addtime_contactid_mid` (`admin_id`,`add_time`,`contact_id`,`m_id`),
  KEY `idx_feedback_time` (`feedback_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='跟进记录'
---
DDL for table: follow_up_relation
CREATE TABLE `follow_up_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(30) DEFAULT NULL COMMENT '商户ID',
  `admin_id` int(11) DEFAULT NULL COMMENT '跟进人',
  `admin_name` varchar(255) DEFAULT NULL COMMENT '管理员名称',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `reassign` tinyint(1) DEFAULT '0' COMMENT '重新指派标志，0没有，1已重新指派跟进人',
  `last_follow_up_time` datetime DEFAULT NULL COMMENT '最近跟进时间',
  `reassign_time` datetime DEFAULT NULL COMMENT '重新指派时间',
  `reason` varchar(100) DEFAULT NULL COMMENT '释放或跟进原因',
  `follow_type` int(11) DEFAULT '0' COMMENT '新购买标签,无(0)新购买(1)由定时任务处理取消新购买标签(2)',
  `danger_day` int(11) DEFAULT NULL COMMENT '自动释放倒计时',
  `timing_follow_type` int(11) DEFAULT '0' COMMENT '省心送标签:无(0)省心送(1)',
  `care_bd_id` bigint(20) DEFAULT '0' COMMENT '关注人id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_m_id` (`m_id`) USING BTREE,
  KEY `in_add_time` (`add_time`) USING BTREE,
  KEY `in_danger` (`danger_day`) USING BTREE,
  KEY `idx_mid_reassign_adminname` (`m_id`,`reassign`,`admin_name`) USING BTREE,
  KEY `follow_up_relation_admin_index` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3595 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户对应负责人'
---
DDL for table: follow_up_relation_20211201_20220228
CREATE TABLE `follow_up_relation_20211201_20220228` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `m_id` bigint(20) DEFAULT NULL COMMENT '客户ID',
  `bd_id` bigint(20) DEFAULT NULL COMMENT '销售ID',
  `ds` bigint(20) DEFAULT NULL COMMENT 'ds',
  `big_cust_id` bigint(20) DEFAULT NULL COMMENT '大客户ID',
  `big_cust` varchar(2048) DEFAULT NULL COMMENT '大客户名称',
  `big_cust_type` varchar(1024) DEFAULT NULL COMMENT '大客户类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户&销售关系备份表 20211201_20220228'
---
DDL for table: front_category
CREATE TABLE `front_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级id',
  `name` varchar(20) DEFAULT NULL COMMENT '名称',
  `outdated` int(11) DEFAULT NULL COMMENT '有效标识 0、有效 1、失效',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标链接',
  `updater` varchar(20) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_name` (`name`,`outdated`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=915 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='前台类目'
---
DDL for table: front_category_config
CREATE TABLE `front_category_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `sort_top` int(11) DEFAULT NULL COMMENT '0不置顶，1置顶',
  `large_area_no` int(11) DEFAULT NULL COMMENT '运营大区编号',
  `front_category_id` int(11) DEFAULT NULL COMMENT '前台类目id',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_search` (`large_area_no`,`front_category_id`),
  KEY `idx_search_sku` (`large_area_no`,`front_category_id`,`sort_top`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='前台类目配置'
---
DDL for table: front_category_to_area
CREATE TABLE `front_category_to_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `front_category_id` int(11) DEFAULT NULL COMMENT '前台类目id',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `display` int(11) DEFAULT NULL COMMENT '展示状态：0、不展示 1、展示',
  `priority` int(11) DEFAULT NULL COMMENT '排序值，从小到大',
  `updater` varchar(20) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `front_category_to_area_index` (`front_category_id`,`area_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=139095 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='前台类目城市表'
---
DDL for table: front_category_to_category
CREATE TABLE `front_category_to_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `front_category_id` int(11) DEFAULT NULL COMMENT '前台类目id',
  `category_id` int(11) DEFAULT NULL COMMENT '后台类目id',
  `creator` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_front_category` (`front_category_id`) USING BTREE,
  KEY `idx_category` (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=907 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='类目映射关系表'
---
DDL for table: fruit_purchase_prediction
CREATE TABLE `fruit_purchase_prediction` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `prediction_date` date NOT NULL COMMENT '预测日期',
  `sku` varchar(30) NOT NULL COMMENT 'sku编号',
  `pd_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `area_no` int(10) NOT NULL COMMENT '仓库编号',
  `quantity` int(10) NOT NULL DEFAULT '0' COMMENT '仓库库存数量',
  `purchase_reference` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '采购参考',
  `sales_prediction` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '今日销量预测',
  `recent_seven_days_sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '近7天平均销量',
  `recent_three_days_sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '近3天平均销量',
  `work_day_sales_bm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '大客户近两周同一工作日平均销量',
  `work_day_sales_ss` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单店近两周同一工作日平均销量',
  `purchaser` varchar(128) DEFAULT NULL COMMENT '采购负责人',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pre_sale_second_day` int(11) DEFAULT '0' COMMENT '第二天销量预测',
  `pre_sale_third_day` int(11) DEFAULT '0' COMMENT '第二天销量预测',
  `pre_sale_fourth_day` int(11) DEFAULT '0' COMMENT '第四天销量预测',
  `pre_sale_fifth_day` int(11) DEFAULT '0' COMMENT '第五天销量预测',
  `pre_sale_sixth_day` int(11) DEFAULT '0' COMMENT '第六天销量预测',
  `pre_sale_seventh_day` int(11) DEFAULT '0' COMMENT '第七天销量预测',
  `vip_avg_sales` int(11) DEFAULT '0' COMMENT '大客户3天销量平均值',
  `single_avg_sales` int(11) DEFAULT '0' COMMENT '单店三天平均值',
  `sales_rate` double(10,2) DEFAULT '0.00' COMMENT '增长率',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_prediction_area_sku` (`prediction_date`,`area_no`,`sku`) USING BTREE,
  KEY `idx_purchaser` (`purchaser`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=176266 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='水果采购预测数据表'
---
DDL for table: fruit_sales
CREATE TABLE `fruit_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `order_item_id` bigint(20) NOT NULL,
  `sku` varchar(30) DEFAULT NULL,
  `sales` int(11) DEFAULT '0' COMMENT '销量明细',
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) DEFAULT '0' COMMENT '0 正常订单 1 当天售后 2 非当天售后',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku_area_time` (`sku`,`area_no`,`time`),
  KEY `idx_order_item_id` (`order_item_id`) COMMENT '明细id索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='水果销量流水'
---
DDL for table: future_sku
CREATE TABLE `future_sku` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `area_no` int(11) NOT NULL,
  `sku` varchar(30) NOT NULL DEFAULT '',
  `curdate` date NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `future_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `un_asd` (`area_no`,`sku`,`curdate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: gmv_month_data
CREATE TABLE `gmv_month_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `admin_id` int(11) DEFAULT NULL COMMENT 'BD',
  `area_no` int(11) DEFAULT NULL COMMENT '城市',
  `dairy_gmv` decimal(10,2) DEFAULT NULL COMMENT '乳制品日gmv',
  `fruit_gmv` decimal(10,2) DEFAULT NULL COMMENT '水果+衍生品日gmv',
  `gmv_time` datetime DEFAULT NULL COMMENT '日gmv时间',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 存在，1 作废',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `realname` varchar(255) DEFAULT NULL COMMENT 'BD名称',
  `amount` int(11) DEFAULT NULL COMMENT '订单日数量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_id` (`admin_id`,`status`) USING BTREE,
  KEY `idx_area_no` (`admin_id`,`area_no`) USING BTREE,
  KEY `idx_gmv_time` (`gmv_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3082 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='销售城市日GMV数据表'
---
DDL for table: goods_allocation
CREATE TABLE `goods_allocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT '调拨入库，调拨出库',
  `record_id` int(11) DEFAULT NULL COMMENT '货位变更id',
  `allocation_id` int(11) DEFAULT NULL COMMENT '调拨单项id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='调拨单详情 货位变更关联表'
---
DDL for table: goods_check_task
CREATE TABLE `goods_check_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `task_source` int(11) NOT NULL COMMENT '任务来源 1-定时任务 2-手动新增 3-新品入仓',
  `task_status` int(11) NOT NULL COMMENT '任务状态 1-待完成 2-已完成',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(128) NOT NULL COMMENT '商品sku编码',
  `sku_name` varchar(128) NOT NULL COMMENT '商品sku名称',
  `weight` varchar(64) NOT NULL DEFAULT '' COMMENT '规格',
  `storage_location` tinyint(4) NOT NULL COMMENT '存储区域',
  `volume` varchar(64) NOT NULL COMMENT '体积',
  `weight_num` decimal(10,2) NOT NULL COMMENT '重量',
  `creator` varchar(64) DEFAULT '' COMMENT '创建人',
  `operator` varchar(128) DEFAULT '' COMMENT '修改人',
  `gmt_created` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否软删',
  `last_ver` int(11) NOT NULL COMMENT '最新版本号',
  `push_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '任务推送状态',
  `pd_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `unit` varchar(10) DEFAULT NULL COMMENT '包装',
  `is_domestic` tinyint(4) DEFAULT '1' COMMENT '是否为国产，0：不是，1是',
  `quality_time` int(11) DEFAULT '0' COMMENT '保质期时长',
  `quality_time_unit` varchar(30) DEFAULT 'day' COMMENT '保质期时长单位（day，month）',
  `quality_time_type` tinyint(4) DEFAULT NULL COMMENT '保质期时长类型, 0 固定时长, 1 到期时间',
  `pic_url` varchar(1024) DEFAULT NULL COMMENT '上传图片url',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`task_status`),
  KEY `idx_sku` (`sku`),
  KEY `idx_warehouse` (`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3567 DEFAULT CHARSET=utf8 COMMENT='商品校验任务表'
---
DDL for table: goods_code_order
CREATE TABLE `goods_code_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_path_id` int(11) DEFAULT NULL COMMENT '配送路线id',
  `order_item_id` int(11) DEFAULT NULL COMMENT '订单项id',
  `only_code` varchar(20) DEFAULT NULL COMMENT '唯一码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `n_order_item` (`order_item_id`) USING BTREE,
  KEY `n_code` (`only_code`) USING BTREE,
  KEY `n_delivery_path_id` (`delivery_path_id`,`order_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='物品码关联信息表'
---
DDL for table: goods_damage_config
CREATE TABLE `goods_damage_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `config_value` int(11) NOT NULL COMMENT '类型值',
  `config_desc` varchar(64) NOT NULL COMMENT '描述',
  `prove_type` int(11) NOT NULL COMMENT '证明类型 1-图片 2-文本框',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '启用状态 1-启用 2-停用',
  `creator` varchar(64) DEFAULT '' COMMENT '创建人',
  `operator` varchar(128) DEFAULT '' COMMENT '修改人',
  `gmt_created` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `last_ver` int(11) NOT NULL COMMENT '最新版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_value` (`config_value`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='货损出库类型'
---
DDL for table: goods_defect_config
CREATE TABLE `goods_defect_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `updated_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `state` int(11) DEFAULT '0' COMMENT '状态0-删除1-正常',
  `defect_type` int(11) DEFAULT '0' COMMENT '缺陷类型',
  `defect_desc` varchar(32) DEFAULT '' COMMENT '缺陷描述',
  `deleted_at` bigint(20) unsigned DEFAULT '0' COMMENT '删除时间',
  `operator` varchar(32) DEFAULT '' COMMENT '操作人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_deleted_at_desc` (`deleted_at`,`defect_desc`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COMMENT='货检商品缺陷配置'
---
DDL for table: goods_detail_record
CREATE TABLE `goods_detail_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `origin_gl_no` varchar(50) DEFAULT NULL COMMENT '原货位',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `pd_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `new_gl_no` varchar(50) DEFAULT NULL COMMENT '新货位编号',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `quantity` int(11) DEFAULT NULL COMMENT '转移数量',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人id ',
  `admin_name` varchar(40) DEFAULT NULL COMMENT '操作人名称',
  `type_name` varchar(50) DEFAULT NULL COMMENT '操作名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1338 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='货位详情变更信息'
---
DDL for table: goods_location
CREATE TABLE `goods_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编码',
  `add_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `temperature` int(11) DEFAULT NULL COMMENT '温区 。常温，冷藏，冷冻，对应的编码为3，2，1',
  `passageway` varchar(10) DEFAULT NULL COMMENT '通道',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 储货位 1 暂存位 2 捡货位',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goods_location_storeno_index` (`store_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='货位表'
---
DDL for table: goods_location_detail
CREATE TABLE `goods_location_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编号',
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `status` int(11) DEFAULT '0' COMMENT '状态 0 生效 1 失效',
  `sale_lock_quantity` int(11) DEFAULT '0' COMMENT '销售出库任务锁定库存',
  `production_date` date DEFAULT NULL COMMENT '生产时期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goods_location_detail_gl_no_batch_quality_date_sku_index` (`sku`,`batch`,`quality_date`,`gl_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=684 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='货位详情\n'
---
DDL for table: goods_mapping
CREATE TABLE `goods_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户Id',
  `goods_type` int(11) DEFAULT NULL COMMENT '货品类型：1=SKU，2=SPU',
  `goods_code` varchar(50) DEFAULT NULL COMMENT '货品唯一编码',
  `source` varchar(20) NOT NULL COMMENT '来源：1=鲜沐， 2=SAAS',
  `source_id` bigint(20) DEFAULT NULL COMMENT '代理skuId',
  `agent_tenant_id` bigint(20) DEFAULT NULL COMMENT '代理租户Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='货品映射表'
---
DDL for table: goods_sku
CREATE TABLE `goods_sku` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sku` varchar(30) NOT NULL COMMENT '产品编号',
  `sku_pic` varchar(50) DEFAULT NULL COMMENT 'sku图',
  `sku_name` varchar(60) DEFAULT NULL COMMENT 'sku名称',
  `pd_no` varchar(30) DEFAULT NULL COMMENT 'spu编码',
  `origin` varchar(100) DEFAULT NULL COMMENT '产地',
  `is_domestic` tinyint(4) DEFAULT '1' COMMENT '是否为国产，0：不是，1是',
  `unit` varchar(5) DEFAULT NULL COMMENT '单位',
  `specification` varchar(100) DEFAULT NULL COMMENT '规格',
  `volume` varchar(255) DEFAULT NULL COMMENT '体积(长*宽*高)',
  `weight_num` decimal(10,2) DEFAULT NULL COMMENT '重量kg',
  `outdated` int(11) DEFAULT '0' COMMENT 'SKU生命周期：-1、上新处理中 0、使用中 1、已删除',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 自营 1 代仓',
  `task_type` int(11) DEFAULT '1' COMMENT '任务类型：0、SPU 1、SKU',
  `audit_status` int(11) DEFAULT '1' COMMENT '上新审核状态：0、待上新 1、上新成功 2、上新失败',
  `audit_time` datetime DEFAULT NULL COMMENT '上新审核时间',
  `create_remark` varchar(1000) DEFAULT NULL COMMENT '上新备注',
  `create_type` int(11) NOT NULL DEFAULT '0' COMMENT '上新类型：0、平台 1、大客户 2、saas自营&代仓 3、仅saas自营',
  `auditor` int(11) DEFAULT NULL COMMENT '操作人adminId',
  `refuse_reason` varchar(255) DEFAULT NULL COMMENT '拒绝原因',
  `admin_id` int(11) DEFAULT NULL COMMENT '所属大客户ID',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='货品SKU表'
---
DDL for table: goods_spu
CREATE TABLE `goods_spu` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pd_no` varchar(30) DEFAULT NULL COMMENT 'spu编码',
  `category_id` int(11) DEFAULT NULL COMMENT '类目ID',
  `brand_id` int(11) DEFAULT NULL COMMENT '品牌(存量数据使用)',
  `pd_name` varchar(255) DEFAULT NULL COMMENT '货品名称',
  `real_name` varchar(50) DEFAULT NULL COMMENT '货品实物名(存量数据使用)',
  `product_introduction` varchar(200) DEFAULT NULL COMMENT '货品介绍信息',
  `pddetail` text COMMENT '货品描述',
  `picture_path` varchar(1255) DEFAULT NULL COMMENT '主图',
  `detail_picture` varchar(1255) DEFAULT NULL COMMENT '详情图片',
  `storage_location` tinyint(2) DEFAULT '0' COMMENT '仓储区域',
  `storage_method` varchar(255) DEFAULT NULL COMMENT '存储方式',
  `quality_time` int(10) DEFAULT '0' COMMENT '保质期时长',
  `quality_time_unit` varchar(30) DEFAULT 'day' COMMENT '保质期时长单位',
  `quality_time_type` tinyint(4) DEFAULT '0' COMMENT '保质期时长类型, 0 固定时长, 1 到期时间',
  `outdated` int(11) DEFAULT '0' COMMENT 'SPU生命周期：-1、上新中 0、有效 1、已删除',
  `warn_time` int(10) DEFAULT NULL COMMENT '临保预警时长',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `create_type` int(11) DEFAULT '0' COMMENT '上新类型：0、平台 1、大客户',
  `create_remark` varchar(500) DEFAULT NULL COMMENT '上新备注',
  `audit_status` int(11) DEFAULT '1' COMMENT '上新审核状态：0、待上新 1、上新成功 2、上新失败',
  `audit_time` datetime DEFAULT NULL COMMENT '上新审核时间',
  `auditor` int(11) DEFAULT NULL COMMENT '操作人adminId',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='货品SPU'
---
DDL for table: goods_task_white_list
CREATE TABLE `goods_task_white_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sku` varchar(128) NOT NULL COMMENT '商品sku编码',
  `creator` varchar(64) DEFAULT '' COMMENT '创建人',
  `operator` varchar(128) DEFAULT '' COMMENT '修改人',
  `gmt_created` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否软删',
  `last_ver` int(11) NOT NULL COMMENT '最新版本号',
  `push_status` tinyint(4) DEFAULT NULL COMMENT '推送状态 1-需要推送 2-关闭推送',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unidx_sku` (`sku`),
  KEY `idx_status` (`push_status`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='任务推送白名单表'
---
DDL for table: goods_transfer
CREATE TABLE `goods_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total_quantity` int(11) DEFAULT NULL COMMENT '总数量',
  `store_no` int(11) DEFAULT NULL COMMENT '仓库',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '操作人名称',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='货位转移'
---
DDL for table: goods_transfer_item
CREATE TABLE `goods_transfer_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `pd_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `goods_transfer_id` int(11) DEFAULT NULL COMMENT '货位转移任务id',
  `total_quantity` int(11) DEFAULT NULL COMMENT '总数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='货位转移条目'
---
DDL for table: goods_transfer_item_detail
CREATE TABLE `goods_transfer_item_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_transfer_item_id` int(11) DEFAULT NULL COMMENT '货位转移id',
  `origin_gl_no` varchar(50) DEFAULT NULL COMMENT '原货位',
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `quality_date` datetime DEFAULT NULL COMMENT '保质期',
  `quantity` int(11) DEFAULT NULL COMMENT '转移时的剩余数量',
  `transfer_quantity` int(11) DEFAULT NULL COMMENT '转移数量',
  `new_gl_no` varchar(50) DEFAULT NULL COMMENT '新货位',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='货位转移详情'
---
DDL for table: group_buy_config
CREATE TABLE `group_buy_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `area_no` int(11) NOT NULL COMMENT '开放城市',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态：0、失效 1、有效',
  `least_number` int(11) NOT NULL COMMENT '最小成团量',
  `end_time` datetime NOT NULL COMMENT '团购截止时间',
  `delivery_time` date NOT NULL COMMENT '配送时间',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `group_buy_name` varchar(255) NOT NULL DEFAULT '' COMMENT '团购活动名称',
  `group_buy_pic` varchar(255) NOT NULL DEFAULT '' COMMENT '团购活动图片',
  `actual_end_time` datetime DEFAULT NULL COMMENT '团购实际结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='团购场次配置'
---
DDL for table: group_buy_info
CREATE TABLE `group_buy_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `m_id` bigint(20) unsigned NOT NULL COMMENT '团长id',
  `contact_id` bigint(20) unsigned NOT NULL COMMENT '配送地址id',
  `status` int(11) DEFAULT NULL COMMENT '状态：0、拼团中 1、拼团成功 2、拼团失败',
  `area_no` int(11) NOT NULL COMMENT '团购发起城市',
  `least_number` int(11) NOT NULL COMMENT '最小成团量',
  `end_time` datetime NOT NULL COMMENT '成团截止时间',
  `delivery_time` date NOT NULL COMMENT '配送时间',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '团购备注',
  `group_buy_config_id` bigint(20) NOT NULL COMMENT 'config id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_m_contact` (`m_id`,`contact_id`) USING BTREE,
  KEY `idx_config` (`group_buy_config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='场次信息'
---
DDL for table: group_buy_order_record
CREATE TABLE `group_buy_order_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `info_id` bigint(20) unsigned NOT NULL COMMENT '团购场次id',
  `order_no` varchar(36) CHARACTER SET utf8mb4 NOT NULL COMMENT '订单编号',
  `contact` varchar(30) CHARACTER SET utf8mb4 NOT NULL COMMENT '联系人地址',
  `phone` varchar(30) CHARACTER SET utf8mb4 NOT NULL COMMENT '手机号',
  `address` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT '送货地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '团购单备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_info_order` (`info_id`,`order_no`) USING BTREE,
  KEY `idx_order` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='团购订单记录'
---
DDL for table: in_bound_order
CREATE TABLE `in_bound_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库号',
  `type` int(10) unsigned DEFAULT NULL COMMENT '入库类型',
  `stock_storage_task_id` bigint(20) unsigned DEFAULT NULL COMMENT '入库任务id',
  `operator` varchar(32) DEFAULT NULL COMMENT '操作人',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id(saas品牌方)',
  `fulfillment_no` varchar(64) DEFAULT NULL COMMENT '履约单号',
  `operator_name` varchar(255) DEFAULT NULL COMMENT '操作人名称',
  `receiving_container` varchar(32) DEFAULT NULL COMMENT '收货容器',
  PRIMARY KEY (`id`),
  KEY `ndx_warehouse_no_type` (`warehouse_no`,`type`),
  KEY `ndx_task_id` (`stock_storage_task_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=460909 DEFAULT CHARSET=utf8 COMMENT='入库单'
---
DDL for table: in_bound_order_detail
CREATE TABLE `in_bound_order_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) unsigned NOT NULL COMMENT '仓库号',
  `in_bound_order_id` bigint(20) unsigned NOT NULL COMMENT '入库单id',
  `stock_num` int(10) unsigned NOT NULL COMMENT '入库数量',
  `cost_batch_id` bigint(20) unsigned DEFAULT '0' COMMENT '成本批次id',
  `produce_at` bigint(20) unsigned DEFAULT '0' COMMENT '生产日期',
  `shelf_life` bigint(20) unsigned DEFAULT '0' COMMENT '保质期',
  `sku` varchar(128) NOT NULL COMMENT 'sku',
  `pd_name` varchar(128) DEFAULT '' COMMENT '商品名称',
  `specification` varchar(128) DEFAULT '' COMMENT '规格',
  `packaging` varchar(128) DEFAULT '' COMMENT '包装',
  `temperature` tinyint(4) DEFAULT NULL COMMENT '温区',
  `supplier` varchar(128) DEFAULT '' COMMENT '供应商',
  `purchase_no` varchar(128) DEFAULT '' COMMENT '采购单号',
  `category` tinyint(4) DEFAULT NULL COMMENT '类目类型',
  `remark` varchar(256) DEFAULT '' COMMENT '备注',
  `cargo_inspection` tinyint(4) DEFAULT NULL COMMENT '是否需要货检',
  `quality_time_type` tinyint(4) DEFAULT NULL COMMENT '保质期时长类型, 0 固定时长, 1 到期时间',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id(saas品牌方)',
  `cargo_owner` varchar(32) DEFAULT NULL COMMENT '货主',
  PRIMARY KEY (`id`),
  KEY `ndx_order_id` (`in_bound_order_id`,`sku`,`purchase_no`),
  KEY `ndx_supplier_pd_name` (`pd_name`,`supplier`,`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=463337 DEFAULT CHARSET=utf8 COMMENT='入库单详情'
---
DDL for table: interest_rate_config
CREATE TABLE `interest_rate_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `area_no` int(11) DEFAULT NULL COMMENT '城市',
  `interest_rate` decimal(10,4) DEFAULT NULL COMMENT '毛利率',
  `auto_flag` int(11) DEFAULT '0' COMMENT '自动调整标识：0、否 1、是',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_admin_name` varchar(255) DEFAULT NULL COMMENT '创建人员',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_area_sku` (`area_no`,`sku`),
  KEY `idx_sku` (`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25371 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='利率配置'
---
DDL for table: interest_rate_record
CREATE TABLE `interest_rate_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `interest_rate_old` decimal(10,4) DEFAULT NULL COMMENT '原毛利率',
  `interest_rate_new` decimal(10,4) DEFAULT NULL COMMENT '新毛利率',
  `auto_flag_old` int(11) DEFAULT NULL COMMENT '原自动调价标识',
  `auto_flag_new` int(11) DEFAULT NULL COMMENT '新自动调价标识',
  `status` int(11) DEFAULT '0' COMMENT '状态：0、待审批 1、审批通过 2、审批拒绝',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_admin_name` varchar(255) DEFAULT NULL COMMENT '创建人员',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `interest_rate_record_area_index` (`area_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=500 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='毛利率修改记录'
---
DDL for table: inventory
CREATE TABLE `inventory` (
  `inv_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) NOT NULL COMMENT '产品编号',
  `store_quantity` int(10) DEFAULT '0' COMMENT '仓库(实际)库存',
  `limited_quantity` int(10) DEFAULT '-1' COMMENT '限制购买数量',
  `ait_id` int(10) DEFAULT NULL COMMENT '属性ID',
  `pd_id` bigint(30) DEFAULT NULL,
  `origin` varchar(100) DEFAULT NULL COMMENT '产地',
  `unit` varchar(5) DEFAULT NULL COMMENT '单位',
  `maturity` varchar(36) DEFAULT NULL COMMENT '生熟度',
  `pack` varchar(20) DEFAULT NULL COMMENT '包数',
  `weight` varchar(100) DEFAULT NULL COMMENT '重量',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `storage_method` varchar(100) DEFAULT NULL COMMENT '贮存方式(作废)',
  `slogan` varchar(200) DEFAULT NULL COMMENT '广告语',
  `sale_count` int(12) DEFAULT '0' COMMENT '销售量',
  `sales_mode` int(2) DEFAULT '0' COMMENT '销售模式；0普通，1团购，2日限购，3永久限购，4新手限购，5订单限购，6定单价函数限购',
  `alert_inventory` int(2) DEFAULT NULL COMMENT '警戒库存',
  `safe_inventory` int(5) DEFAULT NULL COMMENT '安全库存',
  `sale_price` decimal(10,2) DEFAULT NULL COMMENT '销售价',
  `promotion_price` decimal(10,2) DEFAULT NULL COMMENT '促销价',
  `introduction` text COMMENT '商品介绍',
  `after_sale_quantity` int(8) DEFAULT '0' COMMENT '售后最大数量',
  `outdated` int(11) DEFAULT '0' COMMENT 'SKU生命周期：-1、上新处理中 0、使用中 1、已删除',
  `base_sale_quantity` int(10) unsigned DEFAULT '1' COMMENT '最小起售量',
  `base_sale_unit` int(10) unsigned DEFAULT '1' COMMENT '售卖规格',
  `volume` varchar(255) DEFAULT NULL COMMENT '体积(长*宽*高)',
  `weight_num` decimal(10,2) DEFAULT NULL COMMENT '重量kg',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 自营 1 代仓',
  `admin_id` int(11) DEFAULT NULL COMMENT '所属大客户ID',
  `sample_pool` int(11) DEFAULT '0' COMMENT ' 0 不加入 1加入',
  `sku_pic` varchar(50) DEFAULT NULL COMMENT 'sku图',
  `after_sale_unit` varchar(5) DEFAULT NULL COMMENT '售后单位',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `audit_status` int(11) DEFAULT '1' COMMENT '上新审核状态：0、待上新 1、上新成功 2、上新失败',
  `audit_time` datetime DEFAULT NULL COMMENT '上新审核时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `ext_type` int(11) DEFAULT NULL COMMENT 'sku性质：0、常规 2、临保 3、拆包 4、不卖 5、破袋',
  `create_remark` varchar(1000) DEFAULT NULL,
  `task_type` int(11) DEFAULT '1' COMMENT '任务类型：0、SPU 1、SKU',
  `create_type` int(11) NOT NULL DEFAULT '0' COMMENT '上新类型：0、平台 1、大客户 2、saas自营&代仓 3、仅saas自营',
  `auditor` int(11) DEFAULT NULL COMMENT '操作人adminId',
  `weight_notes` varchar(255) DEFAULT NULL COMMENT '规格备注',
  `is_domestic` tinyint(4) DEFAULT '1' COMMENT '是否为国产，0：不是，1是',
  `supplier_visible` tinyint(4) DEFAULT '0' COMMENT '供应商是否可见：0不可见，1可见',
  `average_price_flag` tinyint(4) DEFAULT '0' COMMENT '0 不展示平均价  1 展示平均价',
  `sku_name` varchar(60) DEFAULT NULL COMMENT 'sku名称',
  `refuse_reason` varchar(255) DEFAULT NULL COMMENT '拒绝原因',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID',
  `sub_type` tinyint(4) DEFAULT NULL COMMENT '商品二级性质，1 自营-代销不入仓、2 自营-代销入仓、3 自营-经销、4 代仓-代仓',
  PRIMARY KEY (`inv_id`) USING BTREE,
  KEY `FK_attr_item_ait_id` (`ait_id`) USING BTREE,
  KEY `IN_sku` (`sku`,`outdated`) USING BTREE,
  KEY `FK_product_pd_id` (`pd_id`,`outdated`) USING BTREE,
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_tenant` (`tenant_id`),
  CONSTRAINT `FK_attr_item_ait_id` FOREIGN KEY (`ait_id`) REFERENCES `attr_item` (`ait_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_product_pd_id` FOREIGN KEY (`pd_id`) REFERENCES `products` (`pd_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23000 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品SKU表'
---
DDL for table: inventory_bind
CREATE TABLE `inventory_bind` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `pd_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'spuid(products.pd_id)',
  `sku` varchar(30) NOT NULL DEFAULT '' COMMENT '商品编号',
  `bind_sku` varchar(30) NOT NULL DEFAULT '' COMMENT '绑定sku编号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE,
  KEY `idx_bind_sku` (`bind_sku`) USING BTREE,
  KEY `idx_pd_id` (`pd_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='sku绑定关系表'
---
DDL for table: inventory_lock_detail
CREATE TABLE `inventory_lock_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `warehouse_no` bigint(20) NOT NULL COMMENT '库存仓编号',
  `warehouse_tenant_id` bigint(20) DEFAULT NULL COMMENT '仓库租户id(saas品牌方)，鲜沐为1',
  `sku_code` varchar(30) NOT NULL COMMENT 'sku编码',
  `order_no` varchar(64) NOT NULL COMMENT '业务单号',
  `order_type_name` varchar(20) NOT NULL COMMENT '库存变动类型',
  `lock_quantity` int(11) NOT NULL COMMENT '锁库数量',
  `remain_quantity` int(11) NOT NULL COMMENT '剩余数量',
  `release_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '释放数量',
  `reduce_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '扣减数量',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `sync` int(11) DEFAULT NULL COMMENT '库存同步状态，1：同步，0：不同步',
  PRIMARY KEY (`id`),
  KEY `idx_tid` (`tenant_id`),
  KEY `idx_ono` (`order_no`),
  KEY `idx_wno_sku` (`warehouse_no`,`sku_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11919 DEFAULT CHARSET=utf8mb4 COMMENT='库存锁定明细表'
---
DDL for table: inventory_order_road_sale
CREATE TABLE `inventory_order_road_sale` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku编码',
  `out_order_no` varchar(36) NOT NULL DEFAULT '' COMMENT '单号',
  `out_order_type` int(11) NOT NULL COMMENT '单据类型',
  `arrange_quantity` int(10) unsigned NOT NULL COMMENT '预约数量',
  `road_sale_rate` decimal(10,2) NOT NULL COMMENT '在途可售比例',
  `reject_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '拒收数量',
  `road_sale_quantity` int(10) unsigned NOT NULL COMMENT '在途可售库存',
  `in_store_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已入库数量',
  `remaining_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '剩余在途可售库存',
  `status` int(11) NOT NULL COMMENT '在途可售状态，0：取消，1：正常，2：清零',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `operator` varchar(30) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_sku` (`warehouse_no`,`sku`),
  KEY `idx_out_order_no` (`out_order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=433 DEFAULT CHARSET=utf8 COMMENT='单据在途可售库存表'
---
DDL for table: inventory_order_road_sale_change_record
CREATE TABLE `inventory_order_road_sale_change_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku编码',
  `out_order_no` varchar(36) NOT NULL DEFAULT '' COMMENT '单号',
  `new_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '新在途可售库存',
  `old_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '原在途可售库存',
  `new_remaining_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '新剩余在途可售库存',
  `old_remaining_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '原剩余在途可售库存',
  `new_in_store_quantity` int(10) unsigned NOT NULL COMMENT '新已入库数量',
  `old_in_store_quantity` int(10) unsigned NOT NULL COMMENT '原已入库数量',
  `record_type` int(11) NOT NULL COMMENT '库存变动类型',
  `record_type_desc` varchar(20) NOT NULL COMMENT '库存变动类型描述',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `operator` varchar(30) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_sku_create_time` (`warehouse_no`,`sku`,`create_time`),
  KEY `idx_out_order_no` (`out_order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=927 DEFAULT CHARSET=utf8 COMMENT='单据在途可售变更记录表'
---
DDL for table: inventory_order_sku_share_transfer
CREATE TABLE `inventory_order_sku_share_transfer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `transfer_out_sku` varchar(30) NOT NULL COMMENT '转出sku编码',
  `transfer_in_sku` varchar(30) NOT NULL COMMENT '转入sku编码',
  `share_total_quantity` int(10) unsigned NOT NULL COMMENT '共享的总数量',
  `share_rate` varchar(50) NOT NULL COMMENT '转入sku的共享比例，形如1:2',
  `transfer_rate` varchar(10) NOT NULL COMMENT 'sku转换比例，形如1:2',
  `out_order_no` varchar(36) NOT NULL DEFAULT '' COMMENT '单号',
  `out_order_type` int(11) NOT NULL COMMENT '单据类型',
  `should_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '应转出数量',
  `actual_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '已转出数量',
  `remaining_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '待转出数量',
  `should_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '应转入数量',
  `actual_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '已转入数量',
  `remaining_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '待转入数量',
  `status` int(11) NOT NULL COMMENT '状态，0：取消，1：正常，2：清零',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `operator` varchar(30) DEFAULT NULL COMMENT '操作人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_out_order_no` (`out_order_no`),
  KEY `idx_warehouse_transfer_out_in_sku` (`warehouse_no`,`transfer_out_sku`,`transfer_in_sku`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8 COMMENT='单据规格共享转换表'
---
DDL for table: inventory_order_sku_share_transfer_change_record
CREATE TABLE `inventory_order_sku_share_transfer_change_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `transfer_out_sku` varchar(30) NOT NULL COMMENT '转出sku编码',
  `transfer_in_sku` varchar(30) NOT NULL COMMENT '转入sku编码',
  `out_order_no` varchar(36) NOT NULL DEFAULT '' COMMENT '单号',
  `new_should_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '新应转出数量',
  `old_should_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '原应转出数量',
  `new_actual_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '新已转出数量',
  `old_actual_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '原已转出数量',
  `new_remaining_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '新待转出数量',
  `old_remaining_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '原待转出数量',
  `new_should_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '新应转入数量',
  `old_should_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '原应转入数量',
  `new_actual_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '新已转入数量',
  `old_actual_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '原已转入数量',
  `new_remaining_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '新待转入数量',
  `old_remaining_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '原待转入数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `operator` varchar(30) DEFAULT NULL COMMENT '操作人',
  `record_type` int(11) NOT NULL COMMENT '库存变动类型',
  `record_type_desc` varchar(20) NOT NULL DEFAULT '' COMMENT '库存变动类型描述',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_transfer_out_in_sku` (`warehouse_no`,`transfer_out_sku`,`transfer_in_sku`),
  KEY `idx_out_order_no` (`out_order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=566 DEFAULT CHARSET=utf8 COMMENT='单据规格共享转换变更记录表'
---
DDL for table: inventory_record
CREATE TABLE `inventory_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) NOT NULL,
  `change_field` varchar(20) NOT NULL COMMENT '变化字段',
  `old_value` varchar(30) DEFAULT NULL COMMENT '变化前的值',
  `new_value` varchar(30) DEFAULT NULL COMMENT '变化后的值',
  `recorder` varchar(20) DEFAULT NULL COMMENT '记录人',
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_change_field` (`change_field`) USING BTREE,
  KEY `index_sku` (`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='sku信息变化记录'
---
DDL for table: inventory_road_sale
CREATE TABLE `inventory_road_sale` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL DEFAULT '' COMMENT 'sku编码',
  `road_sale_quantity` int(10) unsigned NOT NULL COMMENT '在途可售库存',
  `remaining_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '剩余在途可售库存',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `operator` varchar(30) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_warehouse_sku` (`warehouse_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='在途可售库存表'
---
DDL for table: inventory_road_sale_change_record
CREATE TABLE `inventory_road_sale_change_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku编码',
  `out_order_no` varchar(36) DEFAULT NULL COMMENT '单号',
  `new_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '新在途可售库存',
  `old_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '原在途可售库存',
  `new_remaining_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '新剩余在途可售库存',
  `old_remaining_road_sale_quantity` int(10) unsigned NOT NULL COMMENT '原剩余在途可售库存',
  `record_type` int(11) NOT NULL COMMENT '库存变动类型',
  `record_type_desc` varchar(20) NOT NULL DEFAULT '' COMMENT '库存变动类型描述',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `operator` varchar(30) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_sku_create_time` (`warehouse_no`,`sku`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=902 DEFAULT CHARSET=utf8 COMMENT='在途可售库存变更记录表'
---
DDL for table: inventory_sku_share_transfer
CREATE TABLE `inventory_sku_share_transfer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku编码',
  `remaining_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '待转出数量',
  `remaining_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '待转入数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `operator` varchar(30) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_warehouse_sku` (`warehouse_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='规格共享转换表'
---
DDL for table: inventory_sku_share_transfer_change_record
CREATE TABLE `inventory_sku_share_transfer_change_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku编码',
  `out_order_no` varchar(36) DEFAULT NULL COMMENT '单号',
  `new_remaining_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '新待转出数量',
  `old_remaining_transfer_out_quantity` int(10) unsigned NOT NULL COMMENT '原待转出数量',
  `new_remaining_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '新待转入数量',
  `old_remaining_transfer_in_quantity` int(10) unsigned NOT NULL COMMENT '原待转入数量',
  `record_type` int(11) NOT NULL COMMENT '库存变动类型',
  `record_type_desc` varchar(20) NOT NULL DEFAULT '' COMMENT '库存变动类型描述',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `operator` varchar(30) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_sku_create_time` (`warehouse_no`,`sku`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=990 DEFAULT CHARSET=utf8 COMMENT='规格共享转换变更记录表'
---
DDL for table: inventory_transaction_request
CREATE TABLE `inventory_transaction_request` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `warehouse_no` bigint(20) NOT NULL COMMENT '库存仓编号',
  `warehouse_tenant_id` bigint(20) DEFAULT NULL COMMENT '仓库租户id(saas品牌方)，鲜沐为1',
  `sku_code` varchar(30) NOT NULL COMMENT 'sku编码',
  `operation_quantity` int(11) NOT NULL COMMENT '操作数量',
  `operation_type` tinyint(4) NOT NULL COMMENT '操作类别，1冻结，2释放冻结，3扣减',
  `order_no` varchar(64) NOT NULL COMMENT '业务单号',
  `order_type_name` varchar(20) NOT NULL COMMENT '库存变动类型',
  `operation_no` varchar(64) DEFAULT NULL COMMENT '操作单号',
  `idempotent_no` varchar(128) DEFAULT NULL COMMENT '，幂等单号',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  PRIMARY KEY (`id`),
  KEY `idx_tid` (`tenant_id`),
  KEY `idx_ono` (`order_no`),
  KEY `idx_wno_sku` (`warehouse_no`,`sku_code`)
) ENGINE=InnoDB AUTO_INCREMENT=18549 DEFAULT CHARSET=utf8mb4 COMMENT='库存事务请求表'
---
DDL for table: invitecode
CREATE TABLE `invitecode` (
  `invite_id` int(11) NOT NULL AUTO_INCREMENT,
  `invitecode` varchar(6) DEFAULT NULL COMMENT '6位邀请码',
  `admin_id` int(11) DEFAULT NULL COMMENT '地推人员',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(2) DEFAULT '0' COMMENT '是否可用',
  PRIMARY KEY (`invite_id`) USING BTREE,
  UNIQUE KEY `IN_code` (`invitecode`) USING BTREE,
  KEY `FK_admin` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1073 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='地推码'
---
DDL for table: invoice_config
CREATE TABLE `invoice_config` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `merchant_id` bigint(11) DEFAULT NULL COMMENT '取自merchant表中m_id，表示单店自由的抬头配置',
  `admin_id` int(30) DEFAULT NULL COMMENT '取自admin表中为大客户的id, 表示所属的大客户',
  `type` tinyint(4) NOT NULL COMMENT '0:门店自有抬头；1:大客户门店下的抬头',
  `invoice_title` varchar(50) NOT NULL COMMENT '发票抬头',
  `tax_number` varchar(50) DEFAULT NULL COMMENT '税号',
  `open_account` varchar(50) DEFAULT NULL COMMENT '开户账号',
  `open_bank` varchar(200) DEFAULT NULL COMMENT '开户银行',
  `company_address` varchar(200) DEFAULT NULL COMMENT '公司地址',
  `company_phone` varchar(50) DEFAULT NULL COMMENT '公司电话',
  `mail_address` varchar(50) DEFAULT NULL COMMENT '邮寄地址',
  `company_receiver` varchar(50) DEFAULT NULL COMMENT '收件人',
  `company_email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `valid_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:生效中（默认), 1:(失效)',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建抬头提交时间',
  `link_method` varchar(200) DEFAULT NULL COMMENT '联系方式',
  `business_license_address` varchar(100) DEFAULT NULL COMMENT '营业执照地址',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `default_flag` tinyint(4) DEFAULT '1' COMMENT '默认标记0:是;1:否',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `in_admin_title_tax` (`admin_id`,`invoice_title`,`tax_number`) USING BTREE,
  KEY `idx_mid` (`merchant_id`,`type`,`valid_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12753 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='大客户抬头配置和普通门店客户抬头配置'
---
DDL for table: invoice_merchant_relation
CREATE TABLE `invoice_merchant_relation` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `invoice_id` bigint(30) NOT NULL COMMENT '取自invoice_config表内',
  `merchant_id` bigint(11) NOT NULL COMMENT '取自merchant表中m_id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建关联关系提交时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT '0' COMMENT '状态 0 存在 1 作废',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_invoice_id` (`invoice_id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4599 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='大客户对应的抬头与门店的链接关系'
---
DDL for table: jmeter_scripts
CREATE TABLE `jmeter_scripts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `script_name` varchar(255) NOT NULL COMMENT '脚本名称',
  `path` varchar(255) NOT NULL COMMENT '脚本路径',
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4
---
DDL for table: ladder_price
CREATE TABLE `ladder_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timing_rule_id` int(11) DEFAULT NULL,
  `ladder` int(11) DEFAULT NULL COMMENT '团购数量阶梯',
  `price` decimal(12,2) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `discount_delivery_times` int(3) DEFAULT NULL COMMENT '优惠配送次数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_lp_id_idx` (`timing_rule_id`) USING BTREE,
  CONSTRAINT `fk_lp_id_idx` FOREIGN KEY (`timing_rule_id`) REFERENCES `timing_rule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=887 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='阶梯定价表'
---
DDL for table: land_page
CREATE TABLE `land_page` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `land_page_name` varchar(50) CHARACTER SET utf8mb4 NOT NULL COMMENT '落地页名称',
  `backgroud_pic_path` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '底图路径',
  `creator_id` int(11) NOT NULL COMMENT '创建人id取自admin表',
  `outdated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记位 1代表过时，表示逻辑删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `bg_color` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '落地页底色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='落地页主表,存放落地页相关信息'
---
DDL for table: land_page_item
CREATE TABLE `land_page_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `type` int(11) NOT NULL DEFAULT '-1' COMMENT '默认 -1：不明确类型,类型：0：图片类型，1：商品类型， 2：table类型; 3:table子项；4: 配方类型；5:配方子项；6临保类型;7预售类型',
  `template_name` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '模板名称；前端自定义',
  `auto_sort` int(11) DEFAULT NULL COMMENT '0: 人工排序， 1：自动排序',
  `formula_pic_path` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '配方图片路径',
  `tab_color` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'table模板颜色',
  `tab_typeface` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'table字体颜色',
  `tab_floor` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'table楼层字体颜色',
  `tab_name` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'table子项的名称',
  `outdated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记位 1代表过时，表示逻辑删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `formula_name` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '配方子项名称',
  `receive_type` int(11) DEFAULT NULL COMMENT '领取形式',
  `effect_type` int(11) DEFAULT NULL COMMENT '动画效果',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2046 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='存放落地页内的各个模块的相关属性'
---
DDL for table: land_page_node
CREATE TABLE `land_page_node` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `node_type` int(11) NOT NULL DEFAULT '-1' COMMENT '默认 -1：不明确的类型，0：sku类型，1：组合包类型，2：图片类型',
  `sku` varchar(30) DEFAULT NULL COMMENT '取自inventory表内的sku',
  `suit_id` int(11) DEFAULT NULL COMMENT '取自suit表内的id',
  `pic_path` varchar(500) DEFAULT NULL COMMENT '图片存放路径',
  `land_page_id` bigint(20) DEFAULT NULL COMMENT '需要跳转的落地页id',
  `item_parent_id` bigint(20) NOT NULL COMMENT '取自 land_page_item的id,是该记录的父级id',
  `sort` int(11) DEFAULT NULL COMMENT '子id在父id下的排序位置为相对位置',
  `outdated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记位 1代表过时，表示逻辑删除',
  `jump_type` tinyint(1) DEFAULT NULL COMMENT '跳转类型',
  `jump_name` varchar(255) DEFAULT NULL COMMENT '跳转名称',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `coupon_id` int(11) DEFAULT NULL COMMENT '优惠券id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `indx_sku` (`sku`) USING BTREE,
  KEY `indx_suit_id` (`suit_id`) USING BTREE,
  KEY `idx_itemparentid_nodetype_sku_sort` (`item_parent_id`,`node_type`,`sku`,`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=2117 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='与 land_page_item某条记录下的下一级具体的信息'
---
DDL for table: land_page_relation
CREATE TABLE `land_page_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `land_page_id` bigint(20) DEFAULT NULL COMMENT '取自land_page的id(用作父id)',
  `item_id` bigint(20) DEFAULT NULL COMMENT '取自land_page_item的id(父id)',
  `item_son_id` bigint(20) NOT NULL COMMENT '取自land_page_item的id(子id)',
  `sort` int(11) DEFAULT NULL COMMENT '子id在父id下的排序位置为相对位置',
  `outdated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记位 1代表过时，表示逻辑删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2046 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='存放了落地页组件之间的关联关系和子组件在父组件中的相对排序位置'
---
DDL for table: large_area
CREATE TABLE `large_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `large_area_no` int(11) DEFAULT NULL COMMENT '运营大区编号',
  `large_area_name` varchar(50) DEFAULT NULL COMMENT '名称',
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '开放状态',
  `manage_admin_id` int(11) DEFAULT NULL COMMENT '负责人id',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '运营大区负责人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_large_area_no` (`large_area_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='运营大区'
---
DDL for table: lucky_draw
CREATE TABLE `lucky_draw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_name` varchar(45) DEFAULT NULL COMMENT '抽奖名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `free_chance` int(11) DEFAULT NULL COMMENT '免费次数',
  `free_type` int(11) DEFAULT NULL COMMENT '免费类型，0 一次免费，1 每天给免费',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='抽奖活动'
---
DDL for table: lucky_draw_activity
CREATE TABLE `lucky_draw_activity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(255) NOT NULL COMMENT '活动名称',
  `start_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `preheat_time` datetime DEFAULT NULL COMMENT '预热时间',
  `rule` varchar(50) DEFAULT NULL COMMENT '规则说明-落地页ID',
  `type` tinyint(4) DEFAULT NULL COMMENT '活动类型  红包雨-1  每日抽奖-2',
  `buoy_image` varchar(255) DEFAULT NULL COMMENT '浮标图',
  `preheat_background` varchar(255) DEFAULT NULL COMMENT '预热背景图',
  `end_background` varchar(255) DEFAULT NULL COMMENT '结束背景图',
  `no_draw_background` varchar(255) DEFAULT NULL COMMENT '未抽奖背景图',
  `draw_background` varchar(255) DEFAULT NULL COMMENT '抽奖背景图',
  `shard_image` varchar(255) DEFAULT NULL COMMENT '分享图',
  `shard_title` varchar(150) DEFAULT NULL COMMENT '分享标题',
  `shard_remake` varchar(255) DEFAULT NULL COMMENT '分享描述',
  `status` tinyint(4) DEFAULT '0' COMMENT '是否失效 0-否  1-是',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `time_index` (`preheat_time`,`end_time`) COMMENT '时间联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COMMENT='红包雨/每日抽奖活动'
---
DDL for table: lucky_draw_activity_equity_package
CREATE TABLE `lucky_draw_activity_equity_package` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `activity_id` bigint(20) DEFAULT NULL COMMENT '抽奖活动ID',
  `name` varchar(255) DEFAULT NULL COMMENT '奖项名称',
  `probability` decimal(12,4) DEFAULT NULL COMMENT '中奖概率',
  `quantity` int(11) DEFAULT NULL COMMENT '奖项数量',
  `surplus_quantity` int(10) unsigned DEFAULT NULL COMMENT '剩余数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `send_quantity` int(11) DEFAULT '0' COMMENT '发放数量',
  PRIMARY KEY (`id`),
  KEY `activity_id_index` (`activity_id`) COMMENT '抽奖活动ID'
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动关联权益包'
---
DDL for table: lucky_draw_activity_prize
CREATE TABLE `lucky_draw_activity_prize` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `activity_id` bigint(20) DEFAULT NULL COMMENT '抽奖活动ID',
  `equity_package_id` bigint(20) DEFAULT NULL COMMENT '抽奖活动权益包ID',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '卡劵ID-奖品',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `activity_index` (`activity_id`) COMMENT '抽奖活动',
  KEY `equity_coupon_index` (`equity_package_id`,`coupon_id`) COMMENT '奖项权益包、卡劵联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=1268 DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动权益包的具体奖品'
---
DDL for table: lucky_draw_activity_record
CREATE TABLE `lucky_draw_activity_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `m_id` bigint(20) NOT NULL COMMENT '客户ID',
  `activity_id` bigint(20) NOT NULL COMMENT '抽奖活动ID',
  `participation_time` date DEFAULT NULL COMMENT '参与时间-针对每日参与一次',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `m_id_and_activity_id_index` (`m_id`,`activity_id`,`participation_time`)
) ENGINE=InnoDB AUTO_INCREMENT=751 DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动参与记录'
---
DDL for table: lucky_draw_chance
CREATE TABLE `lucky_draw_chance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lucky_draw_id` int(11) DEFAULT NULL,
  `m_id` bigint(30) DEFAULT NULL,
  `chance` int(11) unsigned DEFAULT '0' COMMENT '剩余抽奖次数',
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: lucky_draw_prize
CREATE TABLE `lucky_draw_prize` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prize_name` varchar(45) DEFAULT NULL COMMENT '奖项名称',
  `source_id` int(11) DEFAULT NULL COMMENT '奖项来源id，例如优惠券id ，卡券id',
  `prize_type` int(11) DEFAULT NULL COMMENT '奖项类型，0优惠券 1卡 ',
  `level` int(11) DEFAULT NULL COMMENT '奖品等级',
  `lucky_draw_id` int(11) DEFAULT NULL COMMENT '抽奖活动id',
  `score` int(11) DEFAULT NULL COMMENT '中奖阈值（概率）,',
  `upperlimit` int(11) DEFAULT '0' COMMENT '单日中奖次数上限',
  `repeat_get` tinyint(1) DEFAULT '1' COMMENT '能否重复发放,0不能，1能',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='抽奖奖项'
---
DDL for table: lucky_draw_prize_record
CREATE TABLE `lucky_draw_prize_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `activity_id` bigint(20) DEFAULT NULL COMMENT '抽奖活动ID',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '卡劵ID',
  `merchant_coupon_id` bigint(20) DEFAULT NULL COMMENT '客户卡劵ID',
  `m_id` bigint(20) DEFAULT NULL COMMENT '客户ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `m_id_and_activity_index` (`m_id`,`activity_id`) COMMENT '客户、抽奖活动ID联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=1160 DEFAULT CHARSET=utf8mb4 COMMENT='奖品关联客户记录'
---
DDL for table: lucky_draw_win
CREATE TABLE `lucky_draw_win` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prize_id` int(11) DEFAULT NULL COMMENT 'lucky_darw_prize id ,奖项id ',
  `prize_name` varchar(45) DEFAULT NULL,
  `m_id` bigint(30) DEFAULT NULL,
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `lucky_draw_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2559 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: major_category
CREATE TABLE `major_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `type` int(11) DEFAULT '1' COMMENT '是否展示 0 展示 1 不展示',
  `status` int(11) DEFAULT NULL COMMENT '是否删除 0 删除 1 未删除',
  `category_id` int(11) DEFAULT NULL COMMENT '类目id',
  `direct` int(11) DEFAULT NULL COMMENT '1 先结 2 账期',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `admin_id` int(11) DEFAULT NULL COMMENT '大客户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_area_category_direct_status` (`admin_id`,`area_no`,`category_id`,`direct`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2640 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='大客户类目展示表'
---
DDL for table: major_price
CREATE TABLE `major_price` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(20) DEFAULT NULL,
  `pd_name` varchar(50) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `area_name` varchar(30) DEFAULT NULL,
  `direct` int(2) DEFAULT NULL,
  `pay_method` tinyint(4) DEFAULT NULL COMMENT '当为代仓商品时的支付方式：0：无需支付 1：下单时支付',
  `valid_time` datetime DEFAULT NULL COMMENT '报价单生效时间',
  `invalid_time` datetime DEFAULT NULL COMMENT '报价单失效时间',
  `mall_show` int(11) DEFAULT '0' COMMENT '用户是否展示',
  `price_type` tinyint(4) DEFAULT NULL COMMENT '价格类型：0代表商城价 1合同价（指定价）2 合同价（毛利率）',
  `cost` decimal(13,2) DEFAULT NULL COMMENT '毛利率的成本价',
  `interest_rate` decimal(11,2) DEFAULT NULL COMMENT '毛利率',
  `fixed_price` decimal(13,2) DEFAULT NULL COMMENT '毛利率的固定价',
  `original_price` decimal(13,2) DEFAULT NULL COMMENT '原售价',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uq_major_price` (`admin_id`,`direct`,`area_no`) USING BTREE,
  KEY `sku_index` (`sku`,`admin_id`,`area_no`,`direct`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22782 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: major_price_adjustment_record
CREATE TABLE `major_price_adjustment_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `admin_id` int(11) DEFAULT NULL COMMENT '客户id',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `sku` varchar(33) DEFAULT NULL COMMENT 'sku',
  `status` int(11) DEFAULT NULL COMMENT '状态：0、失败 1、成功',
  `interest_rate` varchar(10) DEFAULT NULL COMMENT '毛利率',
  `fixed_price` decimal(11,2) DEFAULT NULL COMMENT '毛利率的固定价',
  `original_cost_price` decimal(10,4) DEFAULT NULL COMMENT '原采购价',
  `cost_price` decimal(10,4) DEFAULT NULL COMMENT '新采购价',
  `original_market_price` decimal(10,4) DEFAULT NULL COMMENT '原售价',
  `market_price` decimal(10,4) DEFAULT NULL COMMENT '新售价',
  `major_cycle` int(2) DEFAULT NULL COMMENT '自动报价周期： 0周报价, 1半月报价, 2月报价，3日报价',
  `reason` varchar(255) DEFAULT NULL COMMENT '调价理由',
  `create_admin_name` varchar(50) DEFAULT NULL COMMENT '系统记为自动',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=904 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='报价单调价记录'
---
DDL for table: major_price_on_sale_adjustment
CREATE TABLE `major_price_on_sale_adjustment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `admin_id` int(11) DEFAULT NULL,
  `direct` int(2) DEFAULT NULL,
  `valid_time` datetime DEFAULT NULL COMMENT '报价单生效时间',
  `invalid_time` datetime DEFAULT NULL COMMENT '报价单失效时间',
  `status` int(2) DEFAULT '0' COMMENT '执行状态: 0待执行、1已执行、2已取消',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_sku` (`sku`) USING BTREE,
  KEY `index_area_no` (`area_no`) USING BTREE,
  KEY `index_admin_id` (`admin_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='报价单生效时间推送上下架表'
---
DDL for table: major_rebate
CREATE TABLE `major_rebate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1定额钱 2 定额百分比',
  `number` double DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL,
  `area_name` varchar(20) DEFAULT NULL,
  `cate` int(11) DEFAULT NULL COMMENT '1 是类目 2代表是sku',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1存在 2删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_area` (`admin_id`,`area_no`) USING BTREE COMMENT '常用索引'
) ENGINE=InnoDB AUTO_INCREMENT=4266 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: market_coupon_send
CREATE TABLE `market_coupon_send` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `coupon_id` bigint(20) NOT NULL COMMENT '优惠券id',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0：审核中 1：审核通过 2：审核失败',
  `sender_name` varchar(255) NOT NULL COMMENT '发送人',
  `audit_name` varchar(255) DEFAULT NULL COMMENT '审核人',
  `reason` varchar(255) DEFAULT NULL COMMENT '发放理由',
  `send_msg_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否发生短信 0：不发送 1：发送',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `send_type` tinyint(4) DEFAULT '0' COMMENT '发放类型 0-立即发放  1-定时发放',
  `release_time` datetime DEFAULT NULL COMMENT '定时发放时间',
  `actual_release_time` datetime DEFAULT NULL COMMENT '实际发放时间',
  `send_client` tinyint(4) DEFAULT '0' COMMENT '发放客户 0-手动  1-圈人',
  `cash_customer` tinyint(4) DEFAULT '1' COMMENT '客户过滤：现结大客户 0-否  1-是',
  `account_customer` tinyint(4) DEFAULT '1' COMMENT '客户过滤：账期大客户  0-否 1-是',
  `send_status` tinyint(4) DEFAULT NULL COMMENT '发放状态  0-未发放 1-部分发放 2-已发放  3-已取消  4-已撤回',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_coupon_id_status` (`coupon_id`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32153 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='优惠券发放记录'
---
DDL for table: market_coupon_send_detail
CREATE TABLE `market_coupon_send_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `send_id` bigint(20) NOT NULL COMMENT '优惠券发放记录id',
  `m_id` bigint(20) NOT NULL COMMENT '商户id',
  `merchant_name` varchar(255) NOT NULL COMMENT '商户名称',
  `phone` varchar(50) NOT NULL COMMENT '发放手机号',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态 0：未发放 1：已发放 2：已撤回 3: 发放失败',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_send_id_status_m_id` (`send_id`,`status`,`m_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`),
  KEY `idx_send_id_m_id` (`m_id`,`send_id`)
) ENGINE=InnoDB AUTO_INCREMENT=209646 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='优惠券发放明细表'
---
DDL for table: market_coupon_send_scope
CREATE TABLE `market_coupon_send_scope` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `send_id` bigint(20) NOT NULL COMMENT '优惠券发放记录ID',
  `scope_id` bigint(20) NOT NULL COMMENT '范围ID',
  `scope_type` tinyint(4) NOT NULL COMMENT '发放客户范围类型，1 人群包，2 运营城市，3 运营大区',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `union_index` (`send_id`,`scope_type`) COMMENT '发放ID和发放范围联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=314 DEFAULT CHARSET=utf8mb4 COMMENT='优惠券发放记录-发放客户范围（圈人2.0）'
---
DDL for table: market_partnership_buy
CREATE TABLE `market_partnership_buy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `config_id` bigint(20) NOT NULL COMMENT '拼团配置id(market_partnership_buy_config.id)',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '拼团状态 0-创建中 1-待成团(已支付) 2-已成团 2-成团失败',
  `start_time` datetime NOT NULL COMMENT '拼团开始时间',
  `end_time` datetime NOT NULL COMMENT '拼团结束时间',
  `group_buy_time` datetime DEFAULT NULL COMMENT '成团时间',
  `sku` varchar(30) NOT NULL COMMENT '商品编号',
  `min_sale_num` int(11) NOT NULL COMMENT '起购量',
  `partnership_buy_sku_id` bigint(20) NOT NULL COMMENT '拼团商品id(market_partnership_buy_sku.id)',
  `auto_group_buy` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否自动成团 0-否 1-是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `join_num` int(11) NOT NULL COMMENT '拼团成功需要的人数',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_start_time_end_time_status` (`start_time`,`end_time`,`status`) USING BTREE,
  KEY `idx_config_id` (`config_id`),
  KEY `idx_sku` (`sku`),
  KEY `idx_partnership_buy_sku_id` (`partnership_buy_sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='营销-多人拼团场次表'
---
DDL for table: market_partnership_buy_config
CREATE TABLE `market_partnership_buy_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `partnership_buy_name` varchar(32) NOT NULL COMMENT '拼团活动名称',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '团购活动状态 0-待生效 1-已生效 2-已失效',
  `start_time` datetime NOT NULL COMMENT '拼团活动开始时间',
  `end_time` datetime NOT NULL COMMENT '拼团活动结束时间',
  `actual_end_time` datetime DEFAULT NULL COMMENT '拼团活动实际结束时间',
  `join_num` int(11) NOT NULL COMMENT '拼团人数',
  `valid_time` int(11) NOT NULL COMMENT '拼团有效期(分钟数)',
  `simulation_group` tinyint(4) NOT NULL COMMENT '是否模拟组团 0-否 1-是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) NOT NULL COMMENT '创建人',
  `updater` int(11) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_start_time_end_time` (`start_time`,`end_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='营销-多人拼团配置表'
---
DDL for table: market_partnership_buy_order
CREATE TABLE `market_partnership_buy_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `partnership_buy_id` bigint(20) NOT NULL COMMENT '拼团id(market_partnership_buy.id)',
  `config_id` bigint(20) NOT NULL COMMENT '拼团配置id(market_partnership_buy_config.id)',
  `m_id` bigint(20) NOT NULL COMMENT '拼团成员(m_id)',
  `role_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '拼团成员类型:0-团员 1-团长',
  `order_no` varchar(36) NOT NULL COMMENT '订单编号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `partnership_buy_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已成团处理 0-否 1-是',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_m_id` (`m_id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE,
  KEY `idx_group_buy_id` (`partnership_buy_id`) USING BTREE,
  KEY `idx_config_id` (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=317 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='营销-拼团订单表'
---
DDL for table: market_partnership_buy_sku
CREATE TABLE `market_partnership_buy_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `config_id` bigint(20) NOT NULL COMMENT '拼团配置id(market_partnership_buy_config.id)',
  `sku` varchar(30) NOT NULL COMMENT '商品编号',
  `min_sale_num` int(11) NOT NULL COMMENT '起购量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-是',
  `creator` int(11) NOT NULL COMMENT '创建人',
  `updater` int(11) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE,
  KEY `idx_config_id` (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='营销-多人拼团配置商品表'
---
DDL for table: market_price_control_products
CREATE TABLE `market_price_control_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `pd_id` bigint(20) NOT NULL COMMENT '商品表-id',
  `pd_no` varchar(30) NOT NULL COMMENT '商品表-spu编号',
  `pd_name` varchar(50) NOT NULL COMMENT '商品表-商品名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_pd_id` (`pd_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='营销-控价品'
---
DDL for table: market_rule
CREATE TABLE `market_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type` int(5) DEFAULT NULL COMMENT '活动类型',
  `detail` varchar(255) DEFAULT NULL COMMENT '规则详情',
  `show_name` varchar(50) DEFAULT NULL COMMENT '商城展示名称',
  `start_time` datetime DEFAULT NULL COMMENT '规则开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '规则结束时间',
  `area_no` varchar(255) DEFAULT NULL COMMENT '营销活动开放区域',
  `category_id` varchar(255) DEFAULT NULL COMMENT '参与活动的品类',
  `sku` varchar(1000) DEFAULT NULL COMMENT '参与活动的所有sku',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `rule_detail` text,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `support_type` int(11) DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_end_time` (`end_time`) COMMENT '结束时间索引',
  KEY `idx_joint_time` (`start_time`,`end_time`) COMMENT '时间搜索联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=4352 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='营销规则表'
---
DDL for table: market_rule_detail
CREATE TABLE `market_rule_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rule_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `category_name` varchar(40) DEFAULT NULL,
  `sku` varchar(20) DEFAULT NULL,
  `pd_name` varchar(100) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind_rule_id` (`rule_id`) USING BTREE,
  KEY `ind_category_id` (`category_id`) USING BTREE,
  KEY `ind_pd_name` (`pd_name`) USING BTREE,
  KEY `ind_sku` (`sku`,`rule_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38970 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: market_rule_history
CREATE TABLE `market_rule_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `detail` longtext COMMENT '营销详情表',
  `order_no` varchar(50) NOT NULL DEFAULT '',
  `market_rule_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `rule_level` int(11) NOT NULL,
  `type` int(11) DEFAULT '0' COMMENT '0满返 1 满减',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind_order_no` (`order_no`) USING BTREE,
  KEY `idx_rule_order` (`market_rule_id`,`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14877 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: master_order
CREATE TABLE `master_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `master_order_no` varchar(36) NOT NULL COMMENT '主订单编号',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户编号',
  `order_time` datetime DEFAULT NULL COMMENT '主订单生成时间',
  `type` int(11) DEFAULT NULL COMMENT '订单类型',
  `status` smallint(6) DEFAULT NULL COMMENT '主订单状态',
  `total_price` decimal(12,2) DEFAULT NULL COMMENT '总金额',
  `origin_price` decimal(12,2) DEFAULT NULL COMMENT '应付金额',
  `area_no` int(11) DEFAULT NULL COMMENT '运营区域编号',
  `m_size` varchar(20) DEFAULT NULL COMMENT '客户类型',
  `account_id` bigint(20) DEFAULT NULL COMMENT '子账号id',
  `admin_id` int(11) DEFAULT NULL COMMENT '大客户的门店下单时，该门店下单时所属大客户',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_master_order_no` (`master_order_no`),
  KEY `idx_order_time` (`order_time`)
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8 COMMENT='主订单表'
---
DDL for table: master_order_preferential
CREATE TABLE `master_order_preferential` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `master_order_no` varchar(36) DEFAULT NULL COMMENT '主订单号',
  `order_no` varchar(36) DEFAULT NULL COMMENT '子订单号',
  `amount` decimal(12,2) DEFAULT NULL COMMENT '优惠金额',
  `type` int(11) DEFAULT NULL COMMENT '优惠类型',
  `related_id` bigint(20) DEFAULT NULL COMMENT 'type关联优惠id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_master_order_no` (`master_order_no`,`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主订单优惠明细表'
---
DDL for table: master_payment
CREATE TABLE `master_payment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pay_type` varchar(20) NOT NULL COMMENT '支付类型',
  `master_order_no` varchar(36) NOT NULL COMMENT '主支付单号',
  `transaction_number` varchar(100) DEFAULT NULL COMMENT '交易号',
  `money` decimal(12,2) DEFAULT NULL COMMENT '支付金额',
  `end_time` datetime DEFAULT NULL COMMENT '支付完成时间',
  `trade_type` varchar(150) DEFAULT NULL COMMENT '支付名称',
  `bank_type` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `status` tinyint(4) DEFAULT '0' COMMENT '支付状态',
  `err_code` varchar(32) DEFAULT NULL COMMENT '支付错误代码',
  `err_code_des` varchar(128) DEFAULT NULL COMMENT '支付错误描述',
  `company_account_id` int(11) DEFAULT '1' COMMENT '支付账号id',
  `scan_code` varchar(100) DEFAULT NULL COMMENT 'Boc支付二维码',
  `account_info` varchar(255) DEFAULT NULL COMMENT '支付账号信息',
  `boc_pay_type` varchar(50) DEFAULT NULL COMMENT 'Boc支付类型',
  `online_pay_end_time` datetime DEFAULT NULL COMMENT '线上支付完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_master_order_no` (`master_order_no`),
  KEY `idx_status_endtime` (`status`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='主单支付表'
---
DDL for table: match_purchase_order
CREATE TABLE `match_purchase_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `purchase_invoice_id` int(11) DEFAULT NULL COMMENT '采购发票表id',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `match_amount` decimal(10,2) DEFAULT NULL COMMENT '匹配金额',
  `status` int(11) DEFAULT NULL COMMENT '是否解除匹配 0 存在，1 解除匹配 ，2 驳回 ',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `price` decimal(10,2) DEFAULT NULL COMMENT '采购成本',
  `purchase_time` datetime DEFAULT NULL COMMENT '采购日期',
  `actual_tax_amount` decimal(10,2) DEFAULT NULL COMMENT '实际可抵扣税额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=666 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='匹配采购单表'
---
DDL for table: match_purchases_plan
CREATE TABLE `match_purchases_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchases_plan_id` int(11) DEFAULT NULL COMMENT '采购计划id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `price` decimal(10,2) DEFAULT NULL COMMENT '采购成本',
  `matching_schedule` varchar(50) DEFAULT NULL COMMENT '匹配进度',
  `wait_match` decimal(10,2) DEFAULT NULL COMMENT '待匹配金额',
  `status` int(11) DEFAULT NULL COMMENT '状态：0 存在，1 已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `match_purchases_plan_p_index` (`purchases_plan_id`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5456 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购计划匹配信息表'
---
DDL for table: mch_enterprise_address_relation
CREATE TABLE `mch_enterprise_address_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `enterprise_information_id` bigint(20) DEFAULT NULL COMMENT '取自mch_enterprise_information_management表中id',
  `contact_id` bigint(20) DEFAULT NULL COMMENT '取自contact表中contact_id',
  `valid_status` int(11) DEFAULT '0' COMMENT '0:生效中（默认), 1:(失效)',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_enterprise_information_id` (`enterprise_information_id`) USING BTREE,
  KEY `idx_contact_id` (`contact_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户企业信息和收货地址关联表'
---
DDL for table: mch_enterprise_information_management
CREATE TABLE `mch_enterprise_information_management` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `m_id` bigint(20) DEFAULT NULL COMMENT '取自merchant表中m_id',
  `invoice_title` varchar(50) DEFAULT NULL COMMENT '企业工商名称',
  `tax_number` varchar(50) DEFAULT NULL COMMENT '统一社会信用代码',
  `valid_status` int(11) DEFAULT '0' COMMENT '0:生效中（默认), 1:(失效)',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `link_method` varchar(200) DEFAULT NULL COMMENT '联系方式',
  `legal_person_name` varchar(255) DEFAULT NULL COMMENT '法人',
  `verification` int(11) DEFAULT '0' COMMENT '验证 0:不需审核, 1:需要审核',
  `business_license_address` varchar(100) DEFAULT NULL COMMENT '营业执照地址',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `sync_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:未同步浙食链, 1:已同步浙食链',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_title_tax` (`invoice_title`,`tax_number`) USING BTREE,
  KEY `idx_mid` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户企业信息管理表'
---
DDL for table: mch_popup_otification
CREATE TABLE `mch_popup_otification` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `banner_id` int(11) NOT NULL COMMENT 'banner表id',
  `m_id` bigint(20) NOT NULL COMMENT '用户mId',
  `status` tinyint(4) DEFAULT '1' COMMENT 'banner状态：0未展示，1已经展示',
  `recognition_time` date DEFAULT NULL COMMENT '弹窗日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_banner_id` (`banner_id`) USING BTREE,
  KEY `idx_m_id_banner` (`m_id`,`banner_id`,`recognition_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2050 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员每日弹窗情况表'
---
DDL for table: menu_purview
CREATE TABLE `menu_purview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '父级菜单权限id',
  `name` varchar(30) NOT NULL COMMENT '菜单权限名称',
  `description` varchar(30) DEFAULT NULL COMMENT '权限描述',
  `type` varchar(10) NOT NULL COMMENT '权限类型 A B 类',
  `status` int(11) NOT NULL COMMENT '状态 0 可用 1 不可用',
  `module` varchar(20) DEFAULT NULL COMMENT '所属模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=326 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='菜单权限表'
---
DDL for table: menu_purview_back
CREATE TABLE `menu_purview_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '父级菜单权限id',
  `name` varchar(30) NOT NULL COMMENT '菜单权限名称',
  `description` varchar(30) DEFAULT NULL COMMENT '权限描述',
  `type` varchar(10) NOT NULL COMMENT '权限类型 A B 类',
  `status` int(11) NOT NULL COMMENT '状态 0 可用 1 不可用',
  `module` varchar(20) DEFAULT NULL COMMENT '所属模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='菜单权限表'
---
DDL for table: menu_purview_copy
CREATE TABLE `menu_purview_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '父级菜单权限id',
  `name` varchar(30) NOT NULL COMMENT '菜单权限名称',
  `description` varchar(30) DEFAULT NULL COMMENT '权限描述',
  `type` varchar(10) NOT NULL COMMENT '权限类型 A B 类',
  `status` int(11) NOT NULL COMMENT '状态 0 可用 1 不可用',
  `module` varchar(20) DEFAULT NULL COMMENT '所属模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='菜单权限表'
---
DDL for table: menu_purview_pro
CREATE TABLE `menu_purview_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '父级菜单权限id',
  `name` varchar(30) NOT NULL COMMENT '菜单权限名称',
  `description` varchar(30) DEFAULT NULL COMMENT '权限描述',
  `type` varchar(10) NOT NULL COMMENT '权限类型 A B 类',
  `status` int(11) NOT NULL COMMENT '状态 0 可用 1 不可用',
  `module` varchar(20) DEFAULT NULL COMMENT '所属模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=371 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='菜单权限表'
---
DDL for table: merchant
CREATE TABLE `merchant` (
  `m_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `role_id` int(2) NOT NULL DEFAULT '6' COMMENT '商户类型',
  `mname` varchar(255) DEFAULT NULL COMMENT '商户名称',
  `mcontact` varchar(255) DEFAULT NULL COMMENT '主联系人',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信用户id',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机',
  `islock` int(11) DEFAULT '1' COMMENT '审核状态：0、审核通过 1、审核中 2、审核未通过 3、账号被拉黑 4、注销',
  `rank_id` int(2) DEFAULT NULL COMMENT '等级',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `invitecode` varchar(20) DEFAULT NULL COMMENT '6位邀请码',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '用户分享码',
  `inviter_channel_code` varchar(20) DEFAULT NULL COMMENT '邀请人渠道码',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_user` int(11) DEFAULT NULL COMMENT '审核人',
  `business_license` varchar(255) DEFAULT NULL COMMENT '营业执照路径',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '地区',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '商家腾讯地图坐标',
  `remark` varchar(100) DEFAULT NULL COMMENT '审核备注',
  `shop_sign` varchar(255) DEFAULT NULL COMMENT '店铺招牌',
  `other_proof` varchar(255) DEFAULT NULL COMMENT '其他证明照片',
  `last_order_time` datetime DEFAULT NULL COMMENT '上次下单时间',
  `area_no` int(11) DEFAULT '1001',
  `size` varchar(50) NOT NULL DEFAULT '单店' COMMENT '1大客户\\2大连锁3\\小连锁\\4单点',
  `type` varchar(50) DEFAULT NULL COMMENT '客户类型',
  `trade_area` varchar(50) DEFAULT NULL COMMENT '商圈',
  `trade_group` varchar(50) DEFAULT NULL COMMENT '商圈组',
  `unionid` varchar(50) DEFAULT NULL,
  `mp_openid` varchar(50) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `direct` int(11) DEFAULT NULL COMMENT '1是直营 2是加盟\n1 账期 2  现结\n\n',
  `server` int(11) NOT NULL DEFAULT '1' COMMENT '1服务区内 2服务区外',
  `pop_view` int(11) NOT NULL DEFAULT '0',
  `member_integral` decimal(10,2) DEFAULT '0.00' COMMENT '会员当月积分',
  `grade` int(2) DEFAULT NULL COMMENT '会员等级',
  `sku_show` int(11) DEFAULT NULL,
  `recharge_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '余额',
  `cash_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '可提现金额',
  `cash_update_time` datetime DEFAULT NULL COMMENT 'cash_amount更新时间',
  `show_price` tinyint(1) DEFAULT '1' COMMENT '配送单是否展示价格',
  `merge_admin` varchar(50) DEFAULT NULL COMMENT '账号合并人',
  `merge_time` datetime DEFAULT NULL COMMENT '账号和并时间',
  `first_login_pop` int(11) DEFAULT '0' COMMENT '首次登录弹窗：0、未弹 1、已弹',
  `change_pop` int(11) DEFAULT '1' COMMENT '更换账号绑定弹窗：0、未弹 1、已弹或未更换账号绑定',
  `pull_black_remark` varchar(50) DEFAULT NULL COMMENT '拉黑备注',
  `pull_black_operator` varchar(50) DEFAULT NULL COMMENT '操作人',
  `house_number` varchar(50) DEFAULT NULL COMMENT '门牌号',
  `company_brand` varchar(50) DEFAULT NULL COMMENT '企业品牌',
  `clue_pool` tinyint(4) DEFAULT '0' COMMENT '是否选择线索池 0 不是 1 是',
  `merchant_type` varchar(20) DEFAULT NULL COMMENT '大客户类型: ka,批发大客户,普通',
  `enterprise_scale` varchar(30) DEFAULT NULL COMMENT '规模',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `examine_type` int(11) DEFAULT '1',
  `display_button` int(11) DEFAULT '1' COMMENT '开关状态 0 开（展示） 1 关（不展示）',
  `operate_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '运营状态:正常(0),倒闭(1)',
  `updater` int(11) DEFAULT NULL COMMENT '更新人adminId',
  `door_pic` varchar(255) DEFAULT NULL COMMENT '门头照片',
  `pre_register_flag` int(11) DEFAULT '0' COMMENT '预注册标记.1-代表为预注册',
  PRIMARY KEY (`m_id`) USING BTREE,
  UNIQUE KEY `Unique_openid` (`openid`) USING BTREE,
  UNIQUE KEY `i_phone` (`phone`) USING BTREE,
  KEY `index_mname` (`mname`) USING BTREE,
  KEY `merchant_admin_index` (`admin_id`,`direct`,`m_id`) USING BTREE,
  KEY `merchant_area_index` (`area_no`,`size`,`type`) USING BTREE,
  KEY `merchant_invitecode_index` (`invitecode`) USING BTREE,
  KEY `idx_last_order_time` (`last_order_time`) USING BTREE,
  KEY `merchant_islock_m_id_index` (`islock`,`admin_id`),
  KEY `idx_channel_code` (`channel_code`),
  KEY `idx_province_city_area` (`province`,`city`,`area`)
) ENGINE=InnoDB AUTO_INCREMENT=344070 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户'
---
DDL for table: merchant_20231018_hengtianran
CREATE TABLE `merchant_20231018_hengtianran` (
  `m_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '门店id',
  `mname` varchar(255) DEFAULT NULL COMMENT '门店名',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '城市',
  `area` varchar(50) DEFAULT NULL COMMENT '区域',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `merchant_type` varchar(30) DEFAULT NULL COMMENT '门店类型',
  PRIMARY KEY (`m_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1019515 DEFAULT CHARSET=utf8 COMMENT='门店表'
---
DDL for table: merchant_20231018_online
CREATE TABLE `merchant_20231018_online` (
  `m_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '1',
  `role_id` int(11) NOT NULL DEFAULT '6' COMMENT '商户类型',
  `mname` varchar(255) DEFAULT NULL COMMENT '商户名称',
  `mcontact` varchar(255) DEFAULT NULL COMMENT '主联系人',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信用户id',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机',
  `islock` int(11) DEFAULT '1' COMMENT '审核状态：0、审核通过 1、审核中 2、审核未通过 3、账号被拉黑 4、注销',
  `rank_id` int(11) DEFAULT NULL COMMENT '等级',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `invitecode` varchar(20) DEFAULT NULL COMMENT '6位邀请码',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '用户分享码',
  `inviter_channel_code` varchar(20) DEFAULT NULL COMMENT '邀请人渠道码',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_user` int(11) DEFAULT NULL COMMENT '审核人',
  `business_license` varchar(255) DEFAULT NULL COMMENT '营业执照路径',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '地区',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '商家腾讯地图坐标',
  `remark` varchar(100) DEFAULT NULL COMMENT '审核备注',
  `shop_sign` varchar(255) DEFAULT NULL COMMENT '店铺招牌',
  `other_proof` varchar(255) DEFAULT NULL COMMENT '其他证明照片',
  `last_order_time` datetime DEFAULT NULL COMMENT '上次下单时间',
  `area_no` int(11) DEFAULT '1001' COMMENT '1',
  `size` varchar(50) NOT NULL DEFAULT '单店' COMMENT '1大客户\\2大连锁3\\小连锁\\4单点',
  `type` varchar(50) DEFAULT NULL COMMENT '客户类型',
  `trade_area` varchar(50) DEFAULT NULL COMMENT '商圈',
  `trade_group` varchar(50) DEFAULT NULL COMMENT '商圈组',
  `unionid` varchar(50) DEFAULT NULL COMMENT '1',
  `mp_openid` varchar(50) DEFAULT NULL COMMENT '1',
  `admin_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `direct` int(11) DEFAULT NULL COMMENT '1是直营 2是加盟\n1 账期 2  现结',
  `server` int(11) NOT NULL DEFAULT '1' COMMENT '1服务区内 2服务区外',
  `pop_view` int(11) NOT NULL DEFAULT '0' COMMENT '1',
  `member_integral` decimal(10,2) DEFAULT '0.00' COMMENT '会员当月积分',
  `grade` int(11) DEFAULT NULL COMMENT '会员等级',
  `sku_show` int(11) DEFAULT NULL COMMENT '1',
  `recharge_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '余额',
  `cash_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '可提现金额',
  `cash_update_time` datetime DEFAULT NULL COMMENT 'cash_amount更新时间',
  `show_price` tinyint(4) DEFAULT '1' COMMENT '配送单是否展示价格',
  `merge_admin` varchar(50) DEFAULT NULL COMMENT '账号合并人',
  `merge_time` datetime DEFAULT NULL COMMENT '账号和并时间',
  `first_login_pop` int(11) DEFAULT '0' COMMENT '首次登录弹窗：0、未弹 1、已弹',
  `change_pop` int(11) DEFAULT '1' COMMENT '更换账号绑定弹窗：0、未弹 1、已弹或未更换账号绑定',
  `pull_black_remark` varchar(50) DEFAULT NULL COMMENT '拉黑备注',
  `pull_black_operator` varchar(50) DEFAULT NULL COMMENT '操作人',
  `house_number` varchar(50) DEFAULT NULL COMMENT '门牌号',
  `company_brand` varchar(50) DEFAULT NULL COMMENT '企业品牌',
  `clue_pool` tinyint(4) DEFAULT '0' COMMENT '是否选择线索池 0 不是 1 是',
  `merchant_type` varchar(20) DEFAULT NULL COMMENT '大客户类型: ka,批发大客户,普通',
  `enterprise_scale` varchar(30) DEFAULT NULL COMMENT '规模',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `examine_type` int(11) DEFAULT '1' COMMENT '1',
  `display_button` int(11) DEFAULT '1' COMMENT '开关状态 0 开（展示） 1 关（不展示）',
  `operate_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '运营状态:正常(0),倒闭(1)',
  `updater` int(11) DEFAULT NULL COMMENT '更新人adminId',
  `door_pic` varchar(255) DEFAULT NULL COMMENT '门头照片',
  `pre_register_flag` int(11) DEFAULT '0' COMMENT '预注册标记.1-代表为预注册',
  PRIMARY KEY (`m_id`),
  KEY `index_mname` (`mname`),
  KEY `merchant_admin_index` (`admin_id`,`direct`,`m_id`),
  KEY `merchant_area_index` (`area_no`,`size`,`type`),
  KEY `merchant_invitecode_index` (`invitecode`),
  KEY `idx_last_order_time` (`last_order_time`),
  KEY `merchant_islock_m_id_index` (`islock`,`admin_id`),
  KEY `idx_channel_code` (`channel_code`),
  KEY `idx_province_city_area` (`province`,`city`,`area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户'
---
DDL for table: merchant_account_transfer
CREATE TABLE `merchant_account_transfer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `m_id` bigint(20) DEFAULT NULL COMMENT '主账号 mid',
  `mname` varchar(64) DEFAULT NULL COMMENT '主账号 名称',
  `transfer_m_id` bigint(20) DEFAULT NULL COMMENT '要迁移的mid',
  `operator_name` varchar(64) DEFAULT NULL COMMENT '操作人姓名',
  `area_no` bigint(20) DEFAULT NULL COMMENT '运营服务区编号',
  `area_name` varchar(64) DEFAULT NULL COMMENT '运营服务区名称',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `addr` varchar(500) DEFAULT NULL COMMENT '地址',
  `bd_name` varchar(64) DEFAULT NULL COMMENT '归属bd名称',
  `transfer_mname` varchar(64) DEFAULT NULL COMMENT '被迁移店铺名称',
  `transfer_bd_name` varchar(64) DEFAULT NULL COMMENT '被迁移的bd名称',
  `phone` varchar(32) DEFAULT NULL COMMENT '主账号手机号',
  `transfer_phone` varchar(32) DEFAULT NULL COMMENT '被转移的主账号手机号',
  PRIMARY KEY (`id`),
  KEY `index_mid` (`m_id`),
  KEY `index_transfer_mid` (`transfer_m_id`),
  KEY `index_mname` (`mname`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='门店迁移'
---
DDL for table: merchant_b2b_helper
CREATE TABLE `merchant_b2b_helper` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `m_id` bigint(20) NOT NULL COMMENT '门店id',
  `account_id` bigint(20) NOT NULL COMMENT '登陆自账号人id',
  `b2b_status` tinyint(4) DEFAULT NULL COMMENT '录入状态 0预录入 1 取消授权  2录入完成',
  `coupon_status` tinyint(4) DEFAULT NULL COMMENT '优惠卷状态 0未发放 1发放',
  `popup_status` tinyint(4) DEFAULT NULL COMMENT '0未弹出 1已弹出',
  `merchant_info` varchar(800) DEFAULT NULL COMMENT '录入的门店信息',
  `mp_openid` varchar(64) DEFAULT NULL COMMENT '小程序openID',
  `cover_status` tinyint(4) DEFAULT NULL COMMENT '蒙层状态 0未弹出 1已弹出',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_mid_account_id` (`m_id`,`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 COMMENT='门店b2b信息'
---
DDL for table: merchant_bak
CREATE TABLE `merchant_bak` (
  `m_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `role_id` int(2) NOT NULL DEFAULT '6' COMMENT '商户类型',
  `mname` varchar(255) DEFAULT NULL COMMENT '商户名称',
  `mcontact` varchar(255) DEFAULT NULL COMMENT '主联系人',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信用户id',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机',
  `islock` int(1) DEFAULT '1' COMMENT '审核是否通过',
  `rank_id` int(2) DEFAULT NULL COMMENT '等级',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `invitecode` varchar(20) DEFAULT NULL COMMENT '6位邀请码',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '用户分享码',
  `inviter_channel_code` varchar(20) DEFAULT NULL COMMENT '邀请人渠道码',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_user` int(11) DEFAULT NULL COMMENT '审核人',
  `business_license` varchar(255) DEFAULT NULL COMMENT '营业执照路径',
  `remark` varchar(100) DEFAULT NULL COMMENT '审核备注',
  `shop_sign` varchar(255) DEFAULT NULL COMMENT '店铺招牌',
  `other_proof` varchar(255) DEFAULT NULL COMMENT '其他证明照片',
  `last_order_time` datetime DEFAULT NULL COMMENT '上次下单时间',
  `area_no` int(11) DEFAULT '1001',
  `size` varchar(50) NOT NULL DEFAULT '单店' COMMENT '1大客户2大连锁3小连锁4单点',
  `type` varchar(50) DEFAULT NULL COMMENT '客户类型',
  `trade_area` varchar(50) DEFAULT NULL COMMENT '商圈',
  `trade_group` varchar(50) DEFAULT NULL COMMENT '商圈组',
  `unionid` varchar(50) DEFAULT NULL,
  `mp_openid` varchar(50) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `direct` int(11) DEFAULT NULL COMMENT '1是直营 2是加盟',
  `server` int(11) NOT NULL DEFAULT '1' COMMENT '1服务区内 2服务区外',
  `pop_view` int(11) NOT NULL DEFAULT '0',
  `member_integral` decimal(10,2) DEFAULT '0.00' COMMENT '会员当月积分',
  `grade` int(2) DEFAULT NULL COMMENT '会员等级',
  `sku_show` int(11) DEFAULT NULL,
  `recharge_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '余额',
  PRIMARY KEY (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=303904 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户合并备份表'
---
DDL for table: merchant_bak_publish
CREATE TABLE `merchant_bak_publish` (
  `m_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `role_id` int(2) NOT NULL DEFAULT '6' COMMENT '商户类型',
  `mname` varchar(255) DEFAULT NULL COMMENT '商户名称',
  `mcontact` varchar(255) DEFAULT NULL COMMENT '主联系人',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信用户id',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机',
  `islock` int(1) DEFAULT '1' COMMENT '审核是否通过',
  `rank_id` int(2) DEFAULT NULL COMMENT '等级',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `invitecode` varchar(20) DEFAULT NULL COMMENT '6位邀请码',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '用户分享码',
  `inviter_channel_code` varchar(20) DEFAULT NULL COMMENT '邀请人渠道码',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_user` int(11) DEFAULT NULL COMMENT '审核人',
  `business_license` varchar(255) DEFAULT NULL COMMENT '营业执照路径',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '地区',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '商家腾讯地图坐标',
  `remark` varchar(100) DEFAULT NULL COMMENT '审核备注',
  `shop_sign` varchar(255) DEFAULT NULL COMMENT '店铺招牌',
  `other_proof` varchar(255) DEFAULT NULL COMMENT '其他证明照片',
  `last_order_time` datetime DEFAULT NULL COMMENT '上次下单时间',
  `area_no` int(11) DEFAULT '1001',
  `size` varchar(50) NOT NULL DEFAULT '单店' COMMENT '1大客户2大连锁3小连锁4单点',
  `type` varchar(50) DEFAULT NULL COMMENT '客户类型',
  `trade_area` varchar(50) DEFAULT NULL COMMENT '商圈',
  `trade_group` varchar(50) DEFAULT NULL COMMENT '商圈组',
  `unionid` varchar(50) DEFAULT NULL,
  `mp_openid` varchar(50) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `direct` int(11) DEFAULT NULL COMMENT '1是直营 2是加盟',
  `server` int(11) NOT NULL DEFAULT '1' COMMENT '1服务区内 2服务区外',
  `pop_view` int(11) NOT NULL DEFAULT '0',
  `member_integral` decimal(10,2) DEFAULT '0.00' COMMENT '会员当月积分',
  `grade` int(2) DEFAULT NULL COMMENT '会员等级',
  `sku_show` int(11) DEFAULT NULL,
  `recharge_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '余额',
  `cash_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '可提现金额',
  `cash_update_time` datetime DEFAULT NULL COMMENT 'cash_amount更新时间',
  PRIMARY KEY (`m_id`) USING BTREE,
  UNIQUE KEY `Unique_openid` (`openid`) USING BTREE,
  UNIQUE KEY `i_phone` (`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11898 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户'
---
DDL for table: merchant_business_switch
CREATE TABLE `merchant_business_switch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `type` int(11) DEFAULT NULL COMMENT '用户标记业务类型-0常用推荐new开关',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户id',
  `enabled` tinyint(4) DEFAULT NULL COMMENT '1开启，0不开启',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_search` (`m_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8 COMMENT='用户业务标记表'
---
DDL for table: merchant_cancel
CREATE TABLE `merchant_cancel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `m_id` bigint(20) NOT NULL COMMENT '门店ID',
  `status` tinyint(4) DEFAULT '1' COMMENT '注销状态 默认-1（待注销） MerchantCancelEnum',
  `remake` varchar(255) DEFAULT NULL COMMENT '申请原因',
  `certificate` varchar(255) DEFAULT NULL COMMENT '申请凭证-后台申请必填',
  `creator` bigint(20) DEFAULT NULL COMMENT '申请人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  `resource` tinyint(4) DEFAULT '0' COMMENT '申请来源  0-商城  1-后台',
  `phone` varchar(11) DEFAULT NULL COMMENT '注册手机号',
  `mname` varchar(255) DEFAULT NULL COMMENT '门店名称',
  PRIMARY KEY (`id`),
  KEY `m_id_status_indxe` (`m_id`,`status`) COMMENT '门店id及状态组合索引',
  KEY `phone_index` (`phone`) COMMENT '手机号普通索引'
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COMMENT='门店注销'
---
DDL for table: merchant_card
CREATE TABLE `merchant_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(30) NOT NULL COMMENT '商户id',
  `card_id` int(11) NOT NULL COMMENT '优惠卡id',
  `card_rule_id` int(11) DEFAULT NULL COMMENT '优惠卡规则id',
  `vaild_date` datetime DEFAULT NULL COMMENT '有效日期',
  `sender` varchar(36) DEFAULT NULL COMMENT '红包发送者',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_mId` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户-优惠卡'
---
DDL for table: merchant_card_record
CREATE TABLE `merchant_card_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_card_id` int(11) NOT NULL COMMENT '用户优惠卡id',
  `order_no` varchar(36) NOT NULL,
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_merchant_card_id` (`merchant_card_id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户-优惠卡使用记录'
---
DDL for table: merchant_clue_pool
CREATE TABLE `merchant_clue_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` int(11) DEFAULT NULL COMMENT '用户id',
  `ml_id` int(11) DEFAULT NULL COMMENT 'merchant_leads 例子池id',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `m_name` varchar(255) DEFAULT NULL COMMENT '店铺名称',
  `phone` varchar(64) DEFAULT NULL COMMENT '手机号',
  `status` int(11) DEFAULT '0' COMMENT '状态 0 生效 1失效',
  `es_id` varchar(50) DEFAULT NULL COMMENT 'es线索池id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `merchant_clue_pool_mid_index` (`m_id`,`status`),
  KEY `idx_ml_id` (`ml_id`),
  KEY `idx_esid` (`es_id`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户线索池关联表'
---
DDL for table: merchant_coupon
CREATE TABLE `merchant_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(30) NOT NULL COMMENT '商户id',
  `coupon_id` int(11) NOT NULL COMMENT '优惠券id',
  `vaild_date` datetime DEFAULT NULL COMMENT '有效日期',
  `sender` varchar(36) DEFAULT NULL COMMENT '红包发送者',
  `used` tinyint(2) DEFAULT '0' COMMENT '是否使用，0未使用，1已使用',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `view` int(2) DEFAULT NULL,
  `order_no` varchar(20) DEFAULT NULL,
  `receive_type` tinyint(4) DEFAULT NULL COMMENT '领取类型 0-发放（人工）1-手动领取  2-抽奖活动 （被动）3-自动领取（新人注册/推荐好友下单）4-满返活动（被动） 5-其他',
  `start_time` datetime DEFAULT NULL COMMENT '开始生效时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `send_id` bigint(20) DEFAULT NULL COMMENT '优惠券发放记录id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `in_order_no` (`order_no`) USING BTREE,
  KEY `merchant_coupon_coupon_index` (`coupon_id`) USING BTREE,
  KEY `idx_send_id_used` (`send_id`,`used`) USING BTREE,
  KEY `idx_vaild_date` (`vaild_date`),
  KEY `idx_add_time` (`add_time`),
  KEY `idx_m_id_used_vaild_date` (`m_id`,`used`,`vaild_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1627703 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户-优惠券关联表'
---
DDL for table: merchant_ext
CREATE TABLE `merchant_ext` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `m_id` bigint(20) DEFAULT NULL COMMENT '客户id',
  `free_day` varchar(30) DEFAULT NULL COMMENT '免邮日',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(30) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `click_flag` tinyint(1) DEFAULT NULL COMMENT '是否点击生效 0否 1是',
  `group_head_flag` int(11) DEFAULT '0' COMMENT '是否可以开团：0、普通 1、团长',
  `group_buy_area_no` int(11) DEFAULT NULL COMMENT '团长所属运营区域',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mid` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8365 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='客户扩展表'
---
DDL for table: merchant_follow_white_list
CREATE TABLE `merchant_follow_white_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(30) DEFAULT NULL COMMENT '用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 不可用 1 可用',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `merchant_follow_white_list_mid_index` (`m_id`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='用户流转白名单表'
---
DDL for table: merchant_free_day_log
CREATE TABLE `merchant_free_day_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `m_id` bigint(20) DEFAULT NULL COMMENT '客户ID',
  `click_flag` tinyint(4) DEFAULT NULL COMMENT '点击是否 0否 1是',
  `free_day` varchar(20) DEFAULT NULL COMMENT '免邮日',
  `effect_flag` tinyint(4) DEFAULT NULL COMMENT '标识是否执行 0否 1是',
  `delete_flag` tinyint(4) DEFAULT NULL COMMENT '是否删除 0否 1是',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_m_id` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='围栏配送表'
---
DDL for table: merchant_group_purchase
CREATE TABLE `merchant_group_purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `m_id` int(11) DEFAULT NULL COMMENT '用户id',
  `m_name` varchar(50) DEFAULT NULL COMMENT '店铺名称',
  `phone` varchar(13) DEFAULT NULL COMMENT '手机号',
  `admin_id` int(11) DEFAULT NULL COMMENT '所属bd',
  `admin_name` varchar(50) DEFAULT NULL COMMENT 'bd名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `merchant_group_purchase_m_id_uindex` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='团购信息表'
---
DDL for table: merchant_key_person
CREATE TABLE `merchant_key_person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `m_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商户id',
  `role` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '角色:0店长,1老板,2合伙人,3采购',
  `person_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'kp姓名',
  `phone` char(11) NOT NULL DEFAULT '' COMMENT '联系电话',
  `create_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建人id',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_m_id_phone` (`m_id`,`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6705 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户关键联系人'
---
DDL for table: merchant_label
CREATE TABLE `merchant_label` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(255) NOT NULL COMMENT '标签名称',
  `status` tinyint(4) DEFAULT '1' COMMENT '售后状态 0-禁用 1-启用',
  `type` tinyint(4) DEFAULT NULL COMMENT '标签类型  MerchantLabelTypeEnum',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `auditor` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='客户标签表'
---
DDL for table: merchant_label_correlation
CREATE TABLE `merchant_label_correlation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `label_id` bigint(20) unsigned DEFAULT NULL COMMENT '商户标签ID',
  `m_id` bigint(20) unsigned DEFAULT NULL COMMENT '商户ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`label_id`,`m_id`) USING BTREE COMMENT '唯一索引',
  KEY `merchant_id_index` (`m_id`) COMMENT '商户索引'
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8 COMMENT='商户标签关联表'
---
DDL for table: merchant_leads
CREATE TABLE `merchant_leads` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `mname` varchar(45) NOT NULL COMMENT '''商户名称''',
  `phone` varchar(15) DEFAULT NULL COMMENT '''联系方式''',
  `province` varchar(20) DEFAULT NULL COMMENT '''省''',
  `city` varchar(20) DEFAULT NULL COMMENT '''市''',
  `area` varchar(50) DEFAULT NULL COMMENT '''区''',
  `address` varchar(255) DEFAULT NULL COMMENT '''详细地址''',
  `poi_note` varchar(50) DEFAULT NULL COMMENT '''高德地址''',
  `area_no` int(11) DEFAULT NULL,
  `area_name` varchar(45) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL COMMENT '''店铺类型''',
  `author` varchar(50) DEFAULT NULL COMMENT '''数据维护人''',
  `admin_id` int(11) DEFAULT NULL COMMENT '当前跟进BD id',
  `admin_name` varchar(45) DEFAULT NULL COMMENT '''当前跟进人姓名''',
  `source` varchar(45) DEFAULT NULL COMMENT '''客户来源''',
  `mcontact` varchar(45) DEFAULT NULL COMMENT '''联系人''',
  `status` int(11) DEFAULT NULL COMMENT '0 待跟进 1 待注册 2 已注册 3 已失效',
  `remark` varchar(255) DEFAULT NULL COMMENT '''备注，可以记录跟进情况或者一些备注''',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  `enterprise_scale` varchar(50) DEFAULT NULL COMMENT '企业规模',
  `house_number` varchar(50) DEFAULT NULL COMMENT '门牌号',
  `company_brand` varchar(50) DEFAULT NULL COMMENT '企业品牌',
  `type` varchar(25) DEFAULT NULL COMMENT '经营类型',
  `m_id` int(11) DEFAULT NULL COMMENT '客户id',
  `door_pic` varchar(255) DEFAULT NULL COMMENT '门头照',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `merchant_leads_status_admin_id_index` (`status`,`admin_id`) USING BTREE,
  KEY `idx_status_m_id` (`status`,`m_id`),
  KEY `idx_merchant_leads` (`mname`)
) ENGINE=InnoDB AUTO_INCREMENT=2245 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: merchant_lifecycle
CREATE TABLE `merchant_lifecycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_id` int(11) NOT NULL,
  `lifecycle` tinyint(2) DEFAULT NULL COMMENT '生命周期，0新注册，1首单，2非稳，3稳定',
  `tag` varchar(50) DEFAULT NULL COMMENT '标签',
  `purchasing_cycle_left` int(3) DEFAULT NULL COMMENT '距离下次采购时间间隔',
  `coupon_expire_date` int(3) DEFAULT NULL COMMENT '优惠券失效时间',
  `last_order_time` datetime DEFAULT NULL COMMENT '上次下单时间',
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind_m_id` (`m_id`,`add_time`) USING BTREE,
  KEY `merchant_lifecycle_addtime_index` (`add_time`,`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=46898825 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户生命周期表'
---
DDL for table: merchant_merge_record
CREATE TABLE `merchant_merge_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `master_merchant_id` bigint(20) NOT NULL COMMENT '合并门店id',
  `old_merchant_id` bigint(20) NOT NULL COMMENT '被合并门店id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_master_merchant_id` (`master_merchant_id`) USING BTREE,
  KEY `idx_old_merchant_id` (`old_merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='门店合并记录表'
---
DDL for table: merchant_month_purmoney
CREATE TABLE `merchant_month_purmoney` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `m_id` bigint(30) DEFAULT NULL COMMENT '客户id',
  `month_purmoney` varchar(30) DEFAULT NULL COMMENT '月度采购金额',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `merchant_month_purmoney_mid_index` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7030 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='客户月度采购金额表'
---
DDL for table: merchant_order_record
CREATE TABLE `merchant_order_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `m_id` bigint(30) DEFAULT NULL COMMENT '客户id',
  `sku` varchar(30) DEFAULT NULL COMMENT '商品sku',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_merchant` (`m_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='秒杀sku客户购买记录45天表'
---
DDL for table: merchant_outer
CREATE TABLE `merchant_outer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `m_id` bigint(20) NOT NULL COMMENT '商家id，merchant.m_id',
  `outer_no` varchar(128) NOT NULL COMMENT '商家外部编码',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `outer_platform_id` int(2) DEFAULT NULL COMMENT '外部平台 1：AOL；2：悸动烧仙草',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_outer_no` (`outer_no`,`outer_platform_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1600678631940 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商家外部信息'
---
DDL for table: merchant_poi_update_record
CREATE TABLE `merchant_poi_update_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `follow_up_record_id` int(11) DEFAULT NULL COMMENT '拜访记录id',
  `address_before_change` varchar(100) NOT NULL COMMENT '变更前地址',
  `poi_before_change` varchar(100) DEFAULT NULL COMMENT '变更前poi',
  `address_after_change` varchar(100) NOT NULL COMMENT '变更后地址',
  `poi_after_change` varchar(100) NOT NULL COMMENT '变更后poi',
  `m_id` bigint(20) NOT NULL COMMENT '销售名称',
  `mname` varchar(255) NOT NULL COMMENT '门店名称',
  `saler_name` varchar(20) NOT NULL COMMENT '门店id',
  `saler_id` bigint(20) NOT NULL COMMENT '销售id',
  `distance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '距离',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `contact_id` bigint(20) DEFAULT NULL COMMENT '联系人id',
  `status` tinyint(4) DEFAULT '0' COMMENT '变更结果0:待审批;1:审批通过;2:审批拒绝;',
  PRIMARY KEY (`id`),
  KEY `idx_follow_up_record_id` (`follow_up_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COMMENT='门店poi更新记录'
---
DDL for table: merchant_pool_detail
CREATE TABLE `merchant_pool_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pool_info_id` bigint(20) DEFAULT NULL COMMENT '人群包id',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户id',
  `size` varchar(16) DEFAULT NULL COMMENT '店铺类型',
  `area_no` int(11) DEFAULT NULL COMMENT '运营服务区域',
  `version` int(11) DEFAULT NULL COMMENT '版本(只会存在两个版本)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_info_id_m_id_v` (`pool_info_id`,`m_id`,`version`),
  KEY `idx_m_id_info_id_v` (`m_id`,`pool_info_id`,`version`)
) ENGINE=InnoDB AUTO_INCREMENT=7801511 DEFAULT CHARSET=utf8 COMMENT='人群包商户明细表'
---
DDL for table: merchant_pool_info
CREATE TABLE `merchant_pool_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) DEFAULT NULL COMMENT '分群名称',
  `create_way` tinyint(4) DEFAULT NULL COMMENT '创建方式,0 在线圈选,1 Excel导入',
  `update_way` tinyint(4) DEFAULT NULL COMMENT '更新方式,0 不支持,1 自动,2 手动',
  `status` tinyint(4) DEFAULT NULL COMMENT '数据状态',
  `remark` varchar(64) DEFAULT NULL COMMENT '备注',
  `version` int(11) NOT NULL DEFAULT '0' COMMENT '当前最新版本号',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(32) DEFAULT NULL COMMENT '最后一次操作者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8 COMMENT='人群包基础信息表'
---
DDL for table: merchant_pool_rule_detail
CREATE TABLE `merchant_pool_rule_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pool_info_id` bigint(20) DEFAULT NULL COMMENT '人群包id',
  `rule_detail` text COMMENT '规则详情json',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_idx_info_id` (`pool_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8 COMMENT='圈人规则详情表'
---
DDL for table: merchant_pool_tag
CREATE TABLE `merchant_pool_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) DEFAULT NULL COMMENT '规则标签名称,例：tag_date_last_buy_time',
  `description` varchar(64) DEFAULT NULL COMMENT '规则标签描述',
  `relation_symbol` varchar(128) NOT NULL COMMENT '关系符号,枚举值逗号分割',
  `field_type` tinyint(4) DEFAULT NULL COMMENT '规则字段ES存储类型,0 单值,1 数组',
  `type` tinyint(4) DEFAULT NULL COMMENT '规则属性类型,0 基本属性,1 行为属性',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='人群包规则标签'
---
DDL for table: merchant_pool_tag_config
CREATE TABLE `merchant_pool_tag_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tag_id` bigint(20) DEFAULT NULL COMMENT 'rule_tag_id规则标签id',
  `value` varchar(128) DEFAULT NULL COMMENT '标签对应的可选值',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tag_id` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='规则标签值配置表'
---
DDL for table: merchant_review_record
CREATE TABLE `merchant_review_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `m_id` bigint(30) NOT NULL COMMENT '商家id',
  `islock` int(1) DEFAULT '1' COMMENT '审核变更状态 0、审核通过 1、审核中 2、审核不通过 3、已拉黑',
  `audit_user` int(11) DEFAULT NULL COMMENT '审核人',
  `audit_name` varchar(64) DEFAULT NULL COMMENT '审核人名称',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1899 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商家审核记录表'
---
DDL for table: merchant_situation
CREATE TABLE `merchant_situation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(11) DEFAULT NULL COMMENT '状态 0待审核 1已审核(待审批) 2审批通过 3 申请未通过',
  `create_location` int(11) DEFAULT NULL COMMENT '创建位置0后台,1CRM(已弃用)',
  `merchant_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人ID',
  `examine_id` int(11) DEFAULT NULL COMMENT '审核人ID',
  `examine_time` datetime DEFAULT NULL COMMENT '审核时间',
  `approval_id` int(11) DEFAULT NULL COMMENT '审批人ID(已弃用)',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间(已弃用)',
  `approval_remark` varchar(255) DEFAULT NULL COMMENT '审批备注(已弃用)',
  `examine_remark` varchar(255) DEFAULT NULL COMMENT '审核备注',
  `examine_name` varchar(50) DEFAULT NULL COMMENT '审核人名称',
  `approval_name` varchar(50) DEFAULT NULL COMMENT '审批人名称(已弃用)',
  `coupon_id` int(11) DEFAULT NULL COMMENT '发券券id',
  `creator_name` varchar(35) DEFAULT NULL COMMENT '创建人名称',
  `admin_id` int(11) DEFAULT NULL COMMENT '所属bd名称',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '所属bd名称',
  `situation_remake` varchar(500) DEFAULT NULL COMMENT '申请单备注',
  `situation_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '申请类型:0客情,1月活,2品类',
  `order_quantity` int(10) unsigned DEFAULT NULL COMMENT '预计下单量',
  `attached_image` text COMMENT '附件图片',
  `merchant_coupon_id` bigint(20) DEFAULT NULL COMMENT '客户券 id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_coupon_id` (`coupon_id`) USING BTREE,
  KEY `idx_merchant_id` (`merchant_id`),
  KEY `idx_examine_time` (`examine_time`),
  KEY `idx_merchant_coupon_id` (`merchant_coupon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1957 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='客情申请表'
---
DDL for table: merchant_situation_quota
CREATE TABLE `merchant_situation_quota` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT 'bd编号',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '已使用客情金额',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 不可用 1 可用',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='客情额度信息表'
---
DDL for table: merchant_sub_account
CREATE TABLE `merchant_sub_account` (
  `account_id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `m_id` bigint(30) DEFAULT NULL COMMENT '店铺id',
  `type` int(1) DEFAULT NULL COMMENT '账号类型：0、母账号 1、子账号',
  `contact` varchar(255) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机',
  `unionid` varchar(50) DEFAULT NULL COMMENT 'unionid',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信用户id',
  `mp_openid` varchar(50) DEFAULT NULL COMMENT '小程序openid',
  `pop_view` int(1) NOT NULL DEFAULT '0' COMMENT '弹窗标识',
  `first_pop_view` int(1) DEFAULT '1' COMMENT '合并后首次登录标识：0、首次 1、非首次',
  `cash_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '可提现金额',
  `cash_update_time` datetime DEFAULT NULL COMMENT 'cash_amount更新时间',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `last_order_time` datetime DEFAULT NULL COMMENT '上次下单时间',
  `status` int(11) DEFAULT '0' COMMENT '审核是否通过（审核不通过直接删除）：0、待审核 1、审核通过  2、注销',
  `delete_flag` int(1) DEFAULT '1' COMMENT '删除标识：0、已删除 1、未删除',
  `m_info` varchar(2000) DEFAULT NULL COMMENT '合并前账号信息',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_user` int(11) DEFAULT NULL COMMENT '审核人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`) USING BTREE,
  KEY `merchant_sub_account_mid_index` (`m_id`) USING BTREE,
  KEY `merchant_sub_account_union_index` (`unionid`,`delete_flag`) USING BTREE,
  KEY `merchant_sub_account_mpopenid_index` (`mp_openid`) USING BTREE,
  KEY `merchant_sub_account_openid_index` (`openid`) USING BTREE,
  KEY `idx_phone` (`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3388 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户子账号'
---
DDL for table: merchant_test
CREATE TABLE `merchant_test` (
  `m_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `role_id` int(2) NOT NULL DEFAULT '6' COMMENT '商户类型',
  `mname` varchar(255) DEFAULT NULL COMMENT '商户名称',
  `mcontact` varchar(255) DEFAULT NULL COMMENT '主联系人',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信用户id',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机',
  `islock` int(1) DEFAULT '1' COMMENT '审核状态：0、审核通过 1、审核中 2、审核未通过 3、账号被拉黑',
  `rank_id` int(2) DEFAULT NULL COMMENT '等级',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `invitecode` varchar(20) DEFAULT NULL COMMENT '6位邀请码',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '用户分享码',
  `inviter_channel_code` varchar(20) DEFAULT NULL COMMENT '邀请人渠道码',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_user` int(11) DEFAULT NULL COMMENT '审核人',
  `business_license` varchar(255) DEFAULT NULL COMMENT '营业执照路径',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '地区',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '商家腾讯地图坐标',
  `remark` varchar(100) DEFAULT NULL COMMENT '审核备注',
  `shop_sign` varchar(255) DEFAULT NULL COMMENT '店铺招牌',
  `other_proof` varchar(255) DEFAULT NULL COMMENT '其他证明照片',
  `last_order_time` datetime DEFAULT NULL COMMENT '上次下单时间',
  `area_no` int(11) DEFAULT '1001',
  `size` varchar(50) NOT NULL DEFAULT '单店' COMMENT '1大客户\\2大连锁3\\小连锁\\4单点',
  `type` varchar(50) DEFAULT NULL COMMENT '客户类型',
  `trade_area` varchar(50) DEFAULT NULL COMMENT '商圈',
  `trade_group` varchar(50) DEFAULT NULL COMMENT '商圈组',
  `unionid` varchar(50) DEFAULT NULL,
  `mp_openid` varchar(50) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `direct` int(11) DEFAULT NULL COMMENT '1是直营 2是加盟\n1 账期 2  现结\n\n',
  `server` int(11) NOT NULL DEFAULT '1' COMMENT '1服务区内 2服务区外',
  `pop_view` int(11) NOT NULL DEFAULT '0',
  `member_integral` decimal(10,2) DEFAULT '0.00' COMMENT '会员当月积分',
  `grade` int(2) DEFAULT NULL COMMENT '会员等级',
  `sku_show` int(11) DEFAULT NULL,
  `recharge_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '余额',
  `cash_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '可提现金额',
  `cash_update_time` datetime DEFAULT NULL COMMENT 'cash_amount更新时间',
  `show_price` tinyint(1) DEFAULT '1' COMMENT '配送单是否展示价格',
  `merge_admin` varchar(50) DEFAULT NULL COMMENT '账号合并人',
  `merge_time` datetime DEFAULT NULL COMMENT '账号和并时间',
  `first_login_pop` int(11) DEFAULT '0' COMMENT '首次登录弹窗：0、未弹 1、已弹',
  `change_pop` int(11) DEFAULT '1' COMMENT '更换账号绑定弹窗：0、未弹 1、已弹或未更换账号绑定',
  `pull_black_remark` varchar(50) DEFAULT NULL COMMENT '拉黑备注',
  `house_number` varchar(50) DEFAULT NULL COMMENT '门牌号',
  `company_brand` varchar(50) DEFAULT NULL COMMENT '企业品牌',
  `clue_pool` tinyint(4) DEFAULT '0' COMMENT '是否选择线索池 0 不是 1 是',
  `merchant_type` varchar(20) DEFAULT NULL COMMENT '大客户类型: ka,批发大客户,普通',
  `enterprise_scale` varchar(30) DEFAULT NULL COMMENT '规模',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`m_id`) USING BTREE,
  UNIQUE KEY `Unique_openid` (`openid`) USING BTREE,
  UNIQUE KEY `i_phone` (`phone`) USING BTREE,
  KEY `index_mname` (`mname`) USING BTREE,
  KEY `merchant_islock_index` (`islock`) USING BTREE,
  KEY `merchant_area_index` (`area_no`,`size`) USING BTREE,
  KEY `merchant_admin_index` (`admin_id`,`direct`,`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=116245 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户'
---
DDL for table: merchant_update_record
CREATE TABLE `merchant_update_record` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT COMMENT '主键，自增长',
  `m_id` bigint(30) NOT NULL COMMENT '门店对应merchant表内的m_id',
  `change_type` tinyint(4) DEFAULT NULL COMMENT '0: 门店切换，1：门店新建，2：门店拉黑不可用，3：门店从黑名单中移除',
  `old_admin` bigint(30) DEFAULT NULL COMMENT '门店切换前所属大客户admin_id,NULL切换前普通门店；门店拉黑不可用',
  `new_admin` bigint(30) DEFAULT NULL COMMENT '门店切换后所属大客户admin_id,NULL切换后普通门店；门店新建；门店从黑名单移除',
  `creator_id` bigint(30) DEFAULT NULL COMMENT '门店切换操作人，admin表内的admin_id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '门店切换记录时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `mId_index` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2869 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='门店客户状态切换记录表'
---
DDL for table: merchant_visit
CREATE TABLE `merchant_visit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `m_id` bigint(20) NOT NULL COMMENT '商家id',
  `count` int(11) NOT NULL DEFAULT '0' COMMENT '访问次数统计',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型，0 换购蒙层',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mid_type` (`m_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='商家访问统计表'
---
DDL for table: message_order
CREATE TABLE `message_order` (
  `sm_id` bigint(40) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(30) NOT NULL,
  `order_no` varchar(36) NOT NULL COMMENT '订单编号',
  `message_type_id` int(5) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`sm_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1240 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户消息'
---
DDL for table: message_type
CREATE TABLE `message_type` (
  `message_type_id` int(5) NOT NULL AUTO_INCREMENT,
  `message_type` varchar(50) DEFAULT NULL COMMENT '消息类型',
  `message_title` varchar(100) DEFAULT NULL COMMENT '消息名称',
  PRIMARY KEY (`message_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='消息类型'
---
DDL for table: message_user
CREATE TABLE `message_user` (
  `sm_id` bigint(40) NOT NULL AUTO_INCREMENT,
  `m_id` bigint(30) DEFAULT NULL,
  `message_type_id` int(5) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`sm_id`) USING BTREE,
  KEY `FK_message_type_user` (`message_type_id`) USING BTREE,
  KEY `FK_message_merchant` (`m_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户消息'
---
DDL for table: mo
CREATE TABLE `mo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `lock_key` varchar(128) NOT NULL COMMENT 'key',
  `ver` int(11) DEFAULT '0' COMMENT '版本',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_lock` (`lock_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: msg_admin
CREATE TABLE `msg_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg_body_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `recv_type` int(3) DEFAULT '0' COMMENT '0接收人，1cc',
  `read` tinyint(1) DEFAULT '0' COMMENT '0已读，1未读',
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_msg_body_id` (`msg_body_id`),
  KEY `idx_admin_id_body_id` (`admin_id`,`msg_body_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46876 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统消息-管理员关联表'
---
DDL for table: msg_body
CREATE TABLE `msg_body` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg_template_id` int(11) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `keyword` varchar(45) DEFAULT NULL,
  `repeat_times` int(11) DEFAULT '0' COMMENT '重复提醒次数',
  `status` int(3) DEFAULT '0' COMMENT '消息处理状态：0暂不处理，1处理中，2已完成',
  `addtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=36250 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台预警消息正文'
---
DDL for table: msg_history
CREATE TABLE `msg_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '消息内容',
  `mode` varchar(255) DEFAULT NULL COMMENT '发送方式',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `operate` varchar(255) DEFAULT NULL COMMENT '触发消息的操作',
  `operator` varchar(255) DEFAULT NULL COMMENT '发送者',
  `add_time` datetime DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mid_time` (`user_id`,`add_time`)
) ENGINE=InnoDB AUTO_INCREMENT=461426 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='消息发送记录表'
---
DDL for table: msg_template
CREATE TABLE `msg_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL COMMENT '消息标题',
  `template` varchar(255) DEFAULT NULL COMMENT '消息模版',
  `type` int(3) DEFAULT '0' COMMENT '发送方式：0站内信 1邮箱 3 短信',
  `admin_id` int(11) DEFAULT NULL COMMENT '消息提醒人，对应管理员id',
  `cc_admin_id` varchar(45) DEFAULT NULL COMMENT '抄送人对应管理员Id,存在多个用,分隔',
  `period` float DEFAULT '0' COMMENT '重复提醒间隔，0则不重复提醒。单位：小时',
  `updatetime` datetime DEFAULT NULL,
  `template_code` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='消息模版'
---
DDL for table: on_sale_adjustment
CREATE TABLE `on_sale_adjustment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `on_sale` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上下架: 0下架、1上架',
  `status` int(2) DEFAULT '0' COMMENT '执行状态: 0待执行、1已执行、2已取消',
  `up_time` datetime DEFAULT NULL COMMENT '生效时间',
  `update_time` datetime DEFAULT NULL,
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_sku` (`sku`) USING BTREE,
  KEY `index_area_no` (`area_no`,`sku`),
  KEY `idex_area_no` (`on_sale`,`status`,`up_time`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='上下架变动表'
---
DDL for table: order_abnormal
CREATE TABLE `order_abnormal` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `order_item_id` varchar(33) NOT NULL COMMENT '订单项id',
  `sku` varchar(30) NOT NULL COMMENT 'sku编号',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '失效状态:0有效 1失效',
  `revoke_quantity` int(11) NOT NULL COMMENT '缺货数量',
  `type` tinyint(4) NOT NULL COMMENT '订单类型0普通/省心送 1售后订单 2出样',
  `m_id` bigint(20) NOT NULL COMMENT '店铺id',
  `delivery_time` date NOT NULL COMMENT '配送日期',
  `order_no` varchar(36) NOT NULL COMMENT '订单编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=268452 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单异常条目表'
---
DDL for table: order_advance
CREATE TABLE `order_advance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(20) DEFAULT NULL COMMENT '订单编号',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `deposit_price` decimal(10,2) DEFAULT NULL COMMENT '定金金额',
  `pay_deposit_time` datetime DEFAULT NULL COMMENT '定金支付时间',
  `remaining_total_price` decimal(10,2) DEFAULT NULL COMMENT '尾款金额',
  `discount_remaining_price` decimal(10,2) DEFAULT NULL COMMENT '尾款立减金额\n',
  `pay_remaining_time` datetime DEFAULT NULL COMMENT '尾款支付时间',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `timing_rule_id` int(11) DEFAULT NULL COMMENT '省心送规则id\n',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_advance_order_index` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='订单预售扩展表'
---
DDL for table: order_defect_info
CREATE TABLE `order_defect_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `m_id` bigint(20) DEFAULT NULL COMMENT 'mId',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `delivery_plan_id` int(11) DEFAULT NULL COMMENT '配送计划ID',
  `weight` varchar(200) DEFAULT NULL COMMENT 'sku规格',
  `sku_name` varchar(255) DEFAULT NULL COMMENT 'sku名称',
  `defect_amount` int(11) DEFAULT NULL COMMENT '缺损数量',
  `amount` int(11) DEFAULT NULL COMMENT '应送数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku_pic` varchar(50) DEFAULT NULL COMMENT 'sku图',
  PRIMARY KEY (`id`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_delivery_id` (`delivery_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='订单缺损信息表'
---
DDL for table: order_delivery_record
CREATE TABLE `order_delivery_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(30) DEFAULT NULL COMMENT '订单号',
  `delivery_fee` decimal(10,2) DEFAULT NULL COMMENT '配送费金额',
  `delivery_rule` varchar(500) DEFAULT NULL COMMENT '免配送费规则',
  `delivery_free_day` varchar(30) DEFAULT NULL COMMENT '免配送费日',
  `big_merchant_delivery_rule` varchar(500) DEFAULT NULL COMMENT '大客户专享免邮规则',
  `big_merchant_delivery_fee` decimal(10,2) DEFAULT NULL COMMENT '大客户配送费金额',
  `delivery_card_id` int(11) DEFAULT NULL COMMENT '订单使用的免邮卡ID',
  `delivery_coupon_id` int(11) DEFAULT NULL COMMENT '订单使用运费券ID',
  `pay_delivery_fee` decimal(10,2) DEFAULT NULL COMMENT '实付运费金额',
  `add_time` datetime DEFAULT NULL COMMENT '使用时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=129186 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='订单配送费相关表'
---
DDL for table: order_export_record
CREATE TABLE `order_export_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `m_id` bigint(20) NOT NULL COMMENT '门店ID',
  `email` varchar(50) NOT NULL COMMENT '门店邮箱',
  `status` tinyint(4) DEFAULT '0' COMMENT '0-待发送  1-发送成功  2-发送失败',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `param` varchar(500) DEFAULT NULL COMMENT '入参信息',
  PRIMARY KEY (`id`),
  KEY `m_id_index` (`m_id`) COMMENT '门店ID索引'
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COMMENT='单店账单导出记录'
---
DDL for table: order_hey_tea
CREATE TABLE `order_hey_tea` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_no` varchar(50) NOT NULL COMMENT '鲜沐订单编号',
  `ht_order_code` varchar(255) NOT NULL COMMENT '喜茶订单编号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=703 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: order_item
CREATE TABLE `order_item` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `pd_name` varchar(255) DEFAULT NULL COMMENT '商品名称（快照）',
  `sku` varchar(30) NOT NULL COMMENT '产品编号',
  `weight` varchar(100) DEFAULT NULL COMMENT '重量/规格',
  `maturity` varchar(36) DEFAULT NULL COMMENT '生熟度',
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `category_id` int(11) DEFAULT NULL,
  `amount` int(10) DEFAULT NULL COMMENT '购买数量',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '购买时的商品价格',
  `original_price` decimal(10,2) DEFAULT '0.00',
  `picture_path` varchar(1150) DEFAULT NULL COMMENT '商品图片',
  `add_time` datetime DEFAULT NULL COMMENT '购买时间',
  `storage_location` tinyint(2) DEFAULT '0' COMMENT '仓储区域',
  `suit_id` int(11) DEFAULT '0',
  `suit_name` varchar(45) DEFAULT NULL,
  `suit_amount` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '订单项状态',
  `rebate_type` int(11) DEFAULT NULL,
  `rebate_number` double DEFAULT NULL,
  `m_price` double DEFAULT NULL,
  `volume` varchar(255) DEFAULT NULL COMMENT '体积',
  `weight_num` decimal(10,2) DEFAULT '0.00' COMMENT '重量kg',
  `use_coupon` tinyint(4) DEFAULT NULL COMMENT '是否用券',
  `max_threshold` int(11) DEFAULT NULL COMMENT '大单值',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '直发采购下单时的sku的总价',
  `product_type` int(11) DEFAULT '0' COMMENT '商品类型：0、普通商品 1、赠品',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `actual_total_price` decimal(10,2) unsigned DEFAULT NULL COMMENT '订单项实付总价',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `sku_name` varchar(60) DEFAULT NULL COMMENT 'sku名称',
  `info` varchar(60) DEFAULT NULL COMMENT 'sku下单时有效期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `in_order_no` (`order_no`,`suit_id`,`sku`) USING BTREE,
  KEY `order_item_sku_index` (`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1251215845 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='购物车'
---
DDL for table: order_item_preferential
CREATE TABLE `order_item_preferential` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '优惠金额',
  `order_item_id` bigint(20) DEFAULT NULL COMMENT '订单项id',
  `type` int(11) DEFAULT NULL COMMENT '优惠类型 0 活动 1组合包 2满减 3阶梯价 4黄金卡优惠 5预售尾款立减优惠 6秒杀 7搭配购 8多人拼团 9优惠券10赠品 11代仓 12预付 13红包',
  `related_id` bigint(20) DEFAULT NULL COMMENT 'type关联优惠id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `in_order_no` (`order_no`),
  KEY `in_order_item_id` (`order_item_id`),
  KEY `in_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=38868 DEFAULT CHARSET=utf8 COMMENT='订单优惠明细表'
---
DDL for table: order_outer_info
CREATE TABLE `order_outer_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `m_id` varchar(50) DEFAULT NULL COMMENT 'aol门店编号',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `delivery_date` date DEFAULT NULL COMMENT '配送时间',
  `mphone` varchar(50) DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `amount` int(11) DEFAULT NULL COMMENT '数量',
  `sku` varchar(255) DEFAULT NULL COMMENT 'aolsku信息',
  `xm_order_no` varchar(50) DEFAULT NULL COMMENT '鲜沐订单号',
  `standard` varchar(255) DEFAULT NULL COMMENT '规格',
  `unit` varchar(50) DEFAULT NULL COMMENT '件',
  `name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `delivery_status` int(11) DEFAULT '0' COMMENT '配送状态',
  `status` int(1) DEFAULT '2' COMMENT '1：成功；2：失败',
  `failure_reason` varchar(255) DEFAULT NULL COMMENT '失败原因',
  `order_success_time` datetime DEFAULT NULL COMMENT '订单同步成功时间',
  `outer_platform_id` int(2) DEFAULT NULL COMMENT '外部平台 1：AOL；2：悸动烧仙草',
  `xm_id` bigint(30) DEFAULT NULL COMMENT '商家id，merchant.m_id',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `detailed_address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_outer_info_order_no_xm_order_no_index` (`order_no`,`xm_order_no`) USING BTREE,
  KEY `idx_gmt_create` (`status`,`gmt_create`) USING BTREE,
  KEY `idx_outer_platform_id` (`outer_platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1960 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='第三方订单信息表(aol接收到的订单)'
---
DDL for table: order_outer_item
CREATE TABLE `order_outer_item` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `sku` varchar(30) DEFAULT NULL COMMENT 'aolsku信息',
  `amount` int(11) DEFAULT NULL COMMENT '数量',
  `standard` varchar(255) DEFAULT NULL COMMENT '规格',
  `unit` varchar(50) DEFAULT NULL COMMENT '件',
  `name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `xm_sku` varchar(30) DEFAULT NULL COMMENT 'xmsku信息',
  `pd_name` varchar(255) DEFAULT NULL COMMENT 'xm商品名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `outer_platform_id` int(2) DEFAULT NULL COMMENT '外部平台 1：AOL；2：悸动烧仙草',
  `item_id` int(2) DEFAULT NULL COMMENT '明细行号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `order_no` (`order_no`) USING BTREE,
  KEY `idx_outer_platform_id` (`outer_platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=600 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='第三方订单明细表(aol接收到的订单明细)'
---
DDL for table: order_preferential
CREATE TABLE `order_preferential` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '优惠金额',
  `type` int(11) DEFAULT NULL COMMENT '优惠类型 0 活动 1组合包 2满减 3阶梯价 4黄金卡优惠 5预售尾款立减优惠 6秒杀 7搭配购',
  `activity_name` varchar(50) DEFAULT NULL COMMENT 'type =1 时生效,活动名称',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `related_id` bigint(20) DEFAULT NULL COMMENT 'type关联优惠id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `in_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64074 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='订单优惠信息表'
---
DDL for table: order_preferential_record
CREATE TABLE `order_preferential_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(30) DEFAULT NULL COMMENT '订单号',
  `market_rule_detail` text COMMENT '满减规则',
  `market_fee` decimal(10,2) DEFAULT NULL COMMENT '满减优惠金额',
  `coupon_id` int(11) DEFAULT NULL COMMENT '使用优惠券id',
  `coupon_fee` decimal(10,2) DEFAULT NULL COMMENT '优惠券优惠金额',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='订单优惠信息'
---
DDL for table: order_relation
CREATE TABLE `order_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `master_order_no` varchar(36) DEFAULT NULL COMMENT '主订单号',
  `order_no` varchar(36) DEFAULT NULL COMMENT '子订单号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_order_no` (`master_order_no`,`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=395 DEFAULT CHARSET=utf8 COMMENT='主子单关联关系表'
---
DDL for table: order_status
CREATE TABLE `order_status` (
  `id` smallint(2) NOT NULL AUTO_INCREMENT,
  `order_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单类型'
---
DDL for table: orders
CREATE TABLE `orders` (
  `order_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `m_id` bigint(30) COMMENT '商户编号',
  `order_time` datetime DEFAULT NULL COMMENT '订单生成时间',
  `type` int(2) DEFAULT '0' COMMENT '订单类型：0普通，1省心送，2运费,3代下单,10虚拟商品（黄金卡、充值...）,11直发采购',
  `status` smallint(2) DEFAULT '1' COMMENT '订单状态',
  `delivery_fee` decimal(12,2) DEFAULT '0.00' COMMENT '配送费用',
  `total_price` decimal(12,2) DEFAULT '0.00' COMMENT '总金额',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认收货时间',
  `area_name` varchar(255) DEFAULT NULL,
  `out_times` int(2) DEFAULT '0',
  `discount_type` int(11) NOT NULL DEFAULT '0' COMMENT '0没用1优惠券2满减3满返',
  `out_times_fee` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '超时加单费用',
  `area_no` int(11) DEFAULT NULL,
  `m_size` varchar(20) DEFAULT NULL,
  `direct` int(11) DEFAULT NULL,
  `sku_show` int(11) DEFAULT NULL,
  `red_pack_amount` decimal(10,2) DEFAULT NULL COMMENT '红包金额',
  `card_rule_id` int(11) DEFAULT NULL COMMENT '待发放优惠卡id',
  `account_id` bigint(30) DEFAULT NULL COMMENT '子账号id',
  `origin_price` decimal(10,2) DEFAULT NULL COMMENT '应付价格',
  `out_stock` int(11) DEFAULT '0',
  `discount_card_id` int(11) DEFAULT NULL COMMENT '虚拟商品id：奶油卡id、充值送券id',
  `order_sale_type` int(11) DEFAULT '0' COMMENT '订单扩展类型\r\n普通订单：0、普通 1、预售 	虚拟商品（type=10）：0、黄金卡 1、充值',
  `receivable_status` smallint(6) NOT NULL DEFAULT '0' COMMENT '0（默认）：该订单下无应收款，1：该订单下有应收款且未付，2：该订单下有应收款且部分付款，3：该订单下有应收且已付清',
  `admin_id` int(11) DEFAULT NULL COMMENT '大客户的门店下单时，该门店下单时所属大客户',
  `invoice_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:未开票,1:部分开票,2:已开票',
  `financial_invoice_id` bigint(20) DEFAULT NULL COMMENT '财务发票表id(202209弃用)',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `operate_id` int(11) DEFAULT NULL COMMENT '代下单操作人',
  `order_pay_type` tinyint(4) DEFAULT NULL COMMENT '代下单类型:1:账期;2:现结;3:账期代下;4:现结代下单',
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE KEY `IN_orderno` (`order_no`,`status`) USING BTREE,
  KEY `orders_ts_index` (`type`,`status`,`area_no`) USING BTREE,
  KEY `rds_idx_2` (`status`,`m_id`,`order_time`,`area_no`) USING BTREE,
  KEY `orders_area_no_index` (`area_no`,`status`) USING BTREE,
  KEY `orders_sale_index` (`order_sale_type`,`status`,`area_no`) USING BTREE,
  KEY `idx_mid` (`m_id`,`status`,`order_time`),
  KEY `idx_financial_invoice_id` (`financial_invoice_id`),
  KEY `orders_time_index` (`order_time`,`status`) USING BTREE,
  KEY `idx_type_time` (`order_id`,`type`,`order_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7455245 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单'
---
DDL for table: orders_coupon
CREATE TABLE `orders_coupon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) DEFAULT NULL,
  `merchant_coupon_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `orders_coupon_index` (`merchant_coupon_id`) USING BTREE,
  KEY `orders_coupon_no_index` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28966 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='记录订单使用了用户的哪张券。包含失效和退款的订单'
---
DDL for table: outer_platform
CREATE TABLE `outer_platform` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `outer_platform_id` int(2) DEFAULT NULL COMMENT '外部平台 1：AOL；2：悸动烧仙草',
  `outer_platform_name` varchar(30) DEFAULT NULL COMMENT '外部平台名称',
  `call_url` varchar(255) DEFAULT NULL COMMENT '外部平台调用地址',
  `token` varchar(50) DEFAULT NULL COMMENT '外部平台调用token',
  `push_goods_switch` int(1) DEFAULT '0' COMMENT '推送商品基础信息开关 0：关；1：开',
  `push_order_switch` int(1) DEFAULT '0' COMMENT '推送订单信息开关 0：关；1：开',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `order_call_back_switch` int(1) DEFAULT '0' COMMENT '订单回调开关 0：关；1：开',
  `order_report_switch` int(1) DEFAULT '0' COMMENT '订单汇总开关 0：关；1：日汇总',
  `push_store_switch` int(1) DEFAULT '0' COMMENT '推送门店开关 0：关；1：开',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `outer_platform_id` (`outer_platform_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='外部对接-外部平台信息'
---
DDL for table: outer_platform_push_record
CREATE TABLE `outer_platform_push_record` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `type` int(1) DEFAULT NULL COMMENT '类型 1：上下架;2：价格更新;3：订单发货通知;4：订单签收通知',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `area_no` int(11) DEFAULT NULL COMMENT '城市',
  `admin_id` int(11) DEFAULT NULL COMMENT 'admin_id',
  `on_sale` int(1) DEFAULT NULL COMMENT '0下架 1上架',
  `price` decimal(11,2) DEFAULT NULL COMMENT '价格',
  `xm_order_no` varchar(50) DEFAULT NULL COMMENT '鲜沐订单号',
  `push_status` int(1) DEFAULT NULL COMMENT '推送状态 1：成功; 2:失败',
  `push_times` int(1) DEFAULT NULL COMMENT '推送次数',
  `req_content` varchar(1000) DEFAULT NULL COMMENT '请求内容',
  `res_content` varchar(255) DEFAULT NULL COMMENT '返回内容',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_sku_index` (`type`,`sku`,`area_no`,`admin_id`) USING BTREE,
  KEY `type_xm_order_no_index` (`type`,`xm_order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='外部对接-外部平台推送记录'
---
DDL for table: outside_contact
CREATE TABLE `outside_contact` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT '' COMMENT '区',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `poi` varchar(50) DEFAULT NULL COMMENT 'poi',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id',
  `store_id` int(11) DEFAULT NULL COMMENT '商户id',
  `distance` decimal(10,2) unsigned DEFAULT NULL COMMENT '到仓距离',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `name` varchar(50) DEFAULT NULL COMMENT '联系人',
  `mname` varchar(255) DEFAULT NULL COMMENT '店铺名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2181 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='外部地址表'
---
DDL for table: panic_buy
CREATE TABLE `panic_buy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `start_flag` int(11) DEFAULT NULL COMMENT '0未开启 1 开启',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store` (`store_no`,`area_no`) USING BTREE,
  KEY `idx_area` (`area_no`) USING BTREE,
  KEY `idx_start_time` (`start_time`) USING BTREE,
  KEY `idx_end_time` (`end_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3363 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='秒杀'
---
DDL for table: panic_buy_record
CREATE TABLE `panic_buy_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `buy_sku_id` int(11) NOT NULL COMMENT '秒杀sku',
  `quantity` int(11) NOT NULL COMMENT '购买数量',
  `order_no` varchar(33) DEFAULT NULL COMMENT '订单编号',
  `order_item_id` int(11) DEFAULT NULL COMMENT '订单编号id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `panic_buy_record_index` (`order_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44497 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='秒杀购买记录'
---
DDL for table: panic_buy_sku
CREATE TABLE `panic_buy_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `panic_id` int(11) DEFAULT NULL COMMENT '秒杀id',
  `sku` varchar(33) DEFAULT NULL COMMENT 'sku',
  `plan_quantity` int(10) unsigned DEFAULT '0' COMMENT '计划数量',
  `actual_quantity` int(10) unsigned DEFAULT '0' COMMENT '实际数量',
  `lock_quantity` int(10) unsigned DEFAULT '0' COMMENT '冻结数量',
  `limit_quantity` int(10) unsigned DEFAULT NULL COMMENT '限购数量',
  `panic_price` decimal(10,4) DEFAULT NULL COMMENT '秒杀价',
  `hide_price` tinyint(1) DEFAULT '0' COMMENT '是否隐价',
  `sort` int(11) DEFAULT NULL COMMENT '排序值（从小到大）',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `panic_buy_sku_unique_index` (`panic_id`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3902 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='秒杀sku表'
---
DDL for table: panic_buy_subscription
CREATE TABLE `panic_buy_subscription` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `detail_id` int(11) DEFAULT NULL COMMENT '秒杀项id',
  `account_id` bigint(20) DEFAULT NULL COMMENT '账号id',
  `status` int(11) DEFAULT '0' COMMENT '状态：0、待发送 1、已发送',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `panic_buy_subscription_unique_uindex` (`detail_id`,`account_id`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='秒杀订阅'
---
DDL for table: payment
CREATE TABLE `payment` (
  `payment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pay_type` varchar(20) NOT NULL COMMENT '支付类型',
  `order_no` varchar(36) NOT NULL COMMENT '订单ID',
  `transaction_number` varchar(100) DEFAULT NULL COMMENT '交易号',
  `money` decimal(12,2) DEFAULT '0.00' COMMENT '支付金额',
  `end_time` datetime DEFAULT NULL COMMENT '支付完成时间',
  `trade_type` varchar(150) DEFAULT NULL COMMENT '支付名称',
  `bank_type` varchar(255) DEFAULT NULL COMMENT '支付方式',
  `status` tinyint(1) DEFAULT '0' COMMENT '支付状态',
  `err_code` varchar(32) DEFAULT NULL COMMENT '支付错误代码',
  `err_code_des` varchar(128) DEFAULT NULL COMMENT '支付错误描述',
  `company_account_id` int(11) DEFAULT '1',
  `scan_code` varchar(100) DEFAULT NULL COMMENT 'Boc支付二维码',
  `account_info` varchar(255) DEFAULT NULL COMMENT '支付账号信息',
  `boc_pay_type` varchar(50) DEFAULT NULL,
  `online_pay_end_time` datetime DEFAULT NULL COMMENT '线上支付完成时间',
  PRIMARY KEY (`payment_id`) USING BTREE,
  UNIQUE KEY `payment_order_no_uindex` (`order_no`) USING BTREE,
  UNIQUE KEY `transaction_number_UNIQUE` (`transaction_number`) USING BTREE,
  KEY `idx_orderno_money` (`order_no`,`money`) USING BTREE,
  KEY `idx_accountid_endtime` (`status`,`company_account_id`,`pay_type`,`end_time`) USING BTREE,
  KEY `idx_endtime` (`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=68206 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='支付'
---
DDL for table: payment_relation
CREATE TABLE `payment_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `master_payment_id` bigint(20) DEFAULT NULL COMMENT '主支付单id',
  `payment_id` bigint(20) DEFAULT NULL COMMENT '子支付单id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_payment_id` (`master_payment_id`,`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主子单支付关联关系表'
---
DDL for table: pc_daily_quantity
CREATE TABLE `pc_daily_quantity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) NOT NULL,
  `sku` varchar(30) NOT NULL,
  `date` date NOT NULL,
  `quantity_all` int(11) DEFAULT NULL COMMENT '未去除大单的销量数据',
  `quantity_threshold` int(11) DEFAULT NULL COMMENT '去除大单的销量数据',
  `sale_time_length` float(10,4) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `max_threshold` int(11) DEFAULT NULL COMMENT '计算时的大单值',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `pc_daily_quantity_u_index` (`store_no`,`sku`,`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3590211 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='日总销量、售卖时长表'
---
DDL for table: pc_day_of_week_quantity
CREATE TABLE `pc_day_of_week_quantity` (
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '预测类型 0、全量 1、去除大单',
  `store_no` int(11) NOT NULL DEFAULT '0',
  `sku` varchar(30) NOT NULL DEFAULT '',
  `week_1` int(11) DEFAULT '0',
  `week_2` int(11) DEFAULT '0',
  `week_3` int(11) DEFAULT '0',
  `week_4` int(11) DEFAULT '0',
  `week_5` int(11) DEFAULT '0',
  `week_6` int(11) DEFAULT '0',
  `week_7` int(11) DEFAULT '0',
  `std` float(10,4) DEFAULT NULL,
  `last_cycle_quantity` int(11) DEFAULT NULL COMMENT '上个周期销量',
  `max_threshold` int(11) DEFAULT NULL COMMENT '计算是的大单值',
  `create_time` datetime DEFAULT NULL,
  `turnover_rate` float(8,4) DEFAULT '0.0000' COMMENT '周转率',
  PRIMARY KEY (`type`,`store_no`,`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: pc_max_threshold
CREATE TABLE `pc_max_threshold` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `calc_store` varchar(30) DEFAULT NULL COMMENT '计算仓库',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `median` float(10,4) DEFAULT NULL COMMENT '中位数',
  `mad` float(10,4) DEFAULT NULL COMMENT 'mad',
  `mul` int(11) DEFAULT NULL COMMENT 'n',
  `threshold` int(11) DEFAULT NULL COMMENT '上限值',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `pc_max_threshold_uindex` (`store_no`,`sku`,`calc_store`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1107 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='单个订单大单判定阈值'
---
DDL for table: pc_sales_volume
CREATE TABLE `pc_sales_volume` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `store_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `pre_sales` int(11) DEFAULT NULL COMMENT '预测量',
  `big_deal` int(11) DEFAULT NULL COMMENT '大单值',
  `calculate_time` date DEFAULT NULL COMMENT '计算日期',
  `true_sales` int(11) DEFAULT '0' COMMENT '实际销量',
  `big_deal_order_cnt` int(11) DEFAULT '0' COMMENT '超出大单值数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=252023 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='销量预测表'
---
DDL for table: pick_detail
CREATE TABLE `pick_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tms_task_id` int(11) DEFAULT NULL COMMENT '捡货配送任务id',
  `sku` varchar(45) DEFAULT NULL,
  `pd_name` varchar(100) DEFAULT NULL COMMENT '商品名称*规格',
  `sku_cnt` int(11) DEFAULT NULL COMMENT 'sku数量',
  `unit` varchar(45) DEFAULT NULL COMMENT '单位',
  `detail_status` int(11) DEFAULT NULL COMMENT '正常/缺损',
  `short_cnt` int(11) DEFAULT NULL COMMENT '缺损数量',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `temperature` int(2) DEFAULT NULL COMMENT '温区',
  `weight` varchar(500) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL COMMENT '大客户id',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '大客户名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pick_detail_task_index` (`tms_task_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11337 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='捡货详情'
---
DDL for table: plan_common_remark
CREATE TABLE `plan_common_remark` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_type` int(11) DEFAULT NULL COMMENT '来源类型1:补货计划任务；2采购任务；3调拨任务',
  `source_key` varchar(100) DEFAULT NULL COMMENT '关联单Key',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `update_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8mb4 COMMENT='计划通用备注表'
---
DDL for table: pms_common_remark
CREATE TABLE `pms_common_remark` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `biz_id` varchar(20) DEFAULT NULL COMMENT '业务主键',
  `biz_type` tinyint(2) DEFAULT NULL COMMENT '业务类型，1采购单',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `source` varchar(255) DEFAULT NULL COMMENT '系统来源,xianmu;saas',
  `creator` varchar(16) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(16) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8mb4 COMMENT='PMS服务通用备注表'
---
DDL for table: pms_inquiry_list
CREATE TABLE `pms_inquiry_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `inquiry_no` varchar(20) NOT NULL COMMENT '询价单号',
  `price_start_time` datetime DEFAULT NULL COMMENT '价格生效时间',
  `price_end_time` datetime DEFAULT NULL COMMENT '价格失效时间',
  `channel_type` tinyint(4) DEFAULT NULL COMMENT '渠道类型,0全部；1源头直采；2市场分销',
  `deadline` datetime DEFAULT NULL COMMENT '截止时间',
  `total_sku_num` int(11) DEFAULT NULL COMMENT '询价单SKU数量',
  `completed_sku_num` int(11) DEFAULT NULL COMMENT '已完成报价数量',
  `status` tinyint(4) DEFAULT NULL COMMENT '询价单状态，-1已作废;0未发布;1竞价中;2评估中;3已完成',
  `source` varchar(32) DEFAULT NULL COMMENT '来源，xianmu,saas',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  `bid_evaluator` varchar(32) DEFAULT NULL COMMENT '评标人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_inquiry_no` (`inquiry_no`) COMMENT '询价单号唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb4 COMMENT='询价单主表'
---
DDL for table: pms_inquiry_list_item
CREATE TABLE `pms_inquiry_list_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `inquiry_no` varchar(20) DEFAULT NULL COMMENT '询价单号',
  `pd_no` varchar(32) DEFAULT NULL COMMENT 'SPU编码',
  `sku` varchar(32) DEFAULT NULL COMMENT 'SKU编码',
  `warehouse_no` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `warehouse_name` varchar(16) DEFAULT NULL COMMENT '仓库名称',
  `need_quantity` int(11) DEFAULT NULL COMMENT '需求量（单位件）',
  `quoted_supplier_num` int(11) DEFAULT NULL COMMENT '报价供应商数量',
  `unquoted_supplier_num` int(11) DEFAULT NULL COMMENT '未报价供应商数量',
  `last_7days_average_price` decimal(10,2) DEFAULT NULL COMMENT '近7天平均采购价',
  `quoted_finish` tinyint(4) DEFAULT NULL COMMENT '报价是否完成，0否;1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `idx_inquiry_no` (`inquiry_no`) COMMENT '询价单号二级索引',
  KEY `idx_sku_warehosue_no` (`sku`,`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=13619 DEFAULT CHARSET=utf8mb4 COMMENT='询价单商品明细'
---
DDL for table: pms_item_cost_detail
CREATE TABLE `pms_item_cost_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `sku` varchar(32) DEFAULT NULL COMMENT 'SKU编码',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商ID',
  `warehouse_no` bigint(20) DEFAULT NULL COMMENT '仓库编号',
  `cost_detail` text COMMENT '成本明细',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `idx_sku_supplier_id_warehosue_no` (`sku`,`supplier_id`,`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=utf8mb4 COMMENT='成本明细'
---
DDL for table: pms_purchases_approve_config
CREATE TABLE `pms_purchases_approve_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `key_name` varchar(100) DEFAULT NULL COMMENT '配置key',
  `key_value` text COMMENT '配置value',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_purchases_no_key` (`purchase_no`,`key_name`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COMMENT='采购审批信息记录表'
---
DDL for table: pms_road_sale_config
CREATE TABLE `pms_road_sale_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL DEFAULT '' COMMENT 'sku编码',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `road_sale_ratio` decimal(10,4) DEFAULT NULL COMMENT '在途可售比例',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_warehouse_sku_supplier` (`warehouse_no`,`sku`,`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COMMENT='在途可售比例配置表'
---
DDL for table: pms_sale_sku
CREATE TABLE `pms_sale_sku` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  PRIMARY KEY (`id`),
  KEY `idx_sku_warehouse_no` (`sku`,`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=41065 DEFAULT CHARSET=utf8mb4 COMMENT='非低销SKU表'
---
DDL for table: pms_supply_list
CREATE TABLE `pms_supply_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `spu` varchar(64) DEFAULT NULL COMMENT 'SPUID',
  `pd_name` varchar(64) DEFAULT NULL COMMENT 'SPU名称',
  `warehouse_no` varchar(16) DEFAULT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(32) DEFAULT NULL COMMENT '仓库名称',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(64) DEFAULT NULL COMMENT '供应商名称',
  `channel_type` tinyint(2) DEFAULT NULL COMMENT '渠道类型,1源头直采；2分销市场',
  `default_supplier` tinyint(1) DEFAULT NULL COMMENT '是否为默认供应商，0否；1是',
  `order_model` tinyint(2) DEFAULT NULL COMMENT '订货模式，1不定期不定量；2不定期定量；3定期不定量；4定期定量',
  `fixed_time` varchar(16) DEFAULT NULL COMMENT '定期时间，多个用逗号隔开',
  `advance_day` int(4) DEFAULT NULL COMMENT '提前期（非负数，最多不超过30天）',
  `source` varchar(16) DEFAULT NULL COMMENT '来源,xianmu,saas',
  `creator` varchar(12) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(12) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2998 DEFAULT CHARSET=utf8mb4 COMMENT='供货目录（品仓供应商信息）'
---
DDL for table: pms_warehouse_change_record
CREATE TABLE `pms_warehouse_change_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `warehouse_no` bigint(20) DEFAULT NULL COMMENT '仓库编号',
  `before_change` varchar(2048) DEFAULT NULL COMMENT '变更前',
  `after_change` varchar(2048) DEFAULT NULL COMMENT '变更后',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态,0未推送；1推送',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COMMENT='仓库信息变更记录（消息推送）'
---
DDL for table: prepay_inventory
CREATE TABLE `prepay_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `admin_id` int(11) NOT NULL COMMENT '大客户账号id',
  `sku` varchar(33) NOT NULL COMMENT 'sku',
  `prepay_price` decimal(10,4) NOT NULL COMMENT '预付总额',
  `prepay_amount` int(11) NOT NULL COMMENT '预付总量',
  `used_amount` int(11) DEFAULT '0' COMMENT '已用总量',
  `usable_type` int(11) NOT NULL COMMENT '可用账户类型：0、全部 1、账期门店 2、现结门店',
  `pay_type` int(11) NOT NULL COMMENT '支付类型：0、全额支付 1、订金尾款支付',
  `delivery_cycle` int(11) DEFAULT NULL COMMENT '配送周期',
  `status` int(11) DEFAULT '0' COMMENT '状态：0、待审核 1、待生效 2、生效中 3、已完成 4、审核失败 5、已失效',
  `effect_time` datetime DEFAULT NULL COMMENT '生效时间',
  `lose_effect_time` datetime DEFAULT NULL COMMENT '失效时间',
  `auditor` varchar(50) DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_admin_id` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2700 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预付商品配置'
---
DDL for table: prepay_inventory_record
CREATE TABLE `prepay_inventory_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `admin_id` int(11) NOT NULL COMMENT '大客户id',
  `prepay_inventory_id` int(11) DEFAULT NULL COMMENT '预付商品id',
  `amount` int(11) NOT NULL COMMENT '使用数量',
  `valid` tinyint(1) DEFAULT '1' COMMENT '是否有效：f、无效 t、有效（默认）',
  `order_no` varchar(50) NOT NULL COMMENT '订单编号',
  `sku` varchar(33) NOT NULL COMMENT 'sku',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `prepay_inventory_record_index` (`admin_id`,`sku`) USING BTREE,
  KEY `prepay_inventory_record_sku_index` (`order_no`,`sku`) USING BTREE,
  KEY `prepay_inventory_record_pid_index` (`prepay_inventory_id`) USING BTREE,
  KEY `prepay_inventory_record_cttime_index` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2093 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预付商品配置'
---
DDL for table: price_adjustment
CREATE TABLE `price_adjustment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) DEFAULT NULL,
  `pd_name` varchar(255) DEFAULT NULL COMMENT 'SPU名称',
  `original_cost_price` decimal(10,2) DEFAULT NULL COMMENT '原采购价',
  `cost_price` decimal(10,2) DEFAULT NULL COMMENT '采购价',
  `original_market_price` decimal(10,2) DEFAULT NULL COMMENT '原市场价',
  `market_price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  `up_time` datetime DEFAULT NULL COMMENT '生效时间',
  `reason` varchar(500) DEFAULT NULL COMMENT '理由',
  `status` int(2) DEFAULT NULL COMMENT '状态，1待处理，2待审批，3待执行，4已执行，5不调整，6超时未审批，7审核不通过',
  `area_price_adjustment` text,
  `update_time` datetime DEFAULT NULL,
  `add_time` datetime DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL,
  `create_admin_name` varchar(50) DEFAULT NULL COMMENT '发起人name，系统记为自动',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sku_index` (`sku`,`area_no`) USING BTREE,
  KEY `price_adjustment_area_no_status_index` (`area_no`,`status`) USING BTREE,
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=19084 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='价格变动表'
---
DDL for table: price_adjustment_pool
CREATE TABLE `price_adjustment_pool` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `sku` varchar(33) DEFAULT NULL COMMENT 'sku',
  `status` int(11) DEFAULT NULL COMMENT '状态：0、待审核 1、审核通过 2、审核失败 3、已执行 4、已取消 5、已超时 6、超时未处理',
  `original_cost_price` decimal(10,4) DEFAULT NULL COMMENT '原采购价',
  `cost_price` decimal(10,4) DEFAULT NULL COMMENT '新采购价',
  `original_market_price` decimal(10,4) DEFAULT NULL COMMENT '原售价',
  `market_price` decimal(10,4) DEFAULT NULL COMMENT '新售价',
  `ladder_price` varchar(500) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL COMMENT '调整理由',
  `create_admin_name` varchar(50) DEFAULT NULL COMMENT '创新admin name，系统记为自动',
  `up_time` datetime DEFAULT NULL COMMENT '生效时间',
  `business_id` bigint(20) DEFAULT NULL COMMENT '业务ID：用于标识是否同一批调价',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `rule_flag` int(11) DEFAULT NULL COMMENT '是否经过定时规则审核  0未经过  1直接生效  2需要审核生效',
  `original_price` decimal(10,4) DEFAULT NULL COMMENT '原采购价',
  `price` decimal(10,4) DEFAULT NULL COMMENT '新采购价',
  `interest_rate` decimal(12,4) DEFAULT NULL COMMENT '毛利率',
  `auto_flag` tinyint(4) DEFAULT NULL COMMENT '自动调价标识',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `price_adjustment_pool_bid_index` (`business_id`) USING BTREE,
  KEY `price_adjustment_pool_rf_index` (`status`,`rule_flag`) USING BTREE,
  KEY `price_adjustment_pool_index` (`area_no`,`sku`,`status`) USING BTREE,
  KEY `idx_area_no_flag_create_time` (`area_no`,`rule_flag`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=4691 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='价格调整处理池'
---
DDL for table: price_adjustment_rule_area
CREATE TABLE `price_adjustment_rule_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `area_no` int(11) DEFAULT NULL COMMENT '区域id',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓',
  `store_no` int(11) DEFAULT NULL COMMENT '服务大区',
  `creater` int(11) DEFAULT NULL COMMENT '创建人',
  `creat_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4317 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: price_adjustment_rule_section
CREATE TABLE `price_adjustment_rule_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `start_price` decimal(10,4) DEFAULT NULL COMMENT '开始价格',
  `end_price` decimal(10,4) DEFAULT NULL COMMENT '结束价格',
  `fluctuation_value` decimal(8,4) DEFAULT NULL COMMENT '波动值',
  `creater` int(11) DEFAULT NULL COMMENT '创建人',
  `creat_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=674 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: price_adjustment_trigger
CREATE TABLE `price_adjustment_trigger` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `business_id` bigint(30) DEFAULT NULL COMMENT '业务id',
  `purchase_no` varchar(255) DEFAULT NULL COMMENT '采购单号',
  `cost_price` decimal(10,4) DEFAULT NULL COMMENT '采购价',
  `market_price` decimal(10,4) DEFAULT NULL COMMENT '市场价',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `valid` int(11) DEFAULT NULL COMMENT '0、无效（同批次数据） 1、有效（发起数据）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_business_id` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15190 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='触发自动调价的价格、数量信息'
---
DDL for table: price_strategy
CREATE TABLE `price_strategy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键 自增',
  `business_id` bigint(20) NOT NULL COMMENT '业务id',
  `type` tinyint(4) NOT NULL COMMENT '类型：0：省心送 1：活动配置 2：秒杀配置 3：组合包 4：搭配购',
  `adjust_type` tinyint(4) NOT NULL COMMENT '价格调整方式：0：指定价 1：百分比 2：定额减 3:毛利百分比',
  `amount` decimal(12,4) NOT NULL COMMENT '价格或百分比分子',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `effective_price` decimal(10,2) unsigned DEFAULT NULL COMMENT '生效的价格（为空时根据策略实时计算）',
  `rounding_mode` int(11) DEFAULT '0' COMMENT '小数处理逻辑：0、四舍五入保留两位小数 1、向上取整',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_business_id_type` (`business_id`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15443 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='价格调整和售卖价关联表'
---
DDL for table: price_strategy_audit
CREATE TABLE `price_strategy_audit` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `area_no` int(11) NOT NULL COMMENT '城市',
  `sku` varchar(33) DEFAULT NULL COMMENT 'sku',
  `cost_price` decimal(10,2) unsigned DEFAULT NULL COMMENT '审核成本价',
  `original_price` decimal(10,2) unsigned DEFAULT NULL COMMENT '审核原价',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '审核状态：0、待审核 1、审核通过 2、审核拒绝 3、审核撤销',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `auditor` varchar(50) DEFAULT NULL COMMENT '审核人',
  `creator` varchar(50) DEFAULT NULL COMMENT '发起人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_area_sku` (`area_no`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5613 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='营销价审核表'
---
DDL for table: price_strategy_audit_record
CREATE TABLE `price_strategy_audit_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `audit_id` bigint(20) unsigned NOT NULL COMMENT 'FK-price_strategy_audit.id',
  `strategy_id` int(11) NOT NULL COMMENT 'FK-price_strategy.id',
  `old_price` decimal(10,2) DEFAULT NULL COMMENT '审核前价格',
  `new_price` decimal(10,2) DEFAULT NULL COMMENT '审核后价格',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_strategy` (`strategy_id`) USING BTREE,
  KEY `idx_audit` (`audit_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6607 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='价格信息审批明细表'
---
DDL for table: process_config
CREATE TABLE `process_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `process_code` varchar(125) DEFAULT NULL COMMENT '审批流鲜沐code',
  `process_type` int(11) DEFAULT NULL COMMENT '业务类型',
  `ding_code` varchar(125) DEFAULT NULL COMMENT '审批流钉钉code',
  `feishu_code` varchar(125) DEFAULT NULL COMMENT '审批流飞书code',
  `access_platform_type` varchar(64) DEFAULT NULL COMMENT '当前接入平台类型',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人',
  `create_user_name` varchar(125) DEFAULT NULL COMMENT '创建人',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人',
  `update_user_name` varchar(125) DEFAULT NULL COMMENT '更新人',
  `remark` varchar(125) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `code_index` (`process_code`),
  KEY `type_index` (`process_type`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='审批流配置表'
---
DDL for table: product_label
CREATE TABLE `product_label` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `label_field` varchar(50) NOT NULL COMMENT '标签字段',
  `label_name` varchar(50) DEFAULT NULL COMMENT '标签名称',
  `creat_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8 COMMENT='SKU标签'
---
DDL for table: product_label_value
CREATE TABLE `product_label_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `label_id` varchar(50) DEFAULT NULL COMMENT '标签字段ID',
  `label_value` tinyint(4) DEFAULT NULL COMMENT '标签值：0 关闭 ， 1 开启',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_sku` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=47836 DEFAULT CHARSET=utf8 COMMENT='SKU标签映射表'
---
DDL for table: product_price_adjustment
CREATE TABLE `product_price_adjustment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sku` varchar(30) DEFAULT NULL,
  `pd_name` varchar(255) DEFAULT NULL COMMENT 'SPU名称',
  `weight` varchar(255) NOT NULL COMMENT '规格',
  `up_time` datetime DEFAULT NULL COMMENT '生效时间',
  `reason` varchar(500) DEFAULT NULL COMMENT '理由',
  `status` int(2) DEFAULT NULL COMMENT '状态，1待处理，2待审批，3待执行，4已执行，5不调整，6超时未审批，7审核不通过',
  `create_admin_name` varchar(50) DEFAULT NULL COMMENT '发起人name，系统记为自动',
  `audit_admin_name` varchar(50) DEFAULT NULL COMMENT '审核人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21568 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='调价单数据'
---
DDL for table: product_price_adjustment_detail
CREATE TABLE `product_price_adjustment_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `adjustment_id` bigint(20) NOT NULL COMMENT '调价单主键id',
  `sku` varchar(30) DEFAULT NULL,
  `area_no` int(11) NOT NULL COMMENT '城市编号',
  `ladder_price` varchar(500) DEFAULT NULL COMMENT '阶梯价',
  `price` decimal(12,4) DEFAULT NULL COMMENT '售价',
  `interest_rate` decimal(12,4) DEFAULT NULL COMMENT '毛利率',
  `auto_flag` int(11) DEFAULT NULL COMMENT '自动调价标识',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_adjustment_id_area_no_sku` (`adjustment_id`,`sku`,`area_no`) USING BTREE,
  KEY `idx_sku_area_no_adjustment_id` (`sku`,`area_no`,`adjustment_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22029 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='调价单详情数据'
---
DDL for table: product_price_adjustment_record
CREATE TABLE `product_price_adjustment_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `price` decimal(12,4) DEFAULT NULL COMMENT '新售卖价',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT '原售卖价',
  `ladder_price` varchar(500) DEFAULT NULL,
  `original_ladder_price` varchar(500) DEFAULT NULL,
  `interest_rate_new` decimal(12,4) DEFAULT NULL COMMENT '新毛利率',
  `interest_rate_old` decimal(12,4) DEFAULT NULL COMMENT '原毛利率',
  `auto_flag_new` tinyint(3) DEFAULT NULL COMMENT '新自动调价',
  `auto_flag_old` tinyint(3) DEFAULT NULL COMMENT '原自动调价',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku_area_no` (`sku`,`area_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18595 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='商品调价记录表'
---
DDL for table: product_sync_record
CREATE TABLE `product_sync_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pd_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `reason` varchar(255) NOT NULL COMMENT '失败原因',
  `retry_flag` tinyint(4) DEFAULT '1' COMMENT '删除标识 0、不重试 1、需要重试',
  `api_type` varchar(30) NOT NULL COMMENT 'api类型',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_sku` (`sku`),
  KEY `index_pd_id` (`pd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55995 DEFAULT CHARSET=utf8 COMMENT='同步商品失败记录'
---
DDL for table: products
CREATE TABLE `products` (
  `pd_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL COMMENT '分类',
  `brand_id` int(11) DEFAULT NULL COMMENT '品牌',
  `pd_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `pddetail` text COMMENT '商品描述',
  `detail_picture` varchar(1255) DEFAULT NULL COMMENT '详情图片',
  `view_count` bigint(30) DEFAULT NULL COMMENT '浏览次数',
  `priority` int(11) DEFAULT '1',
  `after_sale_time` int(3) DEFAULT '38' COMMENT '从截单开始的售后时间？？',
  `after_sale_type` varchar(50) DEFAULT NULL COMMENT '售后类型',
  `after_sale_unit` varchar(5) DEFAULT NULL COMMENT '售后单位',
  `create_time` datetime DEFAULT NULL COMMENT '上架时间',
  `expire_time` datetime DEFAULT NULL COMMENT '下架时间',
  `outdated` int(11) NOT NULL DEFAULT '0' COMMENT 'SPU生命周期：-1、上新中 0、有效 1、已删除',
  `storage_location` tinyint(2) DEFAULT '0' COMMENT '仓储区域',
  `pd_no` varchar(30) DEFAULT NULL,
  `origin` int(11) DEFAULT NULL,
  `storage_method` varchar(255) DEFAULT NULL,
  `slogan` varchar(36) DEFAULT NULL,
  `other_slogan` varchar(500) DEFAULT NULL,
  `picture_path` varchar(1255) DEFAULT NULL,
  `refund_type` varchar(255) DEFAULT NULL COMMENT '退款原因',
  `quality_time` int(10) NOT NULL DEFAULT '0' COMMENT '保质期时长',
  `quality_time_unit` varchar(30) NOT NULL DEFAULT 'day' COMMENT '保质期时长单位',
  `warn_time` int(10) DEFAULT NULL COMMENT '临保预警时长',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `create_type` int(11) DEFAULT '0' COMMENT '上新类型：0、平台 1、大客户',
  `real_name` varchar(50) DEFAULT NULL COMMENT '商品实物名',
  `create_remark` varchar(500) DEFAULT NULL COMMENT '上新备注',
  `audit_status` int(11) DEFAULT '1' COMMENT '上新审核状态：0、待上新 1、上新成功 2、上新失败',
  `audit_time` datetime DEFAULT NULL COMMENT '上新审核时间',
  `product_introduction` varchar(200) DEFAULT NULL COMMENT '商品介绍信息',
  `auditor` int(11) DEFAULT NULL COMMENT '操作人adminId',
  `quality_time_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '保质期时长类型, 0 固定时长, 1 到期时间',
  PRIMARY KEY (`pd_id`) USING BTREE,
  KEY `products_to_category_fk` (`category_id`) USING BTREE,
  KEY `products_to_brand_fk` (`brand_id`) USING BTREE,
  KEY `products_pdname_index` (`pd_name`) USING BTREE,
  CONSTRAINT `products_to_category_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21749 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品'
---
DDL for table: products_bak
CREATE TABLE `products_bak` (
  `pd_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL COMMENT '分类',
  `brand_id` int(11) DEFAULT NULL COMMENT '品牌',
  `pd_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `pddetail` text COMMENT '商品描述',
  `detail_picture` varchar(1255) DEFAULT NULL COMMENT '详情图片',
  `view_count` bigint(30) DEFAULT NULL COMMENT '浏览次数',
  `priority` int(11) DEFAULT '1',
  `after_sale_time` int(3) DEFAULT '38' COMMENT '从截单开始的售后时间？？',
  `after_sale_type` varchar(50) DEFAULT NULL COMMENT '售后类型',
  `after_sale_unit` varchar(5) DEFAULT NULL COMMENT '售后单位',
  `create_time` datetime DEFAULT NULL COMMENT '上架时间',
  `expire_time` datetime DEFAULT NULL COMMENT '下架时间',
  `outdated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记位-过时的spu  1代表过时，商品被删除',
  `storage_location` tinyint(2) DEFAULT '0' COMMENT '仓储区域',
  `pd_no` varchar(30) DEFAULT NULL,
  `origin` int(11) DEFAULT NULL,
  `storage_method` varchar(255) DEFAULT NULL,
  `slogan` varchar(36) DEFAULT NULL,
  `other_slogan` varchar(500) DEFAULT NULL,
  `picture_path` varchar(1255) DEFAULT NULL,
  `refund_type` varchar(255) DEFAULT NULL COMMENT '退款原因',
  `quality_time` int(10) NOT NULL DEFAULT '0' COMMENT '保质期时长',
  `quality_time_unit` varchar(30) NOT NULL DEFAULT 'day' COMMENT '保质期时长单位',
  `warn_time` int(10) DEFAULT NULL COMMENT '临保预警时长',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`pd_id`) USING BTREE,
  KEY `products_brand_fk` (`brand_id`) USING BTREE,
  KEY `products_category_fk` (`category_id`) USING BTREE,
  CONSTRAINT `products_brand_fk` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`),
  CONSTRAINT `products_category_fk` FOREIGN KEY (`category_id`) REFERENCES `category_bak` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品'
---
DDL for table: products_property
CREATE TABLE `products_property` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `name` varchar(50) DEFAULT NULL COMMENT '属性名',
  `type` int(11) DEFAULT NULL COMMENT '属性类型：0、关键属性 1、销售属性',
  `format_type` int(11) DEFAULT NULL COMMENT '格式类型：0、复合型 1、数字+单位 2、选择字符串 3、自定义字符串',
  `format_str` varchar(255) DEFAULT NULL COMMENT '格式，根据类型不同处理，eg：\r\n                            0/1:["g","kg"]\r\n                            2:["越南","海南","台湾"]',
  `status` int(11) DEFAULT NULL COMMENT '状态：0、失效 1、有效',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品属性'
---
DDL for table: products_property_mapping
CREATE TABLE `products_property_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `type` int(11) DEFAULT NULL COMMENT '映射类型：0、类目 1、spu',
  `mapping_id` int(11) DEFAULT NULL COMMENT '类目id/pd id',
  `products_property_id` int(11) DEFAULT NULL COMMENT '属性id',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `property_mapping_type_mapping` (`type`,`mapping_id`,`products_property_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50933 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品属性映射'
---
DDL for table: products_property_mapping_bak
CREATE TABLE `products_property_mapping_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `type` int(11) DEFAULT NULL COMMENT '映射类型：0、类目 1、spu',
  `mapping_id` int(11) DEFAULT NULL COMMENT '类目id/pd id',
  `products_property_id` int(11) DEFAULT NULL COMMENT '属性id',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `property_mapping_type_mapping` (`type`,`mapping_id`,`products_property_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品属性映射'
---
DDL for table: products_property_value
CREATE TABLE `products_property_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `pd_id` int(11) DEFAULT NULL COMMENT 'pd_id',
  `sku` varchar(33) DEFAULT NULL COMMENT 'sku',
  `products_property_id` int(11) DEFAULT NULL COMMENT '属性id',
  `products_property_value` varchar(50) DEFAULT NULL COMMENT '属性值',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `products_property_value_index` (`pd_id`,`sku`,`products_property_id`) USING BTREE,
  KEY `products_property_value_sku_index` (`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104527 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品属性值'
---
DDL for table: purchase_accounting
CREATE TABLE `purchase_accounting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `examine_time` datetime DEFAULT NULL COMMENT '审核时间',
  `approval_time` datetime DEFAULT NULL COMMENT '审批时间',
  `create_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `examine_id` int(11) DEFAULT NULL COMMENT '审核人id',
  `approval_id` int(11) DEFAULT NULL COMMENT '审批人id',
  `examine_remark` varchar(255) DEFAULT NULL COMMENT '审核备注',
  `approval_remark` varchar(255) DEFAULT NULL COMMENT '审批备注',
  `examine_name` varchar(50) DEFAULT NULL COMMENT '审核人名称',
  `approval_name` varchar(50) DEFAULT NULL COMMENT '审批人名称',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '核算单总金额',
  `create_amount` decimal(10,2) DEFAULT NULL COMMENT '发起核算单金额',
  `payee_name` varchar(50) DEFAULT NULL COMMENT '收款人',
  `invoice_url` varchar(500) DEFAULT NULL COMMENT '发票信息',
  `status` int(11) DEFAULT NULL COMMENT '申请状态 0 待审核,1 待审批, 2 申请成功, 3 申请拒绝',
  `payee_id` int(11) DEFAULT NULL COMMENT '收款人id',
  `create_remark` varchar(50) DEFAULT NULL COMMENT '创建备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='核算单申请表'
---
DDL for table: purchase_advanced_order
CREATE TABLE `purchase_advanced_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id，也为预付单号',
  `type` int(11) DEFAULT NULL COMMENT '是否关联采购单 1、关联 2、不关联',
  `total_amount` decimal(10,2) DEFAULT '0.00' COMMENT '付款金额',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT '' COMMENT '供应商名称',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付方式 1、银行卡 2、现金',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pd_type` int(11) DEFAULT NULL COMMENT '1 生鲜 2 品牌',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `status` int(11) DEFAULT NULL COMMENT '预付单状态 1、待审核（账单审核） 4、付款审核中 5、待付款 6、已付款 7、作废',
  `supplier_account_id` int(11) DEFAULT NULL COMMENT '供应商账户id',
  `temporary_remark` varchar(200) DEFAULT '' COMMENT '临时备注',
  `state` int(11) DEFAULT NULL COMMENT '是否有关联的对账单 0 是 1 否',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_reason` int(11) DEFAULT NULL COMMENT '作废原因：0：预付审核失败 1：撤回申请 2：：付款审核失败 3:财务付款取消',
  `current_processor` varchar(50) DEFAULT NULL COMMENT '当前状态处理人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2893 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预付单表'
---
DDL for table: purchase_binding_prepayment
CREATE TABLE `purchase_binding_prepayment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `purchase_advanced_order_id` bigint(20) DEFAULT NULL COMMENT '预付单id',
  `advance_amount` decimal(10,2) DEFAULT '0.00' COMMENT '本次预付金额',
  `purchase_no` varchar(30) DEFAULT '' COMMENT '采购单号',
  `binding_status` int(11) DEFAULT NULL COMMENT '绑定状态 1、未绑定 2、绑定 3、解绑',
  `creator` varchar(50) DEFAULT '' COMMENT '发起人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_purchase_advanced_order_id` (`purchase_advanced_order_id`) USING BTREE,
  KEY `idx_purchase_no` (`purchase_no`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4060 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购绑定预付款表'
---
DDL for table: purchase_invoice
CREATE TABLE `purchase_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) DEFAULT NULL COMMENT '供货商id',
  `billing_date` date DEFAULT NULL COMMENT '开票日期',
  `invoice_code` varchar(50) DEFAULT NULL COMMENT '发票代码',
  `invoice_number` varchar(50) DEFAULT NULL COMMENT '发票号码',
  `excluding_tax` decimal(10,2) DEFAULT NULL COMMENT '不含税金额',
  `included_tax` decimal(10,2) DEFAULT NULL COMMENT '含税金额',
  `tax_amount` decimal(10,2) DEFAULT NULL COMMENT '税额',
  `tax_rate` int(11) DEFAULT NULL COMMENT '平均税率',
  `invoice_type` int(11) DEFAULT NULL COMMENT '发票类型：0 普票；1 专票',
  `invoice_form` int(11) DEFAULT NULL COMMENT '发票形式：0 电子；1 纸质',
  `type` int(11) DEFAULT NULL COMMENT '发票销售方类型： 0、企业 1、个人',
  `invoice_attachment` int(11) DEFAULT NULL COMMENT '有无发票附件：0 有；1 无',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `delete_status` int(11) DEFAULT NULL COMMENT '删除状态：0 有效，1 失效',
  `purchaser` varchar(15) DEFAULT NULL COMMENT '采购负责人(可能为供应商管理人)',
  `supplier_name` varchar(50) DEFAULT NULL COMMENT '发票销售方',
  `actual_tax_rate` decimal(10,2) DEFAULT '0.00' COMMENT '实际抵扣税率',
  `actual_tax_amount` decimal(10,2) DEFAULT '0.00' COMMENT '实际可抵扣税额',
  `tax_number` varchar(50) DEFAULT NULL COMMENT '税号',
  `invoice_type_face` int(11) DEFAULT NULL COMMENT '发票字体颜色 1、红字 2、蓝字',
  `wallets_id` bigint(20) DEFAULT NULL COMMENT '票夹id/为空则没被匹配',
  `creator_admin_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `invoice_updater` int(11) DEFAULT '2' COMMENT '发票最后修改角色 1、供应商 2、采购',
  `invoice_commit` int(11) DEFAULT '2' COMMENT '发票添加角色 1、供应商 2、采购3、财务在待匹配页面批量导入',
  `invoice_supplier_type` int(11) DEFAULT '0' COMMENT '合作方类型 0、供应商 1、承运商',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tax_number` (`tax_number`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2469 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购发票表'
---
DDL for table: purchase_invoice_analysis
CREATE TABLE `purchase_invoice_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '当前操作者admin_id',
  `purchase_invoice_id` int(11) DEFAULT NULL COMMENT '采购发票表id',
  `analysis_type` int(11) DEFAULT NULL COMMENT '解析状态: 0 成功；1 失败',
  `billing_date` varchar(50) DEFAULT NULL COMMENT '开票日期',
  `invoice_code` varchar(50) DEFAULT NULL COMMENT '发票代码',
  `invoice_number` varchar(50) DEFAULT NULL COMMENT '发票号码',
  `excluding_tax` decimal(10,2) DEFAULT NULL COMMENT '不含税金额',
  `included_tax` decimal(10,2) DEFAULT NULL COMMENT '含税金额',
  `tax_amount` decimal(10,2) DEFAULT NULL COMMENT '税额',
  `tax_rate` int(11) DEFAULT NULL COMMENT '平均税率',
  `invoice_type` int(11) DEFAULT NULL COMMENT '发票类型：0 普票；1 专票',
  `invoice_form` int(11) DEFAULT NULL COMMENT '发票形式：0 电子；1 纸质',
  `supplier_name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `tax_number` varchar(20) DEFAULT NULL COMMENT '供应商工商信息（税号字段/身份证号）',
  `purchaser` varchar(15) DEFAULT NULL COMMENT '采购负责人(可能为供应商管理人)',
  `fail_reason` varchar(255) DEFAULT NULL COMMENT '解析失败原因',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `type` int(11) DEFAULT NULL COMMENT '发票销售方类型： 0、企业 1、个人',
  `delete_status` int(11) DEFAULT NULL COMMENT '删除状态：0 有效，1 失效',
  `invoice_type_face` int(11) DEFAULT NULL COMMENT '发票字体颜色 1、红字 2、蓝字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购发票上传数据解析表'
---
DDL for table: purchase_invoice_file
CREATE TABLE `purchase_invoice_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_invoice_id` int(11) DEFAULT NULL COMMENT '采购发票表id',
  `file_address` varchar(100) DEFAULT NULL COMMENT '文件地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `delete_status` int(11) DEFAULT NULL COMMENT '删除状态：0 有效，1 失效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2123341921 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购发票文件地址表'
---
DDL for table: purchase_invoice_log
CREATE TABLE `purchase_invoice_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_invoice_id` int(11) DEFAULT NULL COMMENT '采购发票表id',
  `status` int(11) DEFAULT NULL COMMENT '状态：0 待提交，1 可匹配，2 匹配完成-待归档，3 已归档',
  `matching_schedule` varchar(50) DEFAULT NULL COMMENT '匹配进度',
  `state` int(11) DEFAULT NULL COMMENT '日志状态：待匹配 3， 可匹配 4， 匹配完成-待归档 5, 已归档 6； 0 记录当前操作 ，1 过期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2137174384 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购发票操作日志表'
---
DDL for table: purchase_invoice_time
CREATE TABLE `purchase_invoice_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_invoice_id` int(11) DEFAULT NULL COMMENT '采购发票表id',
  `actual_tax_rate` decimal(10,2) DEFAULT NULL COMMENT '实际抵扣税率',
  `actual_tax_amount` decimal(10,2) DEFAULT NULL COMMENT '实际可抵扣税额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `file_time` varchar(50) DEFAULT NULL COMMENT '归档月份',
  `remakes` varchar(150) DEFAULT NULL COMMENT '备注',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `delete_status` int(11) DEFAULT NULL COMMENT '删除状态：0 有效，1 失效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购发票状态时间表'
---
DDL for table: purchase_list
CREATE TABLE `purchase_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `product_id` bigint(20) NOT NULL COMMENT '商品id',
  `group_id` bigint(20) unsigned NOT NULL COMMENT '进货单分组id',
  `m_id` bigint(20) NOT NULL COMMENT '店铺id',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0普通商品,1离线商品',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '加入进货单时sku价格',
  `activity_price` decimal(10,2) unsigned DEFAULT NULL COMMENT '加入进货单时sku活动价格',
  `purchase_list_sort` int(11) NOT NULL DEFAULT '0' COMMENT '进货单排序',
  `top_fix` tinyint(4) NOT NULL DEFAULT '0' COMMENT '置顶',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1删除',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_m_group` (`m_id`,`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=672 DEFAULT CHARSET=utf8 COMMENT='进货单'
---
DDL for table: purchase_list_group
CREATE TABLE `purchase_list_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `m_id` bigint(20) NOT NULL COMMENT '店铺id',
  `group_name` varchar(20) NOT NULL COMMENT '分组名称',
  `group_sort` tinyint(4) NOT NULL DEFAULT '0' COMMENT '分组排序',
  `group_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0默认分组',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1删除',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_account` (`m_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='进货单分组管理'
---
DDL for table: purchase_plan_cost_change
CREATE TABLE `purchase_plan_cost_change` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `purchase_plan_id` int(11) DEFAULT NULL COMMENT '采购计划id',
  `old_total_cost` decimal(10,4) DEFAULT NULL COMMENT '原总成本',
  `new_total_cost` decimal(10,4) DEFAULT NULL COMMENT '新总成本',
  `status` int(11) DEFAULT NULL COMMENT '审核状态 0、待审核 1、审核失败 2、审核通过',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `auditor` varchar(50) DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购计划成本变更'
---
DDL for table: purchase_prepayment_pool
CREATE TABLE `purchase_prepayment_pool` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT '' COMMENT '供应商名称',
  `total_amount` decimal(10,2) DEFAULT '0.00' COMMENT '预付池总金额',
  `binding_amount` decimal(10,2) DEFAULT '0.00' COMMENT '绑定预付金额',
  `unbound_amount` decimal(10,2) DEFAULT '0.00' COMMENT '未绑定预付金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预付池'
---
DDL for table: purchase_prepayment_pool_record
CREATE TABLE `purchase_prepayment_pool_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT '' COMMENT '供应商名称',
  `bill_id` bigint(20) DEFAULT NULL COMMENT '来源单据id',
  `type` int(11) DEFAULT NULL COMMENT '来源类型 1、预付单 2、对账单 3、退款单 4、退款核销单',
  `amount` decimal(10,2) DEFAULT '0.00' COMMENT '金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE,
  KEY `idx_bill_id` (`bill_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2418 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预付池记录表'
---
DDL for table: purchase_product_warehouse_config
CREATE TABLE `purchase_product_warehouse_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pd_id` bigint(20) NOT NULL COMMENT '商品编号spu_id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `purchase_type` int(11) NOT NULL COMMENT '采购类型  0:非直采 1: 直采 ',
  `admin_id` int(11) DEFAULT NULL COMMENT '负责人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `admin_name` varchar(32) DEFAULT NULL COMMENT '负责人name',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `planner_id` int(11) DEFAULT NULL COMMENT '计划员ID',
  `planner_name` varchar(100) DEFAULT NULL COMMENT '计划员名称',
  `safe_water_level` int(11) DEFAULT NULL COMMENT '安全水位',
  `backlog_day` int(11) DEFAULT NULL COMMENT '备货天数',
  `pd_no` varchar(50) DEFAULT NULL COMMENT '商品编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_pd_warehouse` (`pd_id`,`warehouse_no`) USING BTREE,
  KEY `idx_warehouse_no` (`warehouse_no`) USING BTREE,
  KEY `idx_admin` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1419723 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='品仓配置'
---
DDL for table: purchase_product_warehouse_supplier_config
CREATE TABLE `purchase_product_warehouse_supplier_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pd_id` bigint(20) NOT NULL COMMENT '商品编号spu_id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `complete_flag` int(11) NOT NULL COMMENT '配置是否完成标记0:未完成 1:已完成',
  `primary_flag` int(11) NOT NULL COMMENT '首选标记 0: 否 1: 是',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_pd_warehouse` (`pd_id`,`warehouse_no`) USING BTREE,
  KEY `idx_warehouse_no` (`warehouse_no`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6187 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='品仓-供应商配置(该表已废弃)'
---
DDL for table: purchase_replenishment_config_temp
CREATE TABLE `purchase_replenishment_config_temp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `pd_id` int(11) DEFAULT NULL COMMENT '产品id',
  `pd_name` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `purchase_name` varchar(100) DEFAULT NULL COMMENT '采购人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8 COMMENT='采购补货临时表'
---
DDL for table: purchase_replenishment_order
CREATE TABLE `purchase_replenishment_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pd_id` bigint(20) NOT NULL COMMENT '商品编号',
  `pd_name` varchar(32) NOT NULL COMMENT '商品名称',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(50) DEFAULT NULL COMMENT '仓库名称',
  `sku_id` varchar(30) NOT NULL COMMENT 'SKUID',
  `view_date` datetime NOT NULL COMMENT '日期',
  `order_status` int(11) NOT NULL COMMENT '补货单状态1:待确认,2:已发起,3:已关闭,4:自动关闭',
  `replenishment_type` int(11) NOT NULL COMMENT '补货单类型1:常规,2:临时,3:紧急',
  `activity_flag` int(11) NOT NULL DEFAULT '0' COMMENT '活动标签,0:否.1:是,生成补货单时是否特价配置中活动',
  `current_enabled_quantity` int(11) DEFAULT NULL COMMENT '当日可用库存',
  `current_on_way_quantity` int(11) DEFAULT NULL COMMENT '当日采购在途',
  `current_transfer_in_quantity` int(11) DEFAULT NULL COMMENT '当日调拨在途',
  `sales_history_quantity` int(11) DEFAULT NULL COMMENT '7日销售量',
  `transfer_out_history_quantity` int(11) DEFAULT NULL COMMENT '7日调拨出库量',
  `pre_day` int(11) DEFAULT NULL COMMENT '提前天数',
  `backlog_day` int(11) DEFAULT NULL COMMENT '备货天数',
  `safe_water_level` int(11) DEFAULT NULL COMMENT '安全水位',
  `advice_replenishment_quantity` int(11) DEFAULT NULL COMMENT '建议补货量',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `admin_id` int(11) NOT NULL COMMENT '负责人id',
  `final_replenishment_quantity` int(11) DEFAULT NULL COMMENT '最终补货量',
  `final_supplier_id` int(11) NOT NULL COMMENT '最终供应商ID',
  `final_supplier_name` varchar(64) NOT NULL COMMENT '最终供应商名称姓名',
  `final_admin_id` int(11) NOT NULL COMMENT '最终负责人id',
  `final_admin_name` varchar(32) NOT NULL COMMENT '最终负责人姓名',
  `relation_type` int(11) DEFAULT NULL COMMENT '关联操作类型：1:采购单',
  `relation_id` varchar(30) DEFAULT NULL COMMENT '关联操作id',
  `create_date` int(11) NOT NULL COMMENT '创建日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `del_flag` int(11) NOT NULL COMMENT '删除标记 0:未删除 1:已删除',
  `source` tinyint(4) DEFAULT '0' COMMENT '0:缺货提醒 1:补货计划',
  `replenishment_plan_purchase_task_id` bigint(20) DEFAULT NULL COMMENT '补货任务id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_date` (`create_date`,`view_date`) USING BTREE,
  KEY `idx_warehouse_no` (`warehouse_no`) USING BTREE,
  KEY `idx_order_status` (`order_status`) USING BTREE,
  KEY `idx_sku_id` (`sku_id`) USING BTREE,
  KEY `idx_pd_name` (`pd_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=355 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购-补货单'
---
DDL for table: purchase_replenishment_order_reason
CREATE TABLE `purchase_replenishment_order_reason` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `order_id` bigint(20) NOT NULL COMMENT '单号',
  `reason_code` int(11) NOT NULL COMMENT '关闭原因编码',
  `reason_remark` varchar(64) NOT NULL COMMENT '关闭原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `updater` int(11) NOT NULL COMMENT '修改人',
  `creator` int(11) NOT NULL COMMENT '创建人',
  `del_flag` int(11) NOT NULL COMMENT '删除标记 0:未删除 1:已删除',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50689 DEFAULT CHARSET=utf8 COMMENT='补货单关闭原因'
---
DDL for table: purchase_supplier_contract
CREATE TABLE `purchase_supplier_contract` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `file_url` varchar(200) NOT NULL DEFAULT '' COMMENT '材料七牛云url地址',
  `status` tinyint(4) DEFAULT NULL COMMENT '0审核中，1待上传合同，2已关闭，3已完成',
  `valid` tinyint(4) DEFAULT NULL COMMENT '0失效1生效',
  `settle_form` tinyint(4) DEFAULT NULL COMMENT '0、账期结算 1、备用金结算 2、公对公现结 3、私对私现结',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期（永久为null）',
  `settle_type` tinyint(4) DEFAULT NULL COMMENT '结算类型 0、月结 1、自定义',
  `custom_start_date` date DEFAULT NULL COMMENT '自定义开启日期',
  `custom_cycle` int(11) DEFAULT NULL COMMENT '自定义周期天数',
  `credit_days` int(11) DEFAULT NULL COMMENT '账期天数',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(45) DEFAULT NULL COMMENT '最后修改人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4462 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='供应商相关合同'
---
DDL for table: purchase_supplier_grade
CREATE TABLE `purchase_supplier_grade` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `module_type` int(11) NOT NULL DEFAULT '1' COMMENT '模板类型1：鲜果2：标品',
  `total_score` int(11) NOT NULL DEFAULT '0' COMMENT '总分',
  `score_json` text COMMENT '得分json，序号，得分，备注',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(45) DEFAULT NULL COMMENT '最后修改人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4830 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='供应商得分表'
---
DDL for table: purchase_supplier_payment
CREATE TABLE `purchase_supplier_payment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT '' COMMENT '供应商名称',
  `purchase_no` varchar(30) DEFAULT '' COMMENT '采购单号',
  `advance_amount` decimal(10,2) DEFAULT '0.00' COMMENT '预付金额',
  `payment_amount` decimal(10,2) DEFAULT '0.00' COMMENT '付款金额',
  `write_off_amount` decimal(10,2) DEFAULT '0.00' COMMENT '核销金额',
  `adjust_amount` decimal(10,2) DEFAULT '0.00' COMMENT '调整金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_supplier_id` (`supplier_id`) USING BTREE,
  KEY `idx_purchase_no` (`purchase_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1800 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购单供应商付款表'
---
DDL for table: purchase_supplier_related_file
CREATE TABLE `purchase_supplier_related_file` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `file_type` int(11) NOT NULL DEFAULT '1' COMMENT '材料类型：1营业执照2生产许可证3经营许可证4开户许可证5身份证',
  `file_url` varchar(200) NOT NULL DEFAULT '' COMMENT '材料七牛云 url地址',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期（永久为null）',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(45) DEFAULT NULL COMMENT '最后修改人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5246 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='供应商相关文件表'
---
DDL for table: purchase_supplier_replenishment_config
CREATE TABLE `purchase_supplier_replenishment_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pd_id` bigint(20) NOT NULL COMMENT '商品编号spu_id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `replenishment_mode` int(11) NOT NULL DEFAULT '1' COMMENT '补货模式 1:不定期不定量,2:定期不定量,3:不定期定量,4:定期定量',
  `pre_day` int(11) DEFAULT NULL COMMENT '提前天数',
  `backlog_day` int(11) DEFAULT NULL COMMENT '备货天数',
  `order_date` int(11) DEFAULT NULL COMMENT '订货时间周一到周日,1~7',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `safe_water_level` int(11) DEFAULT NULL COMMENT '安全水位',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_config_flag` (`pd_id`,`warehouse_no`,`supplier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8597 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='品仓-供应商补货信息配置(该表已废弃)'
---
DDL for table: purchases
CREATE TABLE `purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'purchase',
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `purchase_time` datetime DEFAULT NULL COMMENT '采购时间',
  `supplier` varchar(50) DEFAULT NULL,
  `purchase_place` varchar(255) DEFAULT NULL COMMENT '采购地点',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `receive_place` varchar(255) DEFAULT NULL COMMENT '收货地点',
  `purchaser` varchar(15) DEFAULT NULL COMMENT '采购负责人',
  `receiver` varchar(15) DEFAULT NULL COMMENT '收货负责人',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `flight_number` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT '0' COMMENT '采购单状态： -1、作废 0、计划制定 1、已发布2、待供应商确认',
  `ds` tinyint(1) DEFAULT '0' COMMENT '数据是否同步至统冠数据库，0未同步1，已同步',
  `area_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `delivery_type` int(2) DEFAULT '1' COMMENT ' 1送货到库，2自提',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `delivery_no` varchar(30) DEFAULT NULL COMMENT '运输单号',
  `logistics_payment_type` int(11) DEFAULT '0' COMMENT '物流支付方式 1、我方付款 2、供应商预付 3、供应商包邮',
  `logistics_cost` decimal(10,2) DEFAULT NULL COMMENT '物流费用',
  `logistics_settle_flag` int(11) DEFAULT '0' COMMENT '物流费结算标识 0、可结算 1、不可结算（结算中或已完成）',
  `purchases_type` tinyint(4) DEFAULT NULL COMMENT '0表示正常采购，1表示直发采购',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `matching_progress` varchar(50) DEFAULT NULL COMMENT '发票匹配进展',
  `status` int(11) DEFAULT NULL COMMENT '采购单状态(发票)： 0、未归档 1、已归档',
  `origin_no` varchar(30) DEFAULT NULL COMMENT '拆单原单号',
  `is_arrange` tinyint(4) DEFAULT '0' COMMENT '可预约标识：0 不可预约1 可预约',
  `process_state` tinyint(4) DEFAULT '0' COMMENT '入库进度：0、待入库 1、部分入库 2、已入库',
  `finish_time` datetime DEFAULT NULL COMMENT '归档时间',
  `arrange_time` date DEFAULT NULL COMMENT '计划制定状态下预约入库时间',
  `arrange_remark` varchar(100) DEFAULT NULL COMMENT '计划制定状态下预约备注',
  `operator_type` tinyint(4) DEFAULT NULL COMMENT '供应商确认状态0未确认1已确认2已拒绝',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作人id',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `source` varchar(255) NOT NULL DEFAULT 'xianmu' COMMENT '来源:xianmu,saas',
  `tenant_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '租户id',
  `creator_name` varchar(255) DEFAULT NULL COMMENT '录入人名',
  `delivery_time` datetime DEFAULT NULL COMMENT '物流用车时间',
  `tms_dist_site_id` bigint(20) DEFAULT NULL COMMENT '物流用车发货地址',
  `business_type` tinyint(4) DEFAULT NULL COMMENT '业务类型：1 代销不入库类型',
  `take_time` datetime DEFAULT NULL COMMENT '提货时间',
  `pso_no` varchar(255) DEFAULT NULL COMMENT 'ofc采购供应单号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `no_index` (`purchase_no`) USING BTREE,
  KEY `area_no_index` (`area_no`) USING BTREE,
  KEY `time_index` (`purchase_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24748 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购单'
---
DDL for table: purchases_account_plan
CREATE TABLE `purchases_account_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL COMMENT '核算单ID',
  `plan_id` int(11) DEFAULT NULL COMMENT '采购单项ID且采购单项中的origin_id为 null',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 关联采购单项 1 关联采购单号(物流信息)',
  `purchases_no` varchar(50) DEFAULT NULL COMMENT '采购单号',
  `back_quantity` int(11) DEFAULT NULL COMMENT '退款单退回数量',
  `back_cost` decimal(10,2) DEFAULT NULL COMMENT '退回金额',
  `accounting_quantity` int(11) DEFAULT NULL COMMENT '核算数量',
  `accounting_cost` decimal(10,2) DEFAULT NULL COMMENT '核算金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: purchases_back
CREATE TABLE `purchases_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchases_back_no` varchar(30) DEFAULT NULL COMMENT '退货单号',
  `store_no` int(11) DEFAULT NULL COMMENT '退货仓库',
  `admin_id` int(11) DEFAULT NULL COMMENT '管理员id',
  `status` int(11) DEFAULT '0' COMMENT '审核状态：0待审核、1审核失败、2审核成功',
  `expect_time` datetime DEFAULT NULL COMMENT '预计出库时间',
  `add_time` datetime DEFAULT NULL COMMENT '发起时间',
  `remark` varchar(50) DEFAULT NULL,
  `type` int(11) DEFAULT '1' COMMENT '采购退货类型：0、未入库采购退货 1、已入库采购退货',
  `auditor` varchar(50) DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `source` varchar(255) NOT NULL DEFAULT 'xianmu' COMMENT '来源:xianmu,saas',
  `tenant_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '租户id',
  `admin_name` varchar(255) DEFAULT NULL COMMENT '录入人名',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_back_no` (`purchases_back_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5647 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购退货'
---
DDL for table: purchases_back_detail
CREATE TABLE `purchases_back_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchases_back_no` varchar(30) DEFAULT NULL COMMENT '退货单号',
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `sku` varchar(36) DEFAULT NULL,
  `area_no` int(11) DEFAULT NULL,
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `cost` decimal(10,2) DEFAULT '0.00' COMMENT '单件成本',
  `out_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '退货数量',
  `total_cost` decimal(10,2) DEFAULT NULL COMMENT '退货总金额',
  `actual_out_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实际退货数量',
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `type` int(11) DEFAULT NULL COMMENT '0 未到货退订 1 已入库退货',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purchases_back_detail_batch_index` (`batch`,`sku`,`quality_date`) USING BTREE,
  KEY `purchases_back_detail_no_index` (`purchases_back_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6567 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购退货详情'
---
DDL for table: purchases_config
CREATE TABLE `purchases_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(2) NOT NULL DEFAULT '0' COMMENT '仓库类型',
  `area_no` int(10) DEFAULT NULL COMMENT '仓库编号',
  `area_manage_id` int(10) DEFAULT NULL COMMENT '仓库所属合伙人',
  `sku` varchar(20) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '当前sku状态：0正常、1采购预警',
  `safe_level` int(10) NOT NULL DEFAULT '0' COMMENT '安全水位',
  `lead_time` int(10) NOT NULL DEFAULT '0' COMMENT '采购提前期',
  `supplier_id` int(10) DEFAULT NULL COMMENT '常用供应商',
  `stock_rate` decimal(10,4) NOT NULL COMMENT '有货率',
  `cc_admin_id` varchar(45) DEFAULT NULL COMMENT '抄送人对应管理员Id',
  `addtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `cycle_time` int(11) DEFAULT NULL COMMENT '采购周期',
  `calc_quantity` int(11) DEFAULT '0' COMMENT '预测量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purchases_config_index` (`area_no`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80161 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购配置表'
---
DDL for table: purchases_imprest
CREATE TABLE `purchases_imprest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '备用金金额',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 生效 1 失效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='备用金'
---
DDL for table: purchases_imprest_record
CREATE TABLE `purchases_imprest_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) DEFAULT NULL COMMENT '变更类型名称',
  `origin_amount` decimal(10,2) DEFAULT NULL COMMENT '原金额',
  `new_amount` decimal(10,2) NOT NULL COMMENT '更改后金额',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 待审核 1 审核成功 2申请拒绝',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `examine_time` datetime DEFAULT NULL COMMENT '审核时间',
  `examine_id` int(11) DEFAULT NULL COMMENT '审核人id',
  `examine_name` varchar(50) DEFAULT NULL COMMENT '审核人名称',
  `imprest_id` int(11) DEFAULT NULL COMMENT '备用金额表id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '发起人名称',
  `create_id` int(11) DEFAULT NULL COMMENT '发起人id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='备用金更改表'
---
DDL for table: purchases_plan
CREATE TABLE `purchases_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `title` varchar(50) DEFAULT NULL COMMENT '商品标题',
  `specification` varchar(20) DEFAULT NULL COMMENT '规格',
  `sku` varchar(30) DEFAULT NULL COMMENT '产品编号',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '采购总价',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `pack` varchar(36) DEFAULT NULL COMMENT '箱包数，例：1箱5个',
  `unit` varchar(36) DEFAULT '件',
  `supplier` varchar(100) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `quality_date` date DEFAULT NULL,
  `check_report` varchar(100) DEFAULT NULL,
  `in_quantity` int(11) DEFAULT '0' COMMENT '实收数量',
  `in_price` decimal(10,2) DEFAULT '0.00' COMMENT '实际成本',
  `origin_id` int(11) DEFAULT NULL COMMENT '原采购条目id',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `market_price` decimal(10,2) DEFAULT NULL COMMENT '市场价',
  `settle_flag` int(11) DEFAULT '0' COMMENT '采购项结算标识 0、可结算 1、不可结算（结算中或已完成）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `plan_status` int(11) DEFAULT '1' COMMENT '0表示活动商品作废，1表示存在',
  `adv_quantity` int(11) DEFAULT '0',
  `ver_quantity` int(11) DEFAULT '0',
  `arrange_quantity` int(10) unsigned DEFAULT '0' COMMENT '可预约数量',
  `stock_task_id` int(11) DEFAULT NULL COMMENT '关联入库任务id',
  `price_type` tinyint(4) DEFAULT '0' COMMENT '价格类型：0指定价1报价单 2 询竞价',
  `latest_arrival_date` date DEFAULT NULL COMMENT '最晚到货日期',
  `tax_rate` decimal(10,2) DEFAULT NULL COMMENT '税率',
  `net_weight` decimal(10,2) DEFAULT NULL COMMENT '净重',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purchases_plan_suppiler_index` (`supplier_id`) USING BTREE,
  KEY `no_index` (`purchase_no`,`sku`,`production_date`) USING BTREE,
  KEY `idx_origin_id` (`origin_id`) USING BTREE,
  KEY `idx_origin_id_purchase_no` (`origin_id`,`purchase_no`),
  KEY `idx_sku` (`sku`,`purchase_no`)
) ENGINE=InnoDB AUTO_INCREMENT=259500 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购计划'
---
DDL for table: purview
CREATE TABLE `purview` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限Id',
  `name` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限对应资源(URL)',
  `description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `son_purview` varchar(200) DEFAULT NULL COMMENT '关联权限',
  `module` varchar(50) DEFAULT NULL COMMENT '所属模块',
  `menu_id` int(11) DEFAULT NULL COMMENT '所属菜单权限ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purview_parent_id_index` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=638 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表'
---
DDL for table: purview_back
CREATE TABLE `purview_back` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限Id',
  `name` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限对应资源(URL)',
  `description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `son_purview` varchar(200) DEFAULT NULL COMMENT '关联权限',
  `module` varchar(50) DEFAULT NULL COMMENT '所属模块',
  `menu_id` int(11) DEFAULT NULL COMMENT '所属菜单权限ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purview_parent_id_index` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表'
---
DDL for table: purview_copy
CREATE TABLE `purview_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限Id',
  `name` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限对应资源(URL)',
  `description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `son_purview` varchar(200) DEFAULT NULL COMMENT '关联权限',
  `module` varchar(50) DEFAULT NULL COMMENT '所属模块',
  `menu_id` int(11) DEFAULT NULL COMMENT '所属菜单权限ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purview_copy_parent_id_index` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=628 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表'
---
DDL for table: purview_pro
CREATE TABLE `purview_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限Id',
  `name` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限对应资源(URL)',
  `description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `son_purview` varchar(200) DEFAULT NULL COMMENT '关联权限',
  `module` varchar(50) DEFAULT NULL COMMENT '所属模块',
  `menu_id` int(11) DEFAULT NULL COMMENT '所属菜单权限ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `purview_parent_id_index` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=732 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台权限表'
---
DDL for table: push_merchant
CREATE TABLE `push_merchant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) DEFAULT NULL COMMENT '推送门店编码',
  `mark` int(11) DEFAULT NULL COMMENT '推送标识 0 失败 1 成功',
  `gmt_modified` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: push_orders
CREATE TABLE `push_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) DEFAULT NULL COMMENT '推送订单编号',
  `mark` int(11) DEFAULT '1' COMMENT '推送标识 0 失败 1 成功',
  `type` varchar(10) DEFAULT NULL COMMENT '推送类型 delivery 发货 receive 收货 return 退货 placeOrder 下订单',
  `gmt_modified` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: quantity_change_record
CREATE TABLE `quantity_change_record` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL,
  `sku` varchar(30) DEFAULT NULL,
  `recorder` varchar(30) DEFAULT NULL COMMENT '记录人',
  `new_quantity` int(11) DEFAULT NULL COMMENT '新仓库库存',
  `old_quantity` int(11) DEFAULT NULL COMMENT '原仓库库存',
  `new_online_quantity` int(11) DEFAULT NULL COMMENT '新虚拟库存',
  `old_online_quantity` int(11) DEFAULT NULL COMMENT '原虚拟库存',
  `new_lock_quantity` int(11) DEFAULT NULL COMMENT '新冻结库存',
  `old_lock_quantity` int(11) DEFAULT NULL COMMENT '原冻结库存',
  `new_sale_lock_quantity` int(11) DEFAULT NULL COMMENT '新销售冻结库存',
  `old_sale_lock_quantity` int(11) DEFAULT NULL COMMENT '原销售冻结库存',
  `new_road_quantity` int(11) DEFAULT NULL COMMENT '新在途库存',
  `old_road_quantity` int(11) DEFAULT NULL COMMENT '原在途库存',
  `new_safe_quantity` int(11) DEFAULT NULL COMMENT '新安全库存',
  `old_safe_quantity` int(11) DEFAULT NULL COMMENT '原安全库存',
  `new_reserve_use_quantity` int(11) DEFAULT '0' COMMENT '新预留库存使用数量',
  `old_reserve_use_quantity` int(11) DEFAULT '0' COMMENT '原预留库存使用数量',
  `new_change` int(11) DEFAULT NULL COMMENT '新虚拟变值',
  `old_change` int(11) DEFAULT NULL COMMENT '原虚拟变值',
  `type_name` varchar(20) DEFAULT NULL COMMENT '库存变动类型',
  `record_no` varchar(36) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL COMMENT '备注原因',
  `addtime` datetime DEFAULT NULL,
  `new_advance_quantity` int(11) DEFAULT '0' COMMENT '新采购预售库存',
  `old_advance_quantity` int(11) DEFAULT '0' COMMENT '原采购预售库存',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `quantity_change_record_store_sku_index` (`area_no`,`sku`,`addtime`) USING BTREE,
  KEY `n_record_no` (`record_no`),
  KEY `idx_area_no_addtime` (`area_no`,`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=622292 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='库存变动记录'
---
DDL for table: quantity_record
CREATE TABLE `quantity_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `recorder` varchar(20) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `store_no` int(11) DEFAULT NULL,
  `store_name` varchar(20) DEFAULT NULL,
  `sku` varchar(20) DEFAULT NULL,
  `old_quantity` int(11) DEFAULT NULL,
  `new_quantity` int(11) DEFAULT NULL,
  `type_name` varchar(50) DEFAULT NULL,
  `quantity_type` varchar(20) DEFAULT NULL,
  `record_no` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `quantity_record_store_sku_index` (`store_no`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=436770 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: quick_bi_report
CREATE TABLE `quick_bi_report` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `aliyun_id` varchar(64) NOT NULL COMMENT '账号所属的阿里云账号id',
  `page_id` varchar(64) NOT NULL COMMENT '报表的id',
  `remark` varchar(64) DEFAULT NULL COMMENT '备注',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_page` (`page_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='quickBi数据报表信息'
---
DDL for table: ram_task_message
CREATE TABLE `ram_task_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `expected_time` varchar(30) DEFAULT NULL COMMENT '预计执行时间',
  `execution_time` datetime DEFAULT NULL COMMENT '实际执行时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0：未执行 1：已执行 2：执行失败',
  `error_stack` longtext,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: ram_user
CREATE TABLE `ram_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL COMMENT '用户名称',
  `user_id` varchar(30) NOT NULL,
  `comments` varchar(100) DEFAULT NULL COMMENT '备注职位',
  `real_name` varchar(20) DEFAULT NULL COMMENT '真实名称',
  `d_request_id` varchar(100) DEFAULT '' COMMENT '删除用户请求id',
  `p_request_id` varchar(255) DEFAULT NULL COMMENT '管理权限请求id',
  `g_request_id` varchar(255) DEFAULT NULL COMMENT '组管理请求id',
  `mobile_phone` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `create_time` varchar(30) DEFAULT NULL COMMENT '用户创建时间',
  `delete_time` datetime NOT NULL COMMENT '删除时间',
  `last_login_time` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='ram用户信息'
---
DDL for table: recharge
CREATE TABLE `recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recharge_no` varchar(36) NOT NULL COMMENT '充值编号',
  `transaction_number` varchar(100) DEFAULT NULL COMMENT '交易号',
  `m_id` bigint(30) DEFAULT NULL COMMENT '充值用户',
  `recharge_num` decimal(10,2) unsigned NOT NULL COMMENT '充值金额',
  `recharge_type` int(2) DEFAULT NULL COMMENT '支付类型',
  `applicant` varchar(50) DEFAULT NULL COMMENT '充值申请人',
  `handler` varchar(50) DEFAULT NULL COMMENT '充值评审人',
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '状态：0审核中，1成功，2失败',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `send_coupon` int(2) NOT NULL DEFAULT '0' COMMENT '是否自动发券：0表示不自动发券，1表示自动发券',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `fund_type` int(11) DEFAULT NULL COMMENT '资金类型 0 充值/购卡，1 余额退还',
  `level` int(11) DEFAULT NULL COMMENT '购卡金额级别0 1 2 3 4 5，0为不满足充送的情况',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注（申请）说明',
  `finance_bank_flowing_water_id` bigint(20) DEFAULT NULL COMMENT '招银流水表id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_rechange_no` (`recharge_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1251 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='充值申请表'
---
DDL for table: recharge_pic
CREATE TABLE `recharge_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recharge_id` int(11) DEFAULT NULL COMMENT '充值/退款申请表id',
  `pic` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT '0' COMMENT '0 存在 1 失效',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='充值/退款申请图片'
---
DDL for table: recharge_record
CREATE TABLE `recharge_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recharge_record_no` varchar(36) NOT NULL COMMENT '变动记录编号',
  `m_id` bigint(30) DEFAULT NULL COMMENT '充值用户',
  `type` int(2) DEFAULT '0' COMMENT '类型：0消费,1订单退款,2充值，3余额退还，4购卡  ',
  `record_no` varchar(36) DEFAULT NULL COMMENT '编号：订单号、售后单号、充值单号',
  `old_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `new_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `addtime` datetime DEFAULT NULL,
  `account_id` bigint(30) DEFAULT NULL COMMENT '操作子账号id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_recharge_record_no` (`recharge_record_no`) USING BTREE,
  KEY `idx_m_id` (`m_id`),
  KEY `idx_addtime` (`addtime`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=74060 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='余额记录表'
---
DDL for table: red_pack
CREATE TABLE `red_pack` (
  `rp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `m_id` bigint(30) DEFAULT NULL COMMENT '商户ID',
  `account_id` bigint(30) DEFAULT NULL,
  `order_no` varchar(30) DEFAULT NULL COMMENT '订单号',
  `pay_amount` decimal(10,2) DEFAULT NULL COMMENT '订单实付金额',
  `red_pack_amount` decimal(10,2) DEFAULT NULL COMMENT '红包金额',
  `status` int(11) DEFAULT NULL COMMENT '红包状态 0、已失效 1、未入账 2、已入账',
  `red_pack_rule_id` int(11) DEFAULT NULL COMMENT '红包规则ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`rp_id`) USING BTREE,
  UNIQUE KEY `red_pack_orderno_index` (`order_no`) USING BTREE,
  KEY `red_pack_mid_index` (`m_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='红包表'
---
DDL for table: red_pack_rule
CREATE TABLE `red_pack_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_no` int(10) DEFAULT NULL,
  `merchant_type` int(2) NOT NULL DEFAULT '0' COMMENT '客户类型:0新用户、1沉睡客户、2老客户',
  `min_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '返现比例下限',
  `max_rate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '返现比例上限',
  `min_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '返现金额下限',
  `max_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '返现金额上限',
  `threshold` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '反现门槛',
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '0:使用中 1已删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_areaNo_merchantType` (`area_no`,`merchant_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='红包规则表'
---
DDL for table: red_packet_circulation
CREATE TABLE `red_packet_circulation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `type` int(11) DEFAULT NULL COMMENT '发放红包类型',
  `name` varchar(30) DEFAULT NULL COMMENT '类型名称',
  `m_id` bigint(30) DEFAULT NULL COMMENT '客户id',
  `money` decimal(6,2) DEFAULT NULL COMMENT '金额',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='红包流转表'
---
DDL for table: red_packet_log
CREATE TABLE `red_packet_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `type` int(11) DEFAULT NULL COMMENT '发放红包类型（1签到，2浏览，3加619购物单，4浏览预售商品）',
  `name` varchar(30) DEFAULT NULL COMMENT '类型名称',
  `m_id` bigint(30) DEFAULT NULL COMMENT '客户id',
  `pd_id` varchar(255) DEFAULT NULL COMMENT '商品id',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=332 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='红包日志表'
---
DDL for table: refund
CREATE TABLE `refund` (
  `refund_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(36) NOT NULL COMMENT '订单ID',
  `after_sale_order_no` varchar(20) DEFAULT NULL,
  `refund_no` varchar(36) NOT NULL COMMENT '退款编号',
  `transaction_number` varchar(100) DEFAULT NULL COMMENT '微信退款交易号',
  `total_fee` decimal(10,2) DEFAULT '0.00' COMMENT '订单金额，单位分',
  `refund_fee` decimal(10,2) DEFAULT '0.00' COMMENT '申请退款金额，单位分',
  `cash_fee` decimal(10,2) DEFAULT '0.00' COMMENT '现金支付金额',
  `cash_refund_fee` decimal(10,2) DEFAULT '0.00' COMMENT '现金退款金额',
  `refund_desc` varchar(80) DEFAULT NULL COMMENT '退款原因',
  `end_time` datetime DEFAULT NULL COMMENT '退款完成时间',
  `refund_channel` varchar(150) DEFAULT NULL COMMENT '退款渠道',
  `status` tinyint(2) DEFAULT '0' COMMENT '退款状态',
  `err_code` varchar(32) DEFAULT NULL COMMENT '退款错误代码',
  `err_code_des` varchar(128) DEFAULT NULL COMMENT '退款错误描述',
  `coupon_id` varchar(255) DEFAULT NULL,
  `online_refund_end_time` datetime DEFAULT NULL COMMENT '线上退款完成时间',
  PRIMARY KEY (`refund_id`) USING BTREE,
  KEY `FK_orderpay` (`refund_no`) USING BTREE,
  KEY `FK_refund` (`order_no`) USING BTREE,
  KEY `idx_after_sale_no` (`after_sale_order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=17822 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='退款'
---
DDL for table: refund_handle_event
CREATE TABLE `refund_handle_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `refund_no` varchar(45) DEFAULT NULL COMMENT '退款号',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态0-NEW 1-IN_HANDLE 2-SUCCESS 3-FAIL',
  `retry_count` int(11) DEFAULT NULL COMMENT '重试次数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `status_idx` (`status`) USING BTREE,
  KEY `idx_refund_no` (`refund_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12820 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='退款事件表'
---
DDL for table: refund_slip
CREATE TABLE `refund_slip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `refund_slip_no` varchar(30) DEFAULT NULL COMMENT '退款单号',
  `settlement_id` int(11) DEFAULT NULL COMMENT '结算单号',
  `purchases_back_no` varchar(30) DEFAULT NULL COMMENT '退货单号',
  `refund_amount` decimal(10,2) DEFAULT NULL COMMENT '退款金额',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 审核中，1 待退款，2 已退款，3 作废',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `refund_slip_index` (`settlement_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='退款单表'
---
DDL for table: refund_slip_voucher
CREATE TABLE `refund_slip_voucher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `refund_slip_id` int(11) DEFAULT NULL COMMENT '退款单id',
  `voucher_address` varchar(100) DEFAULT NULL COMMENT '凭证地址',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 存在 1 作废',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `refund_slip_voucher_index` (`refund_slip_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='退款单凭证表'
---
DDL for table: replenishment_plan
CREATE TABLE `replenishment_plan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `replenishment_plan_no` varchar(20) DEFAULT NULL COMMENT '补货计划单号',
  `requirement_plan_no` varchar(20) DEFAULT NULL COMMENT '需求计划单号',
  `replenishment_freeze_start_time` date DEFAULT NULL COMMENT '冻结开始时间',
  `replenishment_freeze_end_time` date DEFAULT NULL COMMENT '冻结结束时间',
  `requirement_start_time` date DEFAULT NULL COMMENT '需求开始时间',
  `requirement_end_time` date DEFAULT NULL COMMENT '需求结束时间',
  `status` int(11) DEFAULT NULL COMMENT '状态 0:计划中 5:已完成',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_requirement_plan_no` (`requirement_plan_no`),
  KEY `idx_replenishment_plan_no` (`replenishment_plan_no`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8 COMMENT='补货计划:(定时删除一个月前的数据)'
---
DDL for table: replenishment_plan_allocation_task
CREATE TABLE `replenishment_plan_allocation_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(100) DEFAULT NULL COMMENT 'sku',
  `replenishment_plan_detail_id` bigint(20) DEFAULT NULL COMMENT '补货计划详情id',
  `allocation_out_time` date DEFAULT NULL COMMENT '调拨出库时间',
  `allocation_in_time` date DEFAULT NULL COMMENT '调拨入库时间',
  `quantity` int(11) DEFAULT NULL COMMENT '调拨数量',
  `out_warehouse_no` int(11) DEFAULT NULL COMMENT '调出仓编号',
  `out_warehouse_name` varchar(100) DEFAULT NULL COMMENT '调出仓名称',
  `in_warehouse_no` int(11) DEFAULT NULL COMMENT '调入仓编号',
  `in_warehouse_name` varchar(100) DEFAULT NULL COMMENT '调入仓名称',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除 0:正常 1:删除',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`),
  KEY `idx_replenishment_plan_detail_id_sku` (`replenishment_plan_detail_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='废弃-补货计划调拨任务'
---
DDL for table: replenishment_plan_detail
CREATE TABLE `replenishment_plan_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `replenishment_plan_id` bigint(20) DEFAULT NULL COMMENT '补货计划id',
  `sku` varchar(100) DEFAULT NULL COMMENT 'sku',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(100) DEFAULT NULL COMMENT '废弃字段,仓库名称',
  `purchaser_id` int(11) DEFAULT NULL COMMENT '废弃字段,采购员id',
  `purchaser_name` varchar(100) DEFAULT NULL COMMENT '废弃字段,采购员名称',
  `view_date` date DEFAULT NULL COMMENT '日期',
  `on_way_ship_quantity` int(11) DEFAULT NULL COMMENT '废弃字段,采购发货在途',
  `on_way_order_quantity` int(11) DEFAULT NULL COMMENT '废弃字段,采购订单在途',
  `transfer_in_quantity` int(11) DEFAULT NULL COMMENT '废弃字段,调拨入库在途',
  `stock_quantity` decimal(11,2) DEFAULT NULL COMMENT '库存数量',
  `requirement_plan_quantity` decimal(11,2) DEFAULT NULL COMMENT '需求计划数量',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  `pd_name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `replenishment_plan_sub_no` varchar(32) DEFAULT NULL COMMENT '补货计划子单号',
  `transfer_order_in_quantity` decimal(10,2) DEFAULT NULL COMMENT '调拨单订单口径在途',
  `po_on_way_quantity` decimal(10,2) DEFAULT NULL COMMENT '采购订单口径在途',
  `replenishment_plan_no` varchar(20) DEFAULT NULL COMMENT '补货计划单号',
  `small_sku_require_quantity` decimal(10,2) DEFAULT NULL COMMENT '小规格需求量',
  PRIMARY KEY (`id`),
  KEY `idx_plan_warehouse_sku_view_day` (`replenishment_plan_id`,`warehouse_no`,`view_date`,`sku`),
  KEY `idx_sub_no_view_day` (`replenishment_plan_sub_no`,`view_date`)
) ENGINE=InnoDB AUTO_INCREMENT=84429 DEFAULT CHARSET=utf8 COMMENT='补货计划详情:(定时删除一个月前数据）'
---
DDL for table: replenishment_plan_purchase_task
CREATE TABLE `replenishment_plan_purchase_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(100) DEFAULT NULL COMMENT 'sku',
  `replenishment_plan_detail_id` bigint(20) DEFAULT NULL COMMENT '补货计划详情id',
  `purchase_time` date DEFAULT NULL COMMENT '采购时间',
  `latest_arrival_date` date DEFAULT NULL COMMENT '最晚到货时间',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(100) DEFAULT NULL COMMENT '供应商名称',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '0:正常 1:删除',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  `quantity` bigint(20) DEFAULT NULL COMMENT '采购数量',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(100) DEFAULT NULL COMMENT '仓库名称',
  PRIMARY KEY (`id`),
  KEY `idx_replenishment_plan_detail_sku` (`replenishment_plan_detail_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='废弃表 补货计划-采购任务'
---
DDL for table: replenishment_plan_sub_order
CREATE TABLE `replenishment_plan_sub_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `replenishment_plan_no` varchar(20) DEFAULT NULL COMMENT '补货计划单号',
  `replenishment_plan_sub_no` varchar(32) DEFAULT NULL COMMENT '补货计划子单号',
  `sku` varchar(100) DEFAULT NULL COMMENT 'sku',
  `spu_no` varchar(100) DEFAULT NULL COMMENT '商品编号',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(100) DEFAULT NULL COMMENT '仓库名称',
  `planner_id` int(11) DEFAULT NULL COMMENT '计划员ID',
  `planner_name` varchar(100) DEFAULT NULL COMMENT '计划员名称',
  `purchaser_id` int(11) DEFAULT NULL COMMENT '采购员id',
  `purchaser_name` varchar(100) DEFAULT NULL COMMENT '采购员名称',
  `custom_flag` int(11) DEFAULT '0' COMMENT '自定义标记 0:未标记, 1:已标记',
  `status` int(11) DEFAULT NULL COMMENT '状态 0:计划中 5:已完成',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `update_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_plan_sub_no_plan_no` (`replenishment_plan_sub_no`,`replenishment_plan_no`),
  KEY `idx_plan_no` (`replenishment_plan_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1094 DEFAULT CHARSET=utf8mb4 COMMENT='计划子单表:(定时删除一个月前数据)'
---
DDL for table: replenishment_plan_sub_order_index
CREATE TABLE `replenishment_plan_sub_order_index` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `replenishment_plan_no` varchar(20) DEFAULT NULL COMMENT '补货计划单号',
  `replenishment_plan_sub_no` varchar(32) DEFAULT NULL COMMENT '补货计划子单号',
  `sku` varchar(100) DEFAULT NULL COMMENT 'sku',
  `spu_no` varchar(100) DEFAULT NULL COMMENT '商品编号',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `level_label` varchar(4) DEFAULT NULL COMMENT 'SKU+仓维度的ABC分档标签',
  `sell_out_date` date DEFAULT NULL COMMENT '售罄日',
  `purchase_type` int(11) DEFAULT NULL COMMENT '采购类型（非直采:0,直采:1）',
  `default_supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `pre_day` int(11) DEFAULT NULL COMMENT '提前期',
  `backlog_day` int(11) DEFAULT NULL COMMENT '备货天数',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `update_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `temperature` int(11) DEFAULT NULL COMMENT '温区 常温，冷藏，冷冻，对应的编码为3,2,1',
  `brand` varchar(50) DEFAULT NULL COMMENT '品牌',
  `pd_id` bigint(20) DEFAULT NULL COMMENT 'spuId',
  `small_sku` varchar(100) DEFAULT NULL COMMENT '小sku',
  `rates` varchar(20) DEFAULT NULL COMMENT '比例 转出(大)SKU:转入(小)SKU 例子1:2',
  `weight_num` decimal(10,2) DEFAULT NULL COMMENT '重量kg',
  `volume` varchar(255) DEFAULT NULL COMMENT '体积(长*宽*高)',
  `total_weight` decimal(10,2) DEFAULT NULL COMMENT '任务总重量kg',
  `total_volume` decimal(10,2) DEFAULT NULL COMMENT '任务总体积(长*宽*高)',
  PRIMARY KEY (`id`),
  KEY `idx_sub_no` (`replenishment_plan_sub_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1092 DEFAULT CHARSET=utf8mb4 COMMENT='计划子单索引表:(定时删除一个月前的数据)'
---
DDL for table: replenishment_plan_sub_order_task
CREATE TABLE `replenishment_plan_sub_order_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `replenishment_plan_no` varchar(20) DEFAULT NULL COMMENT '补货计划单号',
  `replenishment_plan_sub_no` varchar(32) DEFAULT NULL COMMENT '补货计划子单号',
  `detail_id` bigint(20) DEFAULT NULL COMMENT '计划详单主键',
  `task_date` date DEFAULT NULL COMMENT '任务日期',
  `task_type` int(11) DEFAULT NULL COMMENT '任务类型(采购：0/调拨：1)',
  `create_type` int(11) DEFAULT NULL COMMENT '创建类型(系统：0/手动：1)',
  `sku` varchar(100) DEFAULT NULL COMMENT 'sku',
  `spu_no` varchar(100) DEFAULT NULL COMMENT '商品编号',
  `temperature` int(11) DEFAULT NULL COMMENT '温区 常温，冷藏，冷冻，对应的编码为3,2,1',
  `target_warehouse_no` int(11) DEFAULT NULL COMMENT '补货目标仓编号',
  `target_warehouse_name` varchar(100) DEFAULT NULL COMMENT '补货目标仓',
  `provider_id` int(11) DEFAULT NULL COMMENT '提供方ID',
  `provider_name` varchar(100) DEFAULT NULL COMMENT '提供方名称',
  `except_received_date` date DEFAULT NULL COMMENT '期望到货日期',
  `quantity` decimal(11,2) DEFAULT NULL COMMENT '调拨数量',
  `total_weight` decimal(11,2) DEFAULT NULL COMMENT '总重量',
  `total_volume` decimal(11,2) DEFAULT NULL COMMENT '总体积',
  `status` int(11) DEFAULT NULL COMMENT '状态(计划中:0,待执行:5,已作废:10,已执行:15)',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `update_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_sub_no_status` (`replenishment_plan_sub_no`,`status`),
  KEY `idx_detail_id_status` (`detail_id`,`status`),
  KEY `idx_no_sku_provider_tasktype_status` (`replenishment_plan_no`,`sku`,`provider_id`,`task_type`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=648 DEFAULT CHARSET=utf8mb4 COMMENT='计划补货任务表:(定时删除一个月前的数据)'
---
DDL for table: requirement_plan
CREATE TABLE `requirement_plan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `requirement_plan_no` varchar(20) DEFAULT NULL COMMENT '需求计划编号',
  `requirement_name` varchar(20) DEFAULT NULL COMMENT '需求名称',
  `replenishment_freeze_start_time` date DEFAULT NULL COMMENT '冻结开始时间',
  `replenishment_freeze_end_time` date DEFAULT NULL COMMENT '冻结结束时间',
  `requirement_start_time` date DEFAULT NULL COMMENT '计划开始时间',
  `requirement_end_time` date DEFAULT NULL COMMENT '计划结束时间',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  PRIMARY KEY (`id`),
  KEY `idx_requirement_plan_no` (`requirement_plan_no`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8 COMMENT='需求计划表'
---
DDL for table: requirement_plan_warehouse
CREATE TABLE `requirement_plan_warehouse` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `requirement_plan_id` bigint(20) DEFAULT NULL COMMENT '需求计划id',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(50) DEFAULT NULL COMMENT '仓库名称',
  PRIMARY KEY (`id`),
  KEY `idx_requirement_plan_id` (`requirement_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11588 DEFAULT CHARSET=utf8 COMMENT='需求计划仓库'
---
DDL for table: reserve_quantity_record
CREATE TABLE `reserve_quantity_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku信息',
  `order_no` varchar(30) DEFAULT NULL COMMENT '订单号',
  `quantity` int(11) DEFAULT NULL COMMENT '扣减数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='预留库存变更信息'
---
DDL for table: role
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='权限'
---
DDL for table: role_purview
CREATE TABLE `role_purview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色',
  `purview_id` int(11) NOT NULL COMMENT '权限',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pk_purview_id` (`purview_id`) USING BTREE,
  KEY `pk_role_id` (`role_id`) USING BTREE,
  CONSTRAINT `pk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11377 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色-权限关联表'
---
DDL for table: role_purview_pro
CREATE TABLE `role_purview_pro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色',
  `purview_id` int(11) NOT NULL COMMENT '权限',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pk_purview_id` (`purview_id`) USING BTREE,
  KEY `pk_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16778 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色-权限关联表'
---
DDL for table: rule_distribution_free
CREATE TABLE `rule_distribution_free` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT NULL COMMENT '状态 0 生效 1 不生效',
  `distribution_id` int(11) DEFAULT NULL COMMENT '配送费规则id',
  `rule` varchar(300) DEFAULT NULL COMMENT '免配送费规则 list集合',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=842 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='免配送费规则表'
---
DDL for table: saas_orders
CREATE TABLE `saas_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `tenant_name` varchar(50) DEFAULT NULL COMMENT '品牌方名称',
  `store_name` varchar(50) DEFAULT NULL COMMENT '门店名称',
  `order_time` datetime DEFAULT NULL COMMENT '订单时间',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '下单金额',
  `belong_db` varchar(50) DEFAULT NULL COMMENT '归属BD',
  `status` int(11) DEFAULT NULL COMMENT '订单状态',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='saas同步订单表'
---
DDL for table: sale_prediction_config
CREATE TABLE `sale_prediction_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT '1 简单预测 2 模型预测',
  `k1` double DEFAULT NULL COMMENT '销量预测系数',
  `k2` double DEFAULT NULL COMMENT '库存充足系数',
  `k3` double DEFAULT NULL COMMENT '可能售罄系数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: sample_apply
CREATE TABLE `sample_apply` (
  `sample_id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `create_name` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `m_id` int(11) DEFAULT NULL COMMENT '式样用户id',
  `m_name` varchar(50) DEFAULT NULL COMMENT '式样用户名称',
  `grade` int(11) DEFAULT NULL COMMENT '会员等级',
  `m_size` varchar(20) DEFAULT NULL COMMENT '用户类型 单店，大客户',
  `m_phone` varchar(13) DEFAULT NULL COMMENT '手机号',
  `m_contact` varchar(50) DEFAULT NULL COMMENT '联系人',
  `contact_id` int(11) DEFAULT NULL COMMENT '式样用户收货地址id',
  `bd_id` int(11) DEFAULT NULL COMMENT '客户所属用户bdid',
  `bd_name` varchar(50) DEFAULT NULL COMMENT '客户归属bd名称',
  `status` int(11) DEFAULT NULL COMMENT '状态 0 待反馈 1 已反馈',
  `satisfaction` int(11) DEFAULT NULL COMMENT '客户满意度 0 未评价 1,2,3,4',
  `purchase_intention` int(11) DEFAULT NULL COMMENT '客户购买意向',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `area_no` int(11) DEFAULT NULL COMMENT '所属城市编号',
  `delivery_time` date DEFAULT NULL COMMENT '样品配送时间',
  `store_no` int(11) DEFAULT NULL COMMENT '配送仓编号',
  PRIMARY KEY (`sample_id`) USING BTREE,
  KEY `idx_delivery_time` (`delivery_time`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26745 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='样品申请表'
---
DDL for table: sample_apply_review
CREATE TABLE `sample_apply_review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_id` int(11) NOT NULL COMMENT '样品申请ID',
  `review_id` int(11) DEFAULT NULL COMMENT '审核人id',
  `review_name` varchar(50) DEFAULT NULL COMMENT '审核人名称',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `status` int(11) DEFAULT NULL COMMENT '审核状态 0 通过 1 不通过',
  `review_remark` varchar(255) DEFAULT NULL COMMENT '审核备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_sample_id` (`sample_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6106 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='样品申请审核信息表'
---
DDL for table: sample_sku
CREATE TABLE `sample_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_id` int(11) DEFAULT NULL COMMENT '样品申请ID',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `pd_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `amount` int(11) DEFAULT NULL COMMENT '申请数量',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update_time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create_time',
  `intercept_flag` int(11) DEFAULT '0' COMMENT '拦截状态 0 正常 1被拦截',
  `intercept_time` datetime DEFAULT NULL COMMENT '拦截时间',
  `show_flag` tinyint(4) DEFAULT '0' COMMENT '完成排线-展示标识 0 展示 1不展示',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE,
  KEY `idx_sample_id` (`sample_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6533 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='样品申请sku信息'
---
DDL for table: schedule_task
CREATE TABLE `schedule_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `name` varchar(25) NOT NULL COMMENT '任务名称',
  `entrance` varchar(255) NOT NULL COMMENT '任务执行入口，形如：beanName.methodName，例如：cashServiceImpl.cashTest',
  `args` varchar(255) DEFAULT NULL COMMENT '执行参数，形如：a=1&b=2',
  `cron` varchar(50) DEFAULT NULL COMMENT 'cron表达式',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '任务状态：0、待执行 1、执行中',
  `remark` varchar(255) DEFAULT NULL COMMENT '任务说明',
  `last_exec_time` datetime DEFAULT NULL COMMENT '上次执行时间',
  `last_exec_result` int(11) DEFAULT NULL COMMENT '上次执行结果：0、失败 1、成功',
  `remind_flag` int(11) DEFAULT '1' COMMENT '任务提醒标识：0、不提醒 1、提醒',
  `delete_flag` tinyint(1) DEFAULT '0' COMMENT '删除标识，f、未删除 t、已删除',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `service` varchar(45) NOT NULL DEFAULT 'local' COMMENT '由谁来执行任务',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='任务调度'
---
DDL for table: schedule_task_log
CREATE TABLE `schedule_task_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `start_time` datetime DEFAULT NULL COMMENT '开始执行时间',
  `end_time` datetime DEFAULT NULL COMMENT '执行结束时间',
  `result` int(11) DEFAULT NULL COMMENT '执行结果：0、失败 1、成功',
  `executor` varchar(50) DEFAULT '系统' COMMENT '执行人，默认 系统',
  `exception_info` longtext COMMENT '异常信息',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `schedule_task_log_task_id_index` (`task_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1372672 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='任务执行日志'
---
DDL for table: series_of_area
CREATE TABLE `series_of_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `series_type` int(11) DEFAULT NULL COMMENT '聚合类型：0-鲜沐严选 1-商品排序 2-秒杀 3-卡券发放配置区域',
  `series_id` int(11) DEFAULT NULL COMMENT '聚合id',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `series_of_area_unique_index` (`series_type`,`series_id`,`area_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15972 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='城市聚合表'
---
DDL for table: series_of_sku
CREATE TABLE `series_of_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `series_type` int(11) DEFAULT NULL COMMENT '聚合类型：0、鲜沐严选 1、商品排序',
  `series_id` int(11) DEFAULT NULL COMMENT '聚合id',
  `sku` varchar(33) DEFAULT NULL COMMENT 'sku',
  `sort` int(11) DEFAULT NULL COMMENT '排序值，从小到大',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `series_of_sku_unique_index` (`series_type`,`series_id`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=877 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='sku聚合表'
---
DDL for table: settlement
CREATE TABLE `settlement` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付方式 1、银行卡 2、现金',
  `account_name` varchar(50) DEFAULT NULL COMMENT '账户名称',
  `account_bank` varchar(50) DEFAULT NULL COMMENT '开户行',
  `account_ascription` varchar(50) DEFAULT NULL COMMENT '归属地',
  `account` varchar(50) DEFAULT NULL COMMENT '账号',
  `status` int(11) DEFAULT NULL COMMENT '结算单状态 1、待结算 2、部分计算 3、已结算 4、取消结算',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '应结算总额',
  `creator` varchar(50) DEFAULT NULL COMMENT '发起人',
  `pd_type` int(11) DEFAULT NULL COMMENT '1 生鲜 2 品牌',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `deduction_amount` decimal(10,2) DEFAULT NULL COMMENT '扣款金额',
  `refund_settlement_amount` decimal(10,2) DEFAULT NULL COMMENT '退结金额',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='结算单表'
---
DDL for table: settlement_config
CREATE TABLE `settlement_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT '1 生鲜 2 品牌',
  `auditor` varchar(50) DEFAULT NULL COMMENT '审核人',
  `approver` varchar(50) DEFAULT NULL COMMENT '审批人',
  `threshold` bigint(20) DEFAULT NULL COMMENT '无需审批额度',
  `payer` varchar(50) DEFAULT NULL COMMENT '打款人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='结算单审核配置'
---
DDL for table: settlement_detail
CREATE TABLE `settlement_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `settlement_id` int(11) DEFAULT NULL COMMENT '结算单id',
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `type` int(11) DEFAULT NULL COMMENT '结算单项详情类型 1、sku成本 2、物流费用',
  `purchase_plan_id` int(11) DEFAULT NULL COMMENT '采购单详情id',
  `sku_amount` decimal(10,2) DEFAULT NULL COMMENT '发起时sku总成本或物流费用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `settlement_detail_settle_index` (`settlement_id`) USING BTREE,
  KEY `settlement_detail_pp_index` (`purchase_no`,`purchase_plan_id`) USING BTREE,
  KEY `purchase_plan_id_idx` (`purchase_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=854 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='结算单详情'
---
DDL for table: settlement_expect
CREATE TABLE `settlement_expect` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `pay_date` date DEFAULT NULL COMMENT '打款日期',
  `pay_amount` decimal(10,4) DEFAULT NULL COMMENT '打款金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预计结算金额'
---
DDL for table: settlement_payment_record
CREATE TABLE `settlement_payment_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `settlement_id` int(11) DEFAULT NULL COMMENT '结算单id',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '结算金额',
  `expected_time` datetime DEFAULT NULL COMMENT '期望付款时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `settlement_count` int(11) DEFAULT NULL COMMENT '结算次数',
  `status` int(11) DEFAULT NULL COMMENT '打款状态  1、待审核 2、审核失败 3、待打款 4、打款取消 5、已打款 6、待审批 7、审批失败',
  `creator` varchar(30) DEFAULT NULL COMMENT '发起人',
  `creator_adminId` int(11) DEFAULT NULL COMMENT '发起人adminId',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `auditor` varchar(30) DEFAULT NULL COMMENT '审核人',
  `auditor_adminId` int(11) DEFAULT NULL COMMENT '审核人adminId',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `approver` varchar(50) DEFAULT NULL COMMENT '审批人',
  `approver_adminId` int(11) DEFAULT NULL COMMENT '审批人adminId',
  `approver_time` datetime DEFAULT NULL COMMENT '审批时间',
  `payer` varchar(30) DEFAULT NULL COMMENT '打款人',
  `payer_adminId` int(11) DEFAULT NULL COMMENT '打款人adminId',
  `pay_time` datetime DEFAULT NULL COMMENT '打款时间',
  `payment_voucher` varchar(255) DEFAULT NULL COMMENT '付款凭证',
  `withdraw_time` datetime DEFAULT NULL COMMENT '付款单撤回时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `settlement_payment_record_index` (`settlement_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=538 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='结算单打款记录'
---
DDL for table: shopping_cart
CREATE TABLE `shopping_cart` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `m_id` bigint(20) DEFAULT NULL COMMENT '用户',
  `account_id` bigint(20) DEFAULT NULL COMMENT '子账号id',
  `biz_id` bigint(20) DEFAULT NULL COMMENT '业务id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'sku',
  `parent_sku` varchar(255) DEFAULT NULL COMMENT '搭配购上级sku',
  `product_type` tinyint(4) DEFAULT NULL COMMENT '商品类型：0、普通商品 1、赠品   2、换购',
  `quantity` int(11) DEFAULT NULL COMMENT '购买数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `union_index` (`m_id`,`account_id`) COMMENT '联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=702 DEFAULT CHARSET=utf8mb4 COMMENT='购物车'
---
DDL for table: shopping_list
CREATE TABLE `shopping_list` (
  `m_id` bigint(30) NOT NULL COMMENT '用户',
  `account_id` bigint(30) NOT NULL DEFAULT '0' COMMENT '子账号id',
  `sku` varchar(255) NOT NULL,
  `suit_id` int(11) NOT NULL DEFAULT '0',
  `product_type` int(11) NOT NULL DEFAULT '0' COMMENT '商品类型：0、普通商品 1、赠品',
  `quantity` int(11) DEFAULT '1' COMMENT '购买数量',
  `check` tinyint(4) DEFAULT '1' COMMENT '是否选中,0否，1选中',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标记,0未删除，1已删除',
  PRIMARY KEY (`m_id`,`account_id`,`sku`,`suit_id`,`product_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='shopping-list购物单表'
---
DDL for table: sku_batch_code
CREATE TABLE `sku_batch_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(50) NOT NULL COMMENT 'sku',
  `purchase_no` varchar(50) NOT NULL COMMENT '批次号',
  `production_date` date NOT NULL COMMENT '生产日期',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `sku_batch_only_code` varchar(10) DEFAULT NULL COMMENT '批次唯一码',
  `print_number` int(11) DEFAULT '0' COMMENT '打印次数',
  `biz_id` bigint(20) unsigned DEFAULT NULL COMMENT '业务id,如入库单id',
  `biz_type` tinyint(4) DEFAULT NULL COMMENT '业务类型',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `u_sku_purchase_no` (`sku`,`purchase_no`,`production_date`,`biz_id`,`biz_type`),
  KEY `n_code` (`sku_batch_only_code`) USING BTREE,
  KEY `u_biz_id_type` (`biz_id`,`biz_type`),
  KEY `idx_sku_code` (`sku`,`sku_batch_only_code`)
) ENGINE=InnoDB AUTO_INCREMENT=79465 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='批次码表'
---
DDL for table: sku_discount
CREATE TABLE `sku_discount` (
  `sku` varchar(30) NOT NULL COMMENT 'skuId',
  `discount` decimal(10,4) DEFAULT '0.0000' COMMENT '折扣比例',
  `overlap` tinyint(1) DEFAULT '1' COMMENT '是否与阶梯价叠加0：不叠加 1：叠加',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='sku折扣率表'
---
DDL for table: sku_mapping
CREATE TABLE `sku_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(45) DEFAULT NULL COMMENT '鲜沐sku\n',
  `mapping` varchar(45) DEFAULT NULL COMMENT 'sku映射',
  `admin_id` int(11) DEFAULT NULL COMMENT '映射主体,对应大客户id',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `status` int(11) DEFAULT '1' COMMENT '0删除，1启用',
  `mapping_name` varchar(255) DEFAULT NULL COMMENT '商品名称映射',
  `ka_bill_switch` int(1) DEFAULT '1' COMMENT '影响大客户账单开关 0：关；1：开',
  `outer_platform_id` int(2) DEFAULT '0' COMMENT '外部平台 0：无；1：AOL；2：悸动烧仙草',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku_admin` (`sku`,`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=685 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='鲜沐合作sku映射表'
---
DDL for table: sku_price_fluctuation
CREATE TABLE `sku_price_fluctuation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `recode_time` datetime DEFAULT NULL COMMENT '活动开始时间',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `activity_price` decimal(10,2) DEFAULT NULL COMMENT '活动价格',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku_area_no_recode_time` (`sku`,`area_no`,`add_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30664 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='关注商品价格记录表'
---
DDL for table: sku_sale_statistics
CREATE TABLE `sku_sale_statistics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `rdc_k` bigint(20) NOT NULL COMMENT '仓库号',
  `in_sku_k` varchar(128) NOT NULL COMMENT '转入sku',
  `in_sale_cnt_b15d` decimal(10,2) NOT NULL COMMENT '转入sku15天平均销量',
  `in_sale_cnt_b7d` decimal(10,2) NOT NULL COMMENT '转入sku7天平均销量',
  `in_min_sale_cnt` decimal(10,2) NOT NULL COMMENT '转入sku订单最小销售量',
  `in_max_sale_seven` decimal(10,2) NOT NULL COMMENT '转入sku七天每日总销量峰值',
  `out_sku_k` varchar(128) NOT NULL COMMENT '转出sku',
  `out_sale_cnt_b15d` decimal(10,2) NOT NULL COMMENT '转出sku15天平均销量',
  `out_sale_cnt_b7d` decimal(10,2) NOT NULL COMMENT '转出sku7天平均销量',
  `out_min_sale_cnt` decimal(10,2) NOT NULL COMMENT '转出sku订单最小销售量',
  `out_max_sale_seven` decimal(10,2) NOT NULL COMMENT '转出sku七天每日总销量峰值',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `date_flag` varchar(128) NOT NULL COMMENT '时间标识字段',
  PRIMARY KEY (`id`),
  KEY `idx_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1010 DEFAULT CHARSET=utf8 COMMENT='sku销售统计表'
---
DDL for table: sms_scene
CREATE TABLE `sms_scene` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `template_id` char(20) DEFAULT NULL COMMENT '模板ID',
  `title` varchar(45) DEFAULT NULL COMMENT '场景标题',
  `platform` tinyint(4) NOT NULL COMMENT '平台: 1阿里 2叮咚 3创蓝',
  `template` varchar(300) DEFAULT NULL COMMENT '模板',
  `scene_id` bigint(20) DEFAULT NULL COMMENT '场景id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_scene_id` (`scene_id`,`platform`) USING BTREE,
  KEY `id_templdate_id` (`template_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='发送短信场景表 包括发送短信的模板 模板id 平台'
---
DDL for table: sort_combination
CREATE TABLE `sort_combination` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `name` varchar(50) DEFAULT NULL COMMENT '组合名称',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='排序组合'
---
DDL for table: sort_combination_tab
CREATE TABLE `sort_combination_tab` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `combination_id` int(11) DEFAULT NULL COMMENT '组合id',
  `type` int(11) DEFAULT NULL COMMENT '类型：0、商品推荐前四个 1、tab',
  `name` varchar(50) DEFAULT NULL COMMENT 'tab名称',
  `subtitle` varchar(50) DEFAULT NULL COMMENT '副标题',
  `sort_expire_time` datetime DEFAULT NULL COMMENT '排序过期时间',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sort_combination_tab_com_index` (`combination_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='排序tab'
---
DDL for table: split_area
CREATE TABLE `split_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '状态 0 待执行 1 已执行，2 取消任务',
  `area_no` int(11) DEFAULT NULL COMMENT '拆分至城市编号',
  `split_area_no` int(11) DEFAULT NULL COMMENT '被拆分城市编号',
  `execute_time` date DEFAULT NULL COMMENT '任务执行时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='城市拆分信息表'
---
DDL for table: split_area_detail
CREATE TABLE `split_area_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `split_area_id` int(11) DEFAULT NULL COMMENT '城市拆分项id',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='切换区域信息'
---
DDL for table: srm_inquiry_bid
CREATE TABLE `srm_inquiry_bid` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `inquiry_no` varchar(20) DEFAULT NULL COMMENT '询价单号',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `deadline` datetime DEFAULT NULL COMMENT '截止时间',
  `price_start_time` datetime DEFAULT NULL COMMENT '价格生效时间',
  `price_end_time` datetime DEFAULT NULL COMMENT '价格失效时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '竞价单状态，-1已作废；0竞价中;1评估中;2完成',
  `tag` tinyint(4) DEFAULT NULL COMMENT '竞价单标签,0未报价;1已报价;2中标;3未中标',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `idx_inquiry_no` (`inquiry_no`),
  KEY `idx_supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8mb4 COMMENT='供应商竞价单'
---
DDL for table: srm_inquiry_bid_item
CREATE TABLE `srm_inquiry_bid_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `bid_id` bigint(20) DEFAULT NULL COMMENT '竞价单id',
  `inquiry_item_id` bigint(20) DEFAULT NULL COMMENT '询价单商品id',
  `cost_detail_id` bigint(20) DEFAULT NULL COMMENT '成本明细id',
  `sku` varchar(20) DEFAULT NULL COMMENT 'SKU',
  `warehouse_no` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `warehouse_name` varchar(16) DEFAULT NULL COMMENT '仓库名称',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `need_quantity` int(11) DEFAULT NULL COMMENT '预估需求量（单位件）',
  `supply_quantity` int(11) DEFAULT NULL COMMENT '供应量（单位件）',
  `quoted_price` decimal(10,2) DEFAULT NULL COMMENT '报价',
  `status` tinyint(4) DEFAULT NULL COMMENT '报价状态，0未报价；1中标；2未中标',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `pd_no` varchar(32) DEFAULT NULL COMMENT 'SPU编码',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `idx_bid_id` (`bid_id`) COMMENT '竞价单id'
) ENGINE=InnoDB AUTO_INCREMENT=7786 DEFAULT CHARSET=utf8mb4 COMMENT='供应商询竞商品明细'
---
DDL for table: srm_packup_purchase_order
CREATE TABLE `srm_packup_purchase_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商ID',
  `purchase_no` varchar(64) DEFAULT NULL COMMENT '采购单号',
  `warehouse_no` bigint(20) DEFAULT NULL COMMENT '仓库编号',
  `packup_date` datetime DEFAULT NULL COMMENT '提货日期',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COMMENT='供应商提报采购订单'
---
DDL for table: srm_stock_change_record
CREATE TABLE `srm_stock_change_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商ID',
  `type` tinyint(4) DEFAULT NULL COMMENT '变更类型,1库存提报；2库存调整；3未提报库存失效；4次日提货扣减',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态，0处理中；1审核中；2已完成；',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=395 DEFAULT CHARSET=utf8mb4 COMMENT='供应商库存变更记录'
---
DDL for table: srm_stock_change_record_detail
CREATE TABLE `srm_stock_change_record_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `record_id` bigint(20) NOT NULL COMMENT '变更记录ID',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  `supplier_id` bigint(20) NOT NULL COMMENT '供应商ID',
  `spu` varchar(64) NOT NULL COMMENT 'SPU编码',
  `sku` varchar(64) NOT NULL COMMENT 'SKU编码',
  `warehouse_no` bigint(20) NOT NULL COMMENT '仓库编号',
  `original_total_sale_stock` int(11) DEFAULT NULL COMMENT '原售卖总库存',
  `adjust_total_sale_stock` int(11) DEFAULT NULL COMMENT '调整后售卖总库存',
  `saled_stock` int(11) DEFAULT NULL COMMENT '已售库存',
  `status` tinyint(4) DEFAULT NULL COMMENT '调整状态，0不需要审核；1审核中；2审核通过；3审核拒绝；4超时未审核；5已撤销；6库存已提报',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `remain_sale_stock` int(11) DEFAULT NULL COMMENT '剩余可售库存',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `stock_packup` int(11) DEFAULT NULL COMMENT '库存提报值',
  `now_total_sale_stock` int(11) DEFAULT NULL COMMENT '当前售卖总库存',
  `next_day_delivery_quantity` int(11) DEFAULT NULL COMMENT '次日提货量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=519 DEFAULT CHARSET=utf8mb4 COMMENT='供应商库存变更记录详情'
---
DDL for table: srm_stock_packup
CREATE TABLE `srm_stock_packup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `spu` varchar(64) NOT NULL COMMENT 'SPU编码',
  `sku` varchar(64) NOT NULL COMMENT 'SKU编码',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `yesterday_packup_stock` int(11) DEFAULT NULL COMMENT '昨日库存提报',
  `packup_status` tinyint(4) DEFAULT NULL COMMENT '今日提报状态,0未提报；1已提报',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建人',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新人',
  `today_packup_stock` int(11) DEFAULT NULL COMMENT '今日库存提报',
  `today_clear_stock` tinyint(4) DEFAULT '1' COMMENT '今日清理库存，0否；1是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_warehouse_no_supplier_id_sku` (`warehouse_no`,`supplier_id`,`sku`) COMMENT '仓库供应商SKU唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COMMENT='供应商库存提报'
---
DDL for table: srm_supplier_finance_account_statement
CREATE TABLE `srm_supplier_finance_account_statement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `finance_account_statement_id` bigint(20) DEFAULT NULL COMMENT '采购对账单id',
  `estimate_amount` decimal(10,2) DEFAULT NULL COMMENT '暂估总成本',
  `total_bill_amount` decimal(10,2) DEFAULT NULL COMMENT '账单总额（调整后总额）',
  `wallets_id` bigint(20) DEFAULT NULL COMMENT '票夹id/为空则没被匹配',
  `write_off_amount` decimal(10,2) DEFAULT NULL COMMENT '核销总额',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `supplier_name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `purchaser_name` varchar(50) DEFAULT NULL COMMENT '采购商名称',
  `purchaser_id` int(11) DEFAULT NULL COMMENT '采购商id',
  `tax_number` varchar(50) DEFAULT NULL COMMENT '税号',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付方式 1、银行卡 2、现金',
  `account_name` varchar(50) DEFAULT NULL COMMENT '账户名称',
  `account_bank` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `account_ascription` varchar(50) DEFAULT NULL COMMENT '银行卡归属地',
  `account` varchar(50) DEFAULT NULL COMMENT '账号',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `creator_admin_id` int(11) DEFAULT NULL COMMENT '发起人adminId',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int(11) DEFAULT NULL COMMENT 'SRM对账单状态 0、待确认 1、待开票 2、审核中 3、待付款 4、已完成 5、作废',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_reason` int(11) DEFAULT NULL COMMENT '作废原因：0：关闭账单 1：供应商拒绝 2：付款审核失败',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_supplier_id` (`supplier_id`),
  KEY `idx_supplier_name` (`supplier_name`),
  KEY `idx_tax_number` (`tax_number`),
  KEY `idx_wallets_id` (`wallets_id`),
  KEY `idx_statement_id` (`finance_account_statement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1680 DEFAULT CHARSET=utf8 COMMENT='SRM对账单表'
---
DDL for table: srm_supplier_message_config
CREATE TABLE `srm_supplier_message_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `open_id` varchar(50) DEFAULT NULL COMMENT '公众号openId',
  `union_id` varchar(50) DEFAULT NULL COMMENT 'unionId',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `head_img_url` varchar(200) DEFAULT NULL COMMENT '头像地址',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新id',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COMMENT='srm消息配置表'
---
DDL for table: srm_supplier_offer
CREATE TABLE `srm_supplier_offer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'sku',
  `warehouse_no` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态0待生效，1生效中，2待报价',
  `lowest_price` decimal(10,2) DEFAULT NULL COMMENT '最低价',
  `highest_price` decimal(10,2) DEFAULT NULL COMMENT '最高价',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `tax_rate` decimal(10,2) DEFAULT NULL COMMENT '税率',
  `source` varchar(255) NOT NULL DEFAULT 'xianmu' COMMENT '来源:xianmu,saas',
  `tenant_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '租户id',
  PRIMARY KEY (`id`),
  KEY `idx_sku_warehouse_supplier` (`sku`,`warehouse_no`,`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2067 DEFAULT CHARSET=utf8 COMMENT='报价聚合表'
---
DDL for table: srm_supplier_offer_detail
CREATE TABLE `srm_supplier_offer_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `offer_id` bigint(20) DEFAULT NULL COMMENT '报价单id',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态0待生效1生效中2已失效3已关闭',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `source` varchar(255) NOT NULL DEFAULT 'xianmu' COMMENT '来源:xianmu,saas',
  `tenant_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '租户id',
  `bid_status` tinyint(4) DEFAULT '0' COMMENT '中标情况,0未参与竞价；1未中标；2中标',
  `channel_type` tinyint(4) DEFAULT NULL COMMENT '渠道类型，1源头直采；2分销市场',
  `scene` tinyint(4) DEFAULT '1' COMMENT '场景，1srm，2运营后台',
  `cost_detail_id` bigint(20) DEFAULT NULL COMMENT '成本明细ID',
  `offer_type` tinyint(4) DEFAULT '1' COMMENT '报价单类型，1常规报价；2询竞价',
  PRIMARY KEY (`id`),
  KEY `idx_offer_id` (`offer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2482 DEFAULT CHARSET=utf8 COMMENT='供应商报价详情表'
---
DDL for table: srm_supplier_offer_detail_audit_record
CREATE TABLE `srm_supplier_offer_detail_audit_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `offer_detail_id` bigint(20) DEFAULT NULL COMMENT '生效中的报价单详情id',
  `edit_price` varchar(255) DEFAULT NULL COMMENT '新价格json',
  `result` tinyint(4) DEFAULT NULL COMMENT '结果0审核中1审核通过2审核拒绝3已作废',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_account` varchar(50) DEFAULT NULL COMMENT '审核账号',
  `creator` int(11) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8 COMMENT='报价审核记录表'
---
DDL for table: srm_supplier_offer_detail_step_price
CREATE TABLE `srm_supplier_offer_detail_step_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `offer_detail_id` bigint(20) DEFAULT NULL COMMENT '报价单详情id',
  `quantity` int(11) NOT NULL DEFAULT '1' COMMENT '数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  KEY `idx_offer_detail_id` (`offer_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3114 DEFAULT CHARSET=utf8 COMMENT='报价详情阶梯价表'
---
DDL for table: srm_supplier_user
CREATE TABLE `srm_supplier_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `phone` varchar(30) DEFAULT NULL COMMENT '手机号',
  `open_id` varchar(50) DEFAULT NULL COMMENT '公众号openId',
  `union_id` varchar(50) DEFAULT NULL COMMENT 'unionId',
  `supplier_id` bigint(20) NOT NULL COMMENT '供应商id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `base_user_id` bigint(20) DEFAULT NULL COMMENT '用户中心表 user_base id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_phone` (`phone`) USING BTREE,
  KEY `idx_base_user_id` (`base_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11755 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: srm_supplier_user_wx_bind
CREATE TABLE `srm_supplier_user_wx_bind` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `open_id` varchar(50) DEFAULT NULL COMMENT '公众号openId',
  `union_id` varchar(50) DEFAULT NULL COMMENT 'unionId',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户中心表 user_base id',
  `head_img_url` varchar(200) DEFAULT NULL COMMENT '头像地址',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新id',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='srm账号绑定微信'
---
DDL for table: stick_storage_record_detail
CREATE TABLE `stick_storage_record_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(255) DEFAULT NULL COMMENT 'sku',
  `quantity` int(11) DEFAULT NULL COMMENT '入库数量',
  `produce_batch_id` int(11) DEFAULT NULL COMMENT '生产批次',
  `stock_storage_record_id` int(11) DEFAULT NULL COMMENT '入库单编号',
  PRIMARY KEY (`id`),
  KEY `n_produce` (`produce_batch_id`),
  KEY `n_storage` (`stock_storage_record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入库单详情'
---
DDL for table: stock_allocation_category_config
CREATE TABLE `stock_allocation_category_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pd_no` varchar(32) NOT NULL COMMENT '商品编号',
  `admin_id` int(11) NOT NULL COMMENT '负责人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `admin_name` varchar(32) NOT NULL COMMENT '负责人name',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_pd_no` (`pd_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=449 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='调拨品类配置表'
---
DDL for table: stock_allocation_config_record
CREATE TABLE `stock_allocation_config_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `config_id` int(11) DEFAULT NULL COMMENT '物流信息配置id',
  `list_no` varchar(45) DEFAULT NULL COMMENT '调拨单编号',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '调出仓编号',
  `allocation_warehouse_no` int(11) DEFAULT NULL COMMENT '调入仓编号',
  `cycle_type` int(11) DEFAULT NULL COMMENT '周期类型：0、天 1、周 2、每两周',
  `logistics_time` int(11) DEFAULT NULL COMMENT '配送时间：星期',
  `next_day_arrive` tinyint(4) DEFAULT NULL COMMENT '是否次日达：0、是  1、不是 （空表示次日达）',
  `sale_partake` tinyint(4) DEFAULT NULL COMMENT '销售参与：0.不参与1.参与',
  `creator` varchar(10) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `updater` varchar(10) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `interval_days` int(11) DEFAULT '1' COMMENT '销量预估天数',
  `purchase_partake` tinyint(4) DEFAULT NULL COMMENT '采购参与：0.不参与1.参与',
  `sale_quantity_start` datetime DEFAULT NULL COMMENT '需求销量开始时间',
  `sale_quantity_end` datetime DEFAULT NULL COMMENT '需求销量结束时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ind_list_no` (`list_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2372 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='调拨单配置备份表'
---
DDL for table: stock_allocation_detail_goods
CREATE TABLE `stock_allocation_detail_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `goods_record_id` int(11) DEFAULT NULL COMMENT '货位详情变更信息id',
  `allocation_detail_id` int(11) DEFAULT NULL COMMENT '调拨单单详情id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='调拨，货位变更信息关联表'
---
DDL for table: stock_allocation_item
CREATE TABLE `stock_allocation_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(45) DEFAULT NULL,
  `list_no` varchar(45) DEFAULT NULL,
  `out_quantity` int(11) DEFAULT '0' COMMENT '调拨数量',
  `reason` varchar(100) DEFAULT NULL COMMENT '调拨原因',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `addtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `pd_name` varchar(45) DEFAULT NULL COMMENT '商品名称',
  `weight` varchar(100) DEFAULT NULL,
  `maturity` varchar(36) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `type` int(3) DEFAULT '0' COMMENT '调拨条目类型：0调拨类型，非调拨',
  `price` decimal(10,2) DEFAULT NULL,
  `allocation_lock_quantity` int(11) DEFAULT '0' COMMENT '调拨冻结数量',
  `is_direct` tinyint(4) DEFAULT '0' COMMENT '是否直采：0.不是1.是',
  `system_adjust` int(11) DEFAULT NULL COMMENT '系统调整',
  `purchaser_adjust` int(11) DEFAULT NULL COMMENT '采购调整',
  `purchase_remark` varchar(255) DEFAULT NULL COMMENT '采购备注',
  `sale_adjust` int(11) DEFAULT NULL COMMENT '销售调整',
  `sale_remark` varchar(255) DEFAULT NULL COMMENT '销售备注',
  `operate_adjust` int(11) DEFAULT NULL COMMENT '运营调整',
  `operate_remark` varchar(255) DEFAULT NULL COMMENT '运营备注',
  `create_role` tinyint(4) DEFAULT '0' COMMENT '0系统1采购2销售3运营',
  `creator` varchar(10) DEFAULT NULL COMMENT '创建人',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)',
  `actual_out_quantity` int(11) DEFAULT '0' COMMENT '实际出库数量',
  `actual_in_quantity` int(11) DEFAULT '0' COMMENT '实际入库数量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_list_no_sku` (`list_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=11900 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='库存调拨条目'
---
DDL for table: stock_allocation_item_detail
CREATE TABLE `stock_allocation_item_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_allocation_item_id` int(11) DEFAULT NULL,
  `purchase_no` varchar(30) DEFAULT NULL,
  `actual_out_quantity` int(11) DEFAULT '0',
  `in_quantity` int(11) DEFAULT '0' COMMENT '实收数量',
  `reject_quantity` int(11) DEFAULT '0' COMMENT '拒收数量',
  `reject_reason` varchar(45) DEFAULT NULL COMMENT '拒收原因',
  `addtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_allocation_item_id` (`stock_allocation_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=598 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='库存调拨条目详情'
---
DDL for table: stock_allocation_item_quality_period
CREATE TABLE `stock_allocation_item_quality_period` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `stock_allocation_item_id` bigint(20) DEFAULT NULL COMMENT '调拨详情id',
  `produce_period_start_time` date DEFAULT NULL COMMENT '保质期开始时间',
  `produce_period_end_time` date DEFAULT NULL COMMENT '保质期结束时间',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `creator_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  `updater_id` int(11) DEFAULT NULL COMMENT '更新人id',
  `updater_name` varchar(100) DEFAULT NULL COMMENT '更新人名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)',
  PRIMARY KEY (`id`),
  KEY `idx_stock_allocation_item_id` (`stock_allocation_item_id`,`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=2357 DEFAULT CHARSET=utf8 COMMENT='调拨单sku保质期'
---
DDL for table: stock_allocation_list
CREATE TABLE `stock_allocation_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `list_no` varchar(45) DEFAULT NULL,
  `create_admin` int(11) DEFAULT NULL COMMENT '调拨发起人admin_id',
  `audit_admin` int(11) DEFAULT NULL COMMENT '审核人admin_id',
  `out_store` int(11) DEFAULT NULL COMMENT '调出仓',
  `in_store` int(11) DEFAULT NULL COMMENT '调入仓',
  `out_time` datetime DEFAULT NULL COMMENT '出库时间',
  `expect_time` datetime DEFAULT NULL COMMENT '期望入库时间',
  `status` int(11) DEFAULT NULL COMMENT '调拨单状态: 0-草稿，4-待出库，5-待入库，6-已入库，7-已关闭',
  `in_time` datetime DEFAULT NULL COMMENT '到货时间',
  `transport` int(11) DEFAULT NULL COMMENT '运输方式',
  `tracking_no` varchar(45) DEFAULT NULL COMMENT '物流单号',
  `addtime` datetime DEFAULT NULL,
  `create_admin_name` varchar(45) DEFAULT NULL,
  `audit_admin_name` varchar(45) DEFAULT NULL,
  `out_store_name` varchar(45) DEFAULT NULL,
  `in_store_name` varchar(45) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `in_store_admin` int(11) DEFAULT NULL COMMENT '入库仓库负责人',
  `in_store_admin_name` varchar(45) DEFAULT NULL,
  `out_store_admin` int(11) DEFAULT NULL COMMENT '出库仓库负责人',
  `out_store_admin_name` varchar(45) DEFAULT NULL,
  `out_status` int(11) DEFAULT '0' COMMENT '调入仓负责人确认,0待确认，1通过2不通过',
  `in_status` int(11) DEFAULT '0' COMMENT '调入仓负责人确认',
  `order_type` int(11) DEFAULT NULL COMMENT '单据类型:1:手动创建;2:自动创建;3:手动创建(自动计算);4:调拨计划创建',
  `expect_out_time` datetime DEFAULT NULL COMMENT '期望出库时间',
  `plan_list_no` varchar(20) DEFAULT NULL COMMENT '调拨计划单号',
  `next_day_arrive` int(11) DEFAULT NULL COMMENT '是否次日达：0、是  1、不是 （空表示次日达）',
  `plan_list_id` bigint(20) DEFAULT NULL COMMENT '调拨计划id',
  `trunk_flag` int(11) DEFAULT NULL COMMENT '干线调度(0:否 1:是)',
  `storage_location` int(11) DEFAULT NULL COMMENT '1:冷冻 2:冷藏 3:冷冻+冷藏 4:常温 5:常温+冷冻 6:冷藏+常温 7:冷冻+冷藏+常温，以2的次方表示单一类型',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)',
  `out_warehouse_tenant_id` bigint(20) DEFAULT NULL COMMENT '调出仓租户id',
  `in_warehouse_tenant_id` bigint(20) DEFAULT NULL COMMENT '调入仓租户id',
  `phone` varchar(20) DEFAULT NULL COMMENT '创建人电话',
  `tenant_name` varchar(50) DEFAULT NULL COMMENT '品牌方名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `list_no_UNIQUE` (`list_no`) USING BTREE,
  KEY `idx_out_time` (`out_time`),
  KEY `stock_allocation_list_out_time_IDX` (`out_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8508 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='库存调拨单'
---
DDL for table: stock_allocation_process
CREATE TABLE `stock_allocation_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `list_no` varchar(45) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人',
  `addtime` datetime DEFAULT NULL COMMENT '操作时间',
  `step` int(11) DEFAULT NULL COMMENT '操作步骤',
  `remark` varchar(100) DEFAULT NULL,
  `admin_name` varchar(45) DEFAULT NULL,
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14558 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='库存调拨流程记录'
---
DDL for table: stock_allocation_quick_record
CREATE TABLE `stock_allocation_quick_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `list_no` varchar(30) NOT NULL COMMENT '调拨单编号',
  `actual_out_quantity` int(10) unsigned DEFAULT NULL COMMENT '实出数量',
  `in_quantity` int(10) unsigned DEFAULT '0' COMMENT '实收数量',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0：待入库 1：部分入库 2：已入库',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `in_store` int(11) DEFAULT NULL,
  `out_store` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE,
  KEY `idx_purchase_no` (`list_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1054 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='调拨库存次日达记录表'
---
DDL for table: stock_arrange
CREATE TABLE `stock_arrange` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单编号',
  `stock_task_id` int(11) DEFAULT NULL COMMENT '任务id',
  `state` tinyint(4) DEFAULT NULL COMMENT '状态:0、正常,1、已完成,2、已取消，3、已关闭',
  `arrange_time` date DEFAULT NULL COMMENT '预约入库时间',
  `admin_id` int(11) DEFAULT NULL COMMENT '发起人id',
  `admin_name` varchar(30) DEFAULT NULL COMMENT '发起人',
  `arrange_remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `is_close` tinyint(4) DEFAULT '0' COMMENT '操作标识:0未更新1已更新 （乐观锁）',
  `multi_supplier` tinyint(4) DEFAULT '0' COMMENT '是否是多供应商0否1是',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `source` varchar(255) NOT NULL DEFAULT 'xianmu' COMMENT '来源:xianmu,saas',
  `tenant_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '租户id',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_task_id` (`stock_task_id`) USING BTREE,
  KEY `idx_purchase_no` (`purchase_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23060 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='入库预约单表'
---
DDL for table: stock_arrange_item
CREATE TABLE `stock_arrange_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `stock_arrange_id` int(11) DEFAULT NULL COMMENT '预约单id',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `arrival_quantity` int(11) DEFAULT '0' COMMENT '预约数量',
  `actual_quantity` int(11) DEFAULT '0' COMMENT '实到数量',
  `pd_name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `supplier` varchar(100) DEFAULT NULL COMMENT '供应商',
  `type` tinyint(4) DEFAULT NULL COMMENT '商品归属: 0 自营 1 代仓',
  `quality_time` int(11) DEFAULT NULL COMMENT '保质期时长',
  `quality_time_unit` varchar(10) DEFAULT NULL COMMENT '保质期时长单位',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `supplier_id` bigint(20) DEFAULT NULL COMMENT '供应商id',
  `abnormal_quantity` int(11) DEFAULT '0' COMMENT '异常数量',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE,
  KEY `idx_stock_arrange_id` (`stock_arrange_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26017 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='入库预约单条目表'
---
DDL for table: stock_arrange_item_detail
CREATE TABLE `stock_arrange_item_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `stock_arrange_item_id` int(11) DEFAULT NULL COMMENT '预约单条目id',
  `stock_arrange_id` int(11) DEFAULT NULL COMMENT '预约单id',
  `stock_task_id` int(11) DEFAULT NULL COMMENT '任务id',
  `arr_quantity` int(10) unsigned DEFAULT '0' COMMENT '预约数量',
  `quantity` int(11) DEFAULT '0' COMMENT '到货数量',
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编号',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `updater` varchar(255) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_task_id` (`stock_task_id`) USING BTREE,
  KEY `idx_sku` (`sku`) USING BTREE,
  KEY `idx_item_id` (`stock_arrange_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40660 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='入库预约单条目详情表'
---
DDL for table: stock_inspect_detail
CREATE TABLE `stock_inspect_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_task_process_id` int(11) DEFAULT NULL COMMENT '入库单编号',
  `area_no` int(11) DEFAULT NULL COMMENT 'warehouseNo:城市编号',
  `sku` varchar(36) DEFAULT NULL COMMENT 'sku',
  `pd_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 自营 1 代仓',
  `storage_location` tinyint(2) DEFAULT NULL COMMENT '仓储区域',
  `quality_time` int(10) DEFAULT NULL COMMENT '保质期时长',
  `quality_time_unit` varchar(30) DEFAULT NULL COMMENT '保质期时长单位',
  `supplier` varchar(100) DEFAULT NULL COMMENT '供应商',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `quantity` int(11) DEFAULT NULL COMMENT '采购数量',
  `in_quantity` int(11) DEFAULT '0' COMMENT '实收数量',
  `check_quantity` int(11) DEFAULT '0' COMMENT '抽检数量',
  `qualified_quantity` int(11) DEFAULT '0' COMMENT '合格数量',
  `photos` varchar(500) DEFAULT NULL COMMENT '照片',
  `status` int(2) DEFAULT '0' COMMENT '0待捡货、1已捡货、2关闭',
  `evaluate` text COMMENT '货检评价',
  `updater` varchar(10) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` varchar(10) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `unit` varchar(5) DEFAULT NULL COMMENT '包装',
  `storage_method` varchar(10) DEFAULT NULL COMMENT '储存区域',
  `damage_quantity` int(11) DEFAULT NULL COMMENT '内质货损数量',
  `inspect_persons` tinyint(4) DEFAULT '3' COMMENT '质检人数',
  `failed_num` int(11) DEFAULT '0' COMMENT '不合格数',
  `pick_num` int(11) DEFAULT '0' COMMENT '挑选次数',
  `audit_proof` varchar(1000) DEFAULT '' COMMENT '审批证明',
  `receipt_method` int(11) DEFAULT '-1' COMMENT '收货方式',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id(saas品牌方)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `stock_task_process_id` (`stock_task_process_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1033 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='货检任务详情表'
---
DDL for table: stock_shipment_item
CREATE TABLE `stock_shipment_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_task_id` int(11) NOT NULL COMMENT '任务编号',
  `sku` varchar(30) NOT NULL COMMENT '产品编号',
  `actual_quantity` int(10) unsigned DEFAULT '0' COMMENT '实际出库数量',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `quantity` int(10) unsigned DEFAULT NULL COMMENT '出库数量',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_task_id` (`stock_task_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6658 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='出库任务条目表'
---
DDL for table: stock_shipment_item_detail
CREATE TABLE `stock_shipment_item_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_shipment_item_id` int(11) NOT NULL COMMENT '出库条目id',
  `purchase_no` varchar(30) NOT NULL COMMENT '采购编号',
  `actual_out_quantity` int(11) DEFAULT '0' COMMENT '实出数量',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `gl_no` varchar(30) DEFAULT NULL COMMENT '货位编号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `cabinet_code` varchar(64) DEFAULT NULL COMMENT '库位编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_shipment_item_id` (`stock_shipment_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4670 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='出库任务条目明细表'
---
DDL for table: stock_storage_item
CREATE TABLE `stock_storage_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_task_id` int(11) NOT NULL COMMENT '任务编号',
  `sku` varchar(30) NOT NULL COMMENT '产品编号',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '入库数量',
  `actual_quantity` int(10) unsigned DEFAULT '0' COMMENT '实际入库数量',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `stock_task_storage_id` int(11) DEFAULT NULL COMMENT '入库任务id',
  `category_type` tinyint(4) DEFAULT NULL COMMENT '类目类型',
  `specification` varchar(355) DEFAULT NULL COMMENT '规格',
  `packaging` varchar(255) DEFAULT NULL COMMENT '包装',
  `supplier` varchar(255) DEFAULT NULL COMMENT '供应商',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `pd_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `sku_type` tinyint(4) DEFAULT NULL COMMENT '带仓',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id(saas品牌方)',
  `after_sale_order_no` varchar(1024) DEFAULT NULL COMMENT '售后单号',
  `fulfillment_no` varchar(64) DEFAULT NULL COMMENT '履约单号',
  `after_sale_reason` varchar(127) DEFAULT NULL COMMENT '售后原因',
  `stack_rule` varchar(16) DEFAULT NULL COMMENT '码放规则',
  `category` varchar(16) DEFAULT NULL COMMENT '三级类目',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_stock_task_id` (`stock_task_id`) USING BTREE,
  KEY `index_stock_storage_id` (`stock_task_storage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=266808 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='入库任务条目表'
---
DDL for table: stock_storage_item_detail
CREATE TABLE `stock_storage_item_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_storage_item_id` int(11) NOT NULL COMMENT '条目id',
  `purchase_no` varchar(30) NOT NULL COMMENT '采购编号',
  `actual_in_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实入数量',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `should_in_quantity` int(11) DEFAULT '0' COMMENT '应入数量',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id(saas品牌方)',
  `receiving_container` varchar(32) DEFAULT NULL COMMENT '收货容器',
  `specify` tinyint(4) DEFAULT '0' COMMENT '是否是业务指定的效期明细0:指定，1：非指定',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_storage_item_id` (`stock_storage_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73593 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='入库任务条目明细表'
---
DDL for table: stock_storage_record
CREATE TABLE `stock_storage_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_storage_task_id` int(11) DEFAULT NULL COMMENT '入库任务id',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入库单'
---
DDL for table: stock_store_back_up
CREATE TABLE `stock_store_back_up` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `store_no` int(11) NOT NULL COMMENT '原城配仓',
  `cut_store_no` int(11) NOT NULL COMMENT '切换到城配仓',
  `admin_id` int(11) NOT NULL COMMENT '操作人adminId',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='备份表'
---
DDL for table: stock_store_back_up_detail
CREATE TABLE `stock_store_back_up_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `store_back_up_id` bigint(20) NOT NULL COMMENT '备份id',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `sku` varchar(30) NOT NULL COMMENT 'sku编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_back_up_id` (`store_back_up_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=198101 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='备份明细表'
---
DDL for table: stock_taking_item
CREATE TABLE `stock_taking_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taking_id` int(11) NOT NULL COMMENT '盘点表id',
  `sku` varchar(20) DEFAULT NULL,
  `pd_name` varchar(30) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `store_quantity` int(11) DEFAULT NULL COMMENT '仓库库存',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '当前sku状态：0未盘点、1盘点中、2审核中、3已盘点',
  `gl_no` varchar(50) DEFAULT '0' COMMENT '货位编号',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库号',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID 1-鲜沐',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `stock_taking_item_taking_id_sku_index` (`taking_id`,`sku`) USING BTREE,
  KEY `warehouse_no_sku` (`warehouse_no`,`sku`),
  KEY `idx_tenant` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16534 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='盘点条目表'
---
DDL for table: stock_taking_list
CREATE TABLE `stock_taking_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taking_id` int(11) NOT NULL COMMENT '盘点表id',
  `admin_id` int(11) DEFAULT NULL COMMENT '盘点人',
  `handler` int(11) DEFAULT NULL COMMENT '审核人',
  `remark` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '状态:0盘点中、1审核中、2成功、3关闭',
  `updatetime` datetime DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `updater` varchar(36) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `stock_taking_list_taking_id_index` (`taking_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2763 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='盘点单'
---
DDL for table: stock_taking_list_detail
CREATE TABLE `stock_taking_list_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_taking_list_id` int(11) DEFAULT '0' COMMENT '盘点单id(废弃)',
  `sku` varchar(20) DEFAULT NULL,
  `pd_name` varchar(30) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL COMMENT '仓库库存',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `batch` varchar(20) DEFAULT NULL COMMENT '采购批次',
  `real_quantity` int(11) DEFAULT NULL COMMENT '订正库存',
  `reason` varchar(255) DEFAULT NULL,
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编号',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `reason_type` tinyint(4) DEFAULT NULL COMMENT '原因类型',
  `stocktaking_item_id` bigint(20) unsigned DEFAULT NULL COMMENT 'item表id',
  `deleted_at` bigint(20) unsigned DEFAULT '0' COMMENT '删除时间',
  `produce_batch` bigint(20) unsigned DEFAULT NULL COMMENT '生产批次',
  `diff_stock` bigint(20) DEFAULT NULL COMMENT '盘点库存差值',
  `cabinet_inventory_id` bigint(20) DEFAULT NULL COMMENT '库位库存id',
  `cabinet_code` varchar(30) DEFAULT NULL COMMENT '库位编码',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID 1-鲜沐',
  `cost` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '批次成本',
  `biz_option` int(10) unsigned DEFAULT NULL COMMENT '标志位 10-pda批次修改',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `stock_taking_list_detail_stock_taking_list_id_index` (`stocktaking_item_id`,`deleted_at`),
  KEY `idx_stock_taking_list_id` (`stock_taking_list_id`),
  KEY `idx_tenant` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16456 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='盘点单详情'
---
DDL for table: stock_task
CREATE TABLE `stock_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务编号',
  `task_no` varchar(30) DEFAULT NULL COMMENT '任务订单编号',
  `area_no` int(11) DEFAULT NULL COMMENT '库存仓',
  `type` int(11) DEFAULT '0' COMMENT '出入库类型：10-调拨入库、11-采购入库、12-退货入库、13-拒收回库、14-调拨未收入库（实收+拒收小于实发的情况）、15-盘盈入库、16-转换入库、17-终止调拨回库、19、新退货入库、20、缺货入库、30-批次调整、31-安全库存、50-调拨出库、51-销售出库、52-出样出库、53-货损出库、54-盘亏出库、55-转换出库、56-采购退货出库、57-补货出库、58-销售自提、59-调拨货损出库',
  `expect_time` datetime DEFAULT NULL COMMENT '预期出(入)库时间',
  `state` int(11) DEFAULT '0' COMMENT '出入库进展: 0待入(出)库 1部分入(出)库 2已入(出)库\n采购类型 01状态为正常 2 已完成 3 已取消 4已关闭',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `admin_id` int(11) DEFAULT NULL COMMENT '发起人',
  `updatetime` datetime DEFAULT NULL,
  `out_store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `out_type` int(2) DEFAULT NULL COMMENT '出库性质，0普通 1越库',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `dimension` int(2) DEFAULT '0' COMMENT '盘点维度：0、SKU 1、类目 2、货位 3、批次,转换维度：0、库存转换 1、降级转换',
  `process_state` tinyint(4) DEFAULT '0' COMMENT '入库进度:0、全未入库1、部分入库2、完全入库',
  `mismatch_reason` varchar(100) DEFAULT NULL COMMENT '应入不符原因',
  `transition_field` int(11) DEFAULT NULL COMMENT '库存编号初始化过渡字段',
  `task_type` int(11) DEFAULT NULL COMMENT '任务类型 1、退货 2、拒收 3、拦截',
  `category` varchar(20) DEFAULT NULL COMMENT '类目名称',
  `close_reason` varchar(255) DEFAULT NULL COMMENT '关闭原因',
  `updater` varchar(36) DEFAULT NULL COMMENT '最后修改人admin_id',
  `option_flag` bigint(20) DEFAULT '0' COMMENT '扩展标志位',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID 1-鲜沐',
  `inventory_locked` tinyint(4) DEFAULT NULL COMMENT '库存冻结状态（0：未冻结，1：已冻结）',
  `system_source` int(11) DEFAULT '0' COMMENT '系统来源 0-内部 1-外部',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `task_no` (`task_no`) USING BTREE,
  KEY `expect_time_index` (`expect_time`) USING BTREE,
  KEY `type_index` (`type`,`area_no`) USING BTREE,
  KEY `idx_area_type` (`area_no`,`state`,`task_no`)
) ENGINE=InnoDB AUTO_INCREMENT=225960 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='出入库任务表'
---
DDL for table: stock_task_abnormal_record
CREATE TABLE `stock_task_abnormal_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_task_id` bigint(20) NOT NULL COMMENT '任务id',
  `sku` varchar(30) NOT NULL COMMENT 'sku编号',
  `quantity` int(11) NOT NULL COMMENT '异常数量',
  `reason_type` tinyint(4) NOT NULL COMMENT '0少货 1拒收',
  `create_admin_id` int(11) NOT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`),
  KEY `idx_task_id_sku` (`stock_task_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=2328 DEFAULT CHARSET=utf8 COMMENT='任务异常记录'
---
DDL for table: stock_task_item
CREATE TABLE `stock_task_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_task_id` int(11) DEFAULT NULL COMMENT '任务编号',
  `sku` varchar(30) NOT NULL COMMENT '产品编号',
  `quantity` int(10) unsigned DEFAULT '0' COMMENT '入(出)库数量',
  `actual_quantity` int(10) unsigned DEFAULT '0' COMMENT '实际入(出)库数量',
  `old_quantity` int(11) DEFAULT '0' COMMENT '采购退货前数量（未采购退货时为空）',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID 1-鲜沐',
  `inventory_locked` tinyint(4) DEFAULT NULL COMMENT '库存冻结状态（0：未冻结，1：已冻结）',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  `supplier` varchar(255) DEFAULT NULL COMMENT '供应商',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_stock_task_id` (`stock_task_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85088 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='出入库任务条目'
---
DDL for table: stock_task_item_detail
CREATE TABLE `stock_task_item_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_task_item_id` int(11) DEFAULT NULL,
  `sku` varchar(30) NOT NULL COMMENT '产品编号',
  `list_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `quality_date` date DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT '0' COMMENT '入(出)库数量',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编号',
  `should_quantity` int(11) DEFAULT '0' COMMENT '应出数量',
  `out_store_quantity` int(11) DEFAULT '0' COMMENT '出库数量',
  `system_generation` int(11) DEFAULT '0' COMMENT '是否是手动添加',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `cabinet_code` varchar(64) DEFAULT NULL COMMENT '库位编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `kk_batch` (`stock_task_item_id`,`sku`,`list_no`,`quality_date`,`gl_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22199 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='出入库任务条目详情'
---
DDL for table: stock_task_mail_push_record
CREATE TABLE `stock_task_mail_push_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `stock_task_no` int(11) DEFAULT NULL COMMENT '出库任务编号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `admin_id` int(11) DEFAULT NULL COMMENT '发起人',
  `state` int(11) DEFAULT '0' COMMENT '推送状态',
  `fail_reason` varchar(255) DEFAULT NULL COMMENT '失败原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8 COMMENT='出库任务邮件推送记录表'
---
DDL for table: stock_task_pick
CREATE TABLE `stock_task_pick` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `pd_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `weight` varchar(100) DEFAULT NULL COMMENT '规格',
  `amount` int(11) DEFAULT NULL COMMENT '捡货数量',
  `admin_id` int(11) DEFAULT NULL COMMENT '大客户id',
  `admin_name` varchar(30) DEFAULT NULL COMMENT '大客户备注名称',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 大客户-水果 ，1 其他',
  `store_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `close_order_time` varchar(50) DEFAULT NULL COMMENT '大客户提前截单时间',
  `out_store_no` int(11) DEFAULT NULL COMMENT '出库仓',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_no_delivery_time` (`store_no`,`delivery_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26807 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='捡获任务'
---
DDL for table: stock_task_pick_detail
CREATE TABLE `stock_task_pick_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_task_pick_id` int(11) DEFAULT NULL COMMENT '捡货单id',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `gl_no` varchar(30) DEFAULT NULL COMMENT '货位编号',
  `list_no` varchar(30) DEFAULT NULL COMMENT '批次号',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `should_quantity` int(11) DEFAULT NULL COMMENT '应出数量',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_task_pick_id` (`stock_task_pick_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19566 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='捡获单详情'
---
DDL for table: stock_task_pick_item
CREATE TABLE `stock_task_pick_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `amount` int(11) DEFAULT NULL COMMENT '捡货数量',
  `admin_id` int(11) DEFAULT NULL COMMENT '大客户id',
  `admin_name` varchar(30) DEFAULT NULL COMMENT '大客户备注名称',
  `type` int(11) DEFAULT NULL COMMENT '类型 0 大客户-水果 ，1 其他',
  `out_store_no` int(11) DEFAULT NULL COMMENT '出库仓编号',
  `store_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `close_order_time` varchar(50) DEFAULT NULL COMMENT '大客户提前截单时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26513 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='捡获任务条目'
---
DDL for table: stock_task_process
CREATE TABLE `stock_task_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_task_id` int(11) DEFAULT NULL COMMENT '任务编号',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `recorder` varchar(45) DEFAULT NULL,
  `in_bound_order_id` bigint(20) unsigned DEFAULT NULL COMMENT '入库单新模型id',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID 1-鲜沐',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `stock_task_process_task_index` (`stock_task_id`) USING BTREE,
  KEY `idx_tenant` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95752 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='出入库任务单表'
---
DDL for table: stock_task_process_detail
CREATE TABLE `stock_task_process_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `stock_task_process_id` int(11) DEFAULT NULL COMMENT '出入库任务单表id',
  `item_id` int(11) DEFAULT NULL COMMENT '出入库条目id',
  `sku` varchar(30) NOT NULL COMMENT '转入sku',
  `list_no` varchar(30) DEFAULT NULL COMMENT '转出批次',
  `quality_date` date DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT '0' COMMENT '入(出)库数量',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `remark` varchar(500) DEFAULT NULL,
  `transfer_scale` varchar(30) DEFAULT NULL COMMENT '转换比例',
  `transfer_sku` varchar(33) DEFAULT NULL COMMENT '转出sku',
  `transfer_quantity` int(11) DEFAULT NULL COMMENT '转出数量',
  `create_time` datetime DEFAULT NULL COMMENT '转出时间',
  `creator` varchar(30) DEFAULT NULL COMMENT '操作人',
  `gl_no` varchar(50) DEFAULT NULL COMMENT '货位编号',
  `in_gl_no` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '出库详情状态：0、未生效 1、已生效',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `transfer_list_no` varchar(40) DEFAULT NULL COMMENT '转换到批次号',
  `state` int(11) DEFAULT NULL COMMENT '出库详情关联发票状态： 1、已关联',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID 1-鲜沐',
  `liable_owner` varchar(64) DEFAULT NULL COMMENT '货损责任方',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  `cabinet_code` varchar(64) DEFAULT NULL COMMENT '库位编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `stock_task_process_detail_lsp_index` (`list_no`,`sku`,`quality_date`) USING BTREE,
  KEY `stock_task_process_detail_process_index` (`stock_task_process_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101342 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='出入库任务单详情表表'
---
DDL for table: stock_task_process_expand
CREATE TABLE `stock_task_process_expand` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_task_process_detail_id` int(11) NOT NULL COMMENT '出入库单明细id',
  `is_complete` tinyint(4) NOT NULL COMMENT '供应商证件是否齐全0 不齐 1 齐',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_process_detail_id` (`stock_task_process_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3215 DEFAULT CHARSET=utf8 COMMENT='入库单拓展表'
---
DDL for table: stock_task_storage
CREATE TABLE `stock_task_storage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `source_id` varchar(50) DEFAULT NULL COMMENT '来源单号',
  `type` int(10) unsigned DEFAULT NULL COMMENT '入库任务类型',
  `state` int(11) DEFAULT NULL COMMENT '状态入库进度',
  `expect_time` datetime DEFAULT NULL COMMENT '预约入库时间',
  `in_warehouse_no` int(11) DEFAULT NULL COMMENT '入库库存仓编号',
  `out_warehouse_no` int(11) DEFAULT NULL COMMENT '城配仓(货品来源仓)',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `in_warehouse_name` varchar(50) DEFAULT NULL COMMENT '入库仓名称',
  `out_warehouse_name` varchar(50) DEFAULT NULL COMMENT '出库仓名称',
  `process_state` tinyint(4) DEFAULT NULL COMMENT '入库进度',
  `category` tinyint(4) DEFAULT NULL COMMENT '鲜果,非鲜果',
  `close_reason` varchar(255) DEFAULT NULL COMMENT '关闭原因',
  `mismatch_reason` varchar(255) DEFAULT NULL COMMENT '应入不符合原因',
  `stock_task_id` bigint(20) DEFAULT NULL COMMENT '旧任务id',
  `operator_name` varchar(255) DEFAULT NULL COMMENT '操作人名称',
  `ownership` varchar(255) DEFAULT NULL COMMENT '任务归属人',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id(saas品牌方)',
  `after_sale_order_no` varchar(1024) DEFAULT NULL COMMENT '售后单号',
  `file_address` varchar(1024) DEFAULT NULL COMMENT '文件上传地址',
  `close_time` datetime DEFAULT NULL COMMENT '关闭时间',
  `fulfillment_no` varchar(64) DEFAULT NULL COMMENT '履约单号',
  `cargo_owner` varchar(32) DEFAULT NULL COMMENT '货主',
  `arrival_time` datetime DEFAULT NULL COMMENT '到货时间',
  `receiving_state` int(11) DEFAULT '10' COMMENT '收货状态（默认未确认收货）',
  `receipt_url` varchar(1024) DEFAULT '' COMMENT '任务票据',
  `system_source` int(11) DEFAULT '0' COMMENT '系统来源 0-内部 1-外部',
  `pso_no` varchar(32) DEFAULT NULL COMMENT 'OFC批次号',
  `unique_key` varchar(32) DEFAULT NULL COMMENT '幂等键，不同type类型不同规则',
  PRIMARY KEY (`id`),
  KEY `n_task_no` (`source_id`),
  KEY `n_warehouse_time` (`in_warehouse_no`,`out_warehouse_no`,`stock_task_id`),
  KEY `idx_stocktaskid` (`stock_task_id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_warehouse_type` (`in_warehouse_no`,`type`,`expect_time`)
) ENGINE=InnoDB AUTO_INCREMENT=408320 DEFAULT CHARSET=utf8 COMMENT='入库任务主表'
---
DDL for table: stock_transfer
CREATE TABLE `stock_transfer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) unsigned DEFAULT '0' COMMENT '库存编号',
  `transfer_dimension` int(10) unsigned DEFAULT '0' COMMENT '转换维度',
  `state` int(10) unsigned DEFAULT '0' COMMENT '状态',
  `operator` varchar(32) DEFAULT '' COMMENT '操作人',
  `remark` varchar(128) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `uid_stste_dem_no` (`warehouse_no`,`state`,`transfer_dimension`)
) ENGINE=InnoDB AUTO_INCREMENT=4477 DEFAULT CHARSET=utf8 COMMENT='库存转换表'
---
DDL for table: stock_transfer_item
CREATE TABLE `stock_transfer_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `pre_transfer_in_num` bigint(20) unsigned DEFAULT '0' COMMENT '预转入数量',
  `transfer_in_sku` varchar(128) DEFAULT '' COMMENT '转入sku',
  `stock_transfer_id` bigint(20) unsigned DEFAULT '0' COMMENT '关联表id',
  PRIMARY KEY (`id`),
  KEY `uid_sku` (`transfer_in_sku`),
  KEY `uid_transfer_id` (`stock_transfer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4811 DEFAULT CHARSET=utf8 COMMENT='库存转换实例表'
---
DDL for table: stock_transfer_item_op
CREATE TABLE `stock_transfer_item_op` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_transfer_item_id` bigint(20) unsigned DEFAULT '0' COMMENT '关联表id',
  `type` int(10) unsigned DEFAULT '0' COMMENT '类型',
  `transfer_ratio` varchar(32) DEFAULT '' COMMENT '转换比例',
  `transfer_out_sku` varchar(128) DEFAULT '' COMMENT '转出sku',
  `produce_date` bigint(20) unsigned DEFAULT '0' COMMENT '生产日期',
  `operator` varchar(32) DEFAULT '' COMMENT '操作人',
  `shelf_life` bigint(20) unsigned DEFAULT '0' COMMENT '保质期',
  PRIMARY KEY (`id`),
  KEY `uid_item_id` (`stock_transfer_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6102 DEFAULT CHARSET=utf8 COMMENT='实例操作表'
---
DDL for table: stock_transfer_item_op_detail
CREATE TABLE `stock_transfer_item_op_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_transfer_item_op_id` bigint(20) unsigned DEFAULT '0' COMMENT '关联表id',
  `transfer_out_batch` varchar(128) DEFAULT '' COMMENT '转出批次',
  `transfer_out_num` bigint(20) unsigned DEFAULT '0' COMMENT '转出数量',
  `transfer_in_batch` varchar(128) DEFAULT '' COMMENT '转入批次',
  `produce_at` bigint(20) unsigned DEFAULT '0' COMMENT '转出批次生产日期',
  `shelf_life` bigint(20) unsigned DEFAULT '0' COMMENT '转出批次保质期',
  `transfer_out_cabinet` varchar(32) DEFAULT NULL COMMENT '转出库位',
  `transfer_in_cabinet` varchar(32) DEFAULT NULL COMMENT '转入库位',
  PRIMARY KEY (`id`),
  KEY `uid_op_id_batch` (`stock_transfer_item_op_id`,`transfer_out_batch`)
) ENGINE=InnoDB AUTO_INCREMENT=6363 DEFAULT CHARSET=utf8 COMMENT='操作详情表'
---
DDL for table: stock_warehouse_change_task
CREATE TABLE `stock_warehouse_change_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `store_no` int(11) DEFAULT NULL COMMENT '原城配仓',
  `cut_store_no` int(11) DEFAULT NULL COMMENT '复制到城配仓',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型:0复制 1备份',
  `state` tinyint(4) DEFAULT '0' COMMENT '任务状态 0待执行 1执行中 2执行完毕',
  `back_up_id` int(11) DEFAULT NULL COMMENT '还原备份id',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人adminId',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=579 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='修改库存仓任务表'
---
DDL for table: stocktaking
CREATE TABLE `stocktaking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checker` varchar(30) DEFAULT NULL COMMENT '盘点人',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `status` int(11) DEFAULT '1' COMMENT '1盘点中，2盘点完成',
  `check_date` date DEFAULT NULL COMMENT '盘点时间',
  `area_no` int(11) DEFAULT NULL COMMENT '仓库号',
  `type` int(2) NOT NULL DEFAULT '1' COMMENT '盘点类型:1全盘、2循环盘点',
  `stock_taking_no` varchar(30) DEFAULT NULL COMMENT '盘点单号',
  `updatetime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `cycle` tinyint(4) DEFAULT '3' COMMENT '盘点周期',
  `audit_state` tinyint(4) DEFAULT '0' COMMENT '审核状态',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户ID 1-鲜沐',
  `method` int(11) DEFAULT '10' COMMENT '盘点方式  10-明盘  20-盲盘',
  `system_source` int(11) DEFAULT '0' COMMENT '系统来源 0-内部 1-外部',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `status_warehouse_no` (`area_no`,`status`),
  KEY `idx_tenant` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8946 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: stocktaking_copy
CREATE TABLE `stocktaking_copy` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `checker` varchar(30) DEFAULT NULL COMMENT '盘点人',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `status` int(11) DEFAULT '1' COMMENT '1盘点中，2盘点完成',
  `check_date` date DEFAULT NULL COMMENT '盘点时间',
  `area_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: stocktaking_shadow
CREATE TABLE `stocktaking_shadow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `checker` varchar(30) DEFAULT NULL COMMENT '盘点人',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `status` int(11) DEFAULT '1' COMMENT '1盘点中，2盘点完成',
  `check_date` date DEFAULT NULL COMMENT '盘点时间',
  `area_no` int(11) DEFAULT NULL COMMENT '仓库号',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '盘点类型:1全盘、2循环盘点',
  `stock_taking_no` varchar(30) DEFAULT NULL COMMENT '盘点单号',
  `updatetime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `cycle` tinyint(4) DEFAULT '3' COMMENT '盘点周期',
  `audit_state` tinyint(4) DEFAULT '0' COMMENT '审核状态',
  PRIMARY KEY (`id`),
  KEY `status_warehouse_no` (`area_no`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='盘点影子表'
---
DDL for table: stocktakingdetail
CREATE TABLE `stocktakingdetail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(20) DEFAULT NULL,
  `sku_name` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `weight` varchar(100) DEFAULT NULL COMMENT '重量',
  `quantity` int(11) DEFAULT NULL COMMENT '仓库库存',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `batch` varchar(20) DEFAULT NULL COMMENT '采购批次',
  `real_quantity` int(11) DEFAULT NULL COMMENT '订正库存',
  `reason` varchar(200) DEFAULT NULL COMMENT '订正事由',
  `status` int(11) DEFAULT '1' COMMENT '1盘点中盘点项未确认，2盘点中盘点项确认，3盘点结束后正常库存，4盘点结束后异常库存',
  `taking_id` int(11) DEFAULT NULL COMMENT '盘点记录',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: store_allocation
CREATE TABLE `store_allocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '是否生效 0 生效 1 失效',
  `type` tinyint(4) DEFAULT NULL COMMENT '周期类型  1 星期 2 月',
  `store_no` int(11) DEFAULT NULL COMMENT '调入仓编号',
  `out_store_no` int(11) DEFAULT NULL COMMENT '调出仓信息',
  `allocation_time` varchar(50) DEFAULT NULL COMMENT '调拨时间信息',
  `next_day_reach` tinyint(4) DEFAULT NULL COMMENT '是否是次日达 0 是 1 否',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='仓库调拨周期详情信息表'
---
DDL for table: store_record
CREATE TABLE `store_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `sku` varchar(36) DEFAULT NULL,
  `type` int(11) DEFAULT '0' COMMENT '更新事由：10-调拨入库、11-采购入库、12-退货入库、13-拒收回库、14-调拨未收入库（实收+拒收小于实发的情况）、15-盘盈入库、16-转换入库、17-终止调拨回库、19、新退货入库、30-批次调整、31-安全库存、50-调拨出库、51-销售出库、52-出样出库、53-货损出库、54-盘亏出库、55-转换出库、56-采购退货出库、57-补货出库、58-销售自提、',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `recorder` varchar(36) DEFAULT NULL COMMENT '记录人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `area_no` int(11) DEFAULT NULL,
  `store_quantity` int(11) DEFAULT NULL COMMENT '批次-保质期 剩余数量',
  `cost` decimal(10,2) DEFAULT '0.00' COMMENT '单件成本',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `lot_type` int(2) DEFAULT '0' COMMENT '批次类型：0、正常批次 1、降级批次',
  `insert_type` tinyint(4) DEFAULT '0' COMMENT '修改来源',
  `biz_id` varchar(256) DEFAULT '' COMMENT '业务id',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)，鲜沐为1',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sku_batch_qualitydate_areano` (`batch`,`sku`,`quality_date`,`area_no`) USING BTREE,
  KEY `store_record_area_index` (`area_no`,`batch`,`quality_date`,`sku`) USING BTREE,
  KEY `store_record_sku_index` (`id`,`area_no`,`type`,`sku`) USING BTREE,
  KEY `idx_sku_date` (`area_no`,`sku`,`production_date`,`quality_date`),
  KEY `idx_update_time` (`update_time`),
  KEY `idx_updatetime` (`update_time`,`area_no`,`type`),
  KEY `idx_update_time_sku` (`sku`,`update_time`)
) ENGINE=InnoDB AUTO_INCREMENT=6634323 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='库存记录表'
---
DDL for table: strict_selection
CREATE TABLE `strict_selection` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `background_pic` varchar(50) DEFAULT NULL COMMENT '背景图',
  `head_pic` varchar(50) DEFAULT NULL COMMENT '列表顶部图',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `auto_sort` tinyint(1) DEFAULT '0' COMMENT '自动排序：f、否 t、是',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='鲜沐严选表'
---
DDL for table: suit
CREATE TABLE `suit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_name` varchar(45) NOT NULL COMMENT '组合包名称',
  `addtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatetime` datetime DEFAULT NULL,
  `suit_pic` varchar(255) DEFAULT NULL COMMENT '组合包图片地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `suit_name_UNIQUE` (`suit_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1795 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='组合包'
---
DDL for table: suit_item
CREATE TABLE `suit_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suit_id` int(11) NOT NULL COMMENT '套装id',
  `sku` varchar(30) DEFAULT NULL,
  `amount` int(5) DEFAULT '1' COMMENT '组合包中此商品数量',
  `discount` decimal(10,4) DEFAULT '0.0000' COMMENT '价格',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pd_name` varchar(45) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `suit_item_suit_index` (`suit_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3338 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='套装产品条目'
---
DDL for table: supplier
CREATE TABLE `supplier` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(50) DEFAULT NULL COMMENT '供应商名称',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `category_array` varchar(1000) DEFAULT NULL COMMENT '经营范围',
  `product_array` varchar(500) DEFAULT NULL COMMENT '供应品类',
  `pay_type` varchar(50) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `account_bank` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `manager` varchar(50) DEFAULT NULL COMMENT '供应商管理人',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `invoice` tinyint(1) DEFAULT '1' COMMENT '是否开发票',
  `contract` varchar(50) DEFAULT NULL COMMENT '合同',
  `delivery_frequent` varchar(30) DEFAULT NULL COMMENT '发货频率',
  `settle_form` int(11) DEFAULT NULL COMMENT '0、账期结算 1、备用金结算 2、公对公现结 3、私对私现结',
  `settle_type` int(11) DEFAULT NULL COMMENT '结算类型 0、月结 1、自定义',
  `custom_start_date` date DEFAULT NULL COMMENT '自定义开启日期',
  `custom_cycle` int(11) DEFAULT NULL COMMENT '自定义周期天数',
  `credit_days` int(11) DEFAULT NULL COMMENT '账期天数',
  `supplier_type` tinyint(4) DEFAULT '0' COMMENT '0企业（生产商），1个人，2企业（经销商）',
  `tax_number` varchar(20) DEFAULT NULL COMMENT '供应商工商信息（税号字段/身份证号）',
  `type` tinyint(4) DEFAULT '0' COMMENT '企业（生产商），1个人，2企业（经销商）【无用字段】',
  `status` tinyint(4) DEFAULT '0' COMMENT '0启用，1停用,2审核中，3已关闭',
  `audit_pass_date` date DEFAULT NULL COMMENT '审核通过日期（用于计算剩余天数）',
  `creator` varchar(50) DEFAULT '' COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(45) DEFAULT NULL COMMENT '最后修改人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `qr_code_show_supplier_switch` tinyint(4) NOT NULL DEFAULT '0' COMMENT '二维码是否展示供应商信息 0不展示1展示',
  `source` varchar(255) NOT NULL DEFAULT 'xianmu' COMMENT '来源:xianmu,saas',
  `tenant_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '租户id',
  `business_type` tinyint(4) DEFAULT NULL COMMENT '业务类型，1代销',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3649 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='供应商'
---
DDL for table: supplier_account
CREATE TABLE `supplier_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付方式 1、银行卡 2、现金',
  `account_name` varchar(50) DEFAULT NULL COMMENT '账户名称',
  `account_bank` varchar(50) DEFAULT NULL COMMENT '开户银行',
  `account_ascription` varchar(50) DEFAULT NULL COMMENT '银行卡归属地',
  `account` varchar(50) DEFAULT NULL COMMENT '账号',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `supplier_account_index` (`supplier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3891 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='供应商账户表'
---
DDL for table: supplier_connect
CREATE TABLE `supplier_connect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `admin_name` varchar(45) DEFAULT NULL COMMENT '最后修改人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_phone` (`phone`) USING BTREE,
  KEY `index_supplier_id` (`supplier_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7765 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: supplier_coordination_config
CREATE TABLE `supplier_coordination_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `supplier_id` bigint(20) NOT NULL COMMENT '供应商id',
  `po_coordination_tab` tinyint(1) DEFAULT '0' COMMENT '订单是否协同，0否；1是',
  `inbound_coordination_tab` tinyint(1) DEFAULT '0' COMMENT '入库是否协同，0否；1是',
  `reconciliation_coordination_tab` tinyint(1) DEFAULT '0' COMMENT '对账是否协同，0否；1是',
  `invoice_coordination_tab` tinyint(1) DEFAULT '0' COMMENT '发票是否协同，0否；1是',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` varchar(16) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(16) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_supplier_id` (`supplier_id`) USING BTREE COMMENT '供应商id唯一键'
) ENGINE=InnoDB AUTO_INCREMENT=941 DEFAULT CHARSET=utf8mb4 COMMENT='供应商协同配置'
---
DDL for table: supplier_tenant
CREATE TABLE `supplier_tenant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `tenant_id` bigint(11) NOT NULL COMMENT '租户(SAAS品牌方ID)',
  `creator` varchar(50) DEFAULT '' COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(45) DEFAULT NULL COMMENT '最后修改人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商品牌方关联表'
---
DDL for table: supplier_update_log
CREATE TABLE `supplier_update_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `sku` varchar(30) DEFAULT NULL COMMENT '产品编号',
  `pd_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `warehouse_name` varchar(50) DEFAULT NULL COMMENT '库存仓名称',
  `weight` varchar(50) DEFAULT NULL COMMENT '规格',
  `old_name` varchar(50) DEFAULT NULL COMMENT '原供应商名称',
  `new_name` varchar(50) DEFAULT NULL COMMENT '新供应商名称',
  `old_supplier_id` int(11) DEFAULT NULL COMMENT '原供应商id',
  `new_supplier_id` int(11) DEFAULT NULL COMMENT '新供应商id',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `supplier_update_log_index` (`purchase_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='采购单修改供应商记录表'
---
DDL for table: tag_launch_info
CREATE TABLE `tag_launch_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) DEFAULT NULL COMMENT '标签名称',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '标签类型，0 氛围，1 利益，2 业务',
  `style` tinyint(4) DEFAULT '0' COMMENT '标签样式，0 文案，1 图片',
  `content` varchar(64) DEFAULT NULL COMMENT '标签文案',
  `picture` varchar(128) DEFAULT NULL COMMENT '标签图片',
  `weight` int(11) DEFAULT NULL COMMENT '权重',
  `scope_type` tinyint(4) DEFAULT NULL COMMENT '活动范围类型，0 全部，1 人群包，2 运营城市，3 运营大区',
  `item_type` tinyint(4) DEFAULT NULL COMMENT '商品选择类型，0 全部，1 指定商品，2 指定类目',
  `start_time` datetime DEFAULT NULL COMMENT '生效时间',
  `end_time` datetime DEFAULT NULL COMMENT '失效时间',
  `creator_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次修改人id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_weight` (`weight`),
  KEY `idx_start_end_time` (`start_time`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='前台标签基础信息表'
---
DDL for table: tag_launch_scope_config
CREATE TABLE `tag_launch_scope_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `info_id` bigint(20) NOT NULL COMMENT '基础信息id',
  `scope_id` bigint(20) NOT NULL COMMENT '范围id',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次修改人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_info_id` (`info_id`),
  KEY `idx_scope_id` (`scope_id`)
) ENGINE=InnoDB AUTO_INCREMENT=822 DEFAULT CHARSET=utf8 COMMENT='前台标签活动范围配置表'
---
DDL for table: tag_launch_sku_config
CREATE TABLE `tag_launch_sku_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `info_id` bigint(20) DEFAULT NULL COMMENT '基本信息id',
  `biz_id` varchar(64) DEFAULT NULL COMMENT 'sku或者类目id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater_id` int(11) DEFAULT NULL COMMENT '最后一次修改人id',
  PRIMARY KEY (`id`),
  KEY `idx_info_id` (`info_id`),
  KEY `idx_biz_id` (`biz_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4523 DEFAULT CHARSET=utf8 COMMENT='前台标签sku或者类目配置表'
---
DDL for table: tax_rate
CREATE TABLE `tax_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tax_rate_code` varchar(50) DEFAULT NULL COMMENT '税率分类编码',
  `tax_rate_value` decimal(10,4) DEFAULT NULL COMMENT '税率',
  `name` varchar(50) DEFAULT NULL COMMENT '货物和劳务名称\r\n\r\n',
  `abbr` varchar(50) DEFAULT NULL COMMENT '商品和服务分类简称\r\n\r\n',
  `desc` varchar(200) DEFAULT NULL COMMENT '说明',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `creator_time` datetime DEFAULT NULL,
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: tax_rate_config
CREATE TABLE `tax_rate_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `category_id` int(11) DEFAULT NULL COMMENT '类目id',
  `tax_rate_code` varchar(50) DEFAULT NULL COMMENT '税率分类编码',
  `tax_rate_value` decimal(10,4) DEFAULT NULL COMMENT '税率',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `pd_id` bigint(30) DEFAULT NULL COMMENT '产品id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `pd_id_UNIQUE` (`pd_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10093 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='税率配置信息'
---
DDL for table: temp_gmv_target
CREATE TABLE `temp_gmv_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `value` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: temp_tabletest
CREATE TABLE `temp_tabletest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
---
DDL for table: temp_test
CREATE TABLE `temp_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
---
DDL for table: temporary_activity_config
CREATE TABLE `temporary_activity_config` (
  `table_name` varchar(50) NOT NULL COMMENT '活动table的名称',
  `skus` text COMMENT '固定的sku列表用’,‘隔开',
  `ruler_id` int(11) NOT NULL DEFAULT '0' COMMENT '规则的id',
  `desction` varchar(500) DEFAULT NULL COMMENT '活动描述表',
  PRIMARY KEY (`ruler_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: temporary_activity_ruler
CREATE TABLE `temporary_activity_ruler` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `ruler_id` int(11) DEFAULT NULL COMMENT '规则id,取自temperary_activity_config表',
  `category_id` int(11) NOT NULL COMMENT '二级类目',
  `brand_name` varchar(255) DEFAULT NULL COMMENT '品牌名',
  `category_time` datetime DEFAULT NULL COMMENT '与二级类目对应的时间点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: test
CREATE TABLE `test` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL COMMENT '姓名',
  `time` datetime DEFAULT NULL,
  `m_id` int(11) NOT NULL DEFAULT '0',
  `a` tinyint(4) DEFAULT NULL,
  `b` tinyint(4) DEFAULT NULL,
  `c` tinyint(4) DEFAULT NULL,
  `d` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `test_abcd` (`a`,`b`,`c`,`d`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: test_name
CREATE TABLE `test_name` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pro` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=utf8mb4
---
DDL for table: test_test
CREATE TABLE `test_test` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` char(10) DEFAULT NULL,
  `password1` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8
---
DDL for table: timing_advance_sale_rule
CREATE TABLE `timing_advance_sale_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timing_rule_id` int(11) DEFAULT NULL COMMENT '省心送规则id',
  `deposit_price` decimal(10,2) DEFAULT NULL COMMENT '定金金额 规格最小单位 例:箱',
  `discount_remaining_price` decimal(10,2) DEFAULT NULL COMMENT '尾款立减金额 规格最小单位 例:箱',
  `deposit_start_time` datetime DEFAULT NULL COMMENT '定金开始时间',
  `deposit_end_time` datetime DEFAULT NULL COMMENT '定金结束时间',
  `remaining_start_time` date DEFAULT NULL COMMENT '尾款开始时间\n',
  `remaining_end_time` date DEFAULT NULL COMMENT '尾款支付结束时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '说明',
  `status` int(11) DEFAULT NULL COMMENT '0 生效 1 未生效',
  `type` int(11) DEFAULT NULL COMMENT '预售类型 0 省心送 1 预售',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='省心送预售规则表'
---
DDL for table: timing_order
CREATE TABLE `timing_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(36) DEFAULT NULL COMMENT '订单编号',
  `delivery_start_time` date DEFAULT NULL COMMENT '配送开始时间',
  `delivery_end_time` date DEFAULT NULL COMMENT '配送结束时间',
  `price_ladder` int(11) DEFAULT NULL COMMENT '价格阶梯数量',
  `discount_delivery_times` int(3) DEFAULT NULL COMMENT '优惠配送次数',
  `delivery_times` int(3) DEFAULT NULL COMMENT '用户购买配送总次数',
  `delivery_unit` int(11) DEFAULT '2' COMMENT '起送数量',
  `delivery_upper_limit` int(11) DEFAULT '999' COMMENT '单次配送上限',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `type` int(11) DEFAULT '0',
  `deposit_start_time` datetime DEFAULT NULL COMMENT '定金时间',
  `deposit_end_time` datetime DEFAULT NULL,
  `remaining_start_time` date DEFAULT NULL,
  `remaining_end_time` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=9620 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: timing_order_refund_record
CREATE TABLE `timing_order_refund_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `order_no` varchar(45) DEFAULT NULL COMMENT '订单号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8 COMMENT='省心送订单自动退款弹窗记录表'
---
DDL for table: timing_order_refund_time
CREATE TABLE `timing_order_refund_time` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `order_no` varchar(45) DEFAULT NULL COMMENT '省心送订单号',
  `refund_time` date DEFAULT NULL COMMENT '订单退款时间',
  `m_id` bigint(20) DEFAULT NULL COMMENT '商户id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order` (`order_no`),
  KEY `idx_m_time` (`m_id`,`refund_time`),
  KEY `idx_time` (`refund_time`)
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8 COMMENT='省心送订单退款时间表'
---
DDL for table: timing_order_refund_white_list
CREATE TABLE `timing_order_refund_white_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `order_no` varchar(45) DEFAULT NULL COMMENT '订单号',
  `order_time` datetime DEFAULT NULL COMMENT '订单生成时间',
  `mname` varchar(255) DEFAULT NULL COMMENT '商户名称',
  `pd_name` varchar(255) DEFAULT NULL COMMENT '商品名称（快照）',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `operator` varchar(255) DEFAULT NULL COMMENT '操作人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `days_deferred` int(11) DEFAULT NULL COMMENT '延期天数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8434 DEFAULT CHARSET=utf8 COMMENT='省心送订单自动退款白名单表'
---
DDL for table: timing_rule
CREATE TABLE `timing_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT '规则名称',
  `timing_sku` varchar(30) DEFAULT NULL COMMENT '团购商品sku',
  `area_no` int(11) DEFAULT '1001',
  `display` tinyint(1) DEFAULT '0' COMMENT '展示标记：0不展示，1展示',
  `start_time` datetime DEFAULT NULL COMMENT '团购开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '团购结束时间',
  `delivery_start` date DEFAULT NULL COMMENT '配送开始时间',
  `delivery_end` date DEFAULT NULL COMMENT '配送结束时间',
  `rule_information` varchar(500) DEFAULT NULL COMMENT '规则描述',
  `delivery_unit` int(11) DEFAULT '2' COMMENT '起送数量',
  `delivery_upper_limit` int(11) DEFAULT '999' COMMENT '单词配送上限',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `type` int(11) DEFAULT '0' COMMENT '0省心送，1预售',
  `priority` int(11) DEFAULT '99' COMMENT '排序',
  `auto_calculate` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否自动计算配送次数',
  `delivery_period` int(11) DEFAULT NULL COMMENT '配送周期',
  `delivery_start_type` int(11) DEFAULT '0' COMMENT '开始配送类型：0、下一个配送日 1、指定开始日期（delivery_start）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `threshold` int(10) unsigned DEFAULT NULL COMMENT '省心送门槛',
  `plus_day` int(11) DEFAULT NULL COMMENT '下单日期+N的N值',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_area_sku` (`area_no`,`timing_sku`,`display`,`type`) USING BTREE,
  KEY `idx_sku` (`timing_sku`,`type`,`display`) USING BTREE,
  KEY `idx_type_display` (`type`,`display`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2982 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定期送规则'
---
DDL for table: tmp
CREATE TABLE `tmp` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `bd` varchar(25) DEFAULT NULL COMMENT '归属bd',
  `mname` varchar(100) NOT NULL COMMENT '店铺名',
  `phone` varchar(25) NOT NULL COMMENT 'phone',
  `city` varchar(25) NOT NULL COMMENT '归属城市',
  `size` varchar(25) NOT NULL COMMENT '客户类型',
  `type` varchar(25) NOT NULL COMMENT '客户类型',
  `msize` varchar(25) NOT NULL COMMENT '企业规模',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='临时表'
---
DDL for table: tmp_dms_8977802_20230503143424_msg_history
CREATE TABLE `tmp_dms_8977802_20230503143424_msg_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text COMMENT '消息内容',
  `mode` varchar(255) DEFAULT NULL COMMENT '发送方式',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `operate` varchar(255) DEFAULT NULL COMMENT '触发消息的操作',
  `operator` varchar(255) DEFAULT NULL COMMENT '发送者',
  `add_time` datetime DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_mid_time` (`user_id`,`add_time`)
) ENGINE=InnoDB AUTO_INCREMENT=922 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='消息发送记录表'
---
DDL for table: tms_car
CREATE TABLE `tms_car` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `car_number` varchar(100) DEFAULT NULL COMMENT '车牌号',
  `type` int(11) DEFAULT NULL COMMENT '车型0:小面包车 1:中面包车 2:依维柯 3:小型货车 4: 4米2 5:6米8  6:7米6  7:7 9米6  8 :13米5 9:17米5',
  `volume` decimal(10,2) DEFAULT NULL COMMENT '体积',
  `weight` decimal(10,2) DEFAULT NULL COMMENT '重量',
  `car_photos` varchar(255) DEFAULT NULL COMMENT '车辆照片',
  `driver_photos` varchar(255) DEFAULT NULL COMMENT '行驶证照片',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0有效 1无效',
  `admin_id` varchar(255) DEFAULT NULL COMMENT '操作人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `storage` int(11) DEFAULT NULL COMMENT '存储条件 0常温、1冷藏',
  `traffic_insurance_policy` varchar(500) DEFAULT NULL COMMENT '交强险保额保单',
  `commercial_insurance_expire_time` datetime DEFAULT NULL COMMENT '商业险到期时间',
  `commercial_insurance_amount` decimal(18,2) DEFAULT NULL COMMENT '商业险保额额度,单位/元',
  `commercial_insurance_policy` varchar(500) DEFAULT NULL COMMENT '商业险保额保单',
  `traffic_insurance_expire_time` datetime DEFAULT NULL COMMENT '交强险到期时间',
  `traffic_insurance_amount` decimal(18,2) DEFAULT NULL COMMENT '交强险保额额度,单位/元',
  `quantity` int(11) DEFAULT NULL COMMENT '装载件数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=utf8 COMMENT='tms车辆信息'
---
DDL for table: tms_complete_delivery_area_mapping
CREATE TABLE `tms_complete_delivery_area_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fence_area_id` bigint(20) NOT NULL COMMENT '围栏区域ID',
  `complete_delivery_id` int(11) NOT NULL COMMENT '完成配送提醒ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_fence_area_id` (`fence_area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='完成配送提醒对应围栏区域表'
---
DDL for table: tms_complete_delivery_rule
CREATE TABLE `tms_complete_delivery_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `store_no` int(11) NOT NULL COMMENT '配送仓编号',
  `rule_name` varchar(64) NOT NULL COMMENT '规则名称',
  `brand_rule_object_oss_key` varchar(500) DEFAULT NULL COMMENT '品牌规则文件oss标识',
  `merchant_rule_object_oss_key` varchar(500) DEFAULT NULL COMMENT '门店规则文件oss标识',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_store_no` (`store_no`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='完成配送提醒规则组'
---
DDL for table: tms_complete_delivery_rule_item
CREATE TABLE `tms_complete_delivery_rule_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `rule_id` bigint(20) NOT NULL COMMENT '规则ID',
  `channel` tinyint(4) NOT NULL COMMENT '渠道，0：鲜沐，1：SAAS',
  `type` tinyint(4) NOT NULL COMMENT '类型，0：品牌，1：门店',
  `biz_no` varchar(64) NOT NULL COMMENT '对应类型业务编号',
  `biz_name` varchar(64) DEFAULT NULL COMMENT '对应类型业务名称',
  `begin_time` time NOT NULL COMMENT '配送提醒开始时间',
  `end_time` time NOT NULL COMMENT '配送提醒结束时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `store_no` int(11) NOT NULL COMMENT '配送仓编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_store_channel_type_no` (`store_no`,`channel`,`type`,`biz_no`),
  KEY `idx_rule_id` (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8 COMMENT='完成配送提醒规则项'
---
DDL for table: tms_config
CREATE TABLE `tms_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(50) NOT NULL COMMENT '配置键值',
  `value` text COMMENT '配置名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=66797 DEFAULT CHARSET=utf8 COMMENT='tms配置表'
---
DDL for table: tms_config_copy1
CREATE TABLE `tms_config_copy1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(45) NOT NULL COMMENT '''配置键值''',
  `value` text COMMENT '''配置名称''',
  `remark` varchar(255) DEFAULT NULL COMMENT '''备注''',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_UNIQUE` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tms配置表'
---
DDL for table: tms_delivery_batch
CREATE TABLE `tms_delivery_batch` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `type` int(11) NOT NULL COMMENT '类型 0干线用车、1调拨用车、2采购用车、3大客户用车、4仓库用车、5城配用车',
  `status` int(11) NOT NULL DEFAULT '10' COMMENT '任务状态 10待排线,20待拣货,30配送中,40配送完成 50关闭',
  `car_id` bigint(20) DEFAULT NULL,
  `driver_id` bigint(20) DEFAULT NULL COMMENT '司机id',
  `carrier_id` bigint(20) DEFAULT NULL COMMENT '承运商id',
  `path_id` bigint(20) DEFAULT NULL COMMENT '线路ID',
  `path_code` varchar(50) DEFAULT NULL COMMENT '线路编码',
  `path_name` varchar(100) DEFAULT NULL COMMENT '线路名称',
  `begin_site_id` bigint(20) DEFAULT NULL COMMENT '开始点位',
  `end_site_id` bigint(20) DEFAULT NULL COMMENT '结束点位',
  `delivery_time` datetime DEFAULT NULL COMMENT '配送时间,履约交付时间',
  `plan_begin_time` datetime DEFAULT NULL COMMENT '计划开始运输时间',
  `plan_total_distance` decimal(10,2) DEFAULT NULL COMMENT '总距离 km',
  `real_total_distance` decimal(10,2) DEFAULT NULL COMMENT '实际总距离 km',
  `be_path_time` datetime DEFAULT NULL COMMENT '完成排线时间',
  `pick_up_time` datetime DEFAULT NULL COMMENT '完成捡货时间',
  `finish_delivery_time` datetime DEFAULT NULL COMMENT '完成配送时间',
  `static_info` text COMMENT '批次维度统计数据',
  `query_feature` text COMMENT '附属信息',
  `create_id` int(11) DEFAULT NULL COMMENT '创建人id',
  `close_reason` varchar(450) DEFAULT NULL COMMENT '关闭原因',
  `estimate_fare` decimal(10,2) DEFAULT '0.00' COMMENT '预估运费',
  `intelligence_total_distance` decimal(10,2) DEFAULT NULL COMMENT '智能排线总距离',
  `area` varchar(30) DEFAULT NULL COMMENT '区域',
  `classes` int(11) DEFAULT NULL COMMENT '班次 0正常 1加班',
  `remark` varchar(120) DEFAULT NULL COMMENT '备注',
  `close_user` varchar(50) DEFAULT NULL COMMENT '关闭人',
  `volume_load_ratio` decimal(10,2) DEFAULT NULL COMMENT '体积装载率',
  `weight_load_ratio` decimal(10,2) DEFAULT NULL COMMENT '重量装载率',
  `quantity_load_ratio` decimal(10,2) DEFAULT NULL COMMENT '件数装载率',
  `load_ratio_calculate_json` text COMMENT '装载率计算JSON(分子，分母)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_pid_dt_bsid_car_id` (`path_id`,`delivery_time`,`begin_site_id`,`car_id`),
  KEY `idx_dt_status_bsid_esid` (`delivery_time`,`status`,`type`,`begin_site_id`,`end_site_id`),
  KEY `idx_dt_bs_type_status` (`delivery_time`,`begin_site_id`,`type`,`status`),
  KEY `idx_driver_type` (`driver_id`,`type`),
  KEY `idx_bsid_type_delivery_time` (`begin_site_id`,`type`,`delivery_time`),
  KEY `idx_type_bsi_dt_pid` (`type`,`begin_site_id`,`delivery_time`,`path_id`),
  KEY `idx_type_status_finish_time` (`type`,`status`,`finish_delivery_time`)
) ENGINE=InnoDB AUTO_INCREMENT=7318 DEFAULT CHARSET=utf8 COMMENT='配送批次表'
---
DDL for table: tms_delivery_batch_fare
CREATE TABLE `tms_delivery_batch_fare` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `delivery_batch_id` bigint(20) NOT NULL COMMENT '配送批次ID',
  `fare_type` int(11) NOT NULL COMMENT '费用类型，10：喜茶费用，20：益禾堂费用，30：美团费用，40：大客户费用，50：调拨费用，60：采购费用',
  `amount` decimal(10,2) NOT NULL COMMENT '费用金额',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_batch_type` (`delivery_batch_id`,`fare_type`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8 COMMENT='配送批次运费明细表'
---
DDL for table: tms_delivery_batch_relation
CREATE TABLE `tms_delivery_batch_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `batch_id` bigint(20) NOT NULL COMMENT '配送批次ID',
  `relate_batch_id` bigint(20) NOT NULL COMMENT '关联配送批次ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_batch_id_relation` (`batch_id`,`relate_batch_id`),
  KEY `idx_relate_batch_id` (`relate_batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8 COMMENT='配送批次关系表'
---
DDL for table: tms_delivery_cost
CREATE TABLE `tms_delivery_cost` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dist_order_id` bigint(20) NOT NULL COMMENT '委托单ID',
  `out_item_id` varchar(64) NOT NULL COMMENT '外部货品ID(sku)',
  `source` int(11) NOT NULL COMMENT '来源，100：调拨，101：采购，102：销售出库，103，出样出库，104，补货出库，105，自提销售',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `average_cost` decimal(10,2) NOT NULL COMMENT '平均成本',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_dist_out_item_id` (`dist_order_id`,`out_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8 COMMENT='配送成本表'
---
DDL for table: tms_delivery_cost_record
CREATE TABLE `tms_delivery_cost_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `delivery_cost_id` bigint(20) NOT NULL COMMENT '配送成本ID',
  `change_type` int(11) NOT NULL COMMENT '变更类型，0：修改成本变更，1：绑定关系变更',
  `cost_before` decimal(10,2) NOT NULL COMMENT '成本变更之前',
  `cost_after` decimal(10,2) NOT NULL COMMENT '成本变更之后',
  `creator_id` varchar(64) DEFAULT NULL COMMENT '创建人ID',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=676 DEFAULT CHARSET=utf8 COMMENT='配送成本变更表'
---
DDL for table: tms_delivery_cost_relation
CREATE TABLE `tms_delivery_cost_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dist_order_id` bigint(20) DEFAULT NULL COMMENT '委托单ID',
  `out_item_id` varchar(64) DEFAULT NULL COMMENT '外部货品ID(sku)',
  `out_batch_id` varchar(64) DEFAULT NULL COMMENT '外部成本批次ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_out_batch_id` (`out_batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=332 DEFAULT CHARSET=utf8 COMMENT='配送成本关系表'
---
DDL for table: tms_delivery_item
CREATE TABLE `tms_delivery_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delivery_order_id` bigint(20) NOT NULL COMMENT '配送单ID',
  `dist_order_id` bigint(20) NOT NULL COMMENT '委托单id',
  `out_order_id` varchar(64) NOT NULL COMMENT '外部订单号',
  `out_item_id` varchar(64) NOT NULL COMMENT '外部条目id',
  `plan_receipt_count` int(11) NOT NULL DEFAULT '0' COMMENT '计划签收数量',
  `real_receipt_count` int(11) DEFAULT '0' COMMENT '实际签收数量',
  `short_count` int(11) DEFAULT '0' COMMENT '缺货数量',
  `intercept_count` int(11) DEFAULT '0' COMMENT '拦截数量',
  `reject_count` int(11) DEFAULT '0' COMMENT '拒收数量',
  `reject_remark` varchar(64) DEFAULT NULL COMMENT '拒收原因',
  `scan_count` int(11) DEFAULT '0' COMMENT '扫码数量',
  `noscan_count` int(11) DEFAULT '0' COMMENT '无码数量',
  `noscan_reason` varchar(64) DEFAULT NULL COMMENT '无码原因',
  `noscan_pics` text COMMENT '无码货物照片',
  `out_item_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  PRIMARY KEY (`id`),
  KEY `idx_order` (`out_order_id`),
  KEY `idx_item` (`out_item_id`),
  KEY `idx_delivery_order_id` (`delivery_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24120 DEFAULT CHARSET=utf8 COMMENT='配送单详情表'
---
DDL for table: tms_delivery_item_code
CREATE TABLE `tms_delivery_item_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delivery_order_item_id` bigint(20) NOT NULL COMMENT '配送详情id',
  `delivery_order_id` bigint(20) NOT NULL COMMENT '配送单id',
  `dist_order_id` bigint(20) NOT NULL COMMENT '委托单id',
  `out_order_id` varchar(64) NOT NULL COMMENT '外部订单ID',
  `out_item_id` varchar(64) NOT NULL COMMENT '外部条目id',
  `only_code` varchar(50) NOT NULL COMMENT '唯一码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配送物品扫码表'
---
DDL for table: tms_delivery_order
CREATE TABLE `tms_delivery_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `batch_id` bigint(20) DEFAULT NULL COMMENT '配送批次id',
  `dist_order_id` bigint(20) NOT NULL COMMENT '委托单id',
  `out_order_id` varchar(64) NOT NULL COMMENT '外部订单号',
  `out_contact_id` varchar(64) DEFAULT NULL COMMENT '外部联系人',
  `out_client_id` varchar(100) DEFAULT NULL COMMENT '外部客户号',
  `out_client_name` varchar(100) DEFAULT NULL COMMENT '外部客户名',
  `delivery_time` datetime NOT NULL COMMENT '配送时间',
  `sequence` int(11) DEFAULT NULL COMMENT '配送序号',
  `begin_site_id` bigint(20) NOT NULL COMMENT '开始点位',
  `end_site_id` bigint(20) NOT NULL COMMENT '结束点位',
  `address_detail` varchar(600) DEFAULT NULL COMMENT '详情地址',
  `name` varchar(200) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `state` int(11) NOT NULL DEFAULT '10' COMMENT '10未签收 20已签收 30异常签收 50关闭',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '配送类型 0 配送 1 回收',
  `source` int(11) NOT NULL COMMENT '来源，\n100：调拨，\n101：采购，\n102：销售出库，\n103，出样出库，\n104，补货出库，\n105，自提销售',
  `site_type` int(11) NOT NULL DEFAULT '0' COMMENT '站点类型，0：无中转，1：起点中转，2：终点中转',
  `send_remark` varchar(255) DEFAULT NULL COMMENT '配送备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_dist_begin_end_batch_type` (`dist_order_id`,`begin_site_id`,`end_site_id`,`batch_id`,`type`),
  KEY `idx_batch_id` (`batch_id`),
  KEY `idx_dist_order_id` (`dist_order_id`),
  KEY `idx_dt_bsid_esid_state` (`delivery_time`,`begin_site_id`,`end_site_id`,`state`)
) ENGINE=InnoDB AUTO_INCREMENT=132995 DEFAULT CHARSET=utf8 COMMENT='配送单表'
---
DDL for table: tms_delivery_performance_review_detail
CREATE TABLE `tms_delivery_performance_review_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `performance_review_task_id` bigint(20) NOT NULL COMMENT '履约审核任务ID',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '状态 0待审核 1无法审核 2合规 3不合规',
  `pic_json` text COMMENT '照片信息',
  `delivery_time` datetime NOT NULL COMMENT '配送/履约日期',
  `driver_name` varchar(50) NOT NULL COMMENT '司机名称',
  `driver_phone` varchar(100) NOT NULL COMMENT '司机电话',
  `car_number` varchar(100) NOT NULL COMMENT '车牌号',
  `car_type` int(11) NOT NULL COMMENT '车型0:小面包车 1:中面包车 2:依维柯 3:小型货车 4: 4米2 5:6米8  6:7米6  7:7 9米6  8 :13米5 9:17米5',
  `car_storage` int(11) NOT NULL COMMENT '车辆存储条件 0常温、1冷藏',
  `delivery_batch_id` bigint(20) NOT NULL COMMENT '配送批次ID',
  `delivery_site_id` bigint(20) NOT NULL COMMENT '配送点id',
  `site_id` bigint(20) NOT NULL COMMENT '点位id',
  `site_address` varchar(1000) DEFAULT NULL COMMENT '详情地址',
  `outer_client_name` varchar(128) DEFAULT NULL COMMENT '外部客户名',
  `outer_brand_name` varchar(64) DEFAULT NULL COMMENT '外部品牌名',
  `begin_site_id` bigint(20) NOT NULL COMMENT '开始点位Id',
  `begin_site_name` varchar(255) DEFAULT NULL COMMENT '开始点位名称',
  `path_code` varchar(50) DEFAULT NULL COMMENT '线路编码',
  `path_name` varchar(100) DEFAULT NULL COMMENT '线路名称',
  `delivery_batch_type` int(11) NOT NULL COMMENT '批次类型 0干线用车、1调拨用车、2采购用车、3大客户用车、4仓库用车、5城配用车',
  `send_way` tinyint(4) NOT NULL DEFAULT '0' COMMENT '配送方式 0正常配送 1专车配送',
  `out_distance` int(11) DEFAULT NULL COMMENT '是否超出距离   0 正常 1超出',
  `penalty_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '判罚金额',
  `site_pic_reason` varchar(100) DEFAULT NULL COMMENT '点位照片原因\n\n城配出仓 装载照片\n1000 保温措施不合格\n1001 无装车照片\n1002 无保温被\n1003 无冰板\n1004 无保温箱、干冰\n\n城配出仓 车牌照片\n1200 车牌不符\n1201 无车牌照\n\n城配-签收 门店抬头\n2000 门头不符\n2001 无门头照\n2002 门头不清晰\n\n城配-签收 门店抬头\n2201 签收单不合格\n2202 无签收单照片\n城配-签收 货物照片\n\n2401 未做保温措施\n2402 未测温\n\n干线-签收 到仓-签收照片\n3000 无车辆温度照片\n3001 其他\n\n干线-签收 出仓-装载照片\n3200 无整体货物照片\n\n干线-签收 出仓-封签照片\n3400 无封签照片',
  `temperature_conditions` varchar(100) DEFAULT NULL COMMENT '温区条件',
  `sign_out_temperature` decimal(10,3) DEFAULT NULL COMMENT '出发温度',
  `sequence` int(11) DEFAULT NULL COMMENT '点位在路线上的顺序',
  `site_name` varchar(200) DEFAULT NULL COMMENT '点位名称',
  PRIMARY KEY (`id`),
  KEY `idx_task_id_state_bs_id_del_time` (`performance_review_task_id`,`state`,`begin_site_id`,`delivery_time`)
) ENGINE=InnoDB AUTO_INCREMENT=2846 DEFAULT CHARSET=utf8 COMMENT='履约审核详情'
---
DDL for table: tms_delivery_performance_review_task
CREATE TABLE `tms_delivery_performance_review_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `review_task_type` int(11) NOT NULL COMMENT '审核类型 0城配-出仓、1城配-签收、2干线-签收',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `penalty_standards` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '判罚标准',
  `property_json` text NOT NULL COMMENT '属性JSON(城配仓/调度类型、配送/履约日期)',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT '状态0审核中、1审核完成、2已关闭',
  `create_name` varchar(100) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`),
  KEY `idx_review_task_type` (`review_task_type`),
  KEY `idx_state` (`state`),
  KEY `idx_create_time` (`create_name`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8 COMMENT='配送履约审核任务表'
---
DDL for table: tms_delivery_pick
CREATE TABLE `tms_delivery_pick` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delivery_batch_id` bigint(20) NOT NULL COMMENT '配送批次id',
  `site_id` bigint(20) NOT NULL COMMENT '点位ID',
  `driver_id` bigint(20) DEFAULT NULL COMMENT '司机ID',
  `out_item_id` varchar(50) DEFAULT NULL COMMENT '外部条目id',
  `item_desc` varchar(128) DEFAULT NULL COMMENT '货品描述',
  `particle` varchar(50) DEFAULT NULL COMMENT '拣货粒度,eg:品牌名',
  `type` int(11) DEFAULT '0' COMMENT '拣货类型：0默认， 1独立拣货(按品牌捡货)',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `pick_quantity` int(11) DEFAULT '0' COMMENT '拣货数量',
  `short_quantity` int(11) DEFAULT '0' COMMENT '缺货数量',
  `intercept_quantity` int(11) DEFAULT '0' COMMENT '拦截数量',
  `unit` varchar(32) DEFAULT NULL COMMENT '单位',
  `status` tinyint(4) NOT NULL DEFAULT '20' COMMENT '状态 20 待捡货 25 捡货完成 26 捡货异常',
  `finish_time` datetime DEFAULT NULL COMMENT '捡货 完成时间',
  `temperature` int(11) DEFAULT NULL COMMENT '温区',
  `weight` decimal(10,2) DEFAULT NULL COMMENT '重量',
  `delivery_site_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '配送点位ID',
  `specification` varchar(255) DEFAULT '' COMMENT '规格',
  `process_flag` int(11) DEFAULT '0' COMMENT '加工标识 0非加工商品 1加工商品',
  `process_quantity` int(11) DEFAULT '0' COMMENT '加工后商品数量',
  `process_conversion_ratio` decimal(10,2) DEFAULT '0.00' COMMENT '加工转化比(加工前数量/加工后数量)',
  `process_pick_quantity` int(11) DEFAULT '0' COMMENT '加工拣货数量',
  `process_short_quantity` int(11) DEFAULT '0' COMMENT '加工缺货数量',
  `process_unit` varchar(100) DEFAULT NULL COMMENT '加工后单位',
  `process_weight` decimal(10,2) DEFAULT '0.00' COMMENT '加工后重量',
  `category_type` int(11) DEFAULT NULL COMMENT '商品分类，0-普通，1-水果',
  PRIMARY KEY (`id`),
  KEY `idx_batch` (`delivery_batch_id`),
  KEY `idx_driver` (`driver_id`),
  KEY `idx_delivery_site` (`delivery_site_id`),
  KEY `idx_batch_site_item_partical_pro_flag_type` (`delivery_batch_id`,`delivery_site_id`,`out_item_id`,`particle`,`type`,`process_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=2025937 DEFAULT CHARSET=utf8 COMMENT='签发,装货表,点位+sku'
---
DDL for table: tms_delivery_plan
CREATE TABLE `tms_delivery_plan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `contact_id` int(11) DEFAULT NULL COMMENT '地址id',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `type` int(11) DEFAULT NULL COMMENT '类型  1销售单 2售后单',
  `delivery_type` int(11) DEFAULT NULL COMMENT '配送类型 0配送、1回收、2回收配送、 3自提',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  `store_id` int(11) DEFAULT NULL COMMENT '商户id',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `u_order_no` (`order_no`),
  KEY `n_order` (`order_no`,`tenant_id`,`contact_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=206402 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='tms 配送计划'
---
DDL for table: tms_delivery_plan_detail
CREATE TABLE `tms_delivery_plan_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `tms_delivery_plan_id` int(11) DEFAULT NULL COMMENT '配送单id',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `amount` int(10) unsigned DEFAULT NULL COMMENT '数量',
  `delivery_type` tinyint(4) DEFAULT NULL COMMENT '类型',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态 0 正常 1售后',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `n_plan_id` (`tms_delivery_plan_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11039 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='配送单详情'
---
DDL for table: tms_delivery_section
CREATE TABLE `tms_delivery_section` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `batch_id` bigint(20) NOT NULL COMMENT '配送批次id',
  `begin_site_id` bigint(20) NOT NULL COMMENT '开始点位',
  `end_site_id` bigint(20) NOT NULL COMMENT '结束点位',
  `distance` decimal(16,4) NOT NULL COMMENT '距离',
  `type` tinyint(4) NOT NULL COMMENT '0完成排线 1配送完成、定时扫描 2智能排线',
  PRIMARY KEY (`id`),
  KEY `idx_batch_id` (`batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9906 DEFAULT CHARSET=utf8 COMMENT='配送路段表'
---
DDL for table: tms_delivery_site
CREATE TABLE `tms_delivery_site` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_batch_id` bigint(20) NOT NULL COMMENT '批次ID',
  `site_id` bigint(20) NOT NULL COMMENT '点位ID',
  `type` int(11) NOT NULL COMMENT '类型 1起点,2途径点,3终点',
  `sequence` int(11) NOT NULL COMMENT '点位在路线上的顺序',
  `status` int(11) NOT NULL COMMENT '10未到站,20已到站,22.已配送,25已拣货30已出发',
  `plan_arrive_time` datetime DEFAULT NULL COMMENT '计划到站时间',
  `sign_in_time` datetime DEFAULT NULL COMMENT '实际到达时间',
  `sign_in_poi` varchar(128) DEFAULT NULL COMMENT '实际到达地点',
  `sign_in_diff_minute` int(11) DEFAULT NULL COMMENT '实际打卡和预计到达时间的差值',
  `sign_in_diff_km` decimal(10,2) DEFAULT NULL COMMENT '实际打卡地和点位的差值',
  `sign_in_pics` text COMMENT '签到打卡照片',
  `sign_in_remark` text COMMENT '签到备注',
  `out_reason` varchar(50) DEFAULT NULL COMMENT '超出距离备注',
  `out_distance` int(11) DEFAULT NULL COMMENT '是否超出距离   0 正常 1超出',
  `sign_out_time` datetime DEFAULT NULL COMMENT '出发打卡时间',
  `sign_out_diff_km` decimal(10,2) DEFAULT NULL COMMENT '实际出发打卡点和点位的差值 km',
  `sign_out_pics` text COMMENT '出发打卡拍照',
  `sign_out_remark` text COMMENT '出发打卡备注',
  `sign_out_temperature` decimal(10,3) DEFAULT NULL COMMENT '出发温度',
  `intercept_state` int(11) DEFAULT '0' COMMENT '状态，0：正常，1取消，2：部分拦截，3：全部拦截，4：拦截关闭',
  `distance` decimal(10,0) DEFAULT NULL COMMENT '到仓距离',
  `outer_client_name` varchar(128) DEFAULT NULL COMMENT '外部客户名',
  `sign_in_distance` decimal(10,0) DEFAULT NULL COMMENT '签到打卡距离',
  `sign_in_status` int(11) DEFAULT NULL COMMENT '是否正常签收，0：正常，1：不正常',
  `outer_client_id` varchar(64) DEFAULT NULL COMMENT '外部客户号',
  `sign_out_status` int(11) DEFAULT NULL COMMENT '签发状态，0：正常，1：不正常',
  `sign_in_err_type` varchar(128) DEFAULT NULL COMMENT '签到异常类型',
  `sign_out_err_type` varchar(128) DEFAULT NULL COMMENT '出发异常类型',
  `sign_out_poi` varchar(128) DEFAULT NULL COMMENT '出发打卡地点',
  `sign_in_address` varchar(128) DEFAULT NULL COMMENT '实际到达详细地址',
  `sign_out_address` varchar(128) DEFAULT NULL COMMENT '出发打卡详细地址',
  `send_way` tinyint(4) DEFAULT '0' COMMENT '配送方式 0正常配送 1专车配送',
  `intelligence_sequence` int(11) DEFAULT NULL COMMENT '智能排线顺序',
  `sign_in_sign_pic` text COMMENT '配送照片签收面单',
  `sign_in_product_pic` text COMMENT '配送照片货物照片',
  `out_reason_type` varchar(50) DEFAULT NULL COMMENT '超区异常打卡原因类型',
  `out_pic` text COMMENT '超区异常打卡图片',
  `arrive_msg_send` bit(1) DEFAULT NULL COMMENT '是否发送过未入仓消息提示',
  `outer_brand_id` varchar(64) DEFAULT NULL COMMENT '外部品牌号',
  `outer_brand_name` varchar(64) DEFAULT NULL COMMENT '外部品牌名',
  `sign_out_diff_minute` int(11) NOT NULL DEFAULT '0' COMMENT '实际打卡出仓和预计出仓时间的差值',
  `plan_out_time` datetime DEFAULT NULL COMMENT '计划出仓时间',
  `leave_msg_send` bit(1) DEFAULT NULL COMMENT '是否发送过出仓消息提示',
  `send_remark` varchar(255) DEFAULT NULL COMMENT '配送备注',
  `temperature_conditions` varchar(100) DEFAULT NULL COMMENT '配送存储条件',
  `property_json` text COMMENT '配送点位属性字段扩展(sealPics-封签照片，vehiclePlatePics-车牌照)',
  `delivery_site_property_json` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_batch_site` (`delivery_batch_id`,`site_id`),
  KEY `idx_batch` (`delivery_batch_id`),
  KEY `idx_site` (`site_id`),
  KEY `idx_batch_intercept_state` (`delivery_batch_id`,`intercept_state`),
  KEY `idx_plan_arrive_time` (`plan_arrive_time`),
  KEY `idx_sign_in_time` (`sign_in_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110028373 DEFAULT CHARSET=utf8 COMMENT='运输单表 点位维度, 路线每个站点的情况'
---
DDL for table: tms_delivery_site_checkin_punch
CREATE TABLE `tms_delivery_site_checkin_punch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_site_id` bigint(20) NOT NULL COMMENT '配送点位Id',
  `punch_range` float(10,2) NOT NULL COMMENT '打卡范围km',
  `punch_address` varchar(500) NOT NULL COMMENT '打卡详细地址',
  `punch_poi` varchar(100) NOT NULL COMMENT '打卡POI',
  `distance_to_store` float(10,2) NOT NULL COMMENT '打卡到店距离km',
  `exceed_reason` varchar(1000) DEFAULT NULL COMMENT '超区原因',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_delivery_site_id` (`delivery_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配送到店打卡'
---
DDL for table: tms_delivery_site_item
CREATE TABLE `tms_delivery_site_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_site_id` bigint(20) DEFAULT NULL COMMENT '运输单id',
  `out_item_id` varchar(64) DEFAULT NULL COMMENT '外部条目id',
  `plan_receipt_count` int(11) DEFAULT '0' COMMENT '计划签收数量',
  `real_receipt_count` int(11) DEFAULT NULL COMMENT '实际签收数量',
  `short_count` int(11) DEFAULT '0' COMMENT '缺货数量',
  `intercept_count` int(11) DEFAULT '0' COMMENT '拦截数量',
  `reject_count` int(11) DEFAULT '0' COMMENT '拒收数量',
  `reject_reason` varchar(64) DEFAULT NULL COMMENT '拒收原因',
  `scan_count` int(11) DEFAULT '0' COMMENT '扫码数量',
  `noscan_count` int(11) DEFAULT '0' COMMENT '无码数量',
  `noscan_reason` varchar(64) DEFAULT NULL COMMENT '无码原因',
  `noscan_pics` text COMMENT '无码货物照片',
  `type` int(11) DEFAULT NULL COMMENT '配送类型 0配送1回收',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `out_item_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `out_item_type` int(11) DEFAULT '0' COMMENT '类型 0普通 1水果',
  PRIMARY KEY (`id`),
  KEY `idx_item` (`out_item_id`),
  KEY `idx_delivery_site_id` (`delivery_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10618 DEFAULT CHARSET=utf8 COMMENT='配送点位详情表'
---
DDL for table: tms_delivery_site_item_code
CREATE TABLE `tms_delivery_site_item_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delivery_site_item_id` bigint(20) NOT NULL COMMENT '配送详情id',
  `delivery_site_id` bigint(20) NOT NULL COMMENT '运输单id',
  `out_item_id` varchar(64) NOT NULL COMMENT '外部条目id',
  `only_code` varchar(50) NOT NULL COMMENT '唯一码',
  PRIMARY KEY (`id`),
  KEY `idx_delivery_site_item_out_id` (`delivery_site_id`,`delivery_site_item_id`,`out_item_id`),
  KEY `idx_only_code` (`only_code`),
  KEY `idx_delivery_site_item_id` (`delivery_site_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8 COMMENT='配送点位物品扫码表'
---
DDL for table: tms_dist_config
CREATE TABLE `tms_dist_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `type` int(11) NOT NULL COMMENT '配置类型，0：黑名单，1：中转站',
  `begin_site_id` bigint(20) NOT NULL COMMENT '起点',
  `end_site_id` bigint(20) NOT NULL COMMENT '终点',
  `config_value` varchar(1000) DEFAULT NULL COMMENT '配置的值',
  `create_id` int(11) NOT NULL COMMENT '创建人ID',
  `creator` varchar(30) NOT NULL COMMENT '创建人',
  `update_id` int(11) DEFAULT NULL COMMENT '更新人ID',
  `updater` varchar(30) DEFAULT NULL COMMENT '更新人',
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  PRIMARY KEY (`id`),
  KEY `idx_begin_end` (`begin_site_id`,`end_site_id`),
  KEY `idx_end` (`end_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='tms系统配送单配置'
---
DDL for table: tms_dist_item
CREATE TABLE `tms_dist_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `outer_item_id` varchar(64) NOT NULL COMMENT '外部货品id(sku)',
  `outer_item_type` varchar(32) DEFAULT NULL COMMENT '外部品类',
  `outer_item_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `outer_item_price` varchar(64) DEFAULT NULL COMMENT '价格',
  `dist_order_id` bigint(20) NOT NULL COMMENT '委托单id',
  `volume` varchar(64) NOT NULL COMMENT '体积',
  `weight` varchar(64) DEFAULT '0' COMMENT '重量',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `temperature` int(11) NOT NULL COMMENT '温区,0:未分类,1:冷冻,2:冷藏,3:常温,4:顶汇大流通',
  `specification` varchar(255) NOT NULL COMMENT '规格',
  `unit` varchar(100) NOT NULL COMMENT '单位',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '类型，0:普通，1:水果',
  `delivery_type` int(11) DEFAULT '0' COMMENT '配送类型，0:配送，1: 回收',
  PRIMARY KEY (`id`),
  KEY `idx_order_item_type` (`dist_order_id`,`outer_item_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=171747 DEFAULT CHARSET=utf8 COMMENT='委托物品表'
---
DDL for table: tms_dist_order
CREATE TABLE `tms_dist_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键 单号',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '配送类型，0：配送，1：回收，2：配送&回收',
  `pick_type` int(11) NOT NULL DEFAULT '0' COMMENT '拣货类型，0：默认，1：品牌独立捡货',
  `source` int(11) NOT NULL COMMENT '来源，\n100：调拨，\n101：采购，\n102：销售出库，\n103，出样出库，\n104，补货出库，\n105，自提销售\n\n200：鲜沐商城，\n201：鲜沐售后，\n202：鲜沐样品，\n203：鲜沐商城省心送，\n210：Saas商城，\n211：Saas售后',
  `outer_order_id` varchar(64) NOT NULL COMMENT '外部单号',
  `outer_tenant_id` varchar(64) DEFAULT NULL COMMENT '外部租户号',
  `outer_client_id` varchar(64) DEFAULT NULL COMMENT '外部客户号',
  `outer_client_name` varchar(128) DEFAULT NULL COMMENT '外部客户名',
  `outer_contact_id` varchar(64) DEFAULT NULL COMMENT '外部联系人ID',
  `outer_remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `begin_site_id` bigint(20) NOT NULL COMMENT '出发点位id',
  `mid_site_id` bigint(20) DEFAULT NULL COMMENT '中转站点位Id',
  `end_site_id` bigint(20) NOT NULL COMMENT '目的地点位id',
  `expect_begin_time` datetime NOT NULL COMMENT '期望开始时间',
  `expect_end_time` datetime DEFAULT NULL COMMENT '期望到达时间',
  `real_arrival_time` datetime DEFAULT NULL COMMENT '实际送达时间',
  `time_frame` varchar(64) DEFAULT NULL COMMENT '希望签收时间',
  `state` int(11) DEFAULT NULL COMMENT '状态，\n10：待排线，\n11：排线中，\n18：已关闭，\n19：完成排线前订单取消，\n20：待捡货，\n30：配送中，\n39：完成排线后订单取消，\n40：配送完成，\n41：拒收，\n42：配送完成但缺货',
  `creator_id` varchar(64) DEFAULT NULL COMMENT '创建人ID',
  `updater_id` varchar(64) DEFAULT NULL COMMENT '更新人ID',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `cancel_type` int(11) DEFAULT '0' COMMENT '取消类型，0：普通，1：拦截',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  `outer_brand_name` varchar(64) DEFAULT NULL COMMENT '外部品牌名',
  `send_remark` varchar(255) DEFAULT NULL COMMENT '配送备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_source_order_time_contact` (`source`,`outer_order_id`,`expect_begin_time`,`outer_contact_id`),
  KEY `outer_client_idx` (`source`,`outer_client_id`),
  KEY `begin_end_site` (`begin_site_id`,`end_site_id`),
  KEY `idx_ebt_bs_source_state` (`expect_begin_time`,`begin_site_id`,`source`,`state`),
  KEY `idx_ebt_es_source_sate` (`expect_begin_time`,`end_site_id`,`source`,`state`),
  KEY `idx_out_order_id` (`outer_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1148927 DEFAULT CHARSET=utf8 COMMENT='委托单'
---
DDL for table: tms_dist_order_config
CREATE TABLE `tms_dist_order_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键 单号',
  `creator` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `begin_site_id` bigint(20) NOT NULL COMMENT '出发点位id',
  `mid_site_id` bigint(20) DEFAULT NULL COMMENT '中转站点位Id',
  `end_site_id` bigint(20) NOT NULL COMMENT '目的地点位id',
  `creator_id` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人ID',
  `updater_id` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人ID',
  `updater` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人',
  `type` varchar(32) DEFAULT NULL COMMENT '类型，0-黑名单，1-中转',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='承运单规则配置表'
---
DDL for table: tms_dist_site
CREATE TABLE `tms_dist_site` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `provice` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `address` varchar(600) DEFAULT NULL COMMENT '详细地址',
  `poi` varchar(50) DEFAULT NULL COMMENT 'poi',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `name` varchar(200) DEFAULT NULL COMMENT '联系人',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型，0：客户，1：城配仓， 2：库存仓，3：监管仓,  4：采购地址，5：Saas',
  `state` tinyint(4) DEFAULT NULL COMMENT '是否需要打卡0 不需要 1需要',
  `punch_distance` decimal(10,2) DEFAULT NULL COMMENT '打卡距离',
  `out_business_no` varchar(100) DEFAULT NULL COMMENT '外部业务编号',
  `out_time` time DEFAULT NULL COMMENT '出仓时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `contact_person` varchar(32) DEFAULT NULL COMMENT '联系人',
  `supervise_site_id` bigint(20) DEFAULT NULL COMMENT '监管仓对应的库存仓',
  `creator` varchar(15) DEFAULT NULL COMMENT '创建人',
  `intelligence_path` tinyint(4) DEFAULT '0' COMMENT '0智能排线 1手动排线',
  PRIMARY KEY (`id`),
  KEY `index_busno_type` (`out_business_no`,`type`),
  KEY `idx_type_address_name_phone` (`type`,`provice`,`city`,`area`,`phone`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=193263 DEFAULT CHARSET=utf8 COMMENT='配送点位表'
---
DDL for table: tms_dist_site_copy1
CREATE TABLE `tms_dist_site_copy1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `provice` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `address` varchar(600) DEFAULT NULL COMMENT '详细地址',
  `poi` varchar(50) DEFAULT NULL COMMENT 'poi',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `name` varchar(200) DEFAULT NULL COMMENT '联系人',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型，0：客户，1：城配仓， 2：库存仓，3：监管仓,  4：采购地址，5：Saas',
  `state` tinyint(4) DEFAULT NULL COMMENT '是否需要打卡0 不需要 1需要',
  `punch_distance` decimal(10,2) DEFAULT NULL COMMENT '打卡距离',
  `out_business_no` varchar(100) DEFAULT NULL COMMENT '外部业务编号',
  `out_time` time DEFAULT NULL COMMENT '出仓时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `contact_person` varchar(32) DEFAULT NULL COMMENT '联系人',
  `supervise_site_id` bigint(20) DEFAULT NULL COMMENT '监管仓对应的库存仓',
  `creator` varchar(15) DEFAULT NULL COMMENT '创建人',
  `intelligence_path` tinyint(4) DEFAULT '0' COMMENT '0智能排线 1手动排线',
  PRIMARY KEY (`id`),
  KEY `index_busno_type` (`out_business_no`,`type`),
  KEY `idx_type_address_name_phone` (`type`,`provice`,`city`,`area`,`phone`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=192722 DEFAULT CHARSET=utf8 COMMENT='配送点位表'
---
DDL for table: tms_driver
CREATE TABLE `tms_driver` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(50) DEFAULT NULL COMMENT '司机姓名',
  `phone` varchar(40) DEFAULT NULL COMMENT '手机号（登录账号）',
  `cooperation_cycle` tinyint(4) DEFAULT NULL COMMENT '合作周期 0 临时 1长期',
  `business_type` tinyint(4) DEFAULT NULL COMMENT '业务类型 0干线 1城配 2干线城配',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0有效 1无效',
  `id_card` varchar(50) DEFAULT NULL COMMENT '身份证号',
  `id_card_front_pic` varchar(255) DEFAULT NULL COMMENT '身份证人面照片',
  `id_card_behind_pic` varchar(255) DEFAULT NULL COMMENT '身份证背面照片',
  `driver_pics` varchar(255) DEFAULT NULL COMMENT '驾驶证照片',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `city_site_id` bigint(20) unsigned DEFAULT NULL COMMENT '城配仓点位id',
  `city_carrier_id` int(11) DEFAULT NULL COMMENT '承运商id',
  `base_user_id` bigint(20) DEFAULT NULL COMMENT '用户中心表 user_base_id',
  PRIMARY KEY (`id`),
  KEY `idx_base_user_id` (`base_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11724 DEFAULT CHARSET=utf8 COMMENT='司机表'
---
DDL for table: tms_driver_account
CREATE TABLE `tms_driver_account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `creator` varchar(32) DEFAULT NULL COMMENT '创建人',
  `creator_id` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `updater_id` bigint(20) DEFAULT NULL COMMENT '更新人id',
  `updater` varchar(32) DEFAULT NULL COMMENT '更新人',
  `driver_id` bigint(20) DEFAULT NULL COMMENT '司机id',
  `pay_type` int(11) DEFAULT NULL COMMENT '支付方式',
  `account_name` varchar(200) DEFAULT NULL COMMENT '账户名称',
  `account_bank` varchar(200) DEFAULT NULL COMMENT '开户银行',
  `account_ascription` varchar(200) DEFAULT NULL COMMENT '银行卡归属地',
  `account` varchar(200) DEFAULT NULL COMMENT '账号',
  PRIMARY KEY (`id`),
  KEY `idx_driver_account_driver_id` (`driver_id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COMMENT='司机账户信息表'
---
DDL for table: tms_driver_car_carrier_mapping
CREATE TABLE `tms_driver_car_carrier_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tms_car_id` bigint(20) DEFAULT NULL COMMENT '车辆id',
  `tms_driver_id` bigint(20) DEFAULT NULL COMMENT '司机id',
  `carrier_id` int(11) DEFAULT NULL COMMENT '承运商id',
  `state` tinyint(4) DEFAULT NULL COMMENT '状态0正常 1取消',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `business_type` tinyint(4) DEFAULT NULL COMMENT '业务类型 0干线 1城配',
  `warehouse_site_id` bigint(20) DEFAULT NULL COMMENT '城配仓点位',
  PRIMARY KEY (`id`),
  KEY `index_dirver_state_business_type` (`tms_driver_id`,`state`,`business_type`)
) ENGINE=InnoDB AUTO_INCREMENT=851 DEFAULT CHARSET=utf8 COMMENT='司机车辆承运商绑定表'
---
DDL for table: tms_expense_audit_record
CREATE TABLE `tms_expense_audit_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `mname` varchar(30) DEFAULT NULL COMMENT '店铺名称',
  `audit_name` varchar(30) DEFAULT NULL COMMENT '审核人',
  `status` int(11) DEFAULT NULL COMMENT '审核状态',
  `driver_id` int(11) DEFAULT NULL COMMENT '司机id',
  `delivery_path_id` int(11) DEFAULT NULL COMMENT '配送路线id',
  `expense_id` int(11) DEFAULT NULL COMMENT '费用报销id',
  `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `reason` varchar(55) DEFAULT NULL COMMENT '审核原因',
  `tms_delivery_site_id` bigint(20) DEFAULT NULL COMMENT '运输单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='费用报销审核记录表'
---
DDL for table: tms_lack_approved_appeal
CREATE TABLE `tms_lack_approved_appeal` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `approved_id` bigint(20) NOT NULL COMMENT '缺货核准id',
  `side` int(11) NOT NULL COMMENT '申诉方:1城配、2干线、3仓库',
  `description` varchar(500) NOT NULL COMMENT '申诉说明',
  `certificate` text COMMENT '申诉凭证',
  `appeal_people_name` varchar(100) NOT NULL COMMENT '申诉人名称',
  PRIMARY KEY (`id`),
  KEY `idx_approved_id` (`approved_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COMMENT='缺货核准申诉'
---
DDL for table: tms_lack_approved_responsible
CREATE TABLE `tms_lack_approved_responsible` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `approved_id` bigint(20) NOT NULL COMMENT '缺货核准id',
  `responsible` int(11) NOT NULL COMMENT '责任方 1仓库 2城配 3无法判责 4干线',
  `buy_out` int(11) DEFAULT '1' COMMENT '是否买赔 0是 1否',
  `buy_out_money` decimal(10,4) DEFAULT NULL COMMENT '买赔金额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_approved_id_responsible` (`approved_id`,`responsible`)
) ENGINE=InnoDB AUTO_INCREMENT=444 DEFAULT CHARSET=utf8mb4 COMMENT='缺货核准责任方'
---
DDL for table: tms_lack_goods_approved
CREATE TABLE `tms_lack_goods_approved` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `delivery_path_id` int(11) DEFAULT NULL COMMENT '配送路线id',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `m_id` int(11) DEFAULT NULL COMMENT '店铺id',
  `lack_num` int(11) DEFAULT NULL COMMENT '缺货数量',
  `money` decimal(10,4) DEFAULT NULL COMMENT '金额',
  `lack_type` varchar(50) DEFAULT NULL COMMENT '缺货类型1.总仓-少发;2.总仓-库存不足;3.总仓-发错货;4.司机-误操作;5.司机-配送丢失;6.干线运输破损;7.其它;8.总仓-腐烂',
  `remark` varchar(400) DEFAULT NULL COMMENT '备注',
  `responsible` int(11) DEFAULT NULL COMMENT '责任方 1仓库 2城配 3无法判责 4干线(已废弃)',
  `state` int(11) DEFAULT NULL COMMENT '状态 1 待核准 2待判责 3 已完成',
  `buy_out` int(11) DEFAULT NULL COMMENT '是否买赔 0是 1否 （已废弃）',
  `buy_out_money` decimal(10,4) DEFAULT NULL COMMENT '买赔金额（已废弃）',
  `judgment_opinion` varchar(400) DEFAULT NULL COMMENT '判责意见',
  `stock_task_id` int(11) DEFAULT NULL COMMENT '任务编号',
  `pic` text COMMENT '缺货核准图片逗号分割',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `approved_admin_id` int(11) DEFAULT NULL COMMENT '缺货核准操作人id',
  `approved_time` datetime DEFAULT NULL COMMENT '缺货核准时间',
  `responsibility_admin_id` int(11) DEFAULT NULL COMMENT '判责操作人id',
  `responsibility_time` datetime DEFAULT NULL COMMENT '判责时间',
  `finish_time` datetime DEFAULT NULL COMMENT '配送结束时间',
  `order_no` varchar(100) DEFAULT NULL COMMENT '订单号',
  `amount` int(11) DEFAULT NULL COMMENT '订单数量',
  `stock_lack_num` int(11) DEFAULT '0' COMMENT '总仓少发数量',
  `tms_delivery_site_id` bigint(20) DEFAULT NULL COMMENT '运输单id',
  `approved_name` varchar(100) DEFAULT NULL COMMENT '缺货核准操作人',
  `responsibility_name` varchar(100) DEFAULT NULL COMMENT '判责操作人',
  `appeal_flag` int(11) DEFAULT '0' COMMENT '是否申诉 0未申诉 1已申诉',
  `responsibility_pic` text COMMENT '判责凭证',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ftime_type_state_index` (`finish_time`,`lack_type`,`state`) USING BTREE,
  KEY `idx_delivery_site_id` (`tms_delivery_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=754 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='缺货核准表'
---
DDL for table: tms_out_distance_config
CREATE TABLE `tms_out_distance_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `out_distance` float DEFAULT NULL COMMENT '签收距离（公里）',
  `state` tinyint(4) DEFAULT '0' COMMENT '状态0正常 1暂停',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8 COMMENT='配送超距离设置表'
---
DDL for table: tms_path
CREATE TABLE `tms_path` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键 路线ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `path_code` varchar(50) DEFAULT NULL COMMENT '路线编码',
  `path_name` varchar(100) DEFAULT NULL COMMENT '路线名称',
  `driver_id` bigint(20) DEFAULT NULL COMMENT '司机id',
  `car_id` bigint(20) DEFAULT NULL COMMENT '车辆id',
  `carrier_id` bigint(20) DEFAULT NULL COMMENT '承运商id',
  `auto_switch` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否按配置 定时生成路线实例(批次), 0关,1开',
  `period_week` int(11) DEFAULT NULL COMMENT '每隔几周运行',
  `period_weekday` varchar(32) DEFAULT NULL COMMENT '一周哪几天运行',
  `delivery_day` int(11) DEFAULT NULL COMMENT '配送时间为当天,还是前一天  0当天,-1前一天',
  `delivery_day_time` varchar(16) DEFAULT NULL COMMENT '配送时间,hh:mm',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '路线状态,-1删除,0停用,1启用',
  `begin_site_id` int(11) DEFAULT NULL COMMENT '路线开始点位',
  `end_site_id` int(11) DEFAULT NULL COMMENT '路线结束点位',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `estimate_fare` decimal(10,2) DEFAULT NULL COMMENT '预估运费',
  `creator_id` varchar(64) DEFAULT NULL COMMENT '创建者ID',
  `updater_id` varchar(64) DEFAULT NULL COMMENT '更新人ID',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '1干线, 2 城配',
  `distance` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '距离/km',
  `region` varchar(50) DEFAULT NULL COMMENT '区域',
  PRIMARY KEY (`id`),
  KEY `idx_carrier` (`carrier_id`),
  KEY `idx_driver` (`driver_id`),
  KEY `idx_car` (`car_id`),
  KEY `idx_begin` (`begin_site_id`),
  KEY `idx_end` (`end_site_id`),
  KEY `idx_begin_type_pcode` (`begin_site_id`,`type`,`path_code`)
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8 COMMENT='线路表'
---
DDL for table: tms_path_car
CREATE TABLE `tms_path_car` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `path_id` bigint(20) unsigned NOT NULL COMMENT '路由id',
  `dispatch_type` int(11) DEFAULT NULL COMMENT '调度类型,0-干线，1-城配',
  `shift_type` int(11) DEFAULT NULL COMMENT '班次类型 0-正班，1-加班',
  `start_time` date DEFAULT NULL COMMENT '开始计算时间',
  `period_type` int(11) DEFAULT NULL COMMENT '周期类型，0-表示每天，1表示每周',
  `every_week_type` varchar(50) DEFAULT NULL COMMENT '每周选项下的类型，0-每天，1-周一，2-周二，3-周三，4-周四，5-周五，6-周六，7-周日',
  `interval_days` int(11) DEFAULT NULL COMMENT '每天选项下，间隔天数',
  `carry_type` int(11) DEFAULT NULL COMMENT '承运类型，-1前一天，0-当日',
  `carry_time` varchar(32) DEFAULT NULL COMMENT '承运时间,HH:mm',
  `carrier_id` bigint(20) DEFAULT NULL COMMENT '承运商id',
  `driver_id` bigint(20) DEFAULT NULL COMMENT '司机id',
  `car_id` bigint(20) DEFAULT NULL COMMENT '车辆id',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `idx_path_car_path_id` (`path_id`)
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8 COMMENT='路由车次表'
---
DDL for table: tms_path_quotation
CREATE TABLE `tms_path_quotation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `path_id` bigint(20) NOT NULL COMMENT '路由id',
  `carrier_id` bigint(20) NOT NULL COMMENT '承运商id',
  `car_type` int(11) NOT NULL COMMENT '车型0:小面包车 1:中面包车 2:依维柯 3:小型货车 4: 4米2 5:6米8  6:7米6  7:7 9米6  8 :13米5 9:17米5',
  `storage` int(11) NOT NULL COMMENT '存储条件 0常温、1冷藏',
  `quotation_fee` decimal(11,2) NOT NULL COMMENT '报价费用。单位/元',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unx_path_quotation_path_id_carrier_id_car_type` (`path_id`,`carrier_id`,`car_type`,`storage`),
  KEY `idx_path_quotation_path_id` (`path_id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COMMENT='路由报价信息'
---
DDL for table: tms_path_section
CREATE TABLE `tms_path_section` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `begin_site_id` bigint(20) NOT NULL COMMENT '路段起点',
  `begin_site_name` varchar(50) DEFAULT NULL COMMENT '路段起点名',
  `end_site_id` bigint(20) NOT NULL COMMENT '路段终点',
  `end_site_name` varchar(50) DEFAULT NULL COMMENT '路段终点名',
  `plan_span` decimal(10,2) DEFAULT NULL COMMENT '单位 小时,预计花费时间',
  `sequence` int(11) DEFAULT NULL COMMENT '路段在path中的次序',
  `path_id` bigint(20) NOT NULL COMMENT '所属路线',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '路段类型 0城配,1干线',
  `load_hour` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '装货时长/h',
  PRIMARY KEY (`id`),
  KEY `idx_path` (`path_id`),
  KEY `idx_begin_type_end` (`begin_site_id`,`type`,`end_site_id`),
  KEY `idx_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=586 DEFAULT CHARSET=utf8 COMMENT='路线详情-路段'
---
DDL for table: tms_recycle
CREATE TABLE `tms_recycle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `after_sale_no` varchar(20) DEFAULT NULL COMMENT '售后单号',
  `delivery_path_id` int(11) DEFAULT NULL COMMENT '配送路线ID',
  `sku` varchar(30) DEFAULT NULL COMMENT 'SKU',
  `status` tinyint(4) DEFAULT NULL COMMENT '回收状态，0：异常，1：正常',
  `abnormal_reason` varchar(100) DEFAULT NULL COMMENT '异常原因',
  `short_flag` tinyint(4) DEFAULT NULL COMMENT '是否缺损，0：否，1：是',
  `recycle_num` int(11) DEFAULT NULL COMMENT '回收数量',
  `weight` varchar(50) DEFAULT NULL COMMENT '包装规格',
  `other_num` varchar(50) DEFAULT NULL COMMENT '其他数量',
  `recycle_pics` varchar(150) DEFAULT NULL COMMENT '回收照片',
  `other_info` varchar(100) DEFAULT NULL COMMENT '其他情况说明',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(30) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='回收详情表'
---
DDL for table: tms_recycle_task
CREATE TABLE `tms_recycle_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tms_recyle_id` bigint(20) DEFAULT NULL COMMENT '回收ID',
  `status` tinyint(4) DEFAULT NULL COMMENT '调整状态，0：未调整，1：已调整',
  `recycle_flag` tinyint(4) DEFAULT NULL COMMENT '是否生成回收任务，0：否，1：是',
  `next_recycle_time` datetime DEFAULT NULL COMMENT '再次回收时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注说明',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(30) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='回收失败任务表'
---
DDL for table: tms_stop_delivery
CREATE TABLE `tms_stop_delivery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `shutdown_start_time` date DEFAULT NULL COMMENT '停运开始时间',
  `shutdown_end_time` date DEFAULT NULL COMMENT '停运结束时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_no` (`store_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='停运时间'
---
DDL for table: tms_task
CREATE TABLE `tms_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_time` date DEFAULT NULL COMMENT '配送时间',
  `path` varchar(45) DEFAULT NULL COMMENT '配送线路',
  `sku_cnt` int(11) DEFAULT NULL COMMENT '捡货商品数',
  `concat_cnt` int(11) DEFAULT NULL COMMENT '配送商家数量',
  `task_status` int(11) DEFAULT NULL COMMENT '任务状态，待捡货，配送中，配送完成',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `pick_up_time` datetime DEFAULT NULL COMMENT '完成捡货时间',
  `store_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `loading_photos` varchar(255) DEFAULT NULL COMMENT '装车照片',
  `out_warehouse_temperature` decimal(10,3) DEFAULT NULL COMMENT '出仓温度',
  `out_time` datetime DEFAULT NULL COMMENT '出仓时间',
  `over_out_time_reason` varchar(255) DEFAULT NULL COMMENT '出仓晚点原因',
  `punch_time` datetime DEFAULT NULL COMMENT '打卡时间',
  `punch_distance` decimal(10,2) DEFAULT NULL COMMENT '打卡距离',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tms_task_index` (`store_no`,`delivery_time`,`path`) USING BTREE,
  KEY `index_delivery_time` (`delivery_time`)
) ENGINE=InnoDB AUTO_INCREMENT=226107 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: tms_task_operate_record
CREATE TABLE `tms_task_operate_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addtime` datetime DEFAULT NULL,
  `operate_type` varchar(100) DEFAULT NULL COMMENT '操作类型',
  `operator` varchar(45) DEFAULT NULL COMMENT '操作人名称',
  `operator_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `delivery_path_id` int(11) DEFAULT NULL,
  `delivery_site_id` bigint(20) DEFAULT NULL COMMENT '新模型点位维度ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tms_task_operate_record_index` (`operate_type`,`delivery_path_id`) USING BTREE,
  KEY `tms_task_operate_record_pid_index` (`delivery_path_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24708 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='tms任务操作轨迹'
---
DDL for table: tms_without_code
CREATE TABLE `tms_without_code` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delivery_path_id` int(11) DEFAULT NULL COMMENT '配送单id',
  `sku` varchar(100) DEFAULT NULL COMMENT 'sku',
  `quantity` int(11) DEFAULT NULL COMMENT '无码数量',
  `remake` varchar(100) DEFAULT NULL COMMENT '原因备注',
  `pictures` varchar(255) DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_dp_id_sku` (`delivery_path_id`,`sku`),
  KEY `n_path_id` (`delivery_path_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1274 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='配送有货无码表'
---
DDL for table: top
CREATE TABLE `top` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL COMMENT '城市',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `keyword` varchar(20) DEFAULT NULL COMMENT '关键词',
  `detail` text COMMENT '详情',
  `type` int(11) DEFAULT NULL COMMENT '1购物车类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT
---
DDL for table: trolley
CREATE TABLE `trolley` (
  `m_id` bigint(30) NOT NULL COMMENT '用户',
  `account_id` bigint(30) NOT NULL DEFAULT '0' COMMENT '子账号id',
  `sku` varchar(255) NOT NULL,
  `parent_sku` varchar(30) NOT NULL DEFAULT '0' COMMENT '搭配购上级sku',
  `suit_id` int(11) NOT NULL DEFAULT '0',
  `product_type` int(11) NOT NULL DEFAULT '0' COMMENT '商品类型：0、普通商品 1、赠品',
  `quantity` int(11) DEFAULT '1' COMMENT '购买数量',
  `check` tinyint(4) DEFAULT '1' COMMENT '是否选中,0否，1选中',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标记,0未删除，1已删除',
  `biz_id` bigint(20) DEFAULT NULL COMMENT '业务id',
  PRIMARY KEY (`m_id`,`account_id`,`parent_sku`,`suit_id`,`sku`,`product_type`) USING BTREE,
  KEY `idx_madc` (`m_id`,`account_id`,`del_flag`,`check`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='trolley购物车表'
---
DDL for table: trolley_bak
CREATE TABLE `trolley_bak` (
  `m_id` bigint(30) NOT NULL COMMENT '用户',
  `account_id` bigint(30) NOT NULL DEFAULT '0' COMMENT '子账号id',
  `sku` varchar(255) NOT NULL,
  `parent_sku` varchar(30) DEFAULT '0' COMMENT '搭配购上级sku',
  `suit_id` int(11) NOT NULL DEFAULT '0',
  `product_type` int(11) NOT NULL DEFAULT '0' COMMENT '商品类型：0、普通商品 1、赠品',
  `quantity` int(11) DEFAULT '1' COMMENT '购买数量',
  `check` tinyint(4) DEFAULT '1' COMMENT '是否选中,0否，1选中',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标记,0未删除，1已删除'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='trolley购物车表'
---
DDL for table: trust_change_record
CREATE TABLE `trust_change_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓编号',
  `sku` varchar(33) DEFAULT NULL,
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `success_flag` tinyint(1) DEFAULT NULL COMMENT '是否成功',
  `result_msg` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=632656 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT
---
DDL for table: user
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `biz_user_id` bigint(20) DEFAULT NULL COMMENT '业务用户关联ID，与其他业务系统用户表主键关联',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0：有效，1：失效',
  `system_origin` tinyint(1) NOT NULL COMMENT '系统来源，0：srm',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_userid_type` (`biz_user_id`,`system_origin`) USING BTREE,
  KEY `idx_username_type` (`username`,`system_origin`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户基础账号表'
---
DDL for table: user_auth
CREATE TABLE `user_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '基础用户表关联ID，与基础用户表主键关联字段',
  `auth_type` tinyint(4) DEFAULT NULL COMMENT '认证类型，0：钉钉，1：微信小程序',
  `auth_id` varchar(50) DEFAULT NULL COMMENT '授权ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_code_type` (`auth_id`,`auth_type`),
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1800 DEFAULT CHARSET=utf8 COMMENT='用户授权表'
---
DDL for table: user_base
CREATE TABLE `user_base` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `biz_user_id` bigint(20) DEFAULT NULL COMMENT '业务用户关联ID，与其他业务系统用户表主键关联',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态，0：有效，1：失效',
  `system_origin` int(11) DEFAULT NULL COMMENT '系统来源，0：srm、1：tms',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `base_user_id` bigint(20) DEFAULT NULL COMMENT 'auth base_user_id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_userid_type` (`biz_user_id`,`system_origin`),
  KEY `idx_username_type` (`username`,`system_origin`),
  KEY `idx_base_user_id` (`base_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=881 DEFAULT CHARSET=utf8 COMMENT='用户基础账号表'
---
DDL for table: user_login_log
CREATE TABLE `user_login_log` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `system_origin` varchar(20) DEFAULT NULL COMMENT '系统来源，SRM、TMS、ADMIN、CRM',
  `login_type` varchar(20) DEFAULT NULL COMMENT '登录类型，PC、微信小程序、钉钉应用',
  `login_status` varchar(10) DEFAULT NULL COMMENT '登录状态，成功、失败',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户登录日志表'
---
DDL for table: user_properties_ext
CREATE TABLE `user_properties_ext` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `user_id` bigint(20) DEFAULT NULL COMMENT '基础用户表关联ID，与基础用户表主键关联字段',
  `prop_key` varchar(100) DEFAULT NULL COMMENT '属性名称',
  `prop_value` varchar(200) DEFAULT NULL COMMENT '属性值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_key_userid` (`prop_key`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1501 DEFAULT CHARSET=utf8 COMMENT='用户属性扩展表'
---
DDL for table: user_properties_ext_copy1
CREATE TABLE `user_properties_ext_copy1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `user_id` bigint(20) DEFAULT NULL COMMENT '基础用户表关联ID，与基础用户表主键关联字段',
  `prop_key` varchar(100) DEFAULT NULL COMMENT '属性名称',
  `prop_value` varchar(200) DEFAULT NULL COMMENT '属性值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_userid_key` (`user_id`,`prop_key`),
  KEY `idx_value` (`prop_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户属性扩展表'
---
DDL for table: user_system_auth
CREATE TABLE `user_system_auth` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '基础用户表关联ID，与基础用户表主键关联字段',
  `biz_user_id` bigint(20) DEFAULT NULL COMMENT '业务用户关联ID，与其他业务系统用户表主键关联',
  `system_origin` tinyint(1) DEFAULT NULL COMMENT '系统来源，0：srm、1：admin、2:crm',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_userid_type` (`biz_user_id`,`system_origin`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
---
DDL for table: v_last_settlement
undefined
---
DDL for table: v_order_preferential
undefined
---
DDL for table: v_purchase_to_settlement
undefined
---
DDL for table: v_purchases_ext
undefined
---
DDL for table: v_unsettle
undefined
---
DDL for table: visit_plan
CREATE TABLE `visit_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `expected_time` datetime DEFAULT NULL COMMENT '期望拜访时间',
  `status` int(11) DEFAULT NULL COMMENT '状态：0待拜访,1已拜访 2,取消 3,未完成',
  `m_id` int(11) DEFAULT NULL COMMENT '客户id',
  `admin_id` int(11) DEFAULT NULL COMMENT '联系人ID',
  `expected_content` varchar(255) DEFAULT NULL COMMENT '期望内容',
  `contact_id` int(11) DEFAULT NULL COMMENT '联系人地址id',
  `creator` varchar(30) DEFAULT NULL COMMENT '创建人名称',
  `type` int(11) DEFAULT '0' COMMENT '拜访类型:0拜访,1拉新,2陪访',
  `cancel_content` varchar(255) DEFAULT NULL COMMENT '取消原因',
  `escort_admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '陪访人id(202207弃用)',
  `source` tinyint(4) DEFAULT '0' COMMENT '0 默认添加 1审核添加',
  `province` varchar(50) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_time_admin_contact` (`expected_time`,`admin_id`,`contact_id`) USING BTREE,
  KEY `idx_admin_id` (`admin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3309 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='拜访计划'
---
DDL for table: warehouse_batch_prove_record
CREATE TABLE `warehouse_batch_prove_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `type` tinyint(4) DEFAULT NULL COMMENT '任务类型编号 9预约入库  10调拨入库 11采购入库',
  `source_id` varchar(30) DEFAULT NULL COMMENT '来源唯一id',
  `sku` varchar(30) NOT NULL COMMENT 'sku编号',
  `batch` varchar(30) NOT NULL COMMENT '批次编号',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `quality_inspection_report` varchar(255) DEFAULT NULL COMMENT '质检报告',
  `customs_declaration_certificate` varchar(255) DEFAULT NULL COMMENT '报关证明',
  `nucleic_acid_detection` varchar(255) DEFAULT NULL COMMENT '核酸检测',
  `disinfection_certificate` varchar(255) DEFAULT NULL COMMENT '消毒证明',
  `supervision_warehouse_certificate` varchar(255) DEFAULT NULL COMMENT '监管仓证明',
  `detection_result` tinyint(4) DEFAULT NULL COMMENT '检测结果 0 合格 1 不合格',
  `sampling_base` decimal(10,2) DEFAULT NULL COMMENT '抽样基数',
  `number_samples` decimal(10,2) DEFAULT NULL COMMENT '抽样数',
  `inhibition_rate` decimal(10,2) DEFAULT NULL COMMENT '抑制率',
  `pesticide_residue_pictures` varchar(500) DEFAULT NULL COMMENT '农药残留报告图片',
  `creator` int(11) DEFAULT NULL COMMENT '创建人admin_id',
  `quality_date` date DEFAULT NULL COMMENT '保质日期',
  `proof_complete` tinyint(4) DEFAULT NULL COMMENT '证件是否齐全',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id(saas品牌方)',
  `creator_name` varchar(255) DEFAULT NULL COMMENT '操作人名称',
  PRIMARY KEY (`id`),
  KEY `idx_batch_production_date` (`batch`,`production_date`),
  KEY `idx_sourceid_type` (`source_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=27118 DEFAULT CHARSET=utf8 COMMENT='库存商品证件信息变更记录表'
---
DDL for table: warehouse_change_record
CREATE TABLE `warehouse_change_record` (
  `id` bigint(30) NOT NULL AUTO_INCREMENT,
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `store_no` int(11) DEFAULT NULL COMMENT '配送仓编号',
  `sku` varchar(30) DEFAULT NULL,
  `recorder` varchar(30) DEFAULT NULL COMMENT '记录人',
  `record_no` varchar(36) DEFAULT NULL,
  `new_sale_lock_quantity` int(11) DEFAULT NULL COMMENT '新销售冻结库存',
  `old_sale_lock_quantity` int(11) DEFAULT NULL COMMENT '原销售冻结库存',
  `type_name` varchar(20) DEFAULT NULL COMMENT '库存变动类型',
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `quantity_change_record_store_sku_index` (`store_no`,`sku`,`addtime`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=137704 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='配送仓冻结库存变动记录'
---
DDL for table: warehouse_cost_batch
CREATE TABLE `warehouse_cost_batch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(255) DEFAULT NULL COMMENT 'sku',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `produce_batch_id` int(11) DEFAULT NULL COMMENT '生产批次id',
  `purchase_no` varchar(30) DEFAULT NULL COMMENT '采购单号',
  `batch_no` varchar(255) DEFAULT NULL COMMENT '批次号(采购单为采购单号)',
  `quantity` int(11) DEFAULT NULL COMMENT '数量',
  `lot_type` tinyint(4) DEFAULT '0' COMMENT '批次类型 0正常 1 降级',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)，鲜沐为1',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`),
  KEY `idx_produce_batch` (`produce_batch_id`),
  KEY `idx_purchase_no` (`purchase_no`,`sku`),
  KEY `idx_warehouse_no_sku` (`warehouse_no`,`sku`,`quantity`)
) ENGINE=InnoDB AUTO_INCREMENT=85310 DEFAULT CHARSET=utf8 COMMENT='成本批次库存信息表'
---
DDL for table: warehouse_cost_batch_detail
CREATE TABLE `warehouse_cost_batch_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `type` int(11) DEFAULT NULL COMMENT '成本类型 1.采购成本 2.自提成本 3 调拨运输成本',
  `cost` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '金额',
  `cost_batch_id` int(11) DEFAULT NULL COMMENT '批次成本id',
  `quantity` int(11) DEFAULT NULL COMMENT '入库数量',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)，鲜沐为1',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`),
  KEY `idx_cost_batch` (`cost_batch_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=87868 DEFAULT CHARSET=utf8 COMMENT='成本批次各项成本详情'
---
DDL for table: warehouse_cost_batch_detail_record
CREATE TABLE `warehouse_cost_batch_detail_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_cost_batch_detail_id` bigint(20) DEFAULT NULL COMMENT 'id',
  `cost` decimal(10,2) DEFAULT '0.00' COMMENT '成本',
  `source_id` int(11) DEFAULT NULL COMMENT '来源id',
  `source_type` int(11) DEFAULT NULL COMMENT '变更类型',
  `recorder` varchar(255) DEFAULT NULL COMMENT 're',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)，鲜沐为1',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`),
  KEY `idx_detail_id` (`warehouse_cost_batch_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69983 DEFAULT CHARSET=utf8 COMMENT='成本变更记录'
---
DDL for table: warehouse_cost_batch_record
CREATE TABLE `warehouse_cost_batch_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `warehouse_cost_batch_id` bigint(20) DEFAULT NULL COMMENT '成本批次id',
  `source_id` varchar(50) DEFAULT NULL COMMENT '改动来源id',
  `source_type` tinyint(4) DEFAULT NULL COMMENT '变动类型',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `quantity` int(11) DEFAULT NULL COMMENT '操作数量',
  `recorder` varchar(255) DEFAULT NULL COMMENT '操作人',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)，鲜沐为1',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`),
  KEY `n_id` (`warehouse_cost_batch_id`),
  KEY `ndx_sku_source` (`warehouse_no`,`source_id`,`source_type`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=88046 DEFAULT CHARSET=utf8 COMMENT='成本变动记录'
---
DDL for table: warehouse_inventory_mapping
CREATE TABLE `warehouse_inventory_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `store_no` int(11) NOT NULL COMMENT '物流中心编号',
  `sku` varchar(33) NOT NULL COMMENT 'sku',
  `sale_lock_quantity` int(10) unsigned DEFAULT '0' COMMENT '物流中心销售冻结',
  `reserve_quantity` int(11) DEFAULT '0' COMMENT '预留库存使用数量',
  `support_reserved` int(11) DEFAULT '0' COMMENT '是否支持预留库存',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `warehouse_inventory_mapping_main_index` (`store_no`,`sku`) USING BTREE,
  KEY `warehouse_inventory_mapping_warehouse_index` (`warehouse_no`,`sku`) USING BTREE,
  KEY `idx_sku_store_warehouse` (`sku`,`store_no`,`warehouse_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=150915 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='sku配送中心仓库映射表'
---
DDL for table: warehouse_inventory_mapping_bak
CREATE TABLE `warehouse_inventory_mapping_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `store_no` int(11) NOT NULL COMMENT '物流中心编号',
  `sku` varchar(33) NOT NULL COMMENT 'sku',
  `sale_lock_quantity` int(10) unsigned DEFAULT '0' COMMENT '物流中心销售冻结',
  `reserve_quantity` int(11) DEFAULT NULL COMMENT '预留库存使用数量',
  `support_reserved` int(11) DEFAULT NULL COMMENT '是否支持预留库存',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `warehouse_inventory_mapping_main_index` (`store_no`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='sku配送中心仓库映射表'
---
DDL for table: warehouse_logistics_center
CREATE TABLE `warehouse_logistics_center` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '物流中心编号（配送仓编号）',
  `store_name` varchar(255) DEFAULT NULL COMMENT '名称',
  `status` int(11) DEFAULT '1' COMMENT '配送中心状态：0、失效 1、有效',
  `manage_admin_id` int(11) DEFAULT NULL COMMENT '物流中心负责人',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德poi',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `close_order_type` int(11) DEFAULT '0' COMMENT '是否支持提前截单：0、false 1、true',
  `origin_store_no` int(11) DEFAULT NULL COMMENT '同步库存使用仓编号',
  `sot_finish_time` datetime DEFAULT NULL COMMENT '销售出库完成时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `close_time` varchar(60) DEFAULT NULL COMMENT '截单时间',
  `update_close_time` varchar(60) DEFAULT NULL COMMENT '更新截单时间',
  `person_contact` varchar(50) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(50) DEFAULT NULL COMMENT '手机号',
  `region` varchar(50) DEFAULT NULL COMMENT '区域',
  `store_pic` varchar(1000) DEFAULT NULL COMMENT '城配仓照片',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `warehouse_logistics_center_store_no_uindex` (`store_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=896 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='仓储物流中心'
---
DDL for table: warehouse_logistics_center_bak
CREATE TABLE `warehouse_logistics_center_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '物流中心编号（配送仓编号）',
  `store_name` varchar(255) DEFAULT NULL COMMENT '名称',
  `status` int(11) DEFAULT '1' COMMENT '配送中心状态：0、失效 1、有效',
  `manage_admin_id` int(11) DEFAULT NULL COMMENT '物流中心负责人',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德poi',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `origin_store_no` int(11) DEFAULT NULL COMMENT '同步库存使用仓编号',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `sot_finish_time` datetime DEFAULT NULL COMMENT '销售出库完成时间',
  `close_order_type` int(11) DEFAULT '0' COMMENT '是否支持提前截单',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `warehouse_logistics_center_store_no_uindex` (`store_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='仓储物流中心'
---
DDL for table: warehouse_logistics_center_copy1
CREATE TABLE `warehouse_logistics_center_copy1` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '物流中心编号（配送仓编号）',
  `store_name` varchar(255) DEFAULT NULL COMMENT '名称',
  `status` int(11) DEFAULT '1' COMMENT '配送中心状态：0、失效 1、有效',
  `manage_admin_id` int(11) DEFAULT NULL COMMENT '物流中心负责人',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德poi',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `close_order_type` int(11) DEFAULT '0' COMMENT '是否支持提前截单：0、false 1、true',
  `origin_store_no` int(11) DEFAULT NULL COMMENT '同步库存使用仓编号',
  `sot_finish_time` datetime DEFAULT NULL COMMENT '销售出库完成时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `updater` int(11) DEFAULT NULL COMMENT '修改人adminId',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `close_time` varchar(60) DEFAULT NULL COMMENT '截单时间',
  `update_close_time` varchar(60) DEFAULT NULL COMMENT '更新截单时间',
  `person_contact` varchar(50) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(50) DEFAULT NULL COMMENT '手机号',
  `region` varchar(50) DEFAULT NULL COMMENT '区域',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `warehouse_logistics_center_store_no_uindex` (`store_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='仓储物流中心'
---
DDL for table: warehouse_logistics_config
CREATE TABLE `warehouse_logistics_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `type` int(11) DEFAULT NULL COMMENT '类型：0、调拨-仓到仓 1、干线车-仓到配送中心 2、配送车-配送中心到城市',
  `status` int(11) DEFAULT '1' COMMENT '状态：0、失效 1、有效',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `store_no` int(11) DEFAULT NULL COMMENT '物流中心编号(配送仓编号)',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `allocation_warehouse_no` int(11) DEFAULT NULL COMMENT '调拨到仓',
  `cycle_type` int(11) DEFAULT NULL COMMENT '周期类型：0、天 1、周 2、月',
  `logistics_time` int(11) DEFAULT NULL COMMENT '配送时间：0、每天 1、每周 2、每月',
  `next_day_arrive` int(11) DEFAULT NULL COMMENT '出库即售/是否次日达：0、开启/是 1、关闭/否',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `sale_partake` tinyint(4) DEFAULT '0' COMMENT '销售参与：0.不参与1.参与',
  `last_implement_time` date DEFAULT NULL COMMENT '上次系统发起调拨时间',
  `purchase_partake` tinyint(4) DEFAULT '1' COMMENT '采购参与：0.不参与1.参与',
  `temperature_split_rule` varchar(10) DEFAULT NULL COMMENT '1:冷冻 2:冷藏 4:常温  逗号分割组合 例如3,4表示冷冻+冷藏,常温组合',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_last_implement_time` (`last_implement_time`),
  KEY `idx_allocation_key` (`warehouse_no`,`allocation_warehouse_no`,`cycle_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2008 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='物流信息配置(截止2022年06月08号,只有调拨配置使用,没有其他类型)'
---
DDL for table: warehouse_logistics_config_bak
CREATE TABLE `warehouse_logistics_config_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `type` int(11) DEFAULT NULL COMMENT '类型：0、调拨-仓到仓 1、干线车-仓到配送中心 2、配送车-配送中心到城市',
  `status` int(11) DEFAULT '1' COMMENT '状态：0、失效 1、有效',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `store_no` int(11) DEFAULT NULL COMMENT '物流中心编号(配送仓编号)',
  `area_no` int(11) DEFAULT NULL COMMENT '城市编号',
  `allocation_warehouse_no` int(11) DEFAULT NULL COMMENT '调拨到仓',
  `cycle_type` int(11) DEFAULT NULL COMMENT '周期类型：0、天 1、周 2、月',
  `logistics_time` int(11) DEFAULT NULL COMMENT '配送时间：0、每天 1、每周 2、每月',
  `next_day_arrive` int(11) DEFAULT NULL COMMENT '是否次日达：0、否 1、是',
  `updater` int(11) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `warehouse_logistics_config_area_index` (`area_no`) USING BTREE,
  KEY `warehouse_logistics_config_warehouse_index` (`warehouse_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='物流信息配置'
---
DDL for table: warehouse_logistics_mapping
CREATE TABLE `warehouse_logistics_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '物流中心编号（配送仓编号）',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号（库存仓编号）',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `mapping_unique_index` (`store_no`,`warehouse_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=787 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='仓储物流中心对应'
---
DDL for table: warehouse_logistics_mapping_bak
CREATE TABLE `warehouse_logistics_mapping_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `store_no` int(11) DEFAULT NULL COMMENT '物流中心编号（配送仓编号）',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号（库存仓编号）',
  `creator` int(11) DEFAULT NULL COMMENT '创建人adminId',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `mapping_unique_index` (`store_no`,`warehouse_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='仓储物流中心对应'
---
DDL for table: warehouse_logistics_path_temp
CREATE TABLE `warehouse_logistics_path_temp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓ID',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓ID',
  `path` int(11) DEFAULT NULL COMMENT '路线ID',
  `path_name` varchar(500) DEFAULT NULL COMMENT '路线名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_warehouseno_storeno` (`warehouse_no`,`store_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存仓-城配仓路线配置表（临时）'
---
DDL for table: warehouse_patrol_check
CREATE TABLE `warehouse_patrol_check` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `sku` varchar(50) DEFAULT NULL COMMENT 'sku',
  `check_time` datetime DEFAULT NULL COMMENT '自检时间',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型 虚拟库存，销售冻结，仓库库存',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1546867 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='库存自检表（异常数据存储）'
---
DDL for table: warehouse_produce_batch
CREATE TABLE `warehouse_produce_batch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(255) DEFAULT NULL COMMENT 'sku',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `quantity` int(10) unsigned DEFAULT NULL COMMENT '数量',
  `shelf_life` bigint(20) unsigned DEFAULT NULL COMMENT '保质期',
  `produce_at` bigint(20) unsigned DEFAULT NULL COMMENT '生产日期',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)，鲜沐为1',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_sku` (`sku`,`warehouse_no`,`shelf_life`,`produce_at`),
  KEY `n_sku_warehouse` (`warehouse_no`,`sku`,`produce_at`)
) ENGINE=InnoDB AUTO_INCREMENT=19820 DEFAULT CHARSET=utf8 COMMENT='生产批次信息'
---
DDL for table: warehouse_produce_batch_record
CREATE TABLE `warehouse_produce_batch_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(255) DEFAULT NULL COMMENT 'sku',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库',
  `warehouse_produce_batch_id` int(11) DEFAULT NULL COMMENT '生产批次id',
  `quantity` int(11) DEFAULT NULL COMMENT '更新后数量',
  `source_id` int(11) DEFAULT NULL COMMENT '原id',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型',
  `recorder` varchar(255) DEFAULT NULL COMMENT '记录人',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id(saas品牌方)，鲜沐为1',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91430 DEFAULT CHARSET=utf8 COMMENT='⽣产批次信息更新表'
---
DDL for table: warehouse_stock_ext
CREATE TABLE `warehouse_stock_ext` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` int(11) DEFAULT NULL COMMENT 'area_store表id',
  `sku` varchar(150) DEFAULT NULL COMMENT 'sku',
  `status` tinyint(4) DEFAULT '0' COMMENT 'sku状态,0正常,1采购入库中,2出入库中,3盘点中',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `n_warehouse_sku` (`warehouse_no`,`sku`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8546948 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='仓库库存扩展表'
---
DDL for table: warehouse_storage_center
CREATE TABLE `warehouse_storage_center` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(50) DEFAULT NULL COMMENT '仓库名称',
  `manage_admin_id` int(11) DEFAULT NULL COMMENT '仓库负责人',
  `type` int(11) DEFAULT NULL COMMENT '仓库类型：0、本部仓 1、外部仓 2、合伙人仓',
  `area_manage_id` int(11) DEFAULT NULL COMMENT '仓库所属合伙人',
  `status` int(11) DEFAULT '1' COMMENT '开放状态：0、不开放 1、开放',
  `address` varchar(255) DEFAULT NULL COMMENT '仓库地址',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德poi',
  `mail_to_address` varchar(255) DEFAULT NULL COMMENT '邮件接收人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `person_contact` varchar(50) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(50) DEFAULT NULL COMMENT '手机号',
  `tenant_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '所属租户1鲜沐',
  `warehouse_pic` varchar(1000) DEFAULT NULL COMMENT '仓库照片',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `warehouse_storage_center_warehouse_no_uindex` (`warehouse_no`) USING BTREE,
  KEY `idx_warehouse_no_status` (`warehouse_no`,`status`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1045 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='仓储中心'
---
DDL for table: warehouse_storage_center_bak
CREATE TABLE `warehouse_storage_center_bak` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(50) DEFAULT NULL COMMENT '仓库名称',
  `manage_admin_id` int(11) DEFAULT NULL COMMENT '仓库负责人',
  `type` int(11) DEFAULT NULL COMMENT '仓库类型：0、本部仓 1、外部仓 2、合伙人仓',
  `area_manage_id` int(11) DEFAULT NULL COMMENT '仓库所属合伙人',
  `status` int(11) DEFAULT '1' COMMENT '开放状态：0、不开放 1、开放',
  `address` varchar(255) DEFAULT NULL COMMENT '仓库地址',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '高德poi',
  `mail_to_address` varchar(255) DEFAULT NULL COMMENT '邮件接收人',
  `updater` int(11) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `warehouse_storage_center_warehouse_no_uindex` (`warehouse_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='仓储中心'
---
DDL for table: warehouse_storage_center_business
CREATE TABLE `warehouse_storage_center_business` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `capacity` bigint(20) DEFAULT NULL COMMENT '产能',
  `advance_day` int(11) DEFAULT NULL COMMENT '预约提前期',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_no` (`warehouse_no`,`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=756 DEFAULT CHARSET=utf8 COMMENT='仓库业务表'
---
DDL for table: warehouse_storage_center_business_work
CREATE TABLE `warehouse_storage_center_business_work` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_storage_center_business_id` bigint(20) DEFAULT NULL COMMENT '仓库业务属性id',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `work_start_time` time DEFAULT NULL COMMENT '仓库工作开始时间',
  `work_end_time` time DEFAULT NULL COMMENT '仓库工作结束时间',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_storage_center_business_id` (`warehouse_storage_center_business_id`,`is_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=1746 DEFAULT CHARSET=utf8 COMMENT='仓库工作时间关联表'
---
DDL for table: warehouse_take_standard
CREATE TABLE `warehouse_take_standard` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `standard_type` int(11) NOT NULL COMMENT '0国产鲜果 1国产非鲜果 2进口鲜果 3进口非鲜果',
  `storage_location` tinyint(4) NOT NULL COMMENT '仓储区域',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `prove_type` tinyint(4) NOT NULL COMMENT '证明类型：0质检报告 1农残检测报告 2消毒记录 3核酸检测 4报关证明 5监管仓证明',
  `create_admin_id` int(11) NOT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14027 DEFAULT CHARSET=utf8 COMMENT='仓库收货标准表'
---
DDL for table: wechat_scheme
CREATE TABLE `wechat_scheme` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `host_ip` varchar(128) NOT NULL COMMENT '请求ip',
  `scheme` varchar(255) DEFAULT NULL COMMENT 'scheme码',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_ip` (`host_ip`) USING BTREE,
  KEY `idx_scheme` (`scheme`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='scheme码存储表'
---
DDL for table: wechat_tag
CREATE TABLE `wechat_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tag_name` varchar(50) DEFAULT NULL COMMENT '标签',
  `tag_id` varchar(100) DEFAULT NULL COMMENT '企微tag id',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `group_id` varchar(50) DEFAULT NULL COMMENT '标签组',
  `group_name` varchar(50) DEFAULT NULL COMMENT '标签名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='企微标签'
---
DDL for table: wechat_user_info
CREATE TABLE `wechat_user_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `user_id` varchar(50) DEFAULT NULL COMMENT '企微用户 id',
  `unionid` varchar(50) DEFAULT NULL COMMENT '企微 unionid',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态:1:正常;2:客户删除员工;3:员工删除客户;4:互删;',
  `external_userid` varchar(50) DEFAULT NULL COMMENT '客户 id',
  `admin_id` bigint(20) DEFAULT NULL COMMENT '鲜沐账号 id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `state` varchar(20) DEFAULT NULL COMMENT '用户的渠道',
  PRIMARY KEY (`id`),
  KEY `idx_user_id_unionid` (`user_id`,`unionid`)
) ENGINE=InnoDB AUTO_INCREMENT=66393 DEFAULT CHARSET=utf8mb4 COMMENT='企微销售客户详情'
---
DDL for table: will_expire_price_log
CREATE TABLE `will_expire_price_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `area_no` int(10) unsigned NOT NULL COMMENT '城市编号',
  `sku` varchar(30) NOT NULL DEFAULT '""' COMMENT 'sku编号',
  `remaining_expired_days` int(11) NOT NULL DEFAULT '0' COMMENT '临保天数',
  `warn_days` int(11) NOT NULL DEFAULT '0' COMMENT '预警天数',
  `sell_out_rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '售罄率',
  `turnover_rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '周转率',
  `sale_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '临保对应普通商品售价',
  `sales_pace` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '销售速度',
  `discout` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '折扣,举例：0.98表示98折',
  `original_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '临保原价',
  `cal_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '计算后的临保价',
  `reason` tinyint(3) unsigned DEFAULT NULL COMMENT '临保价变动原因，0 临保计算，1 转换入库',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `id_sku_area_no` (`sku`,`area_no`)
) ENGINE=InnoDB AUTO_INCREMENT=23911 DEFAULT CHARSET=utf8 COMMENT='临保价计算参数表'
---
DDL for table: wms_abnormal_submit_detail
CREATE TABLE `wms_abnormal_submit_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `mission_no` varchar(32) DEFAULT NULL COMMENT '任务编号',
  `unit_no` varchar(32) DEFAULT NULL COMMENT '执行单元编号',
  `source_carrier_type` int(10) unsigned DEFAULT NULL COMMENT '来源载体类型',
  `source_carrier_code` varchar(32) DEFAULT NULL COMMENT '来源载体编号',
  `target_carrier_type` int(10) unsigned DEFAULT NULL COMMENT '目标载体类型',
  `target_carrier_code` varchar(32) DEFAULT NULL COMMENT '目标载体编号',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库编号',
  `sku` varchar(128) DEFAULT NULL COMMENT 'sku',
  `produce_time` datetime DEFAULT NULL COMMENT '生产日期',
  `shelf_life` datetime DEFAULT NULL COMMENT '保质期',
  `batch_no` varchar(128) DEFAULT NULL COMMENT '批次',
  `abnormal_quantity` int(11) DEFAULT NULL COMMENT '数量',
  `cargo_owner` varchar(32) DEFAULT NULL COMMENT '货主',
  `opreator_name` varchar(16) DEFAULT NULL COMMENT '操作人名称',
  `operator_id` int(10) unsigned DEFAULT NULL COMMENT '操作人id',
  `mission_type` int(10) unsigned DEFAULT NULL COMMENT '任务类型',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id',
  `abnormal_reason` varchar(32) DEFAULT NULL COMMENT '异常原因',
  `split_type` int(10) DEFAULT NULL COMMENT '拆分类型 1-城配仓',
  `split_info` varchar(32) DEFAULT NULL COMMENT '拆分信息',
  PRIMARY KEY (`id`),
  KEY `idx_mission` (`mission_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=2677 DEFAULT CHARSET=utf8 COMMENT='wms任务异常执行明细'
---
DDL for table: wms_area_store_inventory_transaction
CREATE TABLE `wms_area_store_inventory_transaction` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库号',
  `biz_id` varchar(128) DEFAULT NULL COMMENT '业务id',
  `biz_type` varchar(32) DEFAULT NULL COMMENT '业务类型',
  `inventory_type` varchar(32) DEFAULT NULL COMMENT '库存类型',
  `param` text COMMENT '请求参数',
  `transaction_state` int(10) unsigned DEFAULT NULL COMMENT '分布式事务状态',
  `sku` varchar(128) DEFAULT NULL COMMENT 'sku',
  PRIMARY KEY (`id`),
  KEY `idx_biz` (`warehouse_no`,`biz_id`,`biz_type`,`sku`,`inventory_type`)
) ENGINE=InnoDB AUTO_INCREMENT=9498 DEFAULT CHARSET=utf8 COMMENT='仓库库存分布式事务日志表'
---
DDL for table: wms_batch_frozen
CREATE TABLE `wms_batch_frozen` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓id',
  `sku` varchar(30) DEFAULT NULL COMMENT 'sku',
  `batch` varchar(30) DEFAULT NULL COMMENT '批次',
  `lock_quantity` int(11) DEFAULT NULL COMMENT '锁定数量',
  `type` int(11) DEFAULT NULL COMMENT '类型（53 货损出库，58 采购退货出库）',
  `type_id` int(11) DEFAULT NULL COMMENT '关联的类型id',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态 0有效 1失效',
  `reason` varchar(50) DEFAULT NULL COMMENT '原因',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='批次冻结表'
---
DDL for table: wms_cabinet
CREATE TABLE `wms_cabinet` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `cabinet_code` varchar(30) NOT NULL COMMENT '库位编码',
  `cabinet_type` tinyint(4) NOT NULL COMMENT '库位类型（1：高位货架，2：地位货架，3：地堆）',
  `purpose` tinyint(4) NOT NULL COMMENT '库位属性（1：拣货区，2：存储区，3：暂存区）',
  `length` double(10,2) DEFAULT NULL COMMENT '长（单位：m）',
  `width` double(10,2) DEFAULT NULL COMMENT '宽（单位：m）',
  `high` double(10,2) DEFAULT NULL COMMENT '高（单位：m）',
  `zone_id` bigint(20) NOT NULL COMMENT '所属库区id',
  `zone_code` varchar(20) DEFAULT NULL COMMENT '所属库区编码',
  `zone_name` varchar(30) DEFAULT NULL COMMENT '所属库区名称',
  `allow_mixed_sku` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否允许混放sku（0：不允许，1：允许）',
  `allow_mixed_sku_quantity` int(11) DEFAULT '999999' COMMENT '允许sku混放数量',
  `allow_mixed_period` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否允许混放效期（0：不允许，1：允许）',
  `allow_mixed_period_quantity` int(11) DEFAULT '999999' COMMENT '允许效期混放数量',
  `allow_mixed_batch` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否允许混放批次（0：不允许，1：允许）',
  `allow_mixed_batch_quantity` int(11) DEFAULT '999999' COMMENT '允许批次混放数量',
  `sequence` int(11) DEFAULT NULL COMMENT '库位顺序',
  `cabinet_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '库位状态（0：禁用，1：启用）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `load_weight` double(10,2) DEFAULT NULL COMMENT '承重量（单位：kg）',
  `init_option` tinyint(4) DEFAULT NULL COMMENT '初始化库位标签（0：非系统初始化库位，1：系统初始化库位）',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `current_volume` double(10,2) DEFAULT '0.00' COMMENT '当前体积',
  `logic_volume` double(10,2) DEFAULT NULL COMMENT '逻辑体积，0.7当前体积',
  `current_quantity` bigint(20) DEFAULT '0' COMMENT '当前数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_warehouse_no_cabinet_code` (`warehouse_no`,`cabinet_code`),
  KEY `idx_wno_status_zone` (`warehouse_no`,`cabinet_status`,`zone_id`,`current_quantity`),
  KEY `idx_warehouse_no_create_time` (`warehouse_no`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1083117 DEFAULT CHARSET=utf8 COMMENT='库位信息表'
---
DDL for table: wms_cabinet_batch_inventory
CREATE TABLE `wms_cabinet_batch_inventory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `cabinet_code` varchar(30) NOT NULL COMMENT '库位编码',
  `cabinet_id` bigint(20) unsigned NOT NULL COMMENT '关联库位id',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '库存数量',
  `lock_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '冻结数量',
  `available_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '可用数量',
  `produce_date` date NOT NULL COMMENT '生产日期',
  `quality_date` date NOT NULL COMMENT '保质期',
  `batch_no` varchar(30) NOT NULL COMMENT '批次号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `zone_code` varchar(20) DEFAULT NULL COMMENT '库区编码',
  `zone_type` tinyint(4) DEFAULT NULL COMMENT '库区类型（1：冷冻，2：冷藏，3：恒温，4：常温）',
  `cabinet_type` tinyint(4) DEFAULT NULL COMMENT '库位类型（1：高位货架，2：地位货架，3：地堆）',
  `cabinet_purpose` tinyint(4) DEFAULT NULL COMMENT '库位属性（1：拣货区，2：存储区，3：暂存区）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_wno_sku_ccode_date_batch` (`warehouse_no`,`sku`,`cabinet_code`,`produce_date`,`quality_date`,`batch_no`,`cabinet_id`),
  KEY `idx_cabinet_id` (`cabinet_id`),
  KEY `idx_quantity` (`warehouse_no`,`sku`,`quantity`),
  KEY `idx_able_quantity` (`warehouse_no`,`sku`,`available_quantity`),
  KEY `idx_warehouse_no_sku` (`warehouse_no`,`cabinet_code`),
  KEY `idx_wno_zcode` (`warehouse_no`,`zone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=27946 DEFAULT CHARSET=utf8 COMMENT='库位批次库存'
---
DDL for table: wms_cabinet_batch_inventory_flow
CREATE TABLE `wms_cabinet_batch_inventory_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `cabinet_code` varchar(30) NOT NULL COMMENT '库位编码',
  `cabinet_batch_inventory_id` bigint(20) unsigned NOT NULL COMMENT '关联库位批次库存id',
  `before_change_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '变更前数量',
  `change_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '变更数量',
  `after_change_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '变更后数量',
  `order_no` varchar(64) DEFAULT NULL COMMENT '业务单号',
  `order_type_name` varchar(20) DEFAULT NULL COMMENT '库存变动类型',
  `internal_no` varchar(64) DEFAULT NULL COMMENT '内部流转单号',
  `produce_date` date DEFAULT NULL COMMENT '生产日期',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `batch_no` varchar(30) DEFAULT NULL COMMENT '批次号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `zone_code` varchar(20) DEFAULT NULL COMMENT '库区编码',
  `zone_type` tinyint(4) DEFAULT NULL COMMENT '库区类型（1：冷冻，2：冷藏，3：恒温，4：常温）',
  `container_code` varchar(20) DEFAULT NULL COMMENT '容器编码',
  `operator_type` int(11) DEFAULT NULL COMMENT '操作类型',
  `before_change_lock_quantity` int(11) DEFAULT NULL COMMENT '变更前锁库数量',
  `change_lock_quantity` int(11) DEFAULT NULL COMMENT '变更锁库数量',
  `after_change_lock_quantity` int(11) DEFAULT NULL COMMENT '变更后锁库数量',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_no_sku` (`warehouse_no`,`sku`),
  KEY `idx_warehouse_cabinet_code` (`warehouse_no`,`cabinet_code`),
  KEY `idx_wno_ctime` (`warehouse_no`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=57841 DEFAULT CHARSET=utf8 COMMENT='库位批次库存变动流水'
---
DDL for table: wms_cabinet_inventory
CREATE TABLE `wms_cabinet_inventory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `cabinet_code` varchar(30) NOT NULL COMMENT '库位编码',
  `cabinet_id` bigint(20) unsigned NOT NULL COMMENT '关联库位id',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '库存数量',
  `lock_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '冻结数量',
  `available_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '可用数量',
  `produce_date` date NOT NULL COMMENT '生产日期',
  `quality_date` date NOT NULL COMMENT '保质期',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `zone_code` varchar(20) DEFAULT NULL COMMENT '库区编码',
  `zone_type` tinyint(4) DEFAULT NULL COMMENT '库区类型（1：冷冻，2：冷藏，3：恒温，4：常温）',
  `cabinet_type` tinyint(4) DEFAULT NULL COMMENT '库位类型（1：高位货架，2：地位货架，3：地堆）',
  `cabinet_purpose` tinyint(4) DEFAULT NULL COMMENT '库位属性（1：拣货区，2：存储区，3：暂存区）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_wno_sku_cabinet_date` (`warehouse_no`,`sku`,`cabinet_code`,`produce_date`,`quality_date`,`tenant_id`),
  KEY `idx_cabinet_id` (`cabinet_id`),
  KEY `idx_wno_ccd` (`warehouse_no`,`cabinet_code`),
  KEY `idx_quantity` (`warehouse_no`,`sku`,`quantity`),
  KEY `idx_able_quantity` (`warehouse_no`,`sku`,`available_quantity`),
  KEY `idx_wno_sku_qdate` (`warehouse_no`,`sku`,`produce_date`),
  KEY `idx_wno_zcode` (`warehouse_no`,`zone_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4802 DEFAULT CHARSET=utf8 COMMENT='库位库存'
---
DDL for table: wms_cabinet_inventory_flow
CREATE TABLE `wms_cabinet_inventory_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `cabinet_code` varchar(30) NOT NULL COMMENT '库位编码',
  `cabinet_inventory_id` bigint(20) unsigned NOT NULL COMMENT '关联库位库存id',
  `before_change_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '变更前数量',
  `change_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '变更数量',
  `after_change_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '变更后数量',
  `order_no` varchar(64) DEFAULT NULL COMMENT '业务单号',
  `order_type_name` varchar(20) DEFAULT NULL COMMENT '库存变动类型',
  `internal_no` varchar(64) DEFAULT NULL COMMENT '内部流转单号',
  `produce_date` date DEFAULT NULL COMMENT '生产日期',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `zone_code` varchar(20) DEFAULT NULL COMMENT '库区编码',
  `zone_type` tinyint(4) DEFAULT NULL COMMENT '库区类型（1：冷冻，2：冷藏，3：恒温，4：常温）',
  `container_code` varchar(20) DEFAULT NULL COMMENT '容器编码',
  `operator_type` int(11) DEFAULT NULL COMMENT '操作类型',
  `before_change_lock_quantity` int(11) DEFAULT NULL COMMENT '变更前锁库数量',
  `change_lock_quantity` int(11) DEFAULT NULL COMMENT '变更锁库数量',
  `after_change_lock_quantity` int(11) DEFAULT NULL COMMENT '变更后锁库数量',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_no_sku` (`warehouse_no`,`sku`),
  KEY `idx_warehouse_cabinet_code` (`warehouse_no`,`cabinet_code`),
  KEY `idx_wno_ctime` (`warehouse_no`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=55410 DEFAULT CHARSET=utf8 COMMENT='库位库存变动流水'
---
DDL for table: wms_cargo_owner
CREATE TABLE `wms_cargo_owner` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `owner_code` varchar(32) NOT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  `owner_short_name` varchar(64) DEFAULT NULL COMMENT '货主简称',
  `owner_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '货主状态：0：禁用，1：启用',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `credit_code` varchar(64) DEFAULT NULL COMMENT '统一信用代码',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_no` (`warehouse_no`),
  KEY `idx_owner_code` (`owner_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='货主表'
---
DDL for table: wms_container
CREATE TABLE `wms_container` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `container_code` varchar(20) NOT NULL COMMENT '容器编码',
  `container_name` varchar(30) NOT NULL COMMENT '容器名称',
  `purpose` tinyint(4) NOT NULL COMMENT '容器属性（1：收货，2：拣货，3：库内，4：交接，5：通用）',
  `container_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '容器状态（0：禁用，1：启用）',
  `occupy_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '占用状态（0：未占用，1：已占用）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `length` double(10,2) DEFAULT NULL COMMENT '长（单位：m）',
  `width` double(10,2) DEFAULT NULL COMMENT '宽（单位：m）',
  `high` double(10,2) DEFAULT NULL COMMENT '高（单位：m）',
  `weight` double(10,2) DEFAULT NULL COMMENT '重量（单位：kg）',
  `load_weight` double(10,2) DEFAULT NULL COMMENT '承重量（单位：kg）',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_warehouse_no_container_code` (`warehouse_no`,`container_code`),
  KEY `idx_warehouse_no_create_time` (`warehouse_no`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=167159 DEFAULT CHARSET=utf8 COMMENT='容器表'
---
DDL for table: wms_cross_warehouse_sort_info
CREATE TABLE `wms_cross_warehouse_sort_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` bigint(20) unsigned NOT NULL COMMENT '仓库号',
  `store_no` int(10) unsigned NOT NULL COMMENT '城配仓编号',
  `pso_no` varchar(32) NOT NULL COMMENT '采购供应号',
  `sale_order_no` varchar(32) NOT NULL COMMENT '销售订单号',
  `sku` varchar(128) NOT NULL COMMENT 'sku',
  `total_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总需分拣数量',
  `generate_quantity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生成分拣数量',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `supplier_id` varchar(32) NOT NULL COMMENT '供应商',
  `tenant_id` bigint(20) unsigned NOT NULL DEFAULT '1' COMMENT '租户信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_psoNo_sku_sku` (`pso_no`,`sku`,`sale_order_no`),
  KEY `idx_warehouse_store` (`warehouse_no`,`store_no`),
  KEY `idx_saleOrderNo` (`sale_order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=621 DEFAULT CHARSET=utf8 COMMENT='越库分拣信息表'
---
DDL for table: wms_damage_stock_item
CREATE TABLE `wms_damage_stock_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `damage_stock_task_id` bigint(20) DEFAULT NULL COMMENT '货损任务编号',
  `sku` varchar(30) DEFAULT NULL,
  `list_no` varchar(30) DEFAULT NULL,
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `quantity` int(11) DEFAULT '0' COMMENT '数量',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `gl_no` varchar(50) DEFAULT NULL,
  `should_quantity` int(11) DEFAULT NULL COMMENT '应出数量',
  `out_store_quantity` int(11) DEFAULT NULL COMMENT '出库数量',
  `reason_type` varchar(30) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `batch` varchar(30) DEFAULT NULL,
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实际数量',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户',
  `liable_owner` varchar(128) DEFAULT NULL COMMENT '责任方',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `cabinet_code` varchar(30) DEFAULT NULL COMMENT '库位编码',
  `owner_code` varchar(32) DEFAULT NULL COMMENT '货主编码',
  `owner_name` varchar(64) DEFAULT NULL COMMENT '货主名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_damage_stock_task_id` (`damage_stock_task_id`) USING BTREE,
  KEY `idx_sku` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=12732 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='货损出库任务条目'
---
DDL for table: wms_damage_stock_task
CREATE TABLE `wms_damage_stock_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_task_id` int(11) DEFAULT NULL COMMENT '出库任务id',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库id',
  `status` int(11) DEFAULT NULL COMMENT '审核状态',
  `creater` varchar(30) DEFAULT NULL,
  `updater` varchar(30) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `task_end_time` datetime DEFAULT NULL COMMENT '任务完成时间',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_stock_task_id` (`stock_task_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7092 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='货损出库任务'
---
DDL for table: wms_execute_unit
CREATE TABLE `wms_execute_unit` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库号',
  `carrier_type` int(10) unsigned DEFAULT NULL COMMENT '载体类型',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT '载体编号',
  `mission_type` int(10) unsigned DEFAULT NULL COMMENT '任务类型',
  `mission_no` varchar(32) DEFAULT NULL COMMENT '任务编号',
  `source_type` int(10) unsigned DEFAULT NULL COMMENT '来源类型',
  `source_no` varchar(128) DEFAULT NULL COMMENT '来源编号(订单号等)',
  `cancel_time` bigint(20) unsigned DEFAULT NULL COMMENT '取消时间',
  `state` int(10) unsigned DEFAULT NULL COMMENT '状态10-待执行 20-执行中 30-已完成',
  `unit_no` varchar(32) DEFAULT NULL COMMENT '执行单元编号',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_no` (`unit_no`),
  KEY `idx_container_no` (`warehouse_no`,`mission_type`,`carrier_code`,`state`),
  KEY `idx_mission` (`mission_no`,`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=6784 DEFAULT CHARSET=utf8 COMMENT='wms执行单元表'
---
DDL for table: wms_mission
CREATE TABLE `wms_mission` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `cancel_time` bigint(20) unsigned DEFAULT NULL COMMENT '取消时间',
  `creator_name` varchar(32) DEFAULT NULL COMMENT '创建人名称',
  `state` int(10) unsigned DEFAULT NULL COMMENT '状态',
  `source_order_no` varchar(128) DEFAULT NULL COMMENT '来源订单号',
  `source_type` int(10) unsigned DEFAULT NULL COMMENT '来源类型(采购,调拨)',
  `source_id` varchar(32) DEFAULT NULL COMMENT '来源id',
  `mission_type` int(10) unsigned DEFAULT NULL COMMENT '业务类型(上架,移库)',
  `mission_no` varchar(32) DEFAULT NULL COMMENT '任务编号',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库号',
  `p_mission_no` varchar(32) DEFAULT NULL COMMENT '父任务编号',
  `operator_name` varchar(128) DEFAULT NULL COMMENT '操作人名称列表',
  `creator_id` varchar(16) DEFAULT NULL COMMENT '创建人id',
  `operator_id` varchar(128) DEFAULT NULL COMMENT '操作人id列表',
  `p_mission_type` int(10) unsigned DEFAULT NULL COMMENT '父任务类型',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_no` (`mission_no`),
  KEY `idx_mission` (`mission_no`,`mission_type`),
  KEY `idx_p_mission` (`p_mission_no`,`p_mission_type`),
  KEY `idx_mission_page` (`mission_type`,`warehouse_no`,`state`,`mission_no`)
) ENGINE=InnoDB AUTO_INCREMENT=5925 DEFAULT CHARSET=utf8 COMMENT='任务中心表'
---
DDL for table: wms_mission_ageing
CREATE TABLE `wms_mission_ageing` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) unsigned NOT NULL COMMENT '仓库号',
  `mission_no` varchar(32) NOT NULL COMMENT '任务编号',
  `mission_type` int(10) unsigned NOT NULL COMMENT '任务类型',
  `sku` varchar(128) DEFAULT NULL COMMENT 'sku',
  `cabinet_no` varchar(32) DEFAULT NULL COMMENT '库位',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `ageing` time DEFAULT NULL COMMENT '时效',
  `operator` varchar(32) DEFAULT NULL COMMENT '操作人',
  `opeartor_id` varchar(32) DEFAULT NULL COMMENT '操作人id',
  PRIMARY KEY (`id`),
  KEY `idx_mission_ageing` (`warehouse_no`,`mission_no`,`mission_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2807 DEFAULT CHARSET=utf8 COMMENT='任务时效表'
---
DDL for table: wms_mission_detail
CREATE TABLE `wms_mission_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `mission_no` varchar(32) DEFAULT NULL COMMENT '任务编号',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库编号',
  `sku` varchar(128) DEFAULT NULL COMMENT 'sku',
  `produce_time` datetime DEFAULT NULL COMMENT '生产日期',
  `shelf_life` datetime DEFAULT NULL COMMENT '保质期',
  `batch_no` varchar(128) DEFAULT NULL COMMENT '批次号',
  `should_in_quantity` int(11) DEFAULT '0' COMMENT '应入数量',
  `exe_quantity` int(11) DEFAULT NULL COMMENT '已执行数量',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id',
  `unit_no` varchar(32) DEFAULT NULL COMMENT '执行单元编号',
  `state` int(10) unsigned DEFAULT '10' COMMENT '状态',
  `cabinet_no` varchar(32) DEFAULT NULL COMMENT '库位编号',
  `operator` varchar(32) DEFAULT NULL COMMENT '操作人',
  `operator_id` int(10) unsigned DEFAULT NULL COMMENT '操作人id',
  `abnormal_quantity` int(11) DEFAULT '0' COMMENT '异常数量',
  `init` int(11) DEFAULT '0' COMMENT '0-初始化数据, 1-追加数据',
  `deleted_at` bigint(20) unsigned DEFAULT '0' COMMENT '删除时间',
  `split_type` int(10) DEFAULT NULL COMMENT '拆分类型 1-城配仓',
  `split_info` varchar(32) DEFAULT NULL COMMENT '拆分信息',
  PRIMARY KEY (`id`),
  KEY `idx_five_ele` (`mission_no`,`deleted_at`,`sku`,`produce_time`,`shelf_life`,`cabinet_no`,`batch_no`),
  KEY `idx_mission_id` (`warehouse_no`,`mission_no`,`sku`,`cabinet_no`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=10169 DEFAULT CHARSET=utf8 COMMENT='wms任务详情表'
---
DDL for table: wms_mission_detail_extend
CREATE TABLE `wms_mission_detail_extend` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `mission_no` varchar(32) DEFAULT NULL COMMENT '任务编号',
  `extend` text COMMENT 'sku详情信息json串',
  `sku` varchar(128) DEFAULT NULL COMMENT 'sku',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库号',
  PRIMARY KEY (`id`),
  KEY `idx_mission_id` (`mission_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=8566 DEFAULT CHARSET=utf8 COMMENT='wms任务扩展表'
---
DDL for table: wms_mission_log
CREATE TABLE `wms_mission_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `mission_no` varchar(32) DEFAULT NULL COMMENT '业务id',
  `mission_type` int(10) unsigned DEFAULT NULL COMMENT '业务类型',
  `operator` varchar(32) DEFAULT NULL COMMENT '操作人id',
  `operator_name` varchar(16) DEFAULT NULL COMMENT '操作人名称',
  `operate_type` varchar(32) DEFAULT NULL COMMENT '操作类型',
  `operate_info` text COMMENT '操作详情',
  PRIMARY KEY (`id`),
  KEY `idx_biz` (`mission_no`,`mission_type`)
) ENGINE=InnoDB AUTO_INCREMENT=17561 DEFAULT CHARSET=utf8 COMMENT='wms任务操作日志表'
---
DDL for table: wms_mission_operator
CREATE TABLE `wms_mission_operator` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `mission_no` varchar(32) DEFAULT NULL COMMENT '任务编号',
  `cancel_time` bigint(20) unsigned DEFAULT NULL COMMENT '取消时间',
  `operator_id` varchar(32) DEFAULT NULL COMMENT '操作人id',
  `operator_name` varchar(32) DEFAULT NULL COMMENT '操作人名称',
  `state` int(10) unsigned DEFAULT NULL COMMENT '状态10-待执行 20-执行中 30-已取消 40-已完成',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_operator` (`mission_no`,`operator_name`,`operator_id`,`cancel_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5717 DEFAULT CHARSET=utf8 COMMENT='任务操作人表'
---
DDL for table: wms_mission_source_property
CREATE TABLE `wms_mission_source_property` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `source_order_no` varchar(128) DEFAULT NULL COMMENT '来源订单号',
  `source_type` int(10) unsigned DEFAULT NULL COMMENT '来源类型(采购,调拨)',
  `source_id` varchar(128) DEFAULT NULL COMMENT '来源id',
  `mission_no` varchar(128) NOT NULL COMMENT '任务编号',
  `mission_type` int(10) unsigned NOT NULL COMMENT '任务类型',
  `warehouse_no` bigint(20) unsigned NOT NULL COMMENT '仓库号',
  `store_no` bigint(20) unsigned DEFAULT NULL COMMENT '城配仓',
  `expect_time` datetime DEFAULT NULL COMMENT '预计出库日期',
  `target_warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '目标仓库号',
  PRIMARY KEY (`id`),
  KEY `idx_mission_property` (`warehouse_no`,`mission_no`,`mission_type`,`source_type`),
  KEY `idx_mission_no` (`mission_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8096 DEFAULT CHARSET=utf8 COMMENT='任务来源属性表'
---
DDL for table: wms_mission_task_item_mapping
CREATE TABLE `wms_mission_task_item_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_task_id` varchar(128) NOT NULL COMMENT '出库任务id',
  `mission_no` varchar(128) NOT NULL COMMENT '任务号',
  `biz_type` tinyint(4) DEFAULT NULL COMMENT '业务类型',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除（0：否，1：是）',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `status` tinyint(4) DEFAULT NULL COMMENT '处理状态',
  `sku` varchar(32) DEFAULT NULL COMMENT 'sku',
  `pick_quantity` int(11) DEFAULT '0' COMMENT '已拣数量',
  `cabinet_code` varchar(64) DEFAULT NULL COMMENT '库位编码',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `should_pick_quantity` int(11) DEFAULT '0' COMMENT '应拣数量',
  `abnormal_quantity` int(11) DEFAULT '0' COMMENT '异常数量',
  `actual_quantity` int(11) DEFAULT '0' COMMENT '实出数量',
  `init_pick_quantity` int(11) DEFAULT '0' COMMENT '初始化应拣数量',
  PRIMARY KEY (`id`),
  KEY `idx_stock_task_id_sku` (`stock_task_id`,`sku`),
  KEY `idx_mission_no_sku` (`mission_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=3648 DEFAULT CHARSET=utf8 COMMENT='出库拣货任务明细关联关系表'
---
DDL for table: wms_pesticide_residue_report
CREATE TABLE `wms_pesticide_residue_report` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `batch` varchar(20) DEFAULT NULL COMMENT '批次',
  `sku` varchar(20) DEFAULT NULL COMMENT 'sku',
  `detection_result` tinyint(4) DEFAULT NULL COMMENT '检测结果 0 合格 1 不合格',
  `sampling_base` decimal(10,2) DEFAULT NULL COMMENT '抽样基数',
  `number_samples` decimal(10,2) DEFAULT NULL COMMENT '抽样数',
  `inhibition_rate` decimal(10,2) DEFAULT NULL COMMENT '抑制率',
  `picture_url` varchar(500) DEFAULT NULL COMMENT '图片链接',
  `status` int(11) DEFAULT '0' COMMENT '状态 0 生效 1 失效',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `no_sku_batch` (`sku`,`batch`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='农药残留报告'
---
DDL for table: wms_processing_config
CREATE TABLE `wms_processing_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `type` int(11) NOT NULL COMMENT '规则类型：1库内加工，2售卖加工',
  `material_sku_code` varchar(30) NOT NULL COMMENT '原料sku',
  `material_sku_name` varchar(255) NOT NULL COMMENT '原料sku名称',
  `material_sku_weight` decimal(10,2) NOT NULL COMMENT '原料sku重量',
  `material_sku_unit` varchar(30) NOT NULL COMMENT '原料sku单位',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku',
  `product_sku_name` varchar(255) NOT NULL COMMENT '成品sku名称',
  `product_sku_weight` decimal(10,2) NOT NULL COMMENT '成品sku重量',
  `product_sku_unit` varchar(30) NOT NULL COMMENT '成品sku单位',
  `invalid` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否作废，0：否，1：是',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `material_sku_unit_desc` varchar(255) DEFAULT NULL COMMENT '原料sku单位描述',
  `product_sku_unit_desc` varchar(255) DEFAULT NULL COMMENT '成品sku单位描述',
  `processing_config_code` varchar(36) DEFAULT NULL COMMENT '规则编码1',
  PRIMARY KEY (`id`),
  KEY `idx_wno_invalid` (`warehouse_no`,`invalid`),
  KEY `idx_product_sku_code` (`product_sku_code`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='加工规则配置'
---
DDL for table: wms_processing_task
CREATE TABLE `wms_processing_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `processing_task_code` varchar(36) NOT NULL DEFAULT ' NOT NULL' COMMENT '加工任务编号',
  `type` int(11) NOT NULL COMMENT '加工类型：1订单加工，2商品加工',
  `status` int(11) NOT NULL COMMENT '任务状态：0未加工、1已加工、2部分加工',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `finish_remark` varchar(1024) DEFAULT NULL COMMENT '完成备注',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_task_code` (`processing_task_code`),
  KEY `idx_wno_status` (`warehouse_no`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8 COMMENT='加工任务'
---
DDL for table: wms_processing_task_material
CREATE TABLE `wms_processing_task_material` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `processing_task_code` varchar(36) NOT NULL DEFAULT ' NOT NULL' COMMENT '加工任务编号',
  `processing_task_product_id` bigint(20) NOT NULL COMMENT '加工任务成品id',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku',
  `material_sku_code` varchar(30) NOT NULL COMMENT '原料sku编号',
  `material_sku_name` varchar(255) NOT NULL COMMENT '原料sku名称',
  `material_sku_weight` decimal(10,2) NOT NULL COMMENT '原料sku重量',
  `material_sku_unit` varchar(100) NOT NULL COMMENT '原料sku单位',
  `material_sku_quantity` int(11) NOT NULL COMMENT '原料sku使用数量',
  `material_sku_receive_quantity` int(11) NOT NULL COMMENT '原料sku领料数量',
  `material_sku_receive_weight` decimal(10,2) NOT NULL COMMENT '原料sku领料重量',
  `material_sku_restore_quantity` int(11) NOT NULL COMMENT '原料sku归还数量',
  `waste_loss_weight` decimal(10,2) DEFAULT NULL COMMENT '废料损耗重量，人工填写',
  `spec_loss_weight` decimal(10,2) DEFAULT NULL COMMENT '规格损耗重量，加工实重-加工数量*规格重量',
  `material_sku_remain_weight` decimal(10,2) DEFAULT NULL COMMENT '原料SKU剩余重量，领料总重-加工实重-废料损耗',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  PRIMARY KEY (`id`),
  KEY `idx_ptpid_msc` (`processing_task_product_id`,`material_sku_code`),
  KEY `idx_task_code` (`processing_task_code`)
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8 COMMENT='加工任务原料'
---
DDL for table: wms_processing_task_material_receive_record
CREATE TABLE `wms_processing_task_material_receive_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `processing_task_code` varchar(36) NOT NULL DEFAULT ' NOT NULL' COMMENT '加工任务编号',
  `processing_task_product_id` bigint(20) NOT NULL COMMENT '加工任务成品id',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku',
  `material_sku_code` varchar(30) NOT NULL COMMENT '原料sku',
  `material_sku_name` varchar(255) NOT NULL COMMENT '原料sku编号',
  `material_sku_weight` decimal(10,2) NOT NULL COMMENT '原料sku重量',
  `material_sku_unit` varchar(100) NOT NULL COMMENT '原料sku单位',
  `material_sku_quantity` int(11) NOT NULL COMMENT '原料sku使用数量',
  `material_sku_purchase_batch` varchar(30) NOT NULL COMMENT '原料sku采购批次',
  `material_sku_receive_quantity` int(11) NOT NULL COMMENT '原料sku领料数量',
  `material_sku_restore_quantity` int(11) NOT NULL COMMENT '原料sku归还数量',
  `waste_loss_weight` decimal(10,2) DEFAULT NULL COMMENT '废料损耗重量，人工填写',
  `spec_loss_weight` decimal(10,2) DEFAULT NULL COMMENT '规格损耗重量，加工实重-加工数量*规格重量',
  `material_sku_remain_weight` decimal(10,2) DEFAULT NULL COMMENT '原料SKU剩余重量，领料总重-加工实重-废料损耗',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `material_sku_production_date` date NOT NULL COMMENT '原料SKU生产日期',
  `material_sku_quality_date` date NOT NULL COMMENT '原料SKU保质期',
  `processing_task_material_id` bigint(20) NOT NULL COMMENT '领料原料id',
  `material_sku_cabinet_code` varchar(30) DEFAULT NULL COMMENT '原料sku库位编码',
  `material_sku_owner_code` varchar(32) DEFAULT NULL COMMENT '原料sku货主编码',
  `material_sku_owner_name` varchar(64) DEFAULT NULL COMMENT '原料sku货主名称',
  PRIMARY KEY (`id`),
  KEY `idx_ptpid_psc` (`processing_task_product_id`,`product_sku_code`),
  KEY `idx_ptpid_msc` (`processing_task_product_id`,`material_sku_code`),
  KEY `idx_task_code` (`processing_task_code`)
) ENGINE=InnoDB AUTO_INCREMENT=529 DEFAULT CHARSET=utf8 COMMENT='加工任务原料领用明细'
---
DDL for table: wms_processing_task_material_restore_record
CREATE TABLE `wms_processing_task_material_restore_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `processing_task_code` varchar(36) NOT NULL DEFAULT ' NOT NULL' COMMENT '加工任务编号',
  `processing_task_product_id` bigint(20) NOT NULL COMMENT '加工任务成品id',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku',
  `material_sku_code` varchar(30) NOT NULL COMMENT '原料sku',
  `material_sku_name` varchar(255) NOT NULL COMMENT '原料sku编号',
  `material_sku_weight` decimal(10,2) NOT NULL COMMENT '原料sku重量',
  `material_sku_unit` varchar(100) NOT NULL COMMENT '原料sku单位',
  `material_sku_purchase_batch` varchar(30) NOT NULL COMMENT '原料sku采购批次',
  `material_sku_restore_quantity` int(11) NOT NULL COMMENT '原料sku归还数量',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `material_sku_production_date` date NOT NULL COMMENT '原料SKU生产日期',
  `material_sku_quality_date` date NOT NULL COMMENT '原料SKU保质期',
  `processing_task_material_id` bigint(20) NOT NULL COMMENT '领料原料id',
  `material_sku_cabinet_code` varchar(30) DEFAULT NULL COMMENT '原料sku库位编码',
  `material_sku_owner_code` varchar(32) DEFAULT NULL COMMENT '原料sku货主编码',
  `material_sku_owner_name` varchar(64) DEFAULT NULL COMMENT '原料sku货主名称',
  PRIMARY KEY (`id`),
  KEY `idx_ptpid_psc` (`processing_task_product_id`,`product_sku_code`),
  KEY `idx_ptpid_msc` (`processing_task_product_id`,`material_sku_code`),
  KEY `idx_task_code` (`processing_task_code`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8 COMMENT='加工任务原料归还明细'
---
DDL for table: wms_processing_task_product
CREATE TABLE `wms_processing_task_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `processing_task_code` varchar(36) NOT NULL COMMENT '加工任务编号',
  `material_sku_code` varchar(30) DEFAULT NULL COMMENT '原料sku',
  `material_sku_name` varchar(255) DEFAULT NULL COMMENT '原料sku名称',
  `material_sku_weight` decimal(10,2) DEFAULT NULL COMMENT '原料sku重量',
  `material_sku_unit` varchar(100) DEFAULT NULL COMMENT '原料sku单位',
  `material_sku_receive_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '原料sku领料数量',
  `material_sku_restore_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '原料sku归还数量',
  `material_sku_receive_weight` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '原料sku领料总重',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku',
  `product_sku_name` varchar(255) NOT NULL COMMENT '成品sku名称',
  `product_sku_weight` decimal(10,2) NOT NULL COMMENT '成品sku重量',
  `product_sku_unit` varchar(100) NOT NULL COMMENT '成品sku单位',
  `product_sku_unit_desc` varchar(100) NOT NULL COMMENT '成品sku规格描述',
  `product_sku_need_quantity` int(11) NOT NULL COMMENT '成品sku所需数量',
  `product_sku_finish_quantity` int(11) DEFAULT '0' COMMENT '成品sku生产数量',
  `product_sku_spec_finish_weight` decimal(10,2) DEFAULT '0.00' COMMENT '成品总重',
  `waste_loss_weight` decimal(10,2) DEFAULT '0.00' COMMENT '废料损耗重量',
  `spec_loss_weight` decimal(10,2) DEFAULT '0.00' COMMENT '规格损耗重量',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '加工任务成品状态，0，未加工，1，加工完成',
  `finish_remark` varchar(1024) DEFAULT NULL COMMENT '完成备注',
  `material_sku_unit_desc` varchar(255) DEFAULT NULL COMMENT '原料sku单位描述',
  PRIMARY KEY (`id`),
  KEY `idx_ptc_psc` (`processing_task_code`,`product_sku_code`),
  KEY `idx_ptc_msc` (`processing_task_code`,`material_sku_code`),
  KEY `idx_wno` (`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=314 DEFAULT CHARSET=utf8 COMMENT='加工任务成品1'
---
DDL for table: wms_processing_task_product_order_record
CREATE TABLE `wms_processing_task_product_order_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `processing_task_code` varchar(36) NOT NULL DEFAULT ' NOT NULL' COMMENT '加工任务编号',
  `source_id` varchar(50) DEFAULT NULL COMMENT '来源订单',
  `processing_task_product_id` bigint(20) NOT NULL COMMENT '加工任务成品id',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku编号',
  `product_sku_name` varchar(255) NOT NULL COMMENT '成品sku名称',
  `product_sku_spec_weight` decimal(10,2) NOT NULL COMMENT '成品sku规格重量',
  `product_sku_spec_unit` varchar(100) NOT NULL COMMENT '成品sku规格单位',
  `product_sku_spec_need_quantity` int(11) NOT NULL COMMENT '成品sku规格预计加工数',
  `product_sku_spec_submit_quantity` int(11) DEFAULT NULL COMMENT '成品sku规格实际加工数量',
  `product_sku_spec_submit_weight` decimal(10,2) DEFAULT NULL COMMENT '成品sku加工重量',
  `product_sku_spec_print_number` int(11) DEFAULT NULL COMMENT '成品打印次数',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `product_sku_need_quantity` int(11) NOT NULL COMMENT '成品sku需要加工数',
  `product_sku_spec_unit_desc` varchar(255) DEFAULT NULL COMMENT '成品sku规格描述',
  PRIMARY KEY (`id`),
  KEY `idx_ptpid_psc` (`processing_task_product_id`,`product_sku_code`),
  KEY `idx_task_code` (`processing_task_code`),
  KEY `idx_source_id` (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6631 DEFAULT CHARSET=utf8 COMMENT='加工任务成品订单明细'
---
DDL for table: wms_processing_task_product_record
CREATE TABLE `wms_processing_task_product_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `processing_task_code` varchar(36) NOT NULL DEFAULT ' NOT NULL' COMMENT '加工任务编号',
  `processing_task_product_id` bigint(20) NOT NULL COMMENT '加工任务成品id',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku编号',
  `product_sku_name` varchar(255) NOT NULL COMMENT '成品sku名称',
  `product_sku_spec_weight` decimal(10,2) NOT NULL COMMENT '成品sku规格重量',
  `product_sku_spec_unit` varchar(100) NOT NULL COMMENT '成品sku规格单位',
  `product_sku_spec_need_quantity` int(11) NOT NULL COMMENT '成品sku规格预计加工数',
  `product_sku_spec_submit_quantity` int(11) NOT NULL COMMENT '成品sku规格实际加工数量',
  `product_sku_spec_submit_weight` decimal(10,2) NOT NULL COMMENT '成品sku加工重量',
  `product_sku_spec_print_number` int(11) NOT NULL COMMENT '成品打印次数',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `product_sku_need_quantity` int(11) NOT NULL COMMENT '成品sku需要加工数',
  `product_sku_spec_unit_desc` varchar(255) DEFAULT NULL COMMENT '成品sku规格描述',
  PRIMARY KEY (`id`),
  KEY `idx_ptpid_psc` (`processing_task_product_id`,`product_sku_code`),
  KEY `idx_wno` (`warehouse_no`),
  KEY `idx_task_code` (`processing_task_code`)
) ENGINE=InnoDB AUTO_INCREMENT=535 DEFAULT CHARSET=utf8 COMMENT='加工任务成品明细'
---
DDL for table: wms_processing_task_product_submit_record
CREATE TABLE `wms_processing_task_product_submit_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `processing_task_code` varchar(36) NOT NULL DEFAULT ' NOT NULL' COMMENT '加工任务编号',
  `processing_task_product_id` bigint(20) NOT NULL COMMENT '加工任务成品id',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku编号',
  `product_sku_name` varchar(255) NOT NULL COMMENT '成品sku名称',
  `product_sku_weight` decimal(10,2) NOT NULL COMMENT '成品sku重量',
  `product_sku_spec_weight` decimal(10,2) NOT NULL COMMENT '成品sku规格重量',
  `product_sku_spec_unit` varchar(100) NOT NULL COMMENT '成品sku规格单位',
  `product_sku_purchase_batch` varchar(30) NOT NULL COMMENT '成品sku采购批次',
  `product_sku_production_date` date NOT NULL COMMENT '成品SKU生产日期',
  `product_sku_quality_date` date NOT NULL COMMENT '成品SKU保质期',
  `product_sku_spec_submit_quantity` int(11) NOT NULL COMMENT '成品sku规格实际加工数量',
  `product_sku_spec_submit_weight` decimal(10,2) NOT NULL COMMENT '成品sku加工重量',
  `product_sku_spec_print_number` int(11) NOT NULL COMMENT '成品打印次数',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `product_sku_cabinet_code` varchar(30) DEFAULT NULL COMMENT '成品sku库位编码',
  `product_sku_owner_code` varchar(32) DEFAULT NULL COMMENT '成品sku货主编码',
  `product_sku_owner_name` varchar(64) DEFAULT NULL COMMENT '成品sku货主名称',
  PRIMARY KEY (`id`),
  KEY `idx_ptpid_psc` (`processing_task_product_id`,`product_sku_code`),
  KEY `idx_wno` (`warehouse_no`),
  KEY `idx_task_code` (`processing_task_code`)
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=utf8 COMMENT='加工任务成品提交明细'
---
DDL for table: wms_sku_barcode
CREATE TABLE `wms_sku_barcode` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `sku` varchar(30) NOT NULL COMMENT 'sku编码',
  `barcode` varchar(128) NOT NULL COMMENT '条码编码',
  `status` tinyint(4) NOT NULL COMMENT '状态（0：禁用，1：启用）',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_sku_barcode` (`sku`,`barcode`),
  KEY `idx_barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=899 DEFAULT CHARSET=utf8 COMMENT='sku条码'
---
DDL for table: wms_sku_biz
CREATE TABLE `wms_sku_biz` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库号',
  `sku` varchar(128) DEFAULT NULL COMMENT 'sku',
  `is_new` tinyint(4) DEFAULT '0' COMMENT '是否新品0-新品',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sku` (`warehouse_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=15348 DEFAULT CHARSET=utf8 COMMENT='仓库sku业务属性表'
---
DDL for table: wms_sku_spec
CREATE TABLE `wms_sku_spec` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓编号',
  `type` int(11) NOT NULL COMMENT '规则类型：1库内加工，2售卖加工',
  `processing_config_id` bigint(20) NOT NULL COMMENT '加工规则ID',
  `material_sku_code` varchar(30) NOT NULL COMMENT '原料sku',
  `material_sku_name` varchar(255) NOT NULL COMMENT '原料sku名称',
  `product_sku_code` varchar(30) NOT NULL COMMENT '成品sku',
  `product_sku_name` varchar(255) NOT NULL COMMENT '成品sku名称',
  `product_sku_weight` decimal(10,2) NOT NULL COMMENT '成品sku重量',
  `product_sku_unit` varchar(100) NOT NULL COMMENT '成品sku单位',
  `product_sku_spec_weight` decimal(10,2) NOT NULL COMMENT '成品sku规格重量',
  `product_sku_spec_unit` varchar(100) NOT NULL COMMENT '成品sku规格单位',
  `invalid` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否作废，0：否，1：是',
  `creator` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `updater` varchar(50) NOT NULL COMMENT '更新人',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除标识，0：否，1：是',
  `product_sku_spec_unit_desc` varchar(255) NOT NULL COMMENT '成品sku规格单位描述',
  `product_sku_unit_desc` varchar(255) NOT NULL COMMENT '成品sku单位描述',
  PRIMARY KEY (`id`),
  KEY `idx_wno_invalid` (`warehouse_no`,`invalid`),
  KEY `idx_product_sku_code` (`product_sku_code`),
  KEY `idx_processing_config_id` (`processing_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8 COMMENT='SKU包裹规格'
---
DDL for table: wms_stock_task_item_cabinet_occupy
CREATE TABLE `wms_stock_task_item_cabinet_occupy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `stock_task_id` bigint(20) NOT NULL COMMENT '出库任务编码',
  `stock_task_item_id` bigint(20) DEFAULT NULL COMMENT '出库任务明细编码',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓',
  `sku` varchar(30) NOT NULL COMMENT 'sku编码',
  `cabinet_code` varchar(64) NOT NULL COMMENT '库位编码',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `occupy_quantity` int(11) NOT NULL COMMENT '占用数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否软删 0-正常 1-软删',
  `last_ver` int(11) DEFAULT '1' COMMENT '最新版本号',
  `pick_quantity` int(11) DEFAULT NULL COMMENT '拣货数量（实出）',
  `release_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '释放数量',
  `should_pick_quantity` int(11) DEFAULT '0' COMMENT '应拣（出）数量',
  `actual_pick_quantity` int(11) DEFAULT '0' COMMENT '实际拣货数量',
  `abnormal_quantity` int(11) DEFAULT '0' COMMENT '异常缺拣数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_sti_wno_sku_date` (`stock_task_id`,`sku`,`cabinet_code`,`production_date`,`quality_date`,`stock_task_item_id`),
  KEY `idx_item_id_cabinet` (`stock_task_item_id`,`cabinet_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6537 DEFAULT CHARSET=utf8 COMMENT='出库任务明细库位占用'
---
DDL for table: wms_stock_task_notice_order
CREATE TABLE `wms_stock_task_notice_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id',
  `shop_id` bigint(20) NOT NULL COMMENT '门店id',
  `goods_supply_no` varchar(64) DEFAULT '' COMMENT '货品供应单号',
  `out_order_no` varchar(64) NOT NULL DEFAULT '' COMMENT '外部订单号',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `out_order_type` int(11) NOT NULL COMMENT '订单类型',
  `except_time` datetime DEFAULT NULL COMMENT '预计送达时间',
  `status` int(11) NOT NULL COMMENT '通知单状态',
  `receiver` varchar(64) DEFAULT '' COMMENT '收货人姓名',
  `phone` varchar(64) DEFAULT '' COMMENT '联系方式',
  `province` varchar(64) DEFAULT '' COMMENT '省',
  `city` varchar(64) DEFAULT '' COMMENT '市',
  `area` varchar(64) DEFAULT '' COMMENT '区',
  `detail_address` varchar(512) DEFAULT '' COMMENT '详细地址',
  `creator` varchar(64) DEFAULT '' COMMENT '创建人',
  `operator` varchar(64) DEFAULT '' COMMENT '操作人',
  `gmt_created` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否软删',
  `last_ver` int(11) NOT NULL COMMENT '最新版本号',
  `shop_name` varchar(256) DEFAULT '' COMMENT '门店名称',
  `stock_task_create_time` datetime DEFAULT NULL COMMENT '出库任务生成时间',
  `warehouse_name` varchar(128) DEFAULT NULL COMMENT '库存仓名称',
  `stock_task_id` bigint(20) DEFAULT NULL COMMENT '出库任务编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_goods_supply_no` (`goods_supply_no`),
  KEY `idx_tenant` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2633 DEFAULT CHARSET=utf8mb4 COMMENT='出库通知单'
---
DDL for table: wms_stock_task_notice_order_detail
CREATE TABLE `wms_stock_task_notice_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint(20) DEFAULT '1' COMMENT '租户id',
  `shop_id` bigint(20) NOT NULL COMMENT '门店id',
  `out_order_no` varchar(64) NOT NULL DEFAULT '' COMMENT '订单号',
  `warehouse_no` int(11) NOT NULL COMMENT '库存仓',
  `store_no` int(11) DEFAULT NULL COMMENT '城配仓',
  `out_order_type` int(11) NOT NULL COMMENT '类型',
  `sku` varchar(64) DEFAULT '' COMMENT 'sku编码',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `creator` varchar(64) DEFAULT '' COMMENT '创建人',
  `operator` varchar(64) DEFAULT '' COMMENT '操作人',
  `gmt_created` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否软删',
  `last_ver` int(11) NOT NULL COMMENT '最新版本号',
  `goods_name` varchar(256) DEFAULT '' COMMENT '货品名称',
  `notice_order_id` bigint(20) NOT NULL COMMENT '通知单编码',
  PRIMARY KEY (`id`),
  KEY `idx_notice_order_sku` (`notice_order_id`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=3056 DEFAULT CHARSET=utf8mb4 COMMENT='出库通知单明细'
---
DDL for table: wms_stock_task_order_sku
CREATE TABLE `wms_stock_task_order_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `stock_task_id` bigint(20) NOT NULL COMMENT '出库任务ID',
  `out_order_no` varchar(64) NOT NULL DEFAULT '' COMMENT '外部订单号',
  `sku` varchar(64) NOT NULL DEFAULT '' COMMENT 'sku编码',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT 'sku数量',
  `actual_quantity` int(11) NOT NULL DEFAULT '0' COMMENT 'sku实出数量',
  `creator` varchar(64) DEFAULT '' COMMENT '创建人',
  `operator` varchar(64) DEFAULT '' COMMENT '操作人',
  `gmt_created` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否软删',
  `last_ver` int(11) NOT NULL COMMENT '最新版本号',
  PRIMARY KEY (`id`),
  KEY `idx_task_sku` (`stock_task_id`,`out_order_no`,`sku`),
  KEY `idx_order` (`out_order_no`,`stock_task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30716 DEFAULT CHARSET=utf8 COMMENT='出库任务订单明细表'
---
DDL for table: wms_stock_task_process_logistics_order
CREATE TABLE `wms_stock_task_process_logistics_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `stock_task_process_id` bigint(20) NOT NULL COMMENT '出库单号',
  `company` varchar(64) DEFAULT '' COMMENT '快递公司',
  `delivery_order_no` varchar(64) DEFAULT '' COMMENT '配送单号',
  `delivery_type` int(11) DEFAULT '0' COMMENT '配送类型',
  `remark` varchar(64) DEFAULT '' COMMENT '备注',
  `creator` varchar(64) DEFAULT '' COMMENT '创建人',
  `operator` varchar(64) DEFAULT '' COMMENT '操作人',
  `gmt_created` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否软删',
  `last_ver` int(11) NOT NULL COMMENT '最新版本号',
  PRIMARY KEY (`id`),
  KEY `idx_process_id` (`stock_task_process_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1309 DEFAULT CHARSET=utf8mb4 COMMENT='出库单物流信息'
---
DDL for table: wms_stock_task_process_order_sku
CREATE TABLE `wms_stock_task_process_order_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `stock_task_process_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `stock_task_id` bigint(20) NOT NULL COMMENT '出库任务ID',
  `out_order_no` varchar(64) NOT NULL DEFAULT '' COMMENT '外部订单号',
  `sku` varchar(64) NOT NULL DEFAULT '' COMMENT 'sku编码',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT 'sku数量',
  `purchase_batch` varchar(128) DEFAULT '' COMMENT '采购批次',
  `creator` varchar(64) DEFAULT '' COMMENT '创建人',
  `operator` varchar(64) DEFAULT '' COMMENT '操作人',
  `gmt_created` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `gmt_modified` bigint(20) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否软删',
  `last_ver` int(11) NOT NULL COMMENT '最新版本号',
  `quality_date` date DEFAULT NULL COMMENT '过期时间',
  `delivery_date` date DEFAULT NULL COMMENT '配送时间',
  PRIMARY KEY (`id`),
  KEY `idx_order` (`out_order_no`),
  KEY `idx_process_sku` (`stock_task_process_id`,`out_order_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=5210 DEFAULT CHARSET=utf8 COMMENT='出库单订单明细表'
---
DDL for table: wms_stock_task_purchases_back_detail
CREATE TABLE `wms_stock_task_purchases_back_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `stock_task_id` bigint(20) NOT NULL COMMENT '出库任务编码',
  `stock_task_item_id` bigint(20) NOT NULL COMMENT '出库任务明细ID',
  `purchases_back_no` varchar(30) DEFAULT NULL COMMENT '退货单号',
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `sku` varchar(36) DEFAULT NULL COMMENT 'sku编码',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '库存仓编号',
  `quality_date` date DEFAULT NULL COMMENT '保质期',
  `production_date` date DEFAULT NULL COMMENT '生产日期',
  `type` int(11) DEFAULT NULL COMMENT '0 未到货退订 1 已入库退货',
  `supplier_id` int(11) DEFAULT NULL COMMENT '供应商ID',
  `cost` decimal(10,2) DEFAULT '0.00' COMMENT '单件成本',
  `out_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '退货数量',
  `total_cost` decimal(10,2) DEFAULT NULL COMMENT '退货总金额',
  `actual_out_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实际退货数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` varchar(256) DEFAULT '' COMMENT '创建人',
  `operator` varchar(256) DEFAULT '' COMMENT '操作人',
  PRIMARY KEY (`id`),
  KEY `purchases_back_detail_batch_index` (`batch`,`sku`,`quality_date`),
  KEY `purchases_back_detail_no_index` (`purchases_back_no`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='采购退货出库任务详情'
---
DDL for table: wms_stock_task_wave_config
CREATE TABLE `wms_stock_task_wave_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `store_no` int(11) NOT NULL COMMENT '城配仓编号',
  `warehouse_no` int(11) DEFAULT NULL COMMENT '仓库编号',
  `wave_time` varchar(20) NOT NULL COMMENT '波次时间',
  `wave_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '波次状态（0：禁用，1：启用）',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='出库任务波次配置表'
---
DDL for table: wms_stock_task_wave_sku_occupy
CREATE TABLE `wms_stock_task_wave_sku_occupy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `stock_task_id` bigint(20) NOT NULL COMMENT '出库任务ID',
  `warehouse_no` int(11) NOT NULL COMMENT '仓储编码',
  `sku` varchar(30) NOT NULL COMMENT 'sku',
  `occupy_quantity` int(11) NOT NULL COMMENT '占用数量',
  `not_occupy_quantity` int(11) NOT NULL COMMENT '非占用数量',
  `remain_not_occupy_quantity` int(11) NOT NULL COMMENT '剩余占用数量',
  `remain_occupy_quantity` int(11) NOT NULL COMMENT '剩余非占用数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_taskid_sku` (`stock_task_id`,`sku`),
  KEY `idx_wno_sku` (`warehouse_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8 COMMENT='出库任务波次SKU冻结表'
---
DDL for table: wms_store_task_log
CREATE TABLE `wms_store_task_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `biz_id` varchar(32) DEFAULT NULL COMMENT '业务id',
  `biz_type` int(10) unsigned DEFAULT NULL COMMENT '业务类型',
  `operator` varchar(32) DEFAULT NULL COMMENT '操作人id',
  `operator_name` varchar(16) DEFAULT NULL COMMENT '操作人名称',
  `operate_type` varchar(32) DEFAULT NULL COMMENT '操作类型',
  `operate_info` text COMMENT '操作详情',
  PRIMARY KEY (`id`),
  KEY `idx_biz` (`biz_id`,`biz_type`)
) ENGINE=InnoDB AUTO_INCREMENT=10635 DEFAULT CHARSET=utf8 COMMENT='wms任务操作日志表'
---
DDL for table: wms_submit_detail
CREATE TABLE `wms_submit_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `mission_no` varchar(32) DEFAULT NULL COMMENT '任务编号',
  `unit_no` varchar(32) DEFAULT NULL COMMENT '执行单元编号',
  `source_carrier_type` int(10) unsigned DEFAULT NULL COMMENT '来源载体类型',
  `source_carrier_code` varchar(32) DEFAULT NULL COMMENT '来源载体编号',
  `target_carrier_type` int(10) unsigned DEFAULT NULL COMMENT '目标载体类型',
  `target_carrier_code` varchar(32) DEFAULT NULL COMMENT '目标载体编号',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库编号',
  `sku` varchar(128) DEFAULT NULL COMMENT 'sku',
  `produce_time` datetime DEFAULT NULL COMMENT '生产日期',
  `shelf_life` datetime DEFAULT NULL COMMENT '保质期',
  `batch_no` varchar(128) DEFAULT NULL COMMENT '批次',
  `quantity` int(10) unsigned DEFAULT NULL COMMENT '数量',
  `cargo_owner` varchar(32) DEFAULT NULL COMMENT '货主',
  `opreator_name` varchar(16) DEFAULT NULL COMMENT '操作人名称',
  `operator_id` int(10) unsigned DEFAULT NULL COMMENT '操作人id',
  `mission_type` int(10) unsigned DEFAULT NULL COMMENT '任务类型',
  `tenant_id` bigint(20) unsigned DEFAULT '1' COMMENT '租户id',
  `split_type` varchar(32) DEFAULT NULL COMMENT '拆分类型 1-城配仓',
  `split_info` varchar(32) DEFAULT NULL COMMENT '拆分信息',
  PRIMARY KEY (`id`),
  KEY `idx_mission` (`mission_no`,`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=7393 DEFAULT CHARSET=utf8 COMMENT='wms任务执行明细'
---
DDL for table: wms_transaction_log
CREATE TABLE `wms_transaction_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) unsigned DEFAULT NULL COMMENT '仓库号',
  `biz_id` varchar(128) DEFAULT NULL COMMENT '业务id',
  `biz_type` varchar(32) DEFAULT NULL COMMENT '业务类型',
  `local_state` int(10) unsigned DEFAULT NULL COMMENT '本地事务状态',
  `param` text COMMENT '接口请求参数',
  PRIMARY KEY (`id`),
  KEY `idx_biz` (`warehouse_no`,`biz_id`,`biz_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2965 DEFAULT CHARSET=utf8 COMMENT='wms事务日志表'
---
DDL for table: wms_warehouse_config
CREATE TABLE `wms_warehouse_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `config_key` varchar(255) NOT NULL COMMENT '配置key',
  `config_value` varchar(255) DEFAULT NULL COMMENT '配置value',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_warehouse_no_config_key` (`warehouse_no`,`config_key`),
  KEY `idx_config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8 COMMENT='仓库配置表'
---
DDL for table: wms_zone
CREATE TABLE `wms_zone` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `warehouse_no` int(11) NOT NULL COMMENT '仓库编号',
  `zone_code` varchar(20) NOT NULL COMMENT '库区编码',
  `zone_name` varchar(30) NOT NULL COMMENT '库区名称',
  `zone_type` tinyint(4) NOT NULL COMMENT '库区类型（0：默认，1：冷冻，2：冷藏，3：恒温，4：常温）',
  `zone_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '库区状态（0：禁用，1：启用）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_operator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `update_operator` varchar(255) DEFAULT NULL COMMENT '更新人',
  `init_option` tinyint(4) NOT NULL DEFAULT '0' COMMENT '初始化库区标签（0：非系统初始化库区，1：系统初始化库区）',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id(saas品牌方)，鲜沐为1',
  `pick_option` int(11) DEFAULT '0' COMMENT '是否支持拣货(0-不支持  1-支持)',
  PRIMARY KEY (`id`),
  KEY `idx_warehouse_no_zone_code` (`warehouse_no`,`zone_code`),
  KEY `idx_warehouse_no_zone_name` (`warehouse_no`,`zone_name`),
  KEY `idx_warehouse_no_create_time` (`warehouse_no`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='库区信息表'
---
DDL for table: wnc_contact_config
CREATE TABLE `wnc_contact_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source` int(11) NOT NULL COMMENT '来源，0：鲜沐，1：saas',
  `outer_contact_id` varchar(64) NOT NULL COMMENT '外部联系人ID',
  `store_no` int(11) NOT NULL COMMENT '城配仓编号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_source_contact` (`source`,`outer_contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COMMENT='地址映射配置表'
---
DDL for table: wnc_fast_mall
CREATE TABLE `wnc_fast_mall` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `name` varchar(600) NOT NULL COMMENT '快递公司名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=663 DEFAULT CHARSET=utf8 COMMENT='快递公司'
---
DDL for table: wnc_fence_change_task
CREATE TABLE `wnc_fence_change_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fence_id` int(11) NOT NULL COMMENT '操作围栏ID',
  `fence_name` varchar(64) NOT NULL COMMENT '围栏名称',
  `area_no` int(11) NOT NULL COMMENT '操作围栏归属运营服务区编号',
  `store_no` int(11) NOT NULL COMMENT '操作围栏归属城配仓编号',
  `change_acm_id` varchar(500) NOT NULL COMMENT '区域ID，多个区域 '',''分割',
  `type` int(11) NOT NULL COMMENT '类型，0：切仓，1：切围栏',
  `target_no` int(11) NOT NULL COMMENT '目标围栏ID/目标城配仓编号',
  `status` int(11) NOT NULL COMMENT '状态，0：待处理，1：已取消，2：已完成，10：区域切换中，15：订单切换中，20：处理失败',
  `exe_time` datetime NOT NULL COMMENT '执行时间',
  `remark` varchar(1000) NOT NULL COMMENT '切仓说明，json格式存储网点变更信息',
  `creator_id` int(11) NOT NULL COMMENT '创建人ID',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_fence_id` (`fence_id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COMMENT='围栏切仓任务'
---
DDL for table: wnc_fence_change_task_detail
CREATE TABLE `wnc_fence_change_task_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `task_id` bigint(20) NOT NULL COMMENT '切仓任务ID',
  `outer_order_id` varchar(64) NOT NULL COMMENT '外部单号',
  `source` int(11) NOT NULL COMMENT '来源，200：鲜沐-订单，201：鲜沐-售后，202：鲜沐-样品，203：鲜沐-省心送，210：saas-订单，211：saas-售后',
  `outer_contact_id` varchar(64) NOT NULL COMMENT '外部联系人ID',
  `delivery_time` date NOT NULL COMMENT '配送时间',
  `outer_client_id` varchar(64) NOT NULL COMMENT '外部客户号',
  `outer_client_name` varchar(64) NOT NULL COMMENT '外部客户名',
  `status` int(11) NOT NULL COMMENT '状态，10：待处理，20：处理成功，30：处理失败',
  `remark` varchar(1000) DEFAULT NULL COMMENT '失败原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `fulfill_confirm_time` datetime NOT NULL COMMENT '履约确认时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_fence_source_order_time_contact` (`task_id`,`source`,`outer_order_id`,`delivery_time`,`outer_contact_id`),
  KEY `idx_order_no` (`outer_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=611 DEFAULT CHARSET=utf8mb4 COMMENT='围栏切仓任务明细表'
---
DDL for table: wnc_tenant_global_fence_rule
CREATE TABLE `wnc_tenant_global_fence_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `global_delivery_rule` int(11) NOT NULL DEFAULT '0' COMMENT '全局配送规则 0自营仓优先 1三方仓优先',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='全局围栏规则'
---
DDL for table: wnc_warehouse_storage_fence
CREATE TABLE `wnc_warehouse_storage_fence` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `province` varchar(100) DEFAULT NULL COMMENT '省',
  `city` varchar(100) DEFAULT NULL COMMENT '市',
  `area` varchar(100) DEFAULT NULL COMMENT '区',
  `warehouse_no` bigint(20) NOT NULL COMMENT '库存仓编号',
  `tenant_id` bigint(20) NOT NULL COMMENT '所属租户',
  `last_operator_name` varchar(100) NOT NULL COMMENT '最后操作人名称',
  PRIMARY KEY (`id`),
  KEY `idx_tid_province_city_area` (`tenant_id`,`province`,`city`,`area`),
  KEY `idx_tid_warehouse_no` (`tenant_id`,`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=10983 DEFAULT CHARSET=utf8 COMMENT='仓库围栏'
---
DDL for table: wnc_warehouse_storage_fence_rule
CREATE TABLE `wnc_warehouse_storage_fence_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `province` varchar(100) DEFAULT NULL COMMENT '省',
  `city` varchar(100) NOT NULL COMMENT '市',
  `area` varchar(100) DEFAULT NULL COMMENT '区',
  `delivery_rule` int(11) NOT NULL DEFAULT '0' COMMENT '配送规则 0 距离最短 1手动设置优先级',
  `conflict_warehouse_json` text COMMENT '仓库优先级JSON规则',
  `warehouse_name_list` varchar(600) NOT NULL COMMENT '仓库名称合集',
  `last_operator_name` varchar(100) DEFAULT NULL COMMENT '最后操作人名称',
  `last_operator_id` bigint(20) DEFAULT NULL COMMENT '最后操作人id',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_province_city_area_tenant_id` (`province`,`city`,`area`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1870 DEFAULT CHARSET=utf8 COMMENT='仓库围栏配送规则'
---
DDL for table: wnc_warehouse_storage_tenant
CREATE TABLE `wnc_warehouse_storage_tenant` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `warehouse_no` bigint(20) NOT NULL COMMENT '仓库编号',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户Id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_wno_tid` (`warehouse_no`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_warehouse_no` (`warehouse_no`)
) ENGINE=InnoDB AUTO_INCREMENT=286 DEFAULT CHARSET=utf8 COMMENT='仓库租户关系表'
---
DDL for table: zsl_order_abroad_products_report
CREATE TABLE `zsl_order_abroad_products_report` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `m_id` bigint(20) unsigned DEFAULT NULL COMMENT '门店id',
  `contact_id` bigint(20) unsigned DEFAULT NULL COMMENT '联系人-配送地址',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '上报状态：0-待扣库存；1-待上报；2-上报成功；3-上报失败；4-无企业工商信息；5-进货/报备库存不足',
  `push_times` tinyint(4) DEFAULT NULL COMMENT '重新上报次数',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单-进口商品上报订单数据'
---
DDL for table: zsl_product_abroad_mapping
CREATE TABLE `zsl_product_abroad_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `sku` varchar(50) NOT NULL DEFAULT '' COMMENT '商品sku',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品名称',
  `abroad_spu_id` bigint(20) NOT NULL COMMENT '进口报备商品spu字典表',
  `repack_status` tinyint(4) NOT NULL COMMENT '分装状态：0-未分装；1-分装',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品-进口报备商品映射'
---
DDL for table: zsl_product_abroad_spu_dict
CREATE TABLE `zsl_product_abroad_spu_dict` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `spu_code` varchar(50) NOT NULL COMMENT '进口商品品类字典码',
  `spu_name` varchar(50) NOT NULL COMMENT '进口商品品类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16449 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品-进口报备商品spu字典表'
---
DDL for table: zsl_stock_abroad_products
CREATE TABLE `zsl_stock_abroad_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `batch_no` varchar(255) NOT NULL COMMENT '入库批次号',
  `purchase_time` datetime NOT NULL COMMENT '进货/入库时间',
  `product_code` varchar(50) NOT NULL COMMENT '商品品类码',
  `product_name` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `product_spec` varchar(50) DEFAULT NULL COMMENT '商品规格',
  `product_brand` varchar(50) DEFAULT NULL COMMENT '商品品牌',
  `quantity` decimal(10,2) NOT NULL COMMENT '入库数量',
  `online_quantity` decimal(10,2) NOT NULL COMMENT '可用数量',
  `weight` decimal(10,2) NOT NULL COMMENT '重量（默认kg）',
  `online_weight` decimal(10,2) NOT NULL COMMENT '可用重量（默认kg）',
  `product_origin` varchar(50) DEFAULT NULL COMMENT '产地',
  `unit` varchar(10) NOT NULL DEFAULT 'KG' COMMENT '单位',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_batch_no` (`batch_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='库存-进口报备商品'
---
DDL for table: zsl_stock_abroad_products_record
CREATE TABLE `zsl_stock_abroad_products_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `order_no` varchar(50) NOT NULL COMMENT '订单号',
  `m_id` bigint(20) unsigned NOT NULL COMMENT '门店id',
  `contact_id` bigint(20) unsigned NOT NULL COMMENT '联系人-配送地址',
  `batch_no` varchar(255) NOT NULL COMMENT '入库批次号',
  `use_quantity` decimal(10,2) NOT NULL COMMENT '使用数量',
  `remain_quantity` decimal(10,2) NOT NULL COMMENT '剩余数量',
  `use_weight` decimal(10,2) NOT NULL COMMENT '使用重量（默认kg）',
  `remain_weight` decimal(10,2) NOT NULL COMMENT '剩余重量（默认kg）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_batch_no` (`batch_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='库存-进口报备商品库存记录'
---
