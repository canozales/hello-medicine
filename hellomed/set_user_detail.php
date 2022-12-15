<?php

require 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    
    $id_user = $_POST['id_user'];
    $name = $_POST['name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];

    $editUser = "UPDATE user SET name='$name', email='$email', phone='$phone', address='$address' WHERE id_user = '$id_user'";
    if (mysqli_query($connection, $editUser)) {
        $response['value'] = 1;
        $response['message'] = "Informasi Berhasil diubah";
        echo json_encode($response);
    } else {
        $response['value'] = 2;
        $response['message'] = "Perubahan Informasi Gagal";
        echo json_encode($response);
    }
}