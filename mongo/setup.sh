#!/bin/bash
mongo <<EOF

use admin;
db.createUser({ 
    user: "admin", 
    pwd: "123456",
    roles: [ { role: "root", db: "admin" } ], 
    mechanisms : ["SCRAM-SHA-1"]
});
use robot;
db.createUser(
    {
        user: "robot",
        pwd: "kd0a-dlfzdl",
        roles: [
			{role:"read",db:"admin"},
            { role: "readWrite", db: "robot"}
        ],
        mechanisms : ["SCRAM-SHA-1"]
    }
);
db.createCollection("member");
db.member.insert(
	{
		"user_name" : "admin",
		"password" : "e10adc33e5f759abbe56e057f20f883e",
		"company" : "公司",
		"contact_number" : "13188888888",
		"validity" : 1562774400,
		"create_time" : 1562607938,
		"update_time" : 1562607938,
		"role" : 1,
		"status" : 1,
		"del" : 0,
		"id" : "5d238142320fe81ec00056f2"
	}
);

EOF
