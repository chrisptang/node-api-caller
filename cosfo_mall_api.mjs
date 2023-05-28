import fetch from "node-fetch"

//https://devmall.cosfo.cn/home/listAll/1/12?classificationId=855&token=eyJhbGciOiJIUzUxMiJ9.eyJhY2NvdW50SWQiOjM1MzIsInRlbmFudElkIjoyLCJzeXN0ZW1Ub2tlbkhvc3QiOiJjb3Nmby1tYWxsLTdkNmQ3YmI5NTktNTljd2giLCJzdG9yZUlkIjo0MjYyLCJleHAiOjE2ODYyMTk5OTl9.tNvZ30xD-ts4NDKHGKf_cx90N1QK_JpO5sigfQTIaUDRvP23UnmPHP5CIOTte8giRBNtrEvlXvabB8L9OT_NZQ


const token = 'eyJhbGciOiJIUzUxMiJ9.eyJhY2NvdW50SWQiOjM1MzIsInRlbmFudElkIjoyLCJzeXN0ZW1Ub2tlbkhvc3QiOiJjb3Nmby1tY' +
    'WxsLTdkNmQ3YmI5NTktNTljd2giLCJzdG9yZUlkIjo0MjYyLCJleHAiOjE2ODYyMTk5OTl9.tNvZ30xD-ts4NDKHGKf_cx90N1QK_JpO5sigfQTI' +
    'aUDRvP23UnmPHP5CIOTte8giRBNtrEvlXvabB8L9OT_NZQ'

async function callItem(id = 1818) {
    console.log("====>>>>testing id:", id);
    let url = `https://devmall.cosfo.cn/home/selectDetail?itemId=${id}`;
    console.log("calling item-center-api:", url);
    url = `${url}&token=${token}`;
    let res = await fetch(url);
    let json = await res.json();
    if (!json.success) {
        console.warn("call api failed:", JSON.stringify(json));
    }
    let productInItemCenter = json.data || {};

    url = `https://dev2mall.cosfo.cn/home/selectDetail?itemId=${id}`;
    console.log("calling old-api:", url);
    url = `${url}&token=${token}`;

    res = await fetch(url);
    json = await res.json();
    if (!json.success) {
        console.warn("call api failed:", JSON.stringify(json));
    }
    let oldProduct = json.data || {};


    console.log("id:", id, ", price in item-center:", productInItemCenter.price, ', price in old-api:', oldProduct.price, ', has-same-price:', oldProduct.price == productInItemCenter.price);
    if (oldProduct.price > 0 && productInItemCenter.price > 0 && oldProduct.price != productInItemCenter.price) {
        console.error("price dismatch, old-api:", JSON.stringify(oldProduct), ', new-item-center:', productInItemCenter);
    }
    console.log(">>>>====end of id:", id);
}

async function callCategory(id = 855) {
    console.log("====>>>>testing id:", id);
    let url = `https://devmall.cosfo.cn/home/listAll/1/100?classificationId=${id}`;
    console.log("calling:", url);
    url = `${url}&token=${token}`;
    let res = await fetch(url);
    let json = await res.json();
    let products = getDateFromRes(json);
    products = convertProductListToMap(products);

    console.log("\n\nproducts using item-center:", JSON.stringify(products));

    url = `https://dev2mall.cosfo.cn/home/listAll/1/100?classificationId=${id}`;
    console.log("calling:", url);
    url = `${url}&token=${token}`;

    res = await fetch(url);
    json = await res.json();
    let oldProducts = getDateFromRes(json);

    console.log("\n\nproducts using old-cosfo-mall:", JSON.stringify(oldProducts));

    for (let oldP of oldProducts) {
        if (products[`${oldP.id}`]) {
            console.log("id:", oldP.id, ", price in item-center:", products[`${oldP.id}`].price, ', price in old-api:', oldP.price, ', has-same-price:', oldP.price == products[`${oldP.id}`].price);
        } else {
            console.warn("can't find product in item-center:", oldP.id);
        }
    }
    console.log("====>>>>end of id:", id);
}

function getDateFromRes(json) {
    if (json && json.data && json.data.list) {
        return json.data.list;
    }
    console.log("invalid response:", JSON.stringify(json));
    return [];
}

function convertProductListToMap(list) {
    let res = {}
    list.forEach(p => { res[`${p.id}`] = p })
    return res;
}

let cates = [1, 4, 58, 59, 60, 113, 115, 119, 123, 160, 167, 197, 198, 199, 202, 204, 205, 206, 207, 209, 211, 213, 229, 231, 233, 338, 355, 356, 363, 454, 552, 655, 761, 762, 764, 855, 1078, 1079, 1080, 1096, 1099, 1103, 1104, 1105, 1106, 1143, 1144, 1145, 1149, 1150, 1163, 1165, 1169, 1206];

// for (let c of cates) {
//     await callCategory(c);
// }


const item_list = [2262, 2259, 2258, 2254, 2253, 2252, 2251, 2250, 2249, 2246, 2245, 2244, 2243, 2242, 2230, 2229, 2228, 2227, 2226, 2225, 2224, 2223, 2222, 2218, 2217, 2216, 2215, 2214, 2213, 2212, 2211, 2209, 2208, 2207, 2206, 2205, 2204, 2203, 2202, 2200, 2199, 2198, 2197, 2195, 2194, 2193, 2192, 2191, 2190, 2189, 2188, 2186, 2185, 2182, 2181, 2180, 2179, 2178, 2172, 2171, 2167, 2156, 2155, 2154, 2153, 2152, 2151, 2150, 2149, 2148, 2147, 2146, 2145, 2143, 2142, 2141, 2140, 2139, 2138, 2137, 2136, 2135, 2133, 2092, 2091, 2090, 2089, 2088, 2087, 2085, 2067, 2064, 2057, 2056, 2049, 2047, 2046, 2045, 2030, 2029, 2024, 2019, 2018, 2017, 2016, 1996, 1995, 1991, 1990, 1989, 1981, 1963, 1960, 1959, 1945, 1944, 1943, 1937, 1932, 1931, 1930, 1928, 1927, 1926, 1923, 1922, 1921, 1920, 1916, 1915, 1914, 1913, 1912, 1911, 1910, 1909, 1908, 1907, 1905, 1904, 1903, 1878, 1875, 1873, 1872, 1868, 1866, 1865, 1864, 1863, 1859, 1856, 1855, 1850, 1842, 1837, 1836, 1835, 1834, 1833, 1832, 1831, 1830, 1829, 1828, 1827, 1826, 1825, 1824, 1823, 1822, 1821, 1820, 1819, 1818, 1817, 1816, 1815, 1814, 1813, 1812, 1811, 1810, 1809, 1808, 1807, 1806, 1805, 1804, 1803, 1802, 1801, 1800, 1799, 1798, 1797, 1796, 1795, 1794, 1793];

for (let itemId of item_list) {
    await callItem(itemId);
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