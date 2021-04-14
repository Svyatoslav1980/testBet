<?php
$localhost = "localhost";
$db = "testBet";
$user = "mysql";
$password = "mysql";
$link = mysqli_connect($localhost, $user, $password) or
trigger_error(mysql_error(),E_USER_ERROR);
mysqli_select_db($link, $db);
?>