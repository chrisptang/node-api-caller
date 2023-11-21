import fetch from "node-fetch";

async function callImport() {
    let resp = await fetch(`http://localhost:8889/v3/api-docs?t=${new Date().getTime() % 3000}`)
    let json = await resp.json();

    let postJson = {
        "importFormat": "openapi",
        "data": JSON.stringify(json)
    }

    postJson.data = JSON.stringify(json);

    console.log(JSON.stringify(postJson));

    const headers = {
        "X-Apifox-Version": "2022-11-16",
        "Content-Type": "application/json",
        "User-Agent": "Apifox/1.0.0 (https://apifox.com)",
        "Authorization": "Bearer APS-AtZ5r0mmo7MWqCnE5MRRpNXz7jQCGdvf"
    }

    resp = await fetch("https://api.apifox.cn/api/v1/projects/2855269/import-data", {
        method: "post", headers, body: JSON.stringify(postJson)
    });

    let apifox_resp = await resp.json();
    console.log(JSON.stringify(apifox_resp, null, 4));


    // let faked = {
    //     "importFormat": "openapi",
    //     "data": "{\"swagger\":\"2.0\",\"paths\":{\"/pet\":{\"post\":{\"summary\":\"测试Apifox接口导入\",\"description\":\"\",\"operationId\":\"addPet\",\"parameters\":[{\"in\":\"body\",\"name\":\"body\",\"description\":\"Pet object that needs to be added to the store\",\"required\":true,\"schema\":{\"$ref\":\"#/definitions/Pet\"}}],\"responses\":{\"405\":{\"description\":\"Invalid input\"}}}}},\"definitions\":{\"Pet\":{\"type\":\"object\",\"required\":[\"name\",\"photoUrls\"],\"properties\":{\"id\":{\"type\":\"integer\",\"format\":\"int64\"},\"name\":{\"type\":\"string\",\"example\":\"doggie\"},\"photoUrls\":{\"type\":\"array\",\"items\":{\"type\":\"string\",\"xml\":{\"name\":\"photoUrl\"}}},\"status\":{\"type\":\"string\",\"description\":\"pet status in the store\",\"enum\":[\"available\",\"pending\",\"sold\"]}}}}}"
    // }

    // resp = await fetch("https://api.apifox.cn/api/v1/projects/2855269/import-data", {
    //     method: "post", headers, body: JSON.stringify(faked)
    // });

    // apifox_resp = await resp.json();
    // console.log(JSON.stringify(apifox_resp, null, 4));
}

callImport();