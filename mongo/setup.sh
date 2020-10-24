#!/bin/bash
mongo <<EOF

use admin;
db.createUser({ 
    user: "admin",
    pwd: "j8K9aPm1v4z",
    roles: [ { role: "root", db: "admin" } ], 
    mechanisms : ["SCRAM-SHA-1"]
});
use robot;
db.createUser(
    {
        user: "robot",
        pwd: "k3d0adlf5z7dl",
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
        "password" : "d4d5542ea754f5a121ca0d9f293c7115",
        "company" : "company",
        "contact_number" : "",
        "validity" : 1632495600,
        "create_time" : 1563010552,
        "update_time" : 1563010552,
        "role" : "1",
        "status" : 1,
        "del" : 0,
        "id" : "5d29a5f805b794000f55c632",
        "application" : "introduce,staticexplain,library,slides,trailers,newspaper,lawsuit,voicemail,dishonests,copyfile,autoexplain,guide,customexplain,custom",
        "left_menu_role" : "1aic,3dLo,9Em3,12uM3,11dMk,7Jf0,8uMD,4ufD",
        "__token__" : "819cfb153d844c9488044674d789694d",
        "up_size" : 1151144069
	}
);

EOF
