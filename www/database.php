<?php
$dbhost = 'mariadb';
$dbname = 'autogarage';
$dbuser = 'root';
$dbpass = 'password';

$conn = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);


if (!$conn){
    die('connection failed'. mysqli_connect_error());
}
