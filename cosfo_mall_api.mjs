import fetch from "node-fetch"
import mysql from 'mysql2/promise';

//https://devmall.cosfo.cn/home/listAll/1/12?classificationId=855&token=eyJhbGciOiJIUzUxMiJ9.eyJhY2NvdW50SWQiOjM1MzIsInRlbmFudElkIjoyLCJzeXN0ZW1Ub2tlbkhvc3QiOiJjb3Nmby1tYWxsLTdkNmQ3YmI5NTktNTljd2giLCJzdG9yZUlkIjo0MjYyLCJleHAiOjE2ODYyMTk5OTl9.tNvZ30xD-ts4NDKHGKf_cx90N1QK_JpO5sigfQTIaUDRvP23UnmPHP5CIOTte8giRBNtrEvlXvabB8L9OT_NZQ


const token = 'eyJhbGciOiJIUzUxMiJ9.eyJhY2NvdW50SWQiOjM1MzIsInRlbmFudElkIjoyLCJzeXN0ZW1Ub2tlbkhvc3QiOiJjb3Nmby1tY' +
    'WxsLTdkNmQ3YmI5NTktNTljd2giLCJzdG9yZUlkIjo0MjYyLCJleHAiOjE2ODYyMTk5OTl9.tNvZ30xD-ts4NDKHGKf_cx90N1QK_JpO5sigfQTI' +
    'aUDRvP23UnmPHP5CIOTte8giRBNtrEvlXvabB8L9OT_NZQ'

console.log(JSON.stringify(process.argv), "started at:", new Date())
let item_list = [];
if (process.argv.length == 3) {
    item_list = process.argv[2].split(",");
}

async function callItemObj(id = 1818) {
    let url1 = `https://dev2mall.cosfo.cn/home/selectDetail?itemId=${id}`
    console.log("calling old-api:", url1);
    url1 = `${url1}&token=${token}`;
    let res1 = await fetch(url1);
    let json1 = await res1.json();
    let resultJson = { id: id, isPriceMatched: false, oldPrice: 0, itemCenterPrice: 0, isApiCallFailed: false };
    if (!json1.success) {
        console.warn("call old-api failed:", JSON.stringify(json1));
        resultJson.isApiCallFailed = true;
        return resultJson;
    }
    let oldItem = json1.data || {};

    let is_onsale = true;
    if (!oldItem || !oldItem.price || oldItem.price < 0) {
        console.log("item in old-api has no price:", JSON.stringify(oldItem));
        is_onsale = false;
    }

    let url2 = `https://qamall.cosfo.cn/home/selectDetail?itemId=${id}`;
    console.log("calling item-center-api:", url2);
    url2 = `${url2}&token=${token}`;

    let res2 = await fetch(url2);
    let json2 = await res2.json();
    if (!json2.success) {
        console.warn("call item-center-api failed:", id, ", result:", JSON.stringify(json2));
        resultJson.isApiCallFailed = true;
        return resultJson;
    }
    let itemCenterItem = json2.data || {};
    if (!itemCenterItem || !itemCenterItem.price || itemCenterItem.price < 0) {
        console.log("item in item-center-api has no price:", JSON.stringify(itemCenterItem), ', compare to old-api-object:', JSON.stringify(oldItem))
        resultJson.isApiCallFailed = true;
        return resultJson;
    } else if (!is_onsale) {
        console.warn("item is offline:", id, ", but price was presented-in-item-center:", itemCenterItem.price, ", basePrice:", itemCenterItem.basePrice);
        resultJson.isApiCallFailed = true;
        return resultJson;
    }

    console.log("item-id:", id, ", price in old-api:", oldItem.price, ', price in item-center:', itemCenterItem.price,
        ', has-same-price:', itemCenterItem.price == oldItem.price);
    if (itemCenterItem.price > 0 && oldItem.price > 0 && itemCenterItem.price != oldItem.price) {
        console.error("price dismatch, old-api:", JSON.stringify(oldItem), ', new-item-center:', itemCenterItem);
        resultJson.isApiCallFailed = true;
        return resultJson;
    }
    resultJson.isPriceMatched = true;
    resultJson.oldPrice = oldItem.price || 0;
    resultJson.itemCenterPrice = itemCenterItem.price || 0;
    return resultJson;
}

async function callItem(id = 1818) {
    let url = `https://dev2mall.cosfo.cn/home/selectDetail?itemId=${id}`;
    console.log("calling old-api:", url);
    url = `${url}&token=${token}`;
    let res = await fetch(url);
    let json = await res.json();
    if (!json.success) {
        console.warn("call old-api failed:", JSON.stringify(json));
        return false;
    }
    let oldItem = json.data || {};

    let is_onsale = true;
    if (!oldItem || !oldItem.price || oldItem.price < 0) {
        console.log("item in old-api has no price:", JSON.stringify(oldItem));
        is_onsale = false;
    }

    url = `https://qamall.cosfo.cn/home/selectDetail?itemId=${id}`;
    console.log("calling item-center-api:", url);
    url = `${url}&token=${token}`;

    res = await fetch(url);
    json = await res.json();
    if (!json.success) {
        console.warn("call item-center-api failed:", id, ", result:", JSON.stringify(json));
        return false;
    }
    let itemCenterItem = json.data || {};
    if (!itemCenterItem || !itemCenterItem.price || itemCenterItem.price < 0) {
        console.log("item in item-center-api has no price:", JSON.stringify(itemCenterItem), ', compare to old-api-object:', JSON.stringify(oldItem))
        return false;
    } else if (!is_onsale) {
        console.warn("item is offline:", id, ", but price was presented-in-item-center:", itemCenterItem.price, ", basePrice:", itemCenterItem.basePrice);
        return false;
    }

    console.log("item-id:", id, ", price in old-api:", oldItem.price, ', price in item-center:', itemCenterItem.price,
        ', has-same-price:', itemCenterItem.price == oldItem.price);
    if (itemCenterItem.price > 0 && oldItem.price > 0 && itemCenterItem.price != oldItem.price) {
        console.error("price dismatch, old-api:", JSON.stringify(oldItem), ', new-item-center:', itemCenterItem);
        return false;
    }
    return true;
}

async function run() {
    let allResult = [];
    if (!item_list || item_list.length <= 0) {
        let allItems = await fetchAllAvailableItems();

        for (let item of allItems) {
            item_list[item_list.length] = item.item_id;
        }
    }
    console.log("running for list:", JSON.stringify(item_list));
    for (let item_id of item_list) {
        console.log("====>>>>testing id:", item_id);
        let res = await callItemObj(item_id);
        allResult[allResult.length] = { item_id, is_price_matched: res }
        console.log(">>>>====end of id:", item_id);
    }
    console.log("\n\nEND:\n");
    for (let result of allResult) {
        console.log(JSON.stringify(result));
    }
}

run();

async function fetchAllAvailableItems() {
    try {
        // create the connection
        const connection = await mysql.createConnection(process.env.MYSQL_URL);

        // run the sql query
        const [results, fields] = await connection.execute(`select mai.item_id 
        from market_area_item mai
        left join market_item mi on mai.item_id = mi.id
        where mai.tenant_id = 2 and delete_flag = 1`);

        // do something with the results
        console.log("all available items:", JSON.stringify(results));
        // close the connection
        await connection.end();
        return results;
    } catch (error) {
        console.log(error);
        return [];
    }
}


// {
//     "code": 200,
//     "data": {
//         "amount": 0,
//         "basePrice": 1,
//         "brandId": null,
//         "brandName": "",
//         "classificationId": null,
//         "deliveryType": null,
//         "detailPicture": "",
//         "expirationTime": "",
//         "goodsType": 2,
//         "guaranteePeriod": null,
//         "guaranteeUnit": null,
//         "id": 1818,
//         "mainPicture": "test/aj6oudebq5lnzzd2.jpeg",
//         "miniOrderQuantity": 1,
//         "origin": "",
//         "price": 1,
//         "ruleList": [],
//         "skuId": 18288,
//         "specification": "0_1箱*3箱",
//         "specificationUnit": "袋",
//         "storageLocation": null,
//         "storageTemperature": "",
//         "subTitle": "",
//         "tenantId": 2,
//         "title": "贝塔自动化20230510_8386",
//         "trolleyAmount": 0,
//         "warehouseType": null
//     },
//     "fail": false,
//     "message": "成功",
//     "success": true
// }