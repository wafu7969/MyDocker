//创建一个testDB
db = db.getSiblingDB('testDB');
//创建一个名为"test"的用户，设置密码和权限
db.createUser(
    {
        user: "test",
        pwd: "123456",
        roles: [
            { role: "readWrite", db: "testDB"}
        ],
        mechanisms : ["SCRAM-SHA-1"]
    }
);
// 在"newDB"中创建一个名为"testCollection"的Collection
db.createCollection("testCollection");