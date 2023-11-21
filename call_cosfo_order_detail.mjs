import fetch from "node-fetch"
import https from 'https'

const httpsAgent = new https.Agent({
	rejectUnauthorized: false,
});

const order_ids = ['14011', '14012', '14013', '14014', '14024', '14026', '14029', '14030', '14031', '14032', '14033', '14034', '14035', '14036', '14096', '14097', '14268', '60809', '60810', '60864', '60867', '60872', '60873', '60874', '60875', '60876', '60877', '60878', '60881', '60882', '60897', '60900', '60901', '60902', '60903', '60904', '60905', '60906', '60911', '60913', '60919', '60924', '60926', '60927', '60933', '60934', '60935', '60937', '61055', '61060', '61068', '61120', '61122', '61123', '61125', '61127', '61128', '61131', '61132', '61133', '61134', '61138', '61139', '61142', '61143', '61144', '61145', '61146', '61147', '61148', '61149', '61150', '61151', '61155', '61158', '61159', '61165', '61166', '61168', '61174', '61178', '61179', '61191', '61192', '61193', '61194', '61195', '61197', '61198', '61199', '61200', '61214', '61215', '61216', '61217', '61218', '61219', '61220', '61221', '61222', '61223', '61225', '61226', '61227', '61234', '61235', '61236', '61238', '61239', '61240', '61241', '61247', '61248', '61249', '61251', '61252', '61253', '61254', '61256', '61257', '61258', '61259', '61260', '61261', '61262', '61270', '61271', '61272', '61273', '61274', '61276', '61277', '61278', '61279', '61280', '61281', '61282', '61283', '61284', '61290', '61291', '61292', '61293', '61294', '61295', '61296', '61297', '61298', '61299', '61300', '61301', '61302', '61303', '61304', '61305', '61306', '61307', '61308', '61309', '61310', '61311', '61314', '61315', '61316', '61319', '61328', '61329', '61331', '61332', '61333', '61334', '61335', '61336', '61337', '61338', '61339', '61340', '61341', '61342', '61343', '61344', '61345', '61439', '61440', '61441', '61442', '61443', '61444', '61445', '61446', '61447', '61451', '61454', '61455', '61456', '61457', '61458', '61459', '61460', '61461'];

const token = 'eyJhbGciOiJIUzUxMiJ9.eyJhY2NvdW50SWQiOjM1MzIsInRlbmFudElkIjoyLCJzeXN0ZW1Ub2tlbkhvc3QiOiJjb3Nmby1tYWxsLTdmN2Y5OGNkOTgtcjd2OHMiLCJzdG9yZUlkIjo0MjYyLCJleHAiOjE2ODg5NjA1MDV9.ik0fkm38u3VmkIs8FsxvvjMhJ24qI2fbzgxzr8tzSDVp2-eMnOIVz90DGFtc0bWR9t7n2CrmMemNnB9XXIy8CA';

async function callDev4(id) {
	let url = `https://dev4mall.cosfo.cn/order/detail?orderId=${id}&token=${token}`;
	let resp = await fetch(url, { agent: httpsAgent });
	return await resp.json();
}

async function callDev(id) {
	let url = `https://dev3mall.cosfo.cn/order/detail?orderId=${id}&token=${token}`;
	let resp = await fetch(url, { agent: httpsAgent });
	return await resp.json();
}

async function call() {
	for (let id of order_ids) {
		let newJson = await callDev4(id), oldJson = await callDev(id);
		if (JSON.stringify(newJson) === JSON.stringify(oldJson)) {
			console.log("\nthe same result!", id, "\n");
		} else {
			console.error("different result!, id:", id, "new result:", JSON.stringify(newJson), "\nOld result:", JSON.stringify(oldJson));
		}
	}
}

call();