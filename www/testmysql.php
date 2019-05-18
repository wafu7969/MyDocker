<?php

//这里需要说明的是host，我们使用的是docker image， 所以这里的host填写image名称
$conn = new mysqli("mysql-db", 'root', '456321', 'docker_test');
if(!$conn){
    die($conn->connect_error);
}
$result = mysqli_query($conn, "select * from blog");
while ($arr = $result->fetch_assoc()) {
    var_dump($arr);
}