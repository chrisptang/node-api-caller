Connected to MySQL server
Tables in cosfodb:
administrative_division
area_city_group
area_city_group_mapping
auth_account_purview
auth_account_role
auth_purview
auth_role
auth_role_copy
bill_inverted
bill_profit_sharing
bill_profit_sharing_order
bill_profit_sharing_refund_snapshot
bill_profit_sharing_rule
bill_profit_sharing_snapshot
brand
brand_category_mapping
business_information
category
combine_order
common_location
common_location_city
common_resource
compensate_cost_price
cost_price
cost_price_log
crm_clue
crm_clue1
crm_clue_copy1
crm_follow
crm_follow1
file_download_record
financial_bill
financial_bill_credentials
financial_bill_item
financial_bill_rule
future_valid_cost_price
hui_fu_base
hui_fu_payment
hui_fu_refund
huifu_payment_rate_retry
id
item_sale_limit_config
location_province
market
market_area_item
market_area_item_mapping
market_area_item_store_price_mapping
market_area_item_store_price_mapping111
market_classification
market_combine_item_mapping
market_detail
market_item
market_item_classification
market_item_detail
market_item_onsale_strategy_mapping
market_item_order_summary
market_item_price
market_item_price_log
market_item_price_strategy
market_item_price_strategy_mapping
market_item_unfair_price_strategy
measure_item_result
measure_items
measure_report
merchant
merchant_address
merchant_contact
merchant_delivery_fee_rule
merchant_delivery_rule_warehouse_relation
merchant_delivery_step_fee
merchant_order_quantity_rule
merchant_store
merchant_store_account
merchant_store_account_operator_log
merchant_store_account_operator_log_copy1
merchant_store_balance
merchant_store_balance_change_record
merchant_store_change_log
merchant_store_config
merchant_store_ext
merchant_store_group
merchant_store_group_mapping
merchant_store_trade_summary
msg_scene
msg_scene_tenant_mapping
order
order_address
order_after_sale
order_after_sale_rule
order_agent_sku_fee_rule_snapshot
order_combine_snapshot
order_delivery_detail
order_delivery_fee_snapshot
order_item
order_item_extra
order_item_fee_transaction
order_item_snapshot
order_self_lifting
order_snapshot
payment
payment_item
product_agent_application
product_agent_application_item
product_agent_application_record
product_agent_sku_fee_rule
product_agent_sku_mapping
product_agent_warehouse
product_city_stock
product_pricing_supply
product_pricing_supply_bak
product_pricing_supply_city_mapping
product_sku
product_sku_dimension_stock
product_spu
refund
refund_acct_split_detail
refund_log
regional_organization
sms_scene
stock
stock_record
supplier_delivery_info
sync_log
sync_mapping
system_admin
system_admin_role
system_menu
system_parameters
system_permission
system_role
system_role_menu
system_role_permission
system_wechant_tp_info
t_op_log
temp_test12
temp_test123
tenant
tenant_account
tenant_account_bussiness_msg_config
tenant_account_receive_msg_switch
tenant_account_supplier_mapping
tenant_agreement
tenant_auth_connection
tenant_bill
tenant_bill_copy
tenant_common_config
tenant_company
tenant_company_account
tenant_delivery_fee_area
tenant_delivery_fee_rule
tenant_ext_sys_config
tenant_guide_info
tenant_pay_config_log
tenant_prepayment_account
tenant_prepayment_daily_snapshot
tenant_prepayment_record
tenant_prepayment_transaction
tenant_prepayment_transaction_item
tenant_return_address
tenant_switch
tenant_template_init
test_name
test_table
testcode
trans_log_result_list
trolley
user
wechat_authorizer
wechat_lite_config
wechat_template_package
wx_shipping_info_upload_record
xm_contact_mapping
xm_merchant_account_mapping
xm_merchant_adapter
---
DDL for administrative_division
CREATE TABLE `administrative_division` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `pro_name` varchar(50) DEFAULT NULL COMMENT '省份名称',
  `pro_no` varchar(50) DEFAULT NULL COMMENT '省份编码',
  `city_name` varchar(50) DEFAULT NULL COMMENT '城市名称',
  `city_no` varchar(50) DEFAULT NULL COMMENT '城市编码',
  `area_name` varchar(50) DEFAULT NULL COMMENT '区县名称',
  `area_no` varchar(50) DEFAULT NULL COMMENT '区县编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2883 DEFAULT CHARSET=utf8mb3 COMMENT='行政区域划分表'
---
DDL for area_city_group
CREATE TABLE `area_city_group` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `group_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '城市组名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='城市组'
---
DDL for area_city_group_mapping
CREATE TABLE `area_city_group_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `city_group_id` bigint DEFAULT NULL COMMENT '城市组Id',
  `city_id` bigint DEFAULT NULL COMMENT '城市Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='城市组映射'
---
DDL for auth_account_purview
CREATE TABLE `auth_account_purview` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `role_id` int NOT NULL COMMENT '角色',
  `purview_id` int NOT NULL COMMENT '权限',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id cosfo tenant_id为0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后更改时间',
  PRIMARY KEY (`id`),
  KEY `index_purview_id` (`purview_id`),
  KEY `index_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='角色-权限关联表'
---
DDL for auth_account_role
CREATE TABLE `auth_account_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account_id` bigint DEFAULT NULL COMMENT '用户id',
  `role_id` int DEFAULT NULL COMMENT '角色Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后更改时间',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id cosfo tenant_id为0鲜沐',
  PRIMARY KEY (`id`),
  KEY `index_account_id` (`account_id`),
  KEY `index_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='账户-角色关联表'
---
DDL for auth_purview
CREATE TABLE `auth_purview` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `remarks` varchar(255) DEFAULT NULL COMMENT '菜单备注',
  `parent_id` int NOT NULL DEFAULT '0' COMMENT '父权限Id',
  `name` varchar(50) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限对应资源(URL)',
  `description` varchar(100) DEFAULT NULL COMMENT '权限描述',
  `son_purview` varchar(200) DEFAULT NULL COMMENT '关联权限',
  `module` varchar(50) DEFAULT NULL COMMENT '所属模块',
  `menu_id` int DEFAULT NULL COMMENT '所属菜单权限ID',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `weight` int DEFAULT '0' COMMENT '排序权重',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后更改时间',
  `url_type` varchar(32) DEFAULT NULL COMMENT '权限类型',
  PRIMARY KEY (`id`),
  KEY `index_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='权限表'
---
DDL for auth_role
CREATE TABLE `auth_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `rolename` varchar(255) DEFAULT NULL COMMENT '角色名称',
  `remarks` varchar(255) DEFAULT NULL COMMENT '角色备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后更改时间',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id cosfo tenant_id为0',
  `last_updater_id` bigint DEFAULT NULL COMMENT '最后操作人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='角色表'
---
DDL for auth_role_copy
CREATE TABLE `auth_role_copy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `rolename` varchar(255) DEFAULT NULL COMMENT '角色名称',
  `remarks` varchar(255) DEFAULT NULL COMMENT '角色备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '最后更改时间',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id cosfo tenant_id为0',
  `last_updater_id` bigint DEFAULT NULL COMMENT '最后操作人ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='角色表'
---
DDL for bill_inverted
CREATE TABLE `bill_inverted` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `order_id` bigint DEFAULT NULL COMMENT '订单Id',
  `after_sale_id` bigint DEFAULT NULL COMMENT '售后Id',
  `acct_split_tenant_id` bigint DEFAULT NULL COMMENT '分账接收方租户',
  `refundable_amount` decimal(11,2) DEFAULT NULL COMMENT '应退金额',
  `actual_amount` decimal(11,2) DEFAULT NULL COMMENT '实退金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `index_tenantid_orderid` (`tenant_id`,`order_id`),
  KEY `index_tenantid_aftersaleid` (`tenant_id`,`after_sale_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1689918028549120100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='退款倒挂账单'
---
DDL for bill_profit_sharing
CREATE TABLE `bill_profit_sharing` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `receiver_tenant_id` bigint unsigned DEFAULT NULL COMMENT '接收方租户Id',
  `order_id` bigint DEFAULT NULL COMMENT '订单Id',
  `app_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'appId',
  `type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '账号类型',
  `account` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商户号',
  `transaction_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '交易流水号',
  `out_trade_no` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '外部交易订单号',
  `price` decimal(10,2) DEFAULT NULL COMMENT '交易金额',
  `status` tinyint DEFAULT NULL COMMENT '状态0待分账1成功2失败3取消',
  `success_time` datetime DEFAULT NULL COMMENT '成功时间',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '分账描述',
  `wx_order_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '微信分账单号',
  `fail_reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '失败原因',
  `detail_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '分账明细单号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `huifu_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '汇付商号',
  `business_type` tinyint DEFAULT '1' COMMENT '1,正向分账 2逆向分账退款',
  `after_sale_id` bigint DEFAULT NULL COMMENT '售后单id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_tenant_id_order_id` (`tenant_id`,`order_id`) USING BTREE,
  KEY `index_transaction_id` (`transaction_id`) USING BTREE,
  KEY `index_out_trade_no` (`out_trade_no`) USING BTREE,
  KEY `idx_tenant_id_create_time` (`tenant_id`,`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=245675 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='分账表'
---
DDL for bill_profit_sharing_order
CREATE TABLE `bill_profit_sharing_order` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `order_id` bigint NOT NULL COMMENT '订单Id',
  `status` tinyint NOT NULL COMMENT '分账状态0待分账1分账处理中2部分分账3分账完成4分账失败',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_tenant_id_order_id` (`tenant_id`,`order_id`) USING BTREE,
  KEY `index_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2798 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单分账状态'
---
DDL for bill_profit_sharing_refund_snapshot
CREATE TABLE `bill_profit_sharing_refund_snapshot` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `order_after_sale_id` bigint NOT NULL COMMENT '售后id',
  `account_id` bigint NOT NULL COMMENT '账号id',
  `profit_sharing_type` tinyint DEFAULT NULL COMMENT '1、自营商品金额 2、供应商商品金额 3、运费 4、订单手续费',
  `origin_price` decimal(10,2) NOT NULL COMMENT '原始金额',
  `refund_price` decimal(10,2) NOT NULL COMMENT '退款金额',
  `should_refund_price` decimal(10,2) NOT NULL COMMENT '应退金额',
  `actual_refund_price` decimal(10,2) NOT NULL COMMENT '实退金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `order_item_id` bigint NOT NULL COMMENT '订单明细id',
  `final_refund_price` decimal(10,2) NOT NULL COMMENT '最终金额（应退金额-手续费）',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_order_id` (`tenant_id`,`order_id`),
  KEY `idx_tenant_after_sale_id` (`tenant_id`,`order_after_sale_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='分账退款明细快照表'
---
DDL for bill_profit_sharing_rule
CREATE TABLE `bill_profit_sharing_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `delivery_type` tinyint DEFAULT NULL COMMENT '配送方式0品牌方1三方仓',
  `type` tinyint DEFAULT NULL COMMENT '分账金额类型分账金额类型 1,自营商品金额2，供应商商品金额3，代仓商品金额4运费5订单手续费',
  `mapping_type` tinyint DEFAULT NULL COMMENT '分账方式 0, 按价格 1，按比例，2按分账比例均摊',
  `number` decimal(10,4) DEFAULT NULL COMMENT '对应值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `role_code` tinyint DEFAULT NULL COMMENT '分账角色.1=分账方,2=接收方',
  `account_id` bigint DEFAULT NULL COMMENT '账号Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4765 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='分账规则'
---
DDL for bill_profit_sharing_snapshot
CREATE TABLE `bill_profit_sharing_snapshot` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `order_id` bigint DEFAULT NULL COMMENT '订单Id',
  `account_id` bigint DEFAULT NULL COMMENT '账号Id',
  `delivery_type` tinyint DEFAULT NULL COMMENT '订单配送类型 0自营 1三方',
  `profit_sharing_type` tinyint DEFAULT NULL COMMENT '分账金额类型 1、自营商品金额 2、供应商商品金额 3、运费 4、手续费',
  `mapping_type` tinyint DEFAULT NULL COMMENT '分账方式0按价格1按比例2按分账比例均摊',
  `number` decimal(10,4) DEFAULT NULL COMMENT '对应值',
  `origin_price` decimal(10,2) DEFAULT NULL COMMENT '原始金额',
  `profit_sharing_price` decimal(10,2) DEFAULT NULL COMMENT '分账金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `type` tinyint DEFAULT NULL COMMENT '分账类型0部分分账1全部分账',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_tenant_id_order_id` (`tenant_id`,`order_id`) USING BTREE,
  KEY `idx_account_order` (`account_id`,`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63452 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='分账明细快照表'
---
DDL for brand
CREATE TABLE `brand` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '品牌名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=955 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='品牌表'
---
DDL for brand_category_mapping
CREATE TABLE `brand_category_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `brand_id` bigint unsigned NOT NULL COMMENT '品牌Id',
  `category_id` bigint unsigned NOT NULL COMMENT '类目Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_brandid_categoryid` (`brand_id`,`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='品牌类目映射表'
---
DDL for business_information
CREATE TABLE `business_information` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `biz_id` bigint NOT NULL COMMENT '用户id',
  `type` int NOT NULL DEFAULT '0' COMMENT '类型：0-租户用户，1-单店用户，2-区域组织',
  `company_name` varchar(50) DEFAULT NULL COMMENT '公司名称',
  `credit_code` varchar(50) DEFAULT NULL COMMENT '信用代码',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `area` varchar(20) DEFAULT NULL COMMENT '区',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `phone` varchar(30) DEFAULT NULL COMMENT '公司联系手机号',
  `business_license` varchar(255) DEFAULT NULL COMMENT '营业执照',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_bizid_type` (`biz_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=1448 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='企业信息表'
---
DDL for category
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '类目名称',
  `parent_id` int NOT NULL DEFAULT '0' COMMENT '上级类目id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `outdated` tinyint NOT NULL DEFAULT '0' COMMENT '标记位-过时的品类  1代表过时，商品被删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_parent_id` (`parent_id`) USING BTREE,
  KEY `index_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101605 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='后台类目表'
---
DDL for combine_order
CREATE TABLE `combine_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `combine_item_id` bigint NOT NULL COMMENT '组合品id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1663454814895161829 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='组合订单'
---
DDL for common_location
CREATE TABLE `common_location` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `parent_id` bigint DEFAULT NULL COMMENT '父类Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=460400501 DEFAULT CHARSET=utf8mb3 COMMENT='地址信息表'
---
DDL for common_location_city
CREATE TABLE `common_location_city` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `province_id` bigint DEFAULT NULL COMMENT '省份主键Id',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '城市名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=820010 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='城市名称'
---
DDL for common_resource
CREATE TABLE `common_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `resource_type` tinyint DEFAULT NULL COMMENT '资源类型：1-图片资源库',
  `resource_name` varchar(100) DEFAULT NULL COMMENT '资源名称',
  `resource_path` varchar(500) DEFAULT NULL COMMENT '云服务地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=805 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文件资源表'
---
DDL for compensate_cost_price
CREATE TABLE `compensate_cost_price` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `sku_code` varchar(50) NOT NULL COMMENT '货品编码',
  `area` varchar(50) NOT NULL COMMENT '区域',
  `province` varchar(50) NOT NULL COMMENT '省',
  `city` varchar(50) NOT NULL COMMENT '城市',
  `error_log` varchar(3000) NOT NULL COMMENT '失败原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='成本价格表补偿表'
---
DDL for cost_price
CREATE TABLE `cost_price` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `sku_id` bigint NOT NULL COMMENT '货品主键',
  `sku_code` varchar(50) NOT NULL COMMENT '货品编码',
  `area` varchar(50) NOT NULL COMMENT '区域',
  `province` varchar(50) NOT NULL COMMENT '省',
  `city` varchar(50) NOT NULL COMMENT '城市',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `valid_time` datetime DEFAULT NULL COMMENT '生效时间',
  `invalid_time` datetime DEFAULT NULL COMMENT '失效时间',
  `valid_type` tinyint NOT NULL DEFAULT '0' COMMENT '生效类型,0-永久,1-周期',
  `sys_type` tinyint DEFAULT '0' COMMENT '价格来源',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tid_skuid_city_area_validtype` (`tenant_id`,`sku_id`,`city`,`area`,`valid_type`),
  KEY `idx_tid_skucode_city_area_validtype` (`tenant_id`,`sku_code`,`city`,`area`,`valid_type`)
) ENGINE=InnoDB AUTO_INCREMENT=14684 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='成本价格表'
---
DDL for cost_price_log
CREATE TABLE `cost_price_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `sku_id` bigint NOT NULL COMMENT '货品主键',
  `sku_code` varchar(50) NOT NULL COMMENT '货品编码',
  `area` varchar(50) NOT NULL COMMENT '区域',
  `province` varchar(50) NOT NULL COMMENT '省',
  `city` varchar(50) NOT NULL COMMENT '城市',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `valid_time` datetime DEFAULT NULL COMMENT '生效时间',
  `invalid_time` datetime DEFAULT NULL COMMENT '失效时间',
  `valid_type` tinyint DEFAULT '0' COMMENT '生效类型,0-永久,1-周期',
  `opt_type` tinyint NOT NULL DEFAULT '0' COMMENT '操作类型,0-新增,1-修改,2-删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17766 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='成本价格表log'
---
DDL for crm_clue
CREATE TABLE `crm_clue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_source` tinyint NOT NULL COMMENT '客户来源 0 鲜沐大客户 1新增品牌',
  `customer_name` varchar(128) NOT NULL COMMENT '客户名称 可以做唯一索引',
  `kp` varchar(32) DEFAULT NULL COMMENT 'kp名称',
  `phone` varchar(32) DEFAULT NULL COMMENT '手机电话',
  `dept` varchar(32) DEFAULT NULL COMMENT '部门',
  `post` varchar(32) DEFAULT NULL COMMENT '职务',
  `clue_status` varchar(16) DEFAULT NULL COMMENT '线索状态',
  `clue_source` varchar(16) DEFAULT NULL COMMENT '线索来源',
  `want_business` varchar(128) DEFAULT NULL COMMENT '意向业务',
  `area_code` int DEFAULT NULL COMMENT '总部所在地code码',
  `purpose_remark` varchar(1000) DEFAULT NULL COMMENT '需求情况',
  `business_type` varchar(16) DEFAULT NULL COMMENT '经营类型',
  `shop_type` varchar(16) DEFAULT NULL COMMENT '门店类型',
  `shop_size` varchar(16) DEFAULT NULL COMMENT '门店规模',
  `customer_type` varchar(16) DEFAULT NULL COMMENT '客户类型',
  `shop_system` varchar(16) DEFAULT NULL COMMENT '店铺系统',
  `head_system` varchar(16) DEFAULT NULL COMMENT '总部系统',
  `send_remark` varchar(1000) DEFAULT NULL COMMENT '物料备注',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `bd_id` int DEFAULT NULL COMMENT 'bd id',
  `b_id` bigint DEFAULT '0' COMMENT '品牌id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_bd_id` int DEFAULT NULL COMMENT '创建bd id',
  `assist_bd_id` int DEFAULT NULL COMMENT '协助bdid',
  `last_follow_time` datetime DEFAULT NULL COMMENT '最近跟进时间',
  `area_code_name` varchar(64) DEFAULT NULL COMMENT '地区名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_customer_name` (`customer_name`),
  KEY `index_bd_id` (`bd_id`),
  KEY `index_m_id` (`b_id`),
  KEY `index_area_code` (`area_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10051 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='crm线索'
---
DDL for crm_clue1
CREATE TABLE `crm_clue1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_source` tinyint NOT NULL COMMENT '客户来源 0 鲜沐大客户 1新增品牌',
  `customer_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称 可以做唯一索引',
  `kp` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'kp名称',
  `phone` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机电话',
  `dept` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '部门',
  `post` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '职务',
  `clue_status` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '线索状态',
  `clue_source` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '线索来源',
  `want_business` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '意向业务',
  `area_code` int DEFAULT NULL COMMENT '总部所在地code码',
  `purpose_remark` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '需求情况',
  `business_type` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '经营类型',
  `shop_type` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门店类型',
  `shop_size` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门店规模',
  `customer_type` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户类型',
  `shop_system` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '店铺系统',
  `head_system` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '总部系统',
  `send_remark` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料备注',
  `remark` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `bd_id` int DEFAULT NULL COMMENT 'bd id',
  `b_id` bigint DEFAULT '0' COMMENT '品牌id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_bd_id` int DEFAULT NULL COMMENT '创建bd id',
  `assist_bd_id` int DEFAULT NULL COMMENT '协助bdid',
  `last_follow_time` datetime DEFAULT NULL COMMENT '最近跟进时间',
  `area_code_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地区名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_customer_name` (`customer_name`) USING BTREE,
  KEY `index_bd_id` (`bd_id`),
  KEY `index_m_id` (`b_id`),
  KEY `index_area_code` (`area_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10041 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for crm_clue_copy1
CREATE TABLE `crm_clue_copy1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer_source` tinyint NOT NULL COMMENT '客户来源 0 鲜沐大客户 1新增品牌',
  `customer_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称 可以做唯一索引',
  `kp` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'kp名称',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机电话',
  `dept` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '部门',
  `post` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '职务',
  `clue_status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '线索状态',
  `clue_source` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '线索来源',
  `want_business` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '意向业务',
  `area_code` int DEFAULT NULL COMMENT '总部所在地code码',
  `purpose_remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '需求情况',
  `business_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '经营类型',
  `shop_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门店类型',
  `shop_size` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门店规模',
  `customer_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户类型',
  `shop_system` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '店铺系统',
  `head_system` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '总部系统',
  `send_remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料备注',
  `remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `bd_id` int DEFAULT NULL COMMENT 'bd id',
  `b_id` bigint DEFAULT '0' COMMENT '品牌id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_bd_id` int DEFAULT NULL COMMENT '创建bd id',
  `assist_bd_id` int DEFAULT NULL COMMENT '协助bdid',
  `last_follow_time` datetime DEFAULT NULL COMMENT '最近跟进时间',
  `area_code_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地区名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_customer_name` (`customer_name`) USING BTREE,
  KEY `index_bd_id` (`bd_id`),
  KEY `index_m_id` (`b_id`),
  KEY `index_area_code` (`area_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10041 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for crm_follow
CREATE TABLE `crm_follow` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id 自增',
  `type` varchar(8) DEFAULT NULL COMMENT 'clue 线索',
  `subject_id` bigint DEFAULT NULL COMMENT '主题id',
  `bd_id` int DEFAULT NULL COMMENT 'bd id',
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
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='crm 跟进'
---
DDL for crm_follow1
CREATE TABLE `crm_follow1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id 自增',
  `type` varchar(8) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'clue 线索',
  `subject_id` bigint DEFAULT NULL COMMENT '主题id',
  `bd_id` int DEFAULT NULL COMMENT 'bd id',
  `follow_time` datetime DEFAULT NULL COMMENT '跟进时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `follow_goal` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '跟进目的',
  `customer_feedback` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户反馈',
  `next_follow` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '下次跟进',
  `images` varchar(600) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '图片',
  `follow_model` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '跟进方式',
  PRIMARY KEY (`id`),
  KEY `index_type_bd_id` (`type`,`bd_id`),
  KEY `index_subject_id` (`subject_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for file_download_record
CREATE TABLE `file_download_record` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint unsigned DEFAULT NULL COMMENT '租户id',
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '存储地址',
  `params` text COLLATE utf8mb4_general_ci COMMENT '查询条件',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `type` tinyint DEFAULT NULL COMMENT '0、门店 1、商品',
  `status` tinyint DEFAULT NULL COMMENT '1、处理中 2、处理完毕 3、处理失败',
  `origin_params` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '初始查询条件',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5959 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='文件导出记录'
---
DDL for financial_bill
CREATE TABLE `financial_bill` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `bill_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '账单编号',
  `payee_id` bigint DEFAULT NULL COMMENT '收款人Id',
  `payer_id` bigint DEFAULT NULL COMMENT '付款人Id',
  `bill_type` tinyint DEFAULT NULL COMMENT '账期类型0 周账单 1月账单',
  `order_receivable_price` decimal(11,2) DEFAULT NULL COMMENT '订单应收总金额',
  `order_after_sale_total_price` decimal(11,2) DEFAULT NULL COMMENT '售后单总金额',
  `receivable_price` decimal(11,2) DEFAULT NULL COMMENT '应收金额',
  `received_price` decimal(11,2) DEFAULT NULL COMMENT '实收金额',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `type` tinyint DEFAULT NULL COMMENT '账单类型 0应收账单 1应付账单',
  `status` tinyint DEFAULT NULL COMMENT '账单状态0未收款1待审核2已还款3线下核对',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `file_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '文件路径',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_bill_no` (`bill_no`) USING BTREE,
  KEY `index_tenantid_payeeid_payerid` (`tenant_id`,`payee_id`,`payer_id`) USING BTREE,
  KEY `index_tenantid_payerid` (`tenant_id`,`payer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1488 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='账单表'
---
DDL for financial_bill_credentials
CREATE TABLE `financial_bill_credentials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `bill_id` bigint DEFAULT NULL COMMENT '账单Id',
  `operator_id` bigint DEFAULT NULL COMMENT '操作人Id',
  `credentials` varchar(1255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '账单凭证',
  `credentials_time` datetime DEFAULT NULL COMMENT '上传凭证时间',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '留言',
  `operator_type` tinyint DEFAULT NULL COMMENT '操作人类型0收款人1付款方',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_tenantid_billid` (`tenant_id`,`bill_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='账单凭证表'
---
DDL for financial_bill_item
CREATE TABLE `financial_bill_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `bill_id` bigint DEFAULT NULL COMMENT '账单Id',
  `business_id` bigint DEFAULT NULL COMMENT '业务Id',
  `business_type` tinyint DEFAULT NULL COMMENT '业务类型0订单1售后单',
  `price` decimal(11,2) DEFAULT NULL COMMENT '金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_tenantid_billid` (`tenant_id`,`bill_id`) USING BTREE,
  KEY `index_business_id` (`business_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42933 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='账单项表'
---
DDL for financial_bill_rule
CREATE TABLE `financial_bill_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint unsigned DEFAULT NULL COMMENT '租户Id',
  `type` tinyint DEFAULT NULL COMMENT '账期类型 0 按周 1按月',
  `day` int DEFAULT NULL COMMENT '第多少天 1-28',
  `start_time` datetime DEFAULT NULL COMMENT '账期开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '账期结束时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='账期规则表'
---
DDL for future_valid_cost_price
CREATE TABLE `future_valid_cost_price` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `admin_id` bigint NOT NULL COMMENT '大客户id',
  `sku_code` varchar(50) NOT NULL COMMENT '货品编码',
  `area_no` int NOT NULL COMMENT '鲜沐运营区域编码',
  `valid_time` datetime NOT NULL COMMENT '生效时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='未来生效价格表'
---
DDL for hui_fu_base
CREATE TABLE `hui_fu_base` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `reg_name` varchar(255) DEFAULT NULL COMMENT '汇付商户名称',
  `huifu_id` varchar(50) DEFAULT NULL COMMENT '汇付商户Id',
  `settle_type` varchar(10) DEFAULT NULL COMMENT '0对公1对私',
  `opening_bank` varchar(255) DEFAULT NULL COMMENT '开户行',
  `account_name` varchar(255) DEFAULT NULL COMMENT '户名',
  `account_number` varchar(255) DEFAULT NULL COMMENT '户号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tenant` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='汇付商户基本信息表'
---
DDL for hui_fu_payment
CREATE TABLE `hui_fu_payment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `req_seq_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求流水号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `bank_code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '通道返回码',
  `pay_info` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'js支付信息',
  `resp_desc` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务响应信息',
  `bank_message` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '通道返回描述',
  `hf_seq_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '全局流水号',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `req_date` char(8) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求时间',
  `resp_code` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '业务响应码',
  `huifu_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户号',
  `payment_id` bigint NOT NULL COMMENT '支付单id',
  `out_trans_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户账单上的交易订单号',
  `party_order_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户账单上的商户订单号',
  `is_div` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否分账交易；Y: 分账交易， N: 非分账交易',
  `is_delay_acct` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '是否延时交易；Y: 延迟， N: 不延迟',
  `wx_user_id` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信用户唯一标识码',
  `wx_response` longtext COLLATE utf8mb4_unicode_ci COMMENT '微信返回的响应报文',
  `alipay_response` longtext COLLATE utf8mb4_unicode_ci COMMENT '支付宝返回的响应报文',
  `dc_response` longtext COLLATE utf8mb4_unicode_ci COMMENT '数字货币返回的响应报文',
  `unionpay_response` longtext COLLATE utf8mb4_unicode_ci COMMENT '银联返回的响应报文',
  `delay_acct_flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '延时标记',
  `qr_code` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '二维码链接',
  `acct_id` varchar(9) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账户号',
  `settlement_amt` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '结算金额',
  `fee_flag` int DEFAULT NULL COMMENT '手续费扣款标志',
  `fee_amount` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手续费金额',
  `trans_finsh_time` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '汇付侧交易完成时间',
  `acct_date` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '入账时间',
  `acct_split_bunch` longtext COLLATE utf8mb4_unicode_ci COMMENT '分账对象',
  `mer_dev_location` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商户终端定位',
  `trans_fee_allowance_info` longtext COLLATE utf8mb4_unicode_ci COMMENT '手续费补贴信息',
  `combinedpay_data` longtext COLLATE utf8mb4_unicode_ci COMMENT '营销补贴信息',
  `combinedpay_fee_amt` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '补贴部分的手续费',
  `trade_type` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '交易类型:\nT_JSAPI: 微信公众号支付\nT_MINIAPP: 微信小程序支付\nA_JSAPI: 支付宝JS\nA_NATIVE: 支付宝正扫\nU_NATIVE: 银联正扫\nU_JSAPI: 银联 JS\nD_NATIVE: 数字人民币正扫\n示例值：T_JSAPI',
  `trans_amt` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '单位元，需保留小数点后两位，示例值：1.00，最低传入0.01',
  `trans_stat` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'S：成功、F：失败，示例值：S',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `notify_flag` tinyint DEFAULT NULL COMMENT '回调标识，1代表已回调，空代表未回调',
  PRIMARY KEY (`id`),
  KEY `idx_huifu_id` (`huifu_id`),
  KEY `idx_hf_seq_id` (`hf_seq_id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_payment_id` (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4273 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='汇付支付单'
---
DDL for hui_fu_refund
CREATE TABLE `hui_fu_refund` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `resp_code` varchar(8) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '业务响应码',
  `resp_desc` varchar(512) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '业务响应信息',
  `trans_stat` char(1) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '交易状态 P：处理中、S：成功、F：失败；示例值：S',
  `hf_seq_id` varchar(128) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '全局流水号',
  `req_date` varchar(8) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '请求日期',
  `req_seq_id` varchar(128) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '请求流水号',
  `huifu_id` varchar(32) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '商户号',
  `org_req_seq_id` varchar(128) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '原交易请求流水号',
  `loan_flag` char(2) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '是否垫资退款',
  `loan_undertaker` varchar(32) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '垫资承担者',
  `loan_acct_type` char(2) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '垫资账户类型',
  `unconfirm_amt` varchar(14) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '待确认总金额',
  `confirmed_amt` varchar(14) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '已确认总金额',
  `org_req_date` varchar(8) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '支付交易业务请求时间',
  `org_hf_seq_id` varchar(128) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '支付交易汇付全局流水号',
  `refund_id` varchar(64) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '退款id',
  `hui_fu_refund` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分账信息',
  `fee_amount` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手续费金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=834 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='退款记录表'
---
DDL for huifu_payment_rate_retry
CREATE TABLE `huifu_payment_rate_retry` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `payment_id` bigint NOT NULL COMMENT '支付单id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `retry_num` int NOT NULL DEFAULT '0' COMMENT '重试次数(最多重试三次,成功数据不保留)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_payment` (`payment_id`),
  KEY `idx_create_time_num` (`create_time`,`retry_num`)
) ENGINE=InnoDB AUTO_INCREMENT=1635 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='支付费率重试表'
---
DDL for id
CREATE TABLE `id` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for item_sale_limit_config
CREATE TABLE `item_sale_limit_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `market_item_id` bigint NOT NULL COMMENT 'market_item主键',
  `sale_limit_quantity` int DEFAULT NULL COMMENT '限制数量',
  `sale_limit_rule` tinyint NOT NULL DEFAULT '0' COMMENT '0不限制,1每次,2每自然日，3每自然周，4每自然月',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tenantid_marketitemid` (`tenant_id`,`market_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品限购配置'
---
DDL for location_province
CREATE TABLE `location_province` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '省份名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=820001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='省'
---
DDL for market
CREATE TABLE `market` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `title` varchar(255) DEFAULT NULL COMMENT '主标题',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '副标题',
  `category_id` bigint DEFAULT NULL COMMENT '类目Id',
  `main_picture` varchar(1255) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '主图',
  `detail_picture` varchar(1255) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '详情图',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delete_flag` tinyint DEFAULT '1' COMMENT '0、已删除 1、正在使用',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
  `edit_user_id` bigint DEFAULT NULL COMMENT '最后编辑人',
  PRIMARY KEY (`id`),
  KEY `index_title` (`title`),
  KEY `index_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2016687 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='销售商品'
---
DDL for market_area_item
CREATE TABLE `market_area_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '所属租户id',
  `sku_id` bigint DEFAULT NULL COMMENT 'sku id',
  `item_id` bigint NOT NULL COMMENT 'item表id',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `on_sale` tinyint NOT NULL DEFAULT '0' COMMENT '0 下架 1 上架',
  `warehouse_type` tinyint DEFAULT '0' COMMENT '已废弃',
  `mini_order_quantity` int NOT NULL DEFAULT '1' COMMENT '最小起订量',
  `delivery_type` tinyint DEFAULT '0' COMMENT '已废弃',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `price_type` tinyint DEFAULT '0' COMMENT '价格类型 0所有门店展示并统一定价 1所有门店展示单差异化定价 2部分门店展示且差异化定价',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_item_id` (`tenant_id`,`item_id`) USING BTREE,
  KEY `idx_tenant_sku_id` (`tenant_id`,`sku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3594 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='城市商品表'
---
DDL for market_area_item_mapping
CREATE TABLE `market_area_item_mapping` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `area_item_id` bigint NOT NULL COMMENT '映射区域item id',
  `type` tinyint DEFAULT NULL COMMENT '0、百分比上浮 1、定额上浮 2、固定价',
  `mapping_number` decimal(10,2) DEFAULT NULL COMMENT '价格配置数额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `store_price_type` tinyint DEFAULT '0' COMMENT '定价方式0统一价1其他价',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_area_item_id` (`tenant_id`,`area_item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5719 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='价格映射配置表'
---
DDL for market_area_item_store_price_mapping
CREATE TABLE `market_area_item_store_price_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `store_id` bigint DEFAULT NULL COMMENT '门店Id',
  `area_item_mapping_id` bigint DEFAULT NULL COMMENT '价格定价方式Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `pri_tenant_id_store_id` (`tenant_id`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1113 DEFAULT CHARSET=utf8mb3 COMMENT='门店商品定价策略映射'
---
DDL for market_area_item_store_price_mapping111
CREATE TABLE `market_area_item_store_price_mapping111` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `store_id` bigint DEFAULT NULL COMMENT '门店Id',
  `area_item_mapping_id` bigint DEFAULT NULL COMMENT '价格定价方式Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `pri_tenant_id_store_id` (`tenant_id`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11342 DEFAULT CHARSET=utf8mb3 COMMENT='门店商品定价策略映射'
---
DDL for market_classification
CREATE TABLE `market_classification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '分类图标',
  `parent_id` bigint DEFAULT '0' COMMENT '上级分类id',
  `sort` int NOT NULL COMMENT '排序值',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_sort` (`tenant_id`,`sort`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1721 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品分类表'
---
DDL for market_combine_item_mapping
CREATE TABLE `market_combine_item_mapping` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `item_id` bigint NOT NULL COMMENT '组合品itemid',
  `combine_item_id` bigint NOT NULL COMMENT '组合品子itemid',
  `quantity` int NOT NULL COMMENT '数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_item_id` (`item_id`),
  KEY `idx_tenant_id_combine_id` (`tenant_id`,`combine_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1045 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='组合品映射表'
---
DDL for market_detail
CREATE TABLE `market_detail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `market_id` bigint NOT NULL COMMENT 'marketid',
  `after_sale_time` int DEFAULT '38' COMMENT '从截单开始的售后时间',
  `after_sale_reason` varchar(50) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '售后原因',
  `refund_reason` varchar(255) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '退款原因,拍多/拍错/不想要',
  `slogan` varchar(500) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '广告语',
  `description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '描述',
  `out_id` bigint DEFAULT NULL COMMENT '外部id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_outid` (`out_id`),
  KEY `idx_market_id` (`market_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品扩展表'
---
DDL for market_item
CREATE TABLE `market_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `sku_id` bigint DEFAULT NULL COMMENT 'sku主键',
  `title` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `sub_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '副标题',
  `origin` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '产地',
  `main_picture` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '图片',
  `detail_picture` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '详情图',
  `specification` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '规格',
  `specification_unit` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '规格单位',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `market_id` bigint DEFAULT NULL COMMENT '主键Id',
  `brand_id` bigint DEFAULT NULL COMMENT '品牌Id',
  `brand_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品牌名称',
  `supplier_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商名称',
  `item_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '自有编码',
  `weight_notes` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规格备注（区间）',
  `supplier_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商Id',
  `max_after_sale_amount` int DEFAULT '1' COMMENT '最大售后数',
  `after_sale_unit` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '件' COMMENT '售后单位',
  `delete_flag` tinyint DEFAULT '1' COMMENT '删除标识 0、已删除 1、正在使用',
  `goods_type` tinyint DEFAULT NULL COMMENT '货品类型 0虚拟货品 1报价货品 2自营货品',
  `item_type` tinyint DEFAULT '0' COMMENT '0=实物商品,1=虚拟商品,2=组合品',
  `mini_order_quantity` int NOT NULL DEFAULT '1' COMMENT '最小起订量',
  `on_sale` tinyint NOT NULL DEFAULT '0' COMMENT '0下架 1上架\n',
  `price_type` tinyint DEFAULT '0' COMMENT '价格类型 0所有门店展示并统一定价 1所有门店展示单差异化定价 2部分门店展示且差异化定价 3组合品按总价下调固定额度,4组合品按总价下调百分比 5组合品总价',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
  `edit_user_id` bigint DEFAULT NULL COMMENT '最后编辑人',
  `item_sale_mode` tinyint DEFAULT '0' COMMENT '销售方式 0、可独售 1、搭售可凑单 2、搭售不可凑单',
  `no_goods_supply_price` decimal(12,2) DEFAULT NULL COMMENT '无货商品供应价',
  `sale_limit_quantity` int DEFAULT NULL COMMENT '限制数量',
  `sale_limit_rule` tinyint NOT NULL DEFAULT '0' COMMENT '0不限制,1每次,2每自然日，3每自然周，4每自然月',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`,`sku_id`) USING BTREE,
  KEY `idx_market_id` (`market_id`,`tenant_id`),
  KEY `idx_sku_id` (`sku_id`),
  KEY `idx_tenantid_itemcode` (`tenant_id`,`item_code`)
) ENGINE=InnoDB AUTO_INCREMENT=27289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品表'
---
DDL for market_item_classification
CREATE TABLE `market_item_classification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `classification_id` bigint NOT NULL COMMENT '分类id',
  `item_id` bigint NOT NULL DEFAULT '0' COMMENT 'item id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `disable` int DEFAULT '0' COMMENT '是否禁用 0开启 1禁用',
  `market_id` bigint DEFAULT NULL COMMENT 'market主键Id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_item_id` (`tenant_id`,`item_id`) USING BTREE,
  KEY `idx_market_id` (`market_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品分类关联表'
---
DDL for market_item_detail
CREATE TABLE `market_item_detail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `market_item_id` bigint NOT NULL COMMENT 'marketitemid',
  `ext_type` int DEFAULT NULL COMMENT 'sku性质：0、常规 2、临保 3、拆包 4、不卖 5、破袋',
  `base_sale_unit` int unsigned DEFAULT '1' COMMENT '起售规格',
  `average_price_flag` tinyint DEFAULT '0' COMMENT '0 不展示平均价  1 展示平均价',
  `sample_pool` int DEFAULT '0' COMMENT ' 是否加入样本池 0 不加入 1加入',
  `customer_id` bigint DEFAULT NULL COMMENT '客户id',
  `out_id` bigint DEFAULT NULL COMMENT '外部id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_out_id` (`out_id`),
  KEY `idx_market_item_id` (`market_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12785 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品item扩展表'
---
DDL for market_item_onsale_strategy_mapping
CREATE TABLE `market_item_onsale_strategy_mapping` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `m_type` tinyint DEFAULT '0' COMMENT '是否大客户专享',
  `show_flag` tinyint DEFAULT '1' COMMENT '是否展示',
  `item_id` bigint NOT NULL COMMENT '商品id',
  `target_id` bigint NOT NULL COMMENT '上下架目标id',
  `on_sale` tinyint DEFAULT '0' COMMENT '0下架 1上架\n',
  `strategy_type` tinyint DEFAULT '1' COMMENT '上架目标类型 1按租户,2 按门店 3单店 4大客户',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tenantId_itemId_targetId_strategyType` (`tenant_id`,`item_id`,`target_id`,`strategy_type`)
) ENGINE=InnoDB AUTO_INCREMENT=257328378 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品上下架表'
---
DDL for market_item_order_summary
CREATE TABLE `market_item_order_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `item_id` bigint NOT NULL COMMENT '商品id',
  `sku_id` bigint DEFAULT NULL COMMENT '货品id',
  `trade_amount` decimal(10,2) NOT NULL COMMENT '交易金额',
  `trade_quantity` int NOT NULL COMMENT '交易件数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_time` (`tenant_id`,`create_time`),
  KEY `idx_item_id` (`item_id`),
  KEY `idx_sku_id` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='item下单汇总'
---
DDL for market_item_price
CREATE TABLE `market_item_price` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `market_item_id` bigint NOT NULL COMMENT 'sku主键',
  `target_type` tinyint NOT NULL DEFAULT '0' COMMENT '价格目标 0-品牌方,1-门店,2-运营区域,3-门店分组',
  `target_id` bigint NOT NULL COMMENT '价格目标类型id',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `base_price` decimal(10,2) DEFAULT NULL COMMENT '底价',
  `price_strategy` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '价格策略',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tenantId_itemId_targetId_targetType` (`tenant_id`,`market_item_id`,`target_id`,`target_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12345542 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品价格表'
---
DDL for market_item_price_log
CREATE TABLE `market_item_price_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `target_type` tinyint DEFAULT '0' COMMENT '价格目标类型 0-品牌方,1-门店,2-运营区域',
  `target_id` bigint DEFAULT NULL COMMENT '价格目标id',
  `market_item_id` bigint NOT NULL COMMENT 'sku主键',
  `sku_id` bigint DEFAULT NULL COMMENT '货品主键',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `price_strategy` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '价格规则',
  `base_price` decimal(10,2) NOT NULL COMMENT '底价',
  `ops_type` tinyint DEFAULT '0' COMMENT '操作类型,0-新增,1-修改,2-删除',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `price_rule` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '价格规则',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14490134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品价格变化记录表'
---
DDL for market_item_price_strategy
CREATE TABLE `market_item_price_strategy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `item_id` bigint NOT NULL COMMENT 'item id',
  `strategy_type` tinyint DEFAULT NULL COMMENT '0、按成本价百分比上浮 1、按成本价定额上浮 2、固定价 3、按售价百分比下调 4、按售价定额下调',
  `strategy_value` decimal(10,2) DEFAULT NULL COMMENT '策略值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `target_type` tinyint DEFAULT '0' COMMENT '价格目标 0-品牌方,1-门店,2-运营区域,3-门店分组',
  `remarks` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_item_id` (`tenant_id`,`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44909 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品item价格策略表'
---
DDL for market_item_price_strategy_mapping
CREATE TABLE `market_item_price_strategy_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `item_price_strategy_id` bigint NOT NULL COMMENT '商品item价格策略id',
  `target_id` bigint NOT NULL COMMENT '报价目标Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_item_price_strategy_id` (`item_price_strategy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46291 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品item价格策略映射'
---
DDL for market_item_unfair_price_strategy
CREATE TABLE `market_item_unfair_price_strategy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `item_id` bigint NOT NULL DEFAULT '-1' COMMENT 'item id, 如果是-1，则说明是全局默认规则',
  `default_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否默认, 1=是,0=否',
  `strategy_value` tinyint NOT NULL DEFAULT '0' COMMENT '策略值 0-以供应价售卖 1-已自定义价售卖 2-自动下架',
  `target_type` tinyint NOT NULL DEFAULT '0' COMMENT '策略生效目标 0-品牌方',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_item_target` (`tenant_id`,`item_id`,`target_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品倒挂策略表'
---
DDL for measure_item_result
CREATE TABLE `measure_item_result` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `report_id` bigint DEFAULT NULL COMMENT '报告Id',
  `item_id` bigint DEFAULT NULL COMMENT '度量项id',
  `normal_flag` tinyint DEFAULT NULL COMMENT '1、正常 2、异常',
  `deduction_score` int DEFAULT NULL COMMENT '扣分',
  `status` tinyint DEFAULT NULL COMMENT '1、初始化 2、处理中 3、处理完毕 4、处理失败',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_report_id` (`tenant_id`,`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='度量项结果'
---
DDL for measure_items
CREATE TABLE `measure_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `title` varchar(255) NOT NULL COMMENT '度量名称',
  `level` tinyint NOT NULL COMMENT '1、特别关注 2、立即优化',
  `url` varchar(255) DEFAULT NULL COMMENT '地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='度量项表'
---
DDL for measure_report
CREATE TABLE `measure_report` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `account_id` bigint NOT NULL COMMENT '账户id',
  `score` int DEFAULT NULL COMMENT '得分',
  `status` tinyint NOT NULL COMMENT '1、初始化 2、处理中 3、处理完毕 4、处理失败',
  `special_interest_nums` int DEFAULT '0' COMMENT '特别关心数量',
  `optimize_nums` int DEFAULT '0' COMMENT '立即优化数量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_account_id` (`tenant_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='度量报告'
---
DDL for merchant
CREATE TABLE `merchant` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `merchant_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '品牌名称',
  `logo_image` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'logo',
  `background_image` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '背景图',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1663394670634016837 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商户表'
---
DDL for merchant_address
CREATE TABLE `merchant_address` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `store_id` bigint DEFAULT NULL COMMENT '门店id',
  `province` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '市',
  `area` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '区',
  `address` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '详细地址',
  `house_number` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '们拍好',
  `poi_note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商家腾讯地图坐标',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `default_flag` int DEFAULT '1' COMMENT '是否是默认地址：0、否 1、是',
  `status` int DEFAULT '1' COMMENT '状态(1-正常或审核通过、2-删除、3-待审核、4-审核不通过)',
  `xm_contact_id` bigint DEFAULT NULL COMMENT '鲜沐contact表id,冗余字段便于鲜沐接入',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核备注',
  `address_remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_xmcontactid` (`xm_contact_id`),
  KEY `idx_store` (`tenant_id`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20304 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='门店地址信息'
---
DDL for merchant_contact
CREATE TABLE `merchant_contact` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `address_id` bigint DEFAULT NULL COMMENT '地址id',
  `name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系人名称',
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '联系人手机号',
  `default_flag` int DEFAULT NULL COMMENT '是否是默认地址：0、否 1、是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store` (`tenant_id`,`address_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20322 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='门店联系人'
---
DDL for merchant_delivery_fee_rule
CREATE TABLE `merchant_delivery_fee_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `type` tinyint DEFAULT NULL COMMENT '0、无仓 1、三方仓 2、自营仓',
  `delivery_fee` decimal(10,2) DEFAULT NULL COMMENT '运费/ 加价运费 / 实时上浮百分比',
  `free_delivery_price` decimal(10,2) DEFAULT NULL COMMENT '免运费金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `rule_type` tinyint DEFAULT NULL COMMENT '0,每单1,每日2,基于仓运费报价',
  `price_type` tinyint DEFAULT NULL COMMENT '0,固定 1实时加价 2实时上浮',
  `relate_number` decimal(10,2) DEFAULT NULL COMMENT '实时加价运费，实时上浮百分比',
  `default_type` tinyint NOT NULL DEFAULT '1' COMMENT '是否是仓库的默认数据0:非默认类型;1:默认类型',
  `free_delivery_type` int NOT NULL DEFAULT '0' COMMENT '免运费规则，0金额，1数量',
  `free_delivery_quantity` int DEFAULT NULL COMMENT '免运费数量',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `hit_item_ids` json DEFAULT NULL COMMENT '选中商品ID列表',
  `hit_areas` json DEFAULT NULL COMMENT '选中配送区域名称列表',
  `include_new_flag` tinyint DEFAULT '0' COMMENT '包含后续新增商品 0 - 不包含 1 - 包含',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='门店运费规则表'
---
DDL for merchant_delivery_rule_warehouse_relation
CREATE TABLE `merchant_delivery_rule_warehouse_relation` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `rule_id` bigint NOT NULL COMMENT '门店运费规则id',
  `warehouse_no` int NOT NULL COMMENT '仓库编号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id_rule_id` (`tenant_id`,`rule_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1717489529191731202 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='运费规则仓库信息关联表'
---
DDL for merchant_delivery_step_fee
CREATE TABLE `merchant_delivery_step_fee` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户ID',
  `rule_id` bigint DEFAULT NULL COMMENT '运费规则ID',
  `fee_rule` tinyint DEFAULT NULL COMMENT '门槛类型  0-金额 1-数量',
  `step_threshold` decimal(10,2) DEFAULT NULL COMMENT '阶梯门槛。即满xx元/件',
  `delivery_fee` decimal(10,2) DEFAULT NULL COMMENT '运费',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_rule` (`tenant_id`,`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='阶梯运费'
---
DDL for merchant_order_quantity_rule
CREATE TABLE `merchant_order_quantity_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `rule_target` bigint NOT NULL COMMENT '0,全商城,-1表示无仓，-2表示三方仓，其他值表示具体自营仓',
  `warehouse_type` tinyint NOT NULL COMMENT '0,无仓1三方仓 2自营仓',
  `rule` text NOT NULL COMMENT '规则json',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `rule_group` bigint DEFAULT NULL COMMENT '标识相同规则',
  `rule_sort` int NOT NULL DEFAULT '0' COMMENT '规则排序，从小到大',
  `hit_item_ids` json DEFAULT NULL COMMENT '选中商品ID列表',
  `hit_goods_source` tinyint DEFAULT NULL COMMENT '货品类型,和goodsType不同, 0:全部，1:自营，2代仓，3供应商',
  `include_new_flag` tinyint DEFAULT '0' COMMENT '包含后续新增商品 0 - 不包含 1 - 包含',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2692 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='起订量规则表'
---
DDL for merchant_store
CREATE TABLE `merchant_store` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `store_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '门店名称',
  `type` int DEFAULT NULL COMMENT '门店类型：0-直营店 1-加盟店 2-托管店 3-个人店 4-连锁店 5-未知',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `status` int DEFAULT NULL COMMENT '门店状态：0、审核中 1、审核通过 2、审核拒绝 3、已关店 4、拉黑 5、注销',
  `audit_remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '审核备注',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `bill_switch` tinyint DEFAULT '0' COMMENT '账期开关 1开启 0关闭',
  `online_payment` tinyint DEFAULT '1' COMMENT '在线支付1开启0关闭',
  `store_no` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门店编号',
  `balance_authority` tinyint DEFAULT '1' COMMENT '余额权限 0、关闭 1、开启',
  `business_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门店经营类型',
  `regional_id` bigint DEFAULT NULL COMMENT '区域组织id',
  `m_id` bigint DEFAULT NULL COMMENT '鲜沐merchant表id',
  `channel_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '门店自己的邀请码，可用于邀请门店、子账号等',
  `area_no` int DEFAULT '1001' COMMENT '运营服务区域',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_store_no` (`tenant_id`,`store_no`),
  KEY `idx_mid_tenantid` (`m_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=143150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='门店表'
---
DDL for merchant_store_account
CREATE TABLE `merchant_store_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `store_id` bigint DEFAULT NULL COMMENT '门店id',
  `account_name` varchar(50) DEFAULT NULL COMMENT '账号名称',
  `phone` varchar(50) DEFAULT NULL COMMENT '手机号',
  `type` int DEFAULT NULL COMMENT '账号类型：0、店长 1、店员',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `open_id` varchar(255) DEFAULT NULL COMMENT 'open id',
  `union_id` varchar(255) DEFAULT NULL COMMENT 'union id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` int DEFAULT NULL COMMENT '账户状态 0、审核中 1、审核通过 2、审核拒绝 3、关店 4、注销',
  `last_login_time` datetime DEFAULT NULL COMMENT '上次登录时间',
  `delete_flag` tinyint DEFAULT '1' COMMENT '0 已删除 1 正常使用',
  `oa_open_id` varchar(255) DEFAULT NULL COMMENT '公众号openId',
  `m_id` bigint DEFAULT NULL COMMENT '鲜沐merchant表id,冗余字段便于鲜沐接入',
  PRIMARY KEY (`id`),
  KEY `idx_store` (`tenant_id`,`store_id`),
  KEY `idx_phone_store` (`phone`,`store_id`,`tenant_id`),
  KEY `idx_mid` (`m_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50000935 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='账户表'
---
DDL for merchant_store_account_operator_log
CREATE TABLE `merchant_store_account_operator_log` (
  `id` bigint NOT NULL COMMENT '主键Id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `store_id` bigint DEFAULT NULL COMMENT '门店Id',
  `account_id` bigint DEFAULT NULL COMMENT '店员Id',
  `operator_log` text COLLATE utf8mb4_general_ci COMMENT '操作日志',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_tenant_id_store_id_account_id` (`tenant_id`,`store_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for merchant_store_account_operator_log_copy1
CREATE TABLE `merchant_store_account_operator_log_copy1` (
  `id` bigint NOT NULL COMMENT '主键Id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `store_id` bigint DEFAULT NULL COMMENT '门店Id',
  `account_id` bigint DEFAULT NULL COMMENT '店员Id',
  `operator_log` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '操作日志',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_tenant_id_store_id_account_id` (`tenant_id`,`store_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for merchant_store_balance
CREATE TABLE `merchant_store_balance` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint unsigned NOT NULL COMMENT '租户id',
  `store_id` bigint unsigned NOT NULL COMMENT '门店id',
  `store_no` varchar(60) NOT NULL COMMENT '门店编码',
  `balance` decimal(10,2) NOT NULL COMMENT '余额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tenant_store_id` (`tenant_id`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4715 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='门店余额表'
---
DDL for merchant_store_balance_change_record
CREATE TABLE `merchant_store_balance_change_record` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `change_balance` decimal(10,2) NOT NULL COMMENT '变动余额',
  `after_change_balance` decimal(10,2) NOT NULL COMMENT '变动过后的余额',
  `associated_order_no` varchar(50) DEFAULT NULL COMMENT '关联订单单号/售后单号',
  `operator_id` bigint DEFAULT NULL COMMENT '操作人id',
  `proof` varchar(2048) DEFAULT NULL COMMENT '凭证',
  `remark` varchar(2048) DEFAULT NULL COMMENT '备注',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `type` tinyint NOT NULL COMMENT '余额变动类型 0、预付 1、消费 2、消费退款',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_associated_order_no` (`associated_order_no`),
  KEY `idx_tenant_store_id` (`tenant_id`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=132518 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='门店余额变动表'
---
DDL for merchant_store_change_log
CREATE TABLE `merchant_store_change_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `regional_id` bigint DEFAULT NULL COMMENT '区域id',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `inviter_channel_code` varchar(50) DEFAULT NULL COMMENT '记录是哪个销售邀请的',
  `merchant_channel_code` varchar(50) DEFAULT NULL COMMENT '记录是哪个门店邀请的',
  `op_name` varchar(50) DEFAULT NULL COMMENT '操作人名称',
  `op_type` tinyint DEFAULT NULL COMMENT '操作类型，0-创建，1-审核，2-关店，3-拉黑',
  `op_remark` varchar(50) DEFAULT NULL COMMENT '操作备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_storeid` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=138965 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='门店变更记录表'
---
DDL for merchant_store_config
CREATE TABLE `merchant_store_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '操作人名称',
  `pop_view` int DEFAULT '0' COMMENT '弹框',
  `change_pop` int DEFAULT '1' COMMENT '更换账号绑定弹窗：0、未弹 1、已弹或未更换账号绑定',
  `first_login_pop` int DEFAULT '0' COMMENT '首次登录弹窗：0、未弹 1、已弹',
  `display_button` int DEFAULT '1' COMMENT '开关状态 0 开（展示） 1 关（不展示）',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_storeid` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137523 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='门店配置表'
---
DDL for merchant_store_ext
CREATE TABLE `merchant_store_ext` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `pop_view` int DEFAULT '0' COMMENT '弹框',
  `change_pop` int DEFAULT '1' COMMENT '更换账号绑定弹窗：0、未弹 1、已弹或未更换账号绑定',
  `first_login_pop` int DEFAULT '0' COMMENT '首次登录弹窗：0、未弹 1、已弹',
  `display_button` int DEFAULT '1' COMMENT '开关状态 0 开（展示） 1 关（不展示）',
  `pre_register_flag` int DEFAULT '0' COMMENT '预注册标记.1-代表为预注册',
  `mock_login_flag` int DEFAULT '0' COMMENT '模拟登录标记,为1的时候代表支持模拟登录',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '操作人名称',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '商家腾讯地图坐标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_storeid` (`store_id`),
  KEY `idx_province_city_area` (`province`,`city`,`area`)
) ENGINE=InnoDB AUTO_INCREMENT=34403 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='门店拓展信息表'
---
DDL for merchant_store_group
CREATE TABLE `merchant_store_group` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `name` varchar(100) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '分组名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `type` tinyint DEFAULT '0' COMMENT '0、非默认分组 1、默认分组',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id_type` (`tenant_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=1127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='门店分组'
---
DDL for merchant_store_group_mapping
CREATE TABLE `merchant_store_group_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `store_id` bigint DEFAULT NULL COMMENT '门店Id',
  `group_id` bigint DEFAULT NULL COMMENT '分组Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pri_tenant_id_store_id` (`tenant_id`,`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7117 DEFAULT CHARSET=utf8mb3 COMMENT='门店分组映射表'
---
DDL for merchant_store_trade_summary
CREATE TABLE `merchant_store_trade_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `store_type` tinyint NOT NULL COMMENT '门店类型 0、直营店 1、加盟店 2、托管店 3、个人店 4、连锁店',
  `business_id` bigint NOT NULL COMMENT '业务id（支付单id/退款单id）',
  `business_no` varchar(255) NOT NULL COMMENT '业务单号（支付/退款单号）',
  `trade_amount` decimal(10,2) NOT NULL COMMENT '交易金额',
  `trade_type` tinyint NOT NULL COMMENT '交易类型 1、支付 2、退款',
  `trade_time` datetime NOT NULL COMMENT '交易时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `trade_quantity` int DEFAULT NULL COMMENT '交易件数',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_tpye_time` (`tenant_id`,`trade_time`,`trade_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='门店交易汇总'
---
DDL for msg_scene
CREATE TABLE `msg_scene` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `template_id` bigint DEFAULT NULL COMMENT '模版池id',
  `template_type` tinyint DEFAULT '0' COMMENT '模版类型0=微信',
  `template_name` varchar(128) DEFAULT NULL COMMENT '模版名称',
  `keywords` varchar(3000) DEFAULT NULL COMMENT '关键字',
  `scene_name` varchar(128) DEFAULT NULL COMMENT '场景名称',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `scene_status` tinyint DEFAULT '1' COMMENT '场景 状态0=不可用;1=可用',
  `page` varchar(500) DEFAULT NULL COMMENT '消息详情url',
  `updater` bigint DEFAULT NULL COMMENT '操纵人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='消息场景表'
---
DDL for msg_scene_tenant_mapping
CREATE TABLE `msg_scene_tenant_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `scene_id` bigint NOT NULL COMMENT '场景id',
  `template_id` bigint NOT NULL COMMENT '模版id',
  `third_template_id` varchar(64) DEFAULT NULL COMMENT '三方模版id',
  `template_type` tinyint DEFAULT '0' COMMENT '模版类型1=微信',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `available_status` tinyint DEFAULT '1' COMMENT '推送权限0=禁用;1=启用',
  `u_id` bigint NOT NULL COMMENT '用户id',
  `u_name` varchar(64) DEFAULT NULL COMMENT '用户名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='消息场景-租户映射表'
---
DDL for order
CREATE TABLE `order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `store_id` bigint NOT NULL COMMENT '店铺Id',
  `account_id` bigint NOT NULL COMMENT '下单账号Id',
  `supplier_tenant_id` bigint DEFAULT NULL COMMENT '供应商租户Id',
  `order_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单编号',
  `warehouse_type` tinyint NOT NULL COMMENT '配送仓类型 0,无仓1三方仓 2自营仓',
  `payable_price` decimal(12,2) DEFAULT NULL COMMENT '应付价格',
  `delivery_fee` decimal(12,2) DEFAULT NULL COMMENT '配送费',
  `total_price` decimal(12,2) DEFAULT NULL COMMENT '总金额',
  `status` tinyint NOT NULL COMMENT '状态 1、下单中 2、待支付 3、待配送 4、待收货 5、已完成 6、已取消 7、已退款 8、关单中 9、已关闭 10、等待出库 11、部分配送 12、出库中',
  `pay_type` tinyint DEFAULT NULL COMMENT '支付方式 1、微信支付 2、账期 3、余额支付 4、支付宝支付 5、无需支付',
  `online_pay_channel` int DEFAULT NULL COMMENT '支付渠道 0、微信 1、汇付',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '配送时间',
  `finished_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `apply_end_time` int DEFAULT NULL COMMENT '可申请售后时间(小时)',
  `auto_finished_time` int DEFAULT NULL COMMENT '自动完成时间(天)',
  `warehouse_no` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '仓库编号',
  `combine_order_id` bigint NOT NULL DEFAULT '-1' COMMENT '组合订单id',
  `order_type` tinyint NOT NULL DEFAULT '0' COMMENT '0-普通订单,1=组合订单',
  `begin_delivery_time` datetime DEFAULT NULL COMMENT '开始配送时间',
  `profit_sharing_finish_time` datetime DEFAULT NULL COMMENT '分账完成时间',
  `order_version` int DEFAULT NULL COMMENT '订单记录版本',
  `order_source` tinyint DEFAULT '0' COMMENT '订单来源:0：内部系统;1：openapi调用',
  `customer_order_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '外部系统订单号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_unique_orderNO` (`order_no`) USING BTREE,
  KEY `index_tenantId_storeId_accountId` (`tenant_id`,`store_id`,`account_id`) USING BTREE,
  KEY `index_createtime_tenantid_status` (`create_time`,`tenant_id`,`status`),
  KEY `idx_combine_order_id1` (`combine_order_id`),
  KEY `idx_delivery_time_status` (`delivery_time`,`status`),
  KEY `idx_customer_order_id` (`customer_order_id`),
  KEY `idx_createtiem_tenant_store` (`create_time`,`tenant_id`,`store_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=94025 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单表'
---
DDL for order_address
CREATE TABLE `order_address` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户编码',
  `order_id` bigint DEFAULT NULL COMMENT '订单编号',
  `contact_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '收货人',
  `contact_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '收货人联系电话',
  `province` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '市',
  `area` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '区',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '收获地址',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `poi_note` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商家腾讯地图坐标',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_uniqe_orderId` (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25646 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单地址表'
---
DDL for order_after_sale
CREATE TABLE `order_after_sale` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户编号',
  `order_id` bigint DEFAULT NULL COMMENT '订单编号',
  `order_item_id` bigint DEFAULT NULL COMMENT '订单项Id',
  `store_id` bigint DEFAULT NULL COMMENT '门店Id',
  `account_id` bigint DEFAULT NULL COMMENT '账户ID',
  `after_sale_order_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '售后订单编号',
  `amount` int DEFAULT NULL COMMENT '数量',
  `after_sale_type` bigint DEFAULT NULL COMMENT '售后类型 0 已到货 1 未到货',
  `service_type` bigint DEFAULT NULL COMMENT '售后服务类型 1 退款 2 退款录入账单 3 退货退款 4 退货退款录入账单 5 换货 6 补发 7、退款录入余额 8、 退货退款录入余额',
  `apply_price` decimal(12,2) DEFAULT NULL COMMENT '申请金额',
  `total_price` decimal(12,2) DEFAULT NULL COMMENT '售后金额',
  `delivery_fee` decimal(10,2) DEFAULT NULL COMMENT '配送费',
  `reason` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '售后原因',
  `user_remark` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户留言',
  `proof_picture` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '售后凭证照片',
  `status` tinyint DEFAULT NULL COMMENT '状态 1,待审核 2，已成功 3，已失败 4 ，已取消\n系统内部状态 1待审核 2处理中 3退款中 4已同意 5已拒绝 6已取消 7库存退还失败 8 待退款9 三方处理中',
  `handle_remark` varchar(2048) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '处理结果',
  `operator_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `finished_time` datetime DEFAULT NULL COMMENT '完成时间',
  `handle_time` datetime DEFAULT NULL COMMENT '审核时间',
  `recycle_time` datetime DEFAULT NULL COMMENT '处理时间（回收、补发时间）',
  `store_no` int DEFAULT NULL COMMENT '城配仓 编码',
  `recycle_details` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '回收详情',
  `responsibility_type` tinyint DEFAULT '0' COMMENT '责任类型0供应商1品牌方2门店',
  `warehouse_type` tinyint DEFAULT NULL COMMENT '配送仓类型 0,无仓1三方仓 2自营仓',
  `auto_finished_time` datetime DEFAULT NULL COMMENT '自动完成时间',
  `apply_quantity` int DEFAULT NULL COMMENT '申请数量',
  `admin_remark` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '后台售后备注',
  `admin_remark_time` datetime DEFAULT NULL COMMENT '后台售后备注更新时间',
  `second_handle_remark` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退货二次审核说明',
  `return_address_id` bigint DEFAULT NULL COMMENT '退回地址Id',
  `return_warehouse_no` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退货仓库编号',
  `customer_after_sale_order_no` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '外部系统售后单号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_afterorderid` (`after_sale_order_no`) USING BTREE,
  KEY `idx_status` (`tenant_id`,`status`) USING BTREE,
  KEY `idx_createtime_status` (`create_time`,`status`),
  KEY `idx_orderid` (`order_id`),
  KEY `idx_orderitemid` (`order_item_id`),
  KEY `idx_customer_after_sale_order_no` (`customer_after_sale_order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12719 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='售后订单表'
---
DDL for order_after_sale_rule
CREATE TABLE `order_after_sale_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `delivery_type` tinyint DEFAULT NULL COMMENT '配送方式',
  `apply_end_time` int DEFAULT NULL COMMENT '申请结束天数',
  `auto_finished_time` int DEFAULT NULL COMMENT '自动完成时间',
  `deal_type` tinyint DEFAULT NULL COMMENT '处理方式：0同意1拒绝',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `type` tinyint DEFAULT NULL COMMENT '类型 0配送仓库 1商品分组',
  `default_flag` tinyint DEFAULT NULL COMMENT '是否默认0默认 1非默认',
  `rule` text COLLATE utf8mb4_general_ci COMMENT '规则',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=686 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单售后规则'
---
DDL for order_agent_sku_fee_rule_snapshot
CREATE TABLE `order_agent_sku_fee_rule_snapshot` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `order_id` bigint DEFAULT NULL COMMENT '订单Id',
  `account_id` bigint DEFAULT NULL COMMENT '账号Id',
  `fee_rule_type` tinyint DEFAULT NULL COMMENT '费用规则类型0按比例1按件数',
  `rule` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '规则',
  `price` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `hit_rule` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '当前订单命中规则',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_tenant_id_order_id` (`tenant_id`,`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31315 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单代仓品收费快照表'
---
DDL for order_combine_snapshot
CREATE TABLE `order_combine_snapshot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `combine_order_id` bigint NOT NULL COMMENT '组合订单id',
  `combine_item_id` bigint NOT NULL COMMENT '组合品id',
  `item_id` bigint NOT NULL COMMENT '组合品子itemid',
  `quantity` int NOT NULL COMMENT '组合品子item数量',
  `original_price` decimal(10,2) NOT NULL COMMENT '原单价',
  `order_item_id` bigint NOT NULL COMMENT '子订单id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1663454815650137550 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='组合订单快照'
---
DDL for order_delivery_detail
CREATE TABLE `order_delivery_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `order_no` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `after_sale_order_id` bigint DEFAULT NULL COMMENT '补发售后id',
  `after_sale_order_no` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '补发售后编号',
  `order_item_id` bigint NOT NULL COMMENT '订单项id',
  `sku_id` bigint NOT NULL COMMENT 'skuid',
  `supplier_sku_id` bigint DEFAULT NULL COMMENT '供应商skuid',
  `market_item_id` bigint NOT NULL COMMENT 'Marketitemid\n',
  `amount` int DEFAULT NULL COMMENT '总数量',
  `store_id` bigint DEFAULT NULL COMMENT '店铺id',
  `deliveryied_amount` int DEFAULT NULL COMMENT '已配送数量',
  `type` tinyint(1) DEFAULT NULL COMMENT '0-订单;1-售后补发单',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配送详情'
---
DDL for order_delivery_fee_snapshot
CREATE TABLE `order_delivery_fee_snapshot` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户ID',
  `order_id` bigint DEFAULT NULL COMMENT '订单ID',
  `order_delivery_fee` decimal(10,2) DEFAULT NULL COMMENT '订单运费',
  `order_info` json DEFAULT NULL COMMENT '订单信息',
  `rule_info` json DEFAULT NULL COMMENT '规则列表',
  `hit_rule_fee` json DEFAULT NULL COMMENT '命中规则的运费',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `scene` tinyint DEFAULT '1' COMMENT '计算运费场景 1-下单 2-发货前售后',
  `effective_flag` tinyint DEFAULT '1' COMMENT '有效标识 1-有效 0-无效',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='下单运费快照'
---
DDL for order_item
CREATE TABLE `order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `order_id` bigint DEFAULT NULL COMMENT '订单编号',
  `item_id` bigint DEFAULT NULL COMMENT 'itemId编码',
  `amount` int DEFAULT NULL COMMENT '数量',
  `payable_price` decimal(12,2) DEFAULT NULL COMMENT '单价',
  `total_price` decimal(12,2) DEFAULT NULL COMMENT '总价',
  `store_no` int DEFAULT NULL COMMENT '城配仓 编码',
  `status` tinyint DEFAULT NULL COMMENT '1 下单中 2 待支付 3 已支付 4已完成 5 已取消 6 已退款',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `after_sale_expiry_time` datetime DEFAULT NULL COMMENT '可申请售后过期时间',
  `order_type` tinyint NOT NULL DEFAULT '0' COMMENT '0-普通订单,1=组合订单',
  `delivery_quantity` int NOT NULL DEFAULT '0' COMMENT '已配数量(无仓订单有效)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_item_tenant_id` (`item_id`,`tenant_id`),
  KEY `index_tenant_id_order_id` (`tenant_id`,`order_id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=249746 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单详情表'
---
DDL for order_item_extra
CREATE TABLE `order_item_extra` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `order_item_id` bigint NOT NULL COMMENT '订单商品id',
  `customer_order_item_id` varchar(50) NOT NULL COMMENT '外部系统子订单号',
  `customer_sku_code` varchar(50) DEFAULT NULL COMMENT '外部系统货源skuCode',
  `customer_sku_title` varchar(128) DEFAULT NULL COMMENT '外部系统货源商品标题',
  `customer_sku_specification` varchar(128) DEFAULT NULL COMMENT '外部系统货源商品规格',
  `sku_code` varchar(50) DEFAULT NULL COMMENT '供应商货源skucode',
  PRIMARY KEY (`id`),
  KEY `idx_tenantid_orderid_order_item_id` (`tenant_id`,`order_id`,`order_item_id`),
  KEY `idx_tenantid_customer_order_item_id` (`tenant_id`,`customer_order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单子项外部扩展表'
---
DDL for order_item_fee_transaction
CREATE TABLE `order_item_fee_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `order_id` bigint NOT NULL COMMENT '订单编号',
  `order_item_id` bigint NOT NULL COMMENT 'itemId编码',
  `fee` decimal(12,2) NOT NULL COMMENT '明细费用',
  `fee_type` tinyint NOT NULL COMMENT '费用类型1.代仓费用',
  `transaction_type` tinyint NOT NULL COMMENT '0.支付，1.退款',
  `order_after_sale_id` bigint DEFAULT NULL COMMENT '售后单id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_order_item_id` (`order_item_id`),
  KEY `index_order_after_sale_id` (`order_after_sale_id`),
  KEY `index_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39673 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单项费用明细流水'
---
DDL for order_item_snapshot
CREATE TABLE `order_item_snapshot` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `order_item_id` bigint DEFAULT NULL COMMENT '订单商品id',
  `sku_id` bigint DEFAULT NULL COMMENT 'sku编码',
  `supplier_tenant_id` bigint DEFAULT NULL COMMENT '供应商Id',
  `supplier_sku_id` bigint DEFAULT NULL COMMENT '供应商skuId',
  `area_item_id` bigint DEFAULT NULL COMMENT '区域商品Id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '商品名称',
  `main_picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商品图片',
  `specification_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规格单位',
  `specification` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '规格',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `supply_price` decimal(11,2) DEFAULT NULL COMMENT '供应商报价',
  `warehouse_type` tinyint DEFAULT NULL COMMENT '已废弃',
  `delivery_type` tinyint DEFAULT NULL COMMENT '已废弃',
  `supplier_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商名称',
  `item_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品自有编码',
  `max_after_sale_amount` int DEFAULT '1' COMMENT '最大售后数量',
  `after_sale_unit` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '件' COMMENT '售后单位',
  `pricing_type` tinyint DEFAULT NULL COMMENT '定价方式0、百分比上浮 1、定额上浮 2、固定价',
  `pricing_number` decimal(11,2) DEFAULT '0.00' COMMENT '定价数值',
  `after_sale_rule` text COLLATE utf8mb4_general_ci COMMENT '售后规则快照',
  `goods_type` tinyint DEFAULT NULL COMMENT '商品类型 0无货商品 1报价货品 2自营货品',
  `item_sale_mode` tinyint NOT NULL DEFAULT '0' COMMENT '销售方式 0、可独售 1、搭售可凑单 2、搭售不可凑单',
  `order_id` bigint DEFAULT NULL COMMENT '订单编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_item` (`tenant_id`,`order_item_id`) USING BTREE,
  KEY `idx_title_tenant_id` (`title`(12),`tenant_id`),
  KEY `idx_order_item_id` (`order_item_id`),
  KEY `idx_order_item_id_sku_id` (`order_item_id`,`sku_id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=248779 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for order_self_lifting
CREATE TABLE `order_self_lifting` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `order_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '订单编号',
  `warehouse_no` int DEFAULT NULL COMMENT '仓库编号',
  `expect_time` datetime DEFAULT NULL COMMENT '预计自提时间',
  `actual_time` datetime DEFAULT NULL COMMENT '实际自提时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '自提地点',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_order_warehouse` (`order_no`,`warehouse_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=951 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订单自提表'
---
DDL for order_snapshot
CREATE TABLE `order_snapshot` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `order_quantity_rule` text COMMENT '订单起订规则',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_order_id` (`tenant_id`,`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单快照'
---
DDL for payment
CREATE TABLE `payment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `store_id` bigint DEFAULT NULL COMMENT '门店id',
  `account_id` bigint DEFAULT NULL COMMENT '门店账号id',
  `sp_appid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商户/服务商appid',
  `sp_mchid` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商户/服务商id',
  `sup_appid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '子商户appid',
  `sub_mchid` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '子商户id',
  `payment_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '支付单号',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '支付金额',
  `status` int DEFAULT NULL COMMENT '状态：0、待支付（对应汇付P） 1、支付成功(对应汇付S) 2、支付失败(对应汇付F) 3、取消支付 4、处理中 5、重复支付成功幂等状态',
  `prepay_id` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '微信预支付id/汇付支付信息',
  `transaction_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '交易流水号（请求流水号）',
  `trade_type` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '交易类型，枚举值：JSAPI：公众号支付NATIVE：扫码支付APP：APP支付MICROPAY：付款码支付MWEB：H5支付FACEPAY：刷脸支付。汇付字段:T_JSAPI: 微信公众号支付、T_MINIAPP: 微信小程序支付、A_JSAPI: 支付宝JS、A_NATIVE: 支付宝正扫、U_NATIVE: 银联正扫、U_JSAPI: 银联 JS、D_NATIVE: 数字人民币正扫 示例值：T_JSAPI\n、ZERO_PRICE: 无需支付',
  `trade_state` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '交易状态，枚举值：\nSUCCESS：支付成功\nREFUND：转入退款\nNOTPAY：未支付\nCLOSED：已关闭\nREVOKED：已撤销（付款码支付）\nUSERPAYING：用户支付中（付款码支付）\nPAYERROR：支付失败(其他原因，如银行返回失败)',
  `trade_state_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '交易状态描述',
  `bank_type` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '银行类型，采用字符串类型的银行标识',
  `sp_openid` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户在商户/服务商appid下的唯一标识',
  `sub_openid` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户在子商户appid下的唯一标识',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `success_time` datetime DEFAULT NULL COMMENT '支付成功时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `online_pay_channel` int DEFAULT NULL COMMENT '支付类型：0微信支付，1汇付支付',
  `fee_rate` decimal(10,2) DEFAULT NULL COMMENT '支付手续费率',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `payment_payment_no_uindex` (`payment_no`) USING BTREE,
  KEY `idx_tenant_store_account` (`tenant_id`,`store_id`,`account_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=70931 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='支付单'
---
DDL for payment_item
CREATE TABLE `payment_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `payment_id` bigint DEFAULT NULL COMMENT '支付单id',
  `order_id` bigint DEFAULT NULL COMMENT '订单id',
  `order_price` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_order` (`tenant_id`,`order_id`) USING BTREE,
  KEY `idx_tenant_payment` (`tenant_id`,`payment_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71839 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='支付单明细'
---
DDL for product_agent_application
CREATE TABLE `product_agent_application` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `title` varchar(20) DEFAULT NULL COMMENT '商品名称',
  `category_id` bigint DEFAULT NULL COMMENT '类目id',
  `storage_location` tinyint DEFAULT NULL COMMENT '储存区域 0、常温 1、冷藏 2、冷冻',
  `storage_temperature` varchar(20) DEFAULT NULL COMMENT '存储温度',
  `guarantee_period` int DEFAULT NULL COMMENT '保质期',
  `guarantee_unit` tinyint DEFAULT NULL COMMENT '0 天 1 月 2 年',
  `supplier_spu_id` bigint DEFAULT NULL COMMENT '供应商spuId',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COMMENT='代仓商品申请表'
---
DDL for product_agent_application_item
CREATE TABLE `product_agent_application_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `application_id` bigint DEFAULT NULL COMMENT '申请id',
  `specification` varchar(60) DEFAULT NULL COMMENT '规格名称',
  `specification_unit` varchar(10) DEFAULT NULL COMMENT '规格单位',
  `weight_num` decimal(10,2) DEFAULT NULL COMMENT '体重',
  `domestic_flag` tinyint DEFAULT NULL COMMENT '0 进口 1 国产',
  `status` tinyint DEFAULT NULL COMMENT '审核状态 0、审核中 1、审核通过 2、审核拒绝',
  `refuse_reason` varchar(255) DEFAULT NULL COMMENT '拒绝原因',
  `supplier_sku_id` bigint DEFAULT NULL COMMENT '供应商skuId',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `volume` varchar(255) DEFAULT NULL COMMENT '体积',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_application_id` (`tenant_id`,`application_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3 COMMENT='代仓商品申请item表'
---
DDL for product_agent_application_record
CREATE TABLE `product_agent_application_record` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `tenant_id` bigint DEFAULT NULL COMMENT '品牌方Id',
  `agent_tenant_id` bigint DEFAULT NULL COMMENT '代理租户Id',
  `sku_id` bigint DEFAULT NULL COMMENT '货品Id',
  `status` tinyint DEFAULT '0' COMMENT '审核状态 0审核中 1通过 2拒绝',
  `audit_remark` varchar(1024) DEFAULT NULL COMMENT '审核备注',
  PRIMARY KEY (`id`),
  KEY `index_tenant_id_sku_id` (`tenant_id`,`sku_id`),
  KEY `index_agent_tenant_id` (`agent_tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5959 DEFAULT CHARSET=utf8mb3 COMMENT='货品代仓服务申请记录'
---
DDL for product_agent_sku_fee_rule
CREATE TABLE `product_agent_sku_fee_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `type` tinyint DEFAULT NULL COMMENT '规则类型0按比例1按件数',
  `rule` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci COMMENT '规则',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `automatic_increase_price_flag` tinyint DEFAULT '0' COMMENT '自动加价标识 0 关闭 1 开启',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=544 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代仓商品收费规则'
---
DDL for product_agent_sku_mapping
CREATE TABLE `product_agent_sku_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `sku_id` bigint DEFAULT NULL COMMENT 'skuId',
  `agent_sku_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代理skucode',
  `agent_tenant_id` bigint DEFAULT NULL COMMENT '代理供应商租户Id',
  `agent_sku_id` bigint DEFAULT NULL COMMENT '代理skuId',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `spu_id` bigint DEFAULT NULL COMMENT 'spuId',
  `agent_spu_id` bigint DEFAULT NULL COMMENT '代理spuId',
  `agent_spu_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代理spu编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_agent_tenant_id_agent_sku_id` (`agent_tenant_id`,`agent_sku_id`,`tenant_id`),
  KEY `index_tenant_id_sku_id` (`tenant_id`,`sku_id`),
  KEY `idx_sku_id` (`sku_id`),
  KEY `idx_sku_id_agent_tenant_id` (`sku_id`,`agent_tenant_id`),
  KEY `idx_agent_sku_code` (`agent_sku_code`)
) ENGINE=InnoDB AUTO_INCREMENT=23854 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代仓商品映射表'
---
DDL for product_agent_warehouse
CREATE TABLE `product_agent_warehouse` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `warehouse_id` bigint DEFAULT NULL COMMENT '仓库Id',
  `warehouse_name` varchar(100) DEFAULT NULL COMMENT '仓库名称',
  `status` tinyint DEFAULT NULL COMMENT '状态0使用1未使用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8mb3 COMMENT='品牌方代仓品使用仓'
---
DDL for product_city_stock
CREATE TABLE `product_city_stock` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `sku_id` bigint NOT NULL COMMENT 'saas侧skuId',
  `city_id` bigint NOT NULL COMMENT '城市id',
  `quantity` bigint NOT NULL COMMENT '城市库存数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_city_id_sku_id` (`city_id`,`sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2311 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鲜沐报价货品城市库存同步表'
---
DDL for product_pricing_supply
CREATE TABLE `product_pricing_supply` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `associated` bigint DEFAULT '0' COMMENT '是否关联商品 ',
  `sku_id` bigint DEFAULT NULL COMMENT 'sku id',
  `supply_sku_id` bigint DEFAULT NULL COMMENT '供应SKU id',
  `supply_tenant_id` bigint DEFAULT NULL COMMENT '供应商tenantId',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_tenant_sku_id` (`tenant_id`,`supply_sku_id`),
  KEY `idx_supply_tenant_sku_id` (`supply_tenant_id`,`supply_sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='价格供应表'
---
DDL for product_pricing_supply_bak
CREATE TABLE `product_pricing_supply_bak` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `sku_id` bigint DEFAULT NULL COMMENT 'sku id',
  `supply_sku_id` bigint DEFAULT NULL COMMENT '供应SKU id',
  `supply_tenant_id` bigint DEFAULT NULL COMMENT '供应商tenantId',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `type` tinyint DEFAULT NULL COMMENT '报价方式 0、指定价',
  `supply_type` int DEFAULT NULL COMMENT '0、成本供价 1、报价单供价',
  `start_time` datetime DEFAULT NULL COMMENT '创建时间',
  `end_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint DEFAULT '0' COMMENT '删除标记 0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_sku_id` (`tenant_id`,`sku_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='价格供应表备份'
---
DDL for product_pricing_supply_city_mapping
CREATE TABLE `product_pricing_supply_city_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `product_pricing_supply_id` bigint DEFAULT NULL COMMENT '报价单主键Id',
  `city_id` bigint DEFAULT NULL COMMENT '城市Id',
  `type` tinyint DEFAULT NULL COMMENT '报价方式 0、指定价  1,随鲜沐商城价',
  `supply_type` tinyint DEFAULT NULL COMMENT '0、成本供价 1、报价单供价',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `start_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '生效开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '生效结束时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `deleted` tinyint DEFAULT '0' COMMENT '删除标记 0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_product_pricing_supply_id_city_id` (`product_pricing_supply_id`,`city_id`),
  KEY `idx_supply_id_city_id_start_end_time` (`product_pricing_supply_id`,`start_time`,`end_time`,`supply_type`,`city_id`) USING BTREE,
  KEY `idx_supply_id_start_end_time` (`product_pricing_supply_id`,`start_time`,`end_time`,`supply_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2035485 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='城市报价'
---
DDL for product_sku
CREATE TABLE `product_sku` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `spu_id` bigint NOT NULL COMMENT 'spu id',
  `sku` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'sku编码',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核备注',
  `agent_type` tinyint DEFAULT '0' COMMENT '只作为鲜沐供应商货品判断 0自营 1代仓',
  `approve_status` tinyint DEFAULT '1' COMMENT '0待审核1已通过2已拒绝\n',
  `place_type` tinyint DEFAULT NULL COMMENT '地点类型0进口1国产',
  `volume_unit` bigint DEFAULT NULL COMMENT '体积单位',
  `volume` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '体积',
  `specification` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '规格',
  `associated` tinyint NOT NULL DEFAULT '0' COMMENT '是否关联商品只适用于代仓品',
  `weight_notes` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '重量备注',
  `weight` double DEFAULT NULL COMMENT '重量',
  `amount` bigint DEFAULT NULL COMMENT '库存数量',
  `approve_time` datetime DEFAULT NULL COMMENT '审批时间',
  `commit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `specification_unit` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '规格单位',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tax_rate_value` decimal(10,4) DEFAULT NULL COMMENT '税率',
  `custom_sku_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '自有编码',
  `use_flag` tinyint DEFAULT '1' COMMENT '停用状态 0停用1启用',
  `create_type` int DEFAULT NULL COMMENT '上新类型：0、平台 1、大客户 2、saas自营&代仓 3、仅saas自营',
  `sku_picture` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku图片',
  `sku_title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sku实物名称',
  `owner_id` int DEFAULT NULL COMMENT '所属客户ID（admin#id）',
  `sub_agent_type` tinyint DEFAULT NULL COMMENT '货品二级性质(自营/代仓)，1 自营-代销不入仓、2 自营-代销入仓、3 自营-经销、4 代仓-经销',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_spu_id` (`tenant_id`,`spu_id`) USING BTREE,
  KEY `idx_sku` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=27219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for product_sku_dimension_stock
CREATE TABLE `product_sku_dimension_stock` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `sku_id` bigint DEFAULT NULL COMMENT 'skuId',
  `quantity` int DEFAULT NULL COMMENT '库存数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sku_id` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='sku维度的库存表'
---
DDL for product_spu
CREATE TABLE `product_spu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `category_id` bigint DEFAULT NULL COMMENT '类目id',
  `brand_id` bigint DEFAULT NULL COMMENT '品牌id',
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '主标题',
  `sub_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '副标题',
  `main_picture` varchar(1255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '主图',
  `detail_picture` varchar(1255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '详情图',
  `storage_location` tinyint DEFAULT NULL COMMENT '储存区域 0、常温 1、冷藏 2、冷冻',
  `storage_temperature` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '存储温度',
  `guarantee_period` int DEFAULT NULL COMMENT '保质期',
  `guarantee_unit` tinyint DEFAULT NULL COMMENT '0 天 1 月 2 年',
  `agent_type` tinyint DEFAULT '0' COMMENT '已废弃',
  `origin` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '产地',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `brand_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品牌名称',
  `custom_spu_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'spu自由编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品spu表'
---
DDL for refund
CREATE TABLE `refund` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `after_sale_id` bigint DEFAULT NULL COMMENT '售后id',
  `refund_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '退款单号',
  `refund_status` int DEFAULT NULL COMMENT '状态：1、退款中 2、退款成功 3、退款失败 , 100 待退款  200 待交易确认退款 201 交易确认退款中',
  `sub_mchid` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '子商户号',
  `refund_price` decimal(10,2) DEFAULT NULL COMMENT '退款金额',
  `payment_price` decimal(10,2) DEFAULT NULL COMMENT '原支付金额',
  `refund_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '微信支付退款单号',
  `channel` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '退款渠道：\nORIGINAL：原路退款\nBALANCE：退回到余额\nOTHER_BALANCE：原账户异常退到其他余额账户\nOTHER_BANKCARD：原银行卡异常退到其他银行卡',
  `user_received_account` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '退款入账账户',
  `success_time` datetime DEFAULT NULL COMMENT '退款成功时间',
  `status` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '退款状态\nSUCCESS：退款成功\nCLOSED：退款关闭\nPROCESSING：退款处理中\nABNORMAL：退款异常',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `retry_num` int DEFAULT '0' COMMENT '重试次数',
  `req_seq_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '汇付请求退款流水号唯一标识',
  `confirm_refund_req_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '交易确认退款流水号唯一标识',
  `payment_id` bigint DEFAULT NULL COMMENT '支付单id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `refund_refund_no_uindex` (`refund_no`) USING BTREE,
  KEY `idx_tenant_after` (`tenant_id`,`after_sale_id`) USING BTREE,
  KEY `idx_create_status_retry_num` (`create_time`,`status`,`retry_num`),
  KEY `idx_createtime_refundstatus_retrynum` (`create_time`,`refund_status`,`retry_num`)
) ENGINE=InnoDB AUTO_INCREMENT=166289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='退款表'
---
DDL for refund_acct_split_detail
CREATE TABLE `refund_acct_split_detail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '分账租户id',
  `acct_split_tenant_id` bigint DEFAULT NULL COMMENT '账号Id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `div_amt` varchar(8) DEFAULT NULL COMMENT '分账金额',
  `refund_id` varchar(64) DEFAULT NULL COMMENT '退款id',
  `huifu_id` varchar(200) DEFAULT NULL COMMENT '汇付id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=581 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='退款分账明细表'
---
DDL for refund_log
CREATE TABLE `refund_log` (
  `id` bigint NOT NULL COMMENT '主键id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `refund_id` bigint DEFAULT NULL COMMENT '退款Id',
  `after_sale_id` bigint DEFAULT NULL COMMENT '售后单Id',
  `req_seq_id` bigint DEFAULT NULL COMMENT '请求流水Id',
  `request_body` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求body',
  `response_body` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '返回body',
  `status` tinyint DEFAULT NULL COMMENT '状态 0处理中 1成功 2失败',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for regional_organization
CREATE TABLE `regional_organization` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `phone` varchar(50) DEFAULT NULL COMMENT '手机号',
  `organization_name` varchar(50) DEFAULT NULL COMMENT '组织名称',
  `source` int DEFAULT NULL COMMENT '组织来源：0-saas,1-鲜沐',
  `size` int DEFAULT NULL COMMENT '客户类型：1-大客户，2-单店',
  `status` int DEFAULT NULL COMMENT '组织状态： 0正常 1禁用',
  `admin_id` bigint DEFAULT NULL COMMENT '鲜沐大客户id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `updater` varchar(50) DEFAULT NULL COMMENT '操作人名称',
  PRIMARY KEY (`id`),
  KEY `idx_adminid_tenantid` (`admin_id`,`tenant_id`),
  KEY `idx_phone` (`phone`),
  KEY `idx_tenantid` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=138394 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='区域组织表'
---
DDL for sms_scene
CREATE TABLE `sms_scene` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `template_id` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '模板ID',
  `title` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '场景标题',
  `platform` tinyint NOT NULL COMMENT '0、本地 1、创蓝',
  `template` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '模板',
  `scene_id` bigint DEFAULT NULL COMMENT '场景id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_scene_id` (`scene_id`,`platform`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='发送短信场景表 包括发送短信的模板 模板id 平台'
---
DDL for stock
CREATE TABLE `stock` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `sku_id` bigint DEFAULT NULL COMMENT 'skuId',
  `amount` int unsigned NOT NULL DEFAULT '0' COMMENT '库存',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `item_id` bigint DEFAULT NULL COMMENT 'item主键Id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_sku` (`tenant_id`,`sku_id`) USING BTREE,
  KEY `idx_itemid` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='库存表'
---
DDL for stock_record
CREATE TABLE `stock_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `stock_sku_id` bigint DEFAULT NULL COMMENT 'stock sku id',
  `type` int DEFAULT NULL COMMENT '记录类型：0、下单 1、取消订单 2、售后 3、手动调整 4、自营更换三方 5、三方更换自营 6、新建商品',
  `before_amount` int DEFAULT NULL COMMENT '变更前数量',
  `change_amount` int DEFAULT NULL COMMENT '变更数量',
  `after_amount` int DEFAULT NULL COMMENT '变更后数量',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `record_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '记录编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_stock` (`tenant_id`,`stock_sku_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1717135997047898120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='库存变动记录'
---
DDL for supplier_delivery_info
CREATE TABLE `supplier_delivery_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `order_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '订单编号',
  `supplier_delivery_fee` decimal(10,2) DEFAULT NULL COMMENT '供应商收取运费',
  `supplier_delivery_fee_rule` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '供应商收取运费规则',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `type` tinyint DEFAULT NULL COMMENT '0、跟随供应商 1、免运费',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7584 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='供应商配送信息'
---
DDL for sync_log
CREATE TABLE `sync_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint NOT NULL COMMENT '租户编号',
  `type` tinyint(1) NOT NULL COMMENT '数据类型 0-订单;1-退款单;2-配送单',
  `doc_id` bigint NOT NULL COMMENT '数据id',
  `ext_sys_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '外部平台表单id',
  `ext_sys_type` tinyint(1) NOT NULL COMMENT '外部平台类型,1-金蝶',
  `req` varchar(5000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '请求报文',
  `resp` varchar(5000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '响应报文',
  `url` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '请求地址',
  `op_type` tinyint(1) NOT NULL COMMENT '操作类型 0-新增;1-提交;2-审核;3-取消;4下推',
  `status` tinyint(1) DEFAULT NULL COMMENT '0失败;1成功',
  `retry_flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否需要重试 0不需要;1-需要',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `error_message` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '错误原因',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=598 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='同步记录表'
---
DDL for sync_mapping
CREATE TABLE `sync_mapping` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint NOT NULL COMMENT '租户编号',
  `doc_type` tinyint(1) NOT NULL COMMENT '表单类型 0-门店;1-sku',
  `ext_sys_type` tinyint(1) NOT NULL COMMENT '外部平台类型,1-金蝶',
  `description` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述',
  `doc_id` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '内部表单id',
  `ext_sys_id` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '外部平台表单id',
  `extra_info` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其他外部信息字段',
  `op_uid` bigint DEFAULT NULL COMMENT '操作人id',
  `op_uname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作人名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='外部id映射表'
---
DDL for system_admin
CREATE TABLE `system_admin` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '账号名称',
  `phone` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '登录手机号',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '登录密码',
  `status` int DEFAULT '1' COMMENT '账号状态：0、失效 1、有效',
  `delete_flag` tinyint unsigned DEFAULT NULL COMMENT '删除标识：0、未删除 1、已删除',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `sys_admin_phone_uindex` (`phone`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统管理员'
---
DDL for system_admin_role
CREATE TABLE `system_admin_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `admin_id` bigint DEFAULT NULL COMMENT '管理员id',
  `role_id` bigint DEFAULT NULL COMMENT '角色id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_admin_role` (`admin_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户角色表'
---
DDL for system_menu
CREATE TABLE `system_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `parent_id` bigint DEFAULT NULL COMMENT '父级菜单id',
  `type` int DEFAULT NULL COMMENT '权限类型：0、菜单 1、按钮',
  `route_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '前端路由地址',
  `icon_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '图标',
  `sort` int DEFAULT NULL COMMENT '排序值：从小到大',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_parent_type` (`parent_id`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统权限'
---
DDL for system_parameters
CREATE TABLE `system_parameters` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `param_key` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '参数key',
  `param_value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '参数value',
  `description` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '描述',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `account_id` bigint DEFAULT NULL COMMENT '账户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_key_account` (`param_key`,`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for system_permission
CREATE TABLE `system_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `module` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '模块',
  `feature` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '功能',
  `permission_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '权限路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限'
---
DDL for system_role
CREATE TABLE `system_role` (
  `id` bigint DEFAULT NULL COMMENT '主键、自增',
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '角色名',
  `delete_flag` tinyint unsigned DEFAULT '1' COMMENT '删除标识：0、未删除 1、已删除',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  UNIQUE KEY `sys_role_name_uindex` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色表'
---
DDL for system_role_menu
CREATE TABLE `system_role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `role_id` bigint DEFAULT NULL COMMENT '角色id',
  `menu_id` bigint DEFAULT NULL COMMENT '菜单id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_role_menu` (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色菜单表'
---
DDL for system_role_permission
CREATE TABLE `system_role_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `role_id` bigint DEFAULT NULL COMMENT '角色id',
  `permission_id` bigint DEFAULT NULL COMMENT '权限id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_role_menu` (`role_id`,`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色菜单表'
---
DDL for system_wechant_tp_info
CREATE TABLE `system_wechant_tp_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tp_app_id` varchar(255) DEFAULT NULL COMMENT '微信三方平台appId',
  `tp_app_secret` varchar(255) DEFAULT NULL COMMENT '微信三方平台appsecret',
  `tp_token` varchar(255) DEFAULT NULL COMMENT '微信三方平台解密token',
  `tp_encoding_aes_key` varchar(255) DEFAULT NULL COMMENT '微信三方平台解密key',
  `base_url` varchar(50) DEFAULT NULL COMMENT '微信三方基础域名',
  `tp_app_ticket` varchar(255) DEFAULT NULL COMMENT '第三方token获取票据',
  `tp_access_token_json` varchar(255) DEFAULT NULL COMMENT '第三方accessToken',
  `lite_request_download_domain` varchar(255) DEFAULT NULL COMMENT 'downloadFile合法域名',
  `lite_request_request_domain` varchar(255) DEFAULT NULL COMMENT 'request合法域名',
  `lite_request_socket_domain` varchar(255) DEFAULT NULL COMMENT 'socket合法域名',
  `lite_request_upload_domain` varchar(255) DEFAULT NULL COMMENT 'uploadFile合法域名',
  `lite_webview_web_view_domain` varchar(255) DEFAULT NULL COMMENT '业务域名',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='微信三方平台信息'
---
DDL for t_op_log
CREATE TABLE `t_op_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作实体主键',
  `entity_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '操作实体名称',
  `op_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '操作类型编码',
  `op_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '操作类型描述',
  `op_uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作用户id',
  `op_uname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作用户名称',
  `op_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `op_remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作备注',
  `m_id` bigint DEFAULT NULL COMMENT '商户Id',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `tenant_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '租户名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `inx_eid_ename` (`entity_id`,`entity_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for temp_test12
CREATE TABLE `temp_test12` (
  `id` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `title` varchar(100) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '主标题',
  `sub_title` varchar(100) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '副标题',
  `category_id` bigint DEFAULT NULL COMMENT '类目Id',
  `main_picture` varchar(1255) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '主图',
  `detail_picture` varchar(1255) CHARACTER SET utf8mb3 DEFAULT NULL COMMENT '详情图',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `delete_flag` tinyint DEFAULT '1' COMMENT '0、已删除 1、正在使用'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for temp_test123
CREATE TABLE `temp_test123` (
  `id` bigint NOT NULL DEFAULT '0' COMMENT '主键id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `sku_id` bigint DEFAULT NULL COMMENT 'sku主键',
  `title` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `sub_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '副标题',
  `origin` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '产地',
  `main_picture` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '图片',
  `detail_picture` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '详情图',
  `specification` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '规格',
  `specification_unit` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '规格单位',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `market_id` bigint DEFAULT NULL COMMENT '主键Id',
  `brand_id` bigint DEFAULT NULL COMMENT '品牌Id',
  `brand_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品牌名称',
  `supplier_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商名称',
  `item_code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '自有编码',
  `weight_notes` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规格备注（区间）',
  `supplier_id` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商Id',
  `max_after_sale_amount` int DEFAULT '1' COMMENT '最大售后数',
  `after_sale_unit` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '件' COMMENT '售后单位',
  `delete_flag` tinyint DEFAULT '1' COMMENT '删除标识 0、已删除 1、正在使用'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for tenant
CREATE TABLE `tenant` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `phone` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '手机号',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '密码',
  `tenant_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '租户名称',
  `type` int DEFAULT NULL COMMENT '租户类型：0供应商1品牌方2帆台',
  `status` int DEFAULT NULL COMMENT '租户状态：0、禁用 1、启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `belong_DB` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '归属DB',
  `admin_id` bigint DEFAULT NULL COMMENT '大客户ID',
  `op_uid` bigint DEFAULT NULL COMMENT '操作人id',
  `op_uname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作人名称',
  `operator` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作人',
  `profit_sharing_switch` tinyint DEFAULT '0' COMMENT '分账开关0关闭1开启',
  `online_pay_channel` tinyint DEFAULT '1' COMMENT '0 微信 1 汇付',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_phone` (`phone`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24592 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户信息表'
---
DDL for tenant_account
CREATE TABLE `tenant_account` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `auth_user_id` bigint NOT NULL COMMENT '外部用户系统用户id',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `profile_picture` varchar(255) DEFAULT NULL COMMENT '头像',
  `status` tinyint DEFAULT NULL COMMENT '状态0有效1失效',
  `operator_time` datetime DEFAULT NULL COMMENT '操作时间',
  `operator_phone` varchar(20) DEFAULT NULL COMMENT '操作手机号',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `deleted_flag` tinyint NOT NULL DEFAULT '0' COMMENT '删除标识0有效1删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tenant_id_phone` (`tenant_id`,`phone`),
  UNIQUE KEY `index_auth_user_id` (`auth_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11779 DEFAULT CHARSET=utf8mb3 COMMENT='租户账号'
---
DDL for tenant_account_bussiness_msg_config
CREATE TABLE `tenant_account_bussiness_msg_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `bussiness_type` tinyint NOT NULL DEFAULT '1' COMMENT '1=付款后消息提醒;2=退款后消息提醒;3=待发货消息汇总提醒',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `tenant_account_id` bigint NOT NULL COMMENT '租户accoountId',
  `available_status` tinyint NOT NULL DEFAULT '1' COMMENT '是否可接收0=可;1=不可',
  `push_hour` tinyint DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_account_id` (`tenant_id`,`tenant_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=776 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户业务消息配置表'
---
DDL for tenant_account_receive_msg_switch
CREATE TABLE `tenant_account_receive_msg_switch` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `channel_type` tinyint NOT NULL COMMENT '4-微信公众号',
  `channel_code` varchar(24) NOT NULL COMMENT 'FTGYL-帆台供应链;',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `tenant_account_id` bigint NOT NULL COMMENT '租户accoountId',
  `available_status` tinyint NOT NULL DEFAULT '1' COMMENT '是否可接收0=可;1=不可',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_account_id` (`tenant_id`,`tenant_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户接受消息开关表'
---
DDL for tenant_account_supplier_mapping
CREATE TABLE `tenant_account_supplier_mapping` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `account_id` bigint DEFAULT NULL COMMENT '账号id',
  `supplier_id` bigint DEFAULT NULL COMMENT '供应商id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户账号供应商映射表'
---
DDL for tenant_agreement
CREATE TABLE `tenant_agreement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint DEFAULT NULL COMMENT '0、门店注册-品牌方隐私声明 1、门店注册-隐私声明 2、门店注册-用户协议 3、品牌注册-隐私声明 4、品牌注册-用户协议',
  `agreement` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` int DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for tenant_auth_connection
CREATE TABLE `tenant_auth_connection` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `app_id` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权人APPID',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `status` int DEFAULT '1' COMMENT '1-正常',
  `account_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '账号类型',
  `pay_mchid` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '直连支付商户号',
  `pay_secret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '支付秘钥',
  `pay_cert_path` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '证书路径',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `huifu_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '汇付商户号',
  `secret_key` varchar(1255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '汇付支付私钥',
  `public_key` varchar(1255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付公钥',
  `huifu_public_key` varchar(1255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '汇付公钥',
  `sync_time` datetime DEFAULT NULL COMMENT '上次同步结算信息时间',
  `oa_app_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '公众号appId',
  `oa_app_secret` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '公众号appSecret',
  `create_template_status` tinyint DEFAULT '2' COMMENT '创建模版状态,1:待发起创建;2:已发起创建',
  `wechat_direct_switch` tinyint NOT NULL DEFAULT '1' COMMENT '微信直连开关 0、关闭 1、开启',
  `wechat_indirect_switch` tinyint NOT NULL DEFAULT '1' COMMENT '微信间连开关 0、关闭 1、开启',
  `wechat_indirect_sharing_switch` tinyint NOT NULL DEFAULT '1' COMMENT '微信间连分账开关 0、关闭 1、开启',
  `ali_indirect_switch` tinyint NOT NULL DEFAULT '0' COMMENT '支付宝间连开关 0、关闭 1、开启',
  `ali_indirect_sharing_switch` tinyint NOT NULL DEFAULT '0' COMMENT '支付宝间连分账开关 0、关闭 1、开启',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_app` (`tenant_id`,`app_id`) USING BTREE,
  KEY `idx_app` (`app_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for tenant_bill
CREATE TABLE `tenant_bill` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `store_id` bigint DEFAULT NULL COMMENT '门店id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `bill_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '账单编号',
  `bill_price` decimal(10,2) DEFAULT NULL COMMENT '账单金额',
  `type` int DEFAULT NULL COMMENT '类型：0、收入 1、支出',
  `record_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '订单编号、售后单编号',
  `payment_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付类型1、在线支付2、账期 3、余额',
  `online_pay_channel` int DEFAULT NULL COMMENT '支付渠道 0、微信 1、汇付',
  `fee_amount` decimal(10,2) DEFAULT NULL COMMENT '手续费',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_store` (`tenant_id`,`store_id`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27789 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户收支明细'
---
DDL for tenant_bill_copy
CREATE TABLE `tenant_bill_copy` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `store_id` bigint DEFAULT NULL COMMENT '门店id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_date` date GENERATED ALWAYS AS (cast(`create_time` as date)) STORED COMMENT '创建时间日期，来自create_time字段',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `bill_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '账单编号',
  `bill_price` decimal(10,2) DEFAULT NULL COMMENT '账单金额',
  `type` int DEFAULT NULL COMMENT '类型：0、收入 1、支出',
  `record_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '订单编号、售后单编号',
  `payment_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '支付类型1、在线支付2、账期 3、余额',
  `online_pay_channel` int DEFAULT NULL COMMENT '支付渠道 0、微信 1、汇付',
  `fee_amount` decimal(10,2) DEFAULT NULL COMMENT '手续费',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_store` (`tenant_id`,`create_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户收支明细复制'
---
DDL for tenant_common_config
CREATE TABLE `tenant_common_config` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `config_key` varchar(128) DEFAULT NULL COMMENT '配置名称',
  `config_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '配置值',
  `config_desc` varchar(128) DEFAULT NULL COMMENT '配置描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tenant_id_config_key` (`tenant_id`,`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=658 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户公共配置表'
---
DDL for tenant_company
CREATE TABLE `tenant_company` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `company_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公司名称',
  `credit_code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '信用代码',
  `province` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '市',
  `area` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '区',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '联系地址',
  `phone` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '公司联系手机号',
  `business_license` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '营业执照',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `reg_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '汇付商户名称',
  `huifu_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '汇付商户Id',
  `settle_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '0对公1对私',
  `opening_bank` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '开户行',
  `account_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '户名',
  `account_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '户号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1041 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户公司表'
---
DDL for tenant_company_account
CREATE TABLE `tenant_company_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `supplier_tenant_id` bigint NOT NULL COMMENT '供应商id',
  `opening_bank` varchar(255) NOT NULL COMMENT '开户行',
  `account_name` varchar(255) NOT NULL COMMENT '户名',
  `account_number` varchar(255) NOT NULL COMMENT '户号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tenant` (`tenant_id`),
  KEY `idx_supplier` (`supplier_tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='供应商对品牌收款账户'
---
DDL for tenant_delivery_fee_area
CREATE TABLE `tenant_delivery_fee_area` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint DEFAULT NULL COMMENT '品牌方Id',
  `rule_id` bigint DEFAULT NULL COMMENT '默认运费规则Id',
  `province` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '省',
  `city` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '市',
  `area` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区',
  `default_price` decimal(10,2) DEFAULT NULL COMMENT '运费金额',
  `rule` text COLLATE utf8mb4_general_ci COMMENT '规则[{"categoryId":1,"type":0,"free_price":10}]',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `group_id` int DEFAULT NULL COMMENT '分组Id',
  PRIMARY KEY (`id`),
  KEY `index_tenant_id_province_city_area` (`tenant_id`,`province`,`city`,`area`)
) ENGINE=InnoDB AUTO_INCREMENT=7363 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for tenant_delivery_fee_rule
CREATE TABLE `tenant_delivery_fee_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `type` tinyint DEFAULT NULL COMMENT '0、采用鲜沐运费 1、免运费 2、自定义',
  `default_price` decimal(10,2) DEFAULT NULL COMMENT '默认运费',
  `free_number` decimal(10,2) DEFAULT NULL COMMENT '满减',
  `free_type` tinyint DEFAULT NULL COMMENT '满减类型：0按金额 1按件数',
  `operator` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='品牌运费规则表'
---
DDL for tenant_ext_sys_config
CREATE TABLE `tenant_ext_sys_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint NOT NULL COMMENT '租户编号',
  `ext_sys_type` tinyint(1) DEFAULT NULL COMMENT '外部平台类型,0-金蝶',
  `url` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'url',
  `acct_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '账套',
  `app_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'AppID',
  `app_sec` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'AppSec',
  `user_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '用户名',
  `pwd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '密码',
  `op_uid` bigint DEFAULT NULL COMMENT '操作人id',
  `op_uname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作人名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户三方同步系统属性配置表'
---
DDL for tenant_guide_info
CREATE TABLE `tenant_guide_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `step_num` tinyint DEFAULT NULL COMMENT '引导问题步骤 1-第一步，2-第二步，3-第三步',
  `title` varchar(256) DEFAULT NULL COMMENT '引导问题标题',
  `select_item_ids` varchar(128) DEFAULT NULL COMMENT '问题已选ids',
  `select_item` text COMMENT '问题已选json，step_num=3保存建议反馈',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_phone_step_num` (`phone`,`step_num`)
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='登录引导信息收集表'
---
DDL for tenant_pay_config_log
CREATE TABLE `tenant_pay_config_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户Id',
  `pay_mchid` varchar(100) DEFAULT NULL COMMENT '直连支付商户号',
  `pay_secret` varchar(255) DEFAULT NULL COMMENT '支付密钥',
  `pay_cert_path` varchar(255) DEFAULT NULL COMMENT '证书路径',
  `huifu_id` varchar(32) DEFAULT NULL COMMENT '汇付商户号',
  `secret_key` varchar(1255) DEFAULT NULL COMMENT '汇付支付私钥',
  `public_key` varchar(1255) DEFAULT NULL COMMENT '支付公钥',
  `huifu_public_key` varchar(1255) DEFAULT NULL COMMENT '汇付公钥',
  `tenant_account_id` bigint DEFAULT NULL COMMENT '操作人Id',
  PRIMARY KEY (`id`),
  KEY `index_tenant_id` (`tenant_id`),
  KEY `index_huifu_id` (`huifu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户支付配置变更日志表'
---
DDL for tenant_prepayment_account
CREATE TABLE `tenant_prepayment_account` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `supplier_tenant_id` bigint NOT NULL COMMENT '供应商租户id',
  `payable_target` tinyint NOT NULL COMMENT '0、供应商直供 1、代仓费用 2、供应商直供和代仓费用',
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '全部预付金额',
  `frozen_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '冻结金额',
  `available_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '可用金额',
  `last_change_time` datetime DEFAULT NULL COMMENT '最近变动时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tenant_supplier_type` (`tenant_id`,`supplier_tenant_id`,`payable_target`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_supplier_tenant_id` (`supplier_tenant_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='预付账户表'
---
DDL for tenant_prepayment_daily_snapshot
CREATE TABLE `tenant_prepayment_daily_snapshot` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `total_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '预付金额/预收金额',
  `time_tag` date NOT NULL COMMENT '时间 yyyy-MM-dd',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2250 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='预付每日预付快照'
---
DDL for tenant_prepayment_record
CREATE TABLE `tenant_prepayment_record` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `supplier_tenant_id` bigint NOT NULL COMMENT '供应商id',
  `transaction_amount` decimal(10,2) NOT NULL COMMENT '预收/预付金额',
  `payable_target` tinyint NOT NULL COMMENT '0、供应商直供 1、代仓费用 2、供应商直供和代仓费用',
  `audit_status` tinyint NOT NULL DEFAULT '0' COMMENT '0、待审核 1、审核通过 2、 审核失败',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `proof` varchar(2048) DEFAULT NULL COMMENT '凭证',
  `remark` varchar(2048) DEFAULT NULL COMMENT '备注',
  `creator_id` bigint DEFAULT NULL COMMENT '创建人id',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_remark` varchar(2048) DEFAULT NULL COMMENT '审核备注',
  `auditor_id` bigint DEFAULT NULL COMMENT '审核人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `transaction_type` tinyint NOT NULL COMMENT '交易类型 0、预付 1、预收',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_supplier_tenant_id` (`supplier_tenant_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1711295988063121409 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='预付记录表'
---
DDL for tenant_prepayment_transaction
CREATE TABLE `tenant_prepayment_transaction` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `supplier_tenant_id` bigint NOT NULL COMMENT '供应商租户id',
  `transaction_no` varchar(50) NOT NULL COMMENT '交易流水号',
  `type` tinyint NOT NULL COMMENT '收支类型 0、收入 1、支出',
  `transaction_type` tinyint NOT NULL COMMENT '交易类型 0、预付 1、预付退款 2、直供货品消费 3、直供货品退款 4、运费 5、运费退款 6、代仓费用 7、代仓费用退款',
  `transaction_amount` decimal(10,2) NOT NULL COMMENT '交易预付金额',
  `associated_order_no` varchar(50) DEFAULT NULL COMMENT '关联订单单号/售后单号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_supplier_tenant_id` (`supplier_tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`,`associated_order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=9040 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='预付交易明细表'
---
DDL for tenant_prepayment_transaction_item
CREATE TABLE `tenant_prepayment_transaction_item` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `order_item_id` bigint DEFAULT NULL COMMENT '订单明细id',
  `prepayment_account_id` bigint NOT NULL COMMENT '预付账户id',
  `transaction_type` tinyint NOT NULL COMMENT '交易类型 0、预付 1、预付退款 2、直供货品消费 3、直供货品退款 4、运费 5、运费退款 6、代仓费用 7、代仓费用退款',
  `transaction_amount` decimal(10,2) NOT NULL COMMENT '交易金额',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_order_id` (`tenant_id`,`order_id`),
  KEY `idx_tenant_order_item_id` (`tenant_id`,`order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7937 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='预付交易明细表'
---
DDL for tenant_return_address
CREATE TABLE `tenant_return_address` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(50) DEFAULT NULL COMMENT '市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `house_no` varchar(255) DEFAULT NULL COMMENT '门牌号',
  `poi_note` varchar(255) DEFAULT NULL COMMENT '地图坐标',
  `default_flag` int DEFAULT NULL COMMENT '是否是默认地址：0、否 1、是',
  `delete_flag` tinyint NOT NULL DEFAULT '1' COMMENT '0 已删除 1 正常使用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `contact_name` varchar(100) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(50) DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户售后退货地址信息'
---
DDL for tenant_switch
CREATE TABLE `tenant_switch` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `tenant_id` bigint NOT NULL COMMENT '租户编号',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态 0关 1开',
  `type` tinyint(1) NOT NULL COMMENT '类型 同步金蝶开关0,可配置外部字段映射1',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '开关名称',
  `op_uid` bigint DEFAULT NULL COMMENT '操作人id',
  `op_uname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '操作人名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户开关表'
---
DDL for tenant_template_init
CREATE TABLE `tenant_template_init` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `tenant_id` bigint NOT NULL DEFAULT '0' COMMENT '租户id',
  `create_template_status` int NOT NULL DEFAULT '1' COMMENT '创建模版状态,1:待发起创建;2:已发起创建',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_create_status` (`create_time`,`create_template_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=600 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户模版初始化表'
---
DDL for test_name
CREATE TABLE `test_name` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `name` varchar(50) DEFAULT NULL COMMENT '20',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='测试'
---
DDL for test_table
CREATE TABLE `test_table` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测试表'
---
DDL for testcode
CREATE TABLE `testcode` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '品牌名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='品牌表'
---
DDL for trans_log_result_list
CREATE TABLE `trans_log_result_list` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time',
  `trans_id` varchar(16) DEFAULT NULL COMMENT '结算流水编号',
  `trans_date` varchar(8) DEFAULT NULL COMMENT '结算日期；yyyyMMdd；示例值：20221023',
  `huifu_id` varchar(18) DEFAULT NULL COMMENT '结算汇付商户号',
  `settle_cycle` char(2) DEFAULT NULL COMMENT '结算方式',
  `card_no` varchar(64) DEFAULT NULL COMMENT '银行卡号(掩码)',
  `card_name` varchar(64) DEFAULT NULL COMMENT '银行户名',
  `bank_code` varchar(10) DEFAULT NULL COMMENT '银行编码',
  `trans_amt` varchar(16) DEFAULT NULL COMMENT '交易金额（元）',
  `fee_amt` varchar(20) DEFAULT NULL COMMENT '结算手续费（元）',
  `fee_cust_id` varchar(16) DEFAULT NULL COMMENT '手续费汇付商户号',
  `trans_stat` char(1) DEFAULT NULL COMMENT '结算状态 I:处理中 F:结算失败 S:结算成功，为空则未返回结算状态；示例值：S',
  `settle_type` char(1) DEFAULT NULL COMMENT '结算类型 0:对公结算 1:对私法人结算 2:对私非法人结算 3:虚拟户结算；示例值：0',
  `settle_abstract` varchar(128) DEFAULT NULL COMMENT '结算摘要',
  `settle_batch_no` varchar(20) DEFAULT NULL COMMENT '结算批次号\n0：0点昨日余额结算批次，非优先到账批则预计到账时间10:30\n100：1点余额结算批次，优先到账则预计到账时间06:50，非优先到账批则预计到账时间10:30\n200：2点余额结算批次，优先到账则预计到账时间06:50，非优先到账批则预计到账时间10:30\n300：3点余额结算批次，优先到账则预计到账时间06:50，非优先到账批则预计到账时间10:30\n400：4点余额结算批次，优先到账则预计到账时间06:50，非优先到账批则预计到账时间10:30\n500：5点余额结算批次，优先到账则预计到账时间06:50，非优先到账批则预计到账时间10:30\n600：6点余额结算批次，预计到账时间10:30\n700：7点余额结算批次，预计到账时间10:30\n800：8点余额结算批次，预计到账时间10:30\n900：9点余额结算批次，预计到账时间10:30\n1000：10点余额结算批次，预计到账时间14:00\n1100：11点余额结算批次，预计到账时间14:00\n1200：12点余额结算批次，预计到账时间14:00\n无值则结算昨日全部余额\n示例值：100',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `reason` varchar(255) DEFAULT NULL COMMENT '汇付返回描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_trans_id` (`trans_id`),
  KEY `idx_huifu_id` (`huifu_id`),
  KEY `idx_trans_date` (`trans_date`)
) ENGINE=InnoDB AUTO_INCREMENT=7768 DEFAULT CHARSET=utf8mb3 COMMENT='结算信息表'
---
DDL for trolley
CREATE TABLE `trolley` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `tenant_id` bigint NOT NULL COMMENT '租户Id',
  `store_id` bigint NOT NULL COMMENT '店铺Id',
  `account_id` bigint NOT NULL COMMENT '账户Id',
  `item_id` bigint NOT NULL COMMENT '商品sku编码',
  `amount` int DEFAULT NULL COMMENT '数量',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_madc` (`tenant_id`,`store_id`,`account_id`,`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27686 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='购物车'
---
DDL for user
CREATE TABLE `user` (
  `id` bigint NOT NULL COMMENT '主键Id',
  `user_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户名称',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '登录手机号',
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '密码',
  `status` tinyint DEFAULT '0' COMMENT '状态 0，待审核 1，审核通过 2，审核失败',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
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
---
DDL for wechat_lite_config
CREATE TABLE `wechat_lite_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `appid` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权人APPID',
  `name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '小程序名称',
  `original_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '微信原始id',
  `auth_ids` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权的权限集',
  `head_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像',
  `principal_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '主体名称',
  `verify` int DEFAULT NULL COMMENT '-1 未认证 0 微信认证',
  `online_id` bigint DEFAULT NULL COMMENT '线上版本关联id',
  `status` int DEFAULT '1' COMMENT '状态默认1',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_appid` (`appid`) USING BTREE,
  KEY `idx_originalid` (`original_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for wechat_template_package
CREATE TABLE `wechat_template_package` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `appid` varchar(24) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权人APPID',
  `audit_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '审核编号',
  `pkg_status` int DEFAULT NULL COMMENT '版本状态 1、线上版本 2、体验版本 3、开发版本 4、审核中 5、审核失败 6、审核通过 7、延迟审核 9、已撤回审核 10 上一个生产环境的版本 99 版本回退记录修改成已删除',
  `version` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '版本号',
  `remark` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '驳回原因',
  `pkg_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '版本描述',
  `template_id` int DEFAULT NULL COMMENT '对应模板id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_appid` (`appid`) USING BTREE,
  KEY `idx_status` (`pkg_status`) USING BTREE,
  KEY `idx_appid_status` (`appid`,`pkg_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
---
DDL for wx_shipping_info_upload_record
CREATE TABLE `wx_shipping_info_upload_record` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `order_id` bigint DEFAULT NULL COMMENT '订单id',
  `payment_id` bigint DEFAULT NULL COMMENT '支付id',
  `transaction_id` varchar(50) NOT NULL COMMENT '交易流水号（请求流水号）',
  `status` int DEFAULT NULL COMMENT '状态：1-已上传发货信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_transaction_id` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='发货信息上传记录表'
---
DDL for xm_contact_mapping
CREATE TABLE `xm_contact_mapping` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `contact_id` bigint NOT NULL COMMENT '鲜沐contact表id',
  `address_id` bigint NOT NULL COMMENT '用户中心地址表的id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_contacid` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14320 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鲜沐联系人映射'
---
DDL for xm_merchant_account_mapping
CREATE TABLE `xm_merchant_account_mapping` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增长主键',
  `xm_account_id` bigint NOT NULL COMMENT '鲜沐merchant_sub_account表id',
  `account_id` bigint NOT NULL COMMENT '用户中心merchant_store_account表的id',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_xmid` (`xm_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1686941522587358197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鲜沐门店账户映射'
---
DDL for xm_merchant_adapter
CREATE TABLE `xm_merchant_adapter` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键、自增',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `store_id` bigint NOT NULL COMMENT '门店id',
  `direct` int DEFAULT NULL COMMENT '1-账期，2-现结',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人名称',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '操作人名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_storeid` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='鲜沐门店适配表（临时适配鲜沐业务）'
---
