import fetch from "node-fetch"
import mysql from 'mysql2/promise';

//https://devmall.cosfo.cn/home/listAll/1/12?classificationId=855&token=eyJhbGciOiJIUzUxMiJ9.eyJhY2NvdW50SWQiOjM1MzIsInRlbmFudElkIjoyLCJzeXN0ZW1Ub2tlbkhvc3QiOiJjb3Nmby1tYWxsLTdkNmQ3YmI5NTktNTljd2giLCJzdG9yZUlkIjo0MjYyLCJleHAiOjE2ODYyMTk5OTl9.tNvZ30xD-ts4NDKHGKf_cx90N1QK_JpO5sigfQTIaUDRvP23UnmPHP5CIOTte8giRBNtrEvlXvabB8L9OT_NZQ


const token = 'eyJhbGciOiJIUzUxMiJ9.eyJhY2NvdW50SWQiOjM1MzIsInRlbmFudElkIjoyLCJzeXN0ZW1Ub2tlbkhvc3QiOiJjb3Nmby1tY' +
    'WxsLTdkNmQ3YmI5NTktNTljd2giLCJzdG9yZUlkIjo0MjYyLCJleHAiOjE2ODYyMTk5OTl9.tNvZ30xD-ts4NDKHGKf_cx90N1QK_JpO5sigfQTI' +
    'aUDRvP23UnmPHP5CIOTte8giRBNtrEvlXvabB8L9OT_NZQ'

console.log(JSON.stringify(process.argv), new Date())
let item_list = [];
if (process.argv.length == 3) {
    item_list = process.argv[2].split(",");
}

async function callItem(id = 1818) {
    let url = `https://qamall.cosfo.cn/home/selectDetail?itemId=${id}`;
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

    url = `https://devmall.cosfo.cn/home/selectDetail?itemId=${id}`;
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

// async function callCategory(id = 855) {
//     console.log("====>>>>testing id:", id);
//     let url = `https://devmall.cosfo.cn/home/listAll/1/100?classificationId=${id}`;
//     console.log("calling:", url);
//     url = `${url}&token=${token}`;
//     let res = await fetch(url);
//     let json = await res.json();
//     let products = getDateFromRes(json);
//     products = convertProductListToMap(products);

//     console.log("\n\nproducts using item-center:", JSON.stringify(products));

//     url = `https://dev2mall.cosfo.cn/home/listAll/1/100?classificationId=${id}`;
//     console.log("calling:", url);
//     url = `${url}&token=${token}`;

//     res = await fetch(url);
//     json = await res.json();
//     let oldProducts = getDateFromRes(json);

//     console.log("\n\nproducts using old-cosfo-mall:", JSON.stringify(oldProducts));

//     for (let oldP of oldProducts) {
//         if (products[`${oldP.id}`]) {
//             console.log("id:", oldP.id, ", price in item-center:", products[`${oldP.id}`].price, ', price in old-api:', oldP.price, ', has-same-price:', oldP.price == products[`${oldP.id}`].price);
//         } else {
//             console.warn("can't find product in item-center:", oldP.id);
//         }
//     }
//     console.log("====>>>>end of id:", id);
// }

// function getDateFromRes(json) {
//     if (json && json.data && json.data.list) {
//         return json.data.list;
//     }
//     console.log("invalid response:", JSON.stringify(json));
//     return [];
// }

// function convertProductListToMap(list) {
//     let res = {}
//     list.forEach(p => { res[`${p.id}`] = p })
//     return res;
// }

// let cates = [1, 4, 58, 59, 60, 113, 115, 119, 123, 160, 167, 197, 198, 199, 202, 204, 205, 206, 207, 209, 211, 213, 229, 231, 233, 338,
//     355, 356, 363, 454, 552, 655, 761, 762, 764, 855, 1078, 1079, 1080, 1096, 1099, 1103, 1104, 1105, 1106, 1143, 1144, 1145, 1149, 1150,
//     1163, 1165, 1169, 1206];

// for (let c of cates) {
//     await callCategory(c);
// }

async function run() {
    let allResult = [];
    if (item_list && item_list.length > 0) {
        console.log("running for special list:", JSON.stringify(item_list));
        for (let item_id of item_list) {
            console.log("====>>>>testing id:", item_id);
            let res = await callItem(item_id);
            allResult[allResult.length] = { item_id, is_price_matched: res }
            console.log(">>>>====end of id:", item_id);
        }
        return;
    } else {
        let allItems = await fetchAllAvailableItems();

        for (let itemId of allItems) {
            // console.log(JSON.stringify(itemId));
            let { item_id } = { ...itemId };
            console.log("====>>>>testing id:", item_id);
            let res = await callItem(item_id);
            allResult[allResult.length] = { item_id, is_price_matched: res }
            console.log(">>>>====end of id:", item_id);
        }
    }
    console.log("\n\nEND:\n", JSON.stringify(allResult));
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