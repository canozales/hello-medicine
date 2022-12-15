<?php

require 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    
    $id_user = $_POST['id_user'];
    $latitude = $_POST['latitude'];
    $longtitude = $_POST['longtitude'];
    $address = $_POST['address'];

    $editUser = "UPDATE user SET latitude='$latitude', longtitude='$longtitude', address='$address' WHERE id_user = '$id_user'";
    if (mysqli_query($connection, $editUser)) {
        $response['value'] = 1;
        $response['message'] = "Alamat Berhasil diubah";
        echo json_encode($response);
    } else {
        $response['value'] = 2;
        $response['message'] = "Perubahan Alamat Gagal";
        echo json_encode($response);
    }
}