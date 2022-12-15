<?php

require "config.php";
$response = array();

$userID = $_GET['userID'];

$getUser = mysqli_query($connection, "SELECT * FROM user WHERE id_user = '$userID'");

$result = mysqli_fetch_array($getUser);

$response['name'] = $result['name'];
$response['email'] = $result['email'];
$response['phone'] = $result['phone'];
$response['address'] = $result['address'];
$response['latitude'] = $result['latitude'];
$response['longtitude'] = $result['longtitude'];

echo json_encode($response);
