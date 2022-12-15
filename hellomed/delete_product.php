<?php

require "config.php";
$response = array();

$id_product = $_GET['id_product'];
$sql = "DELETE FROM product WHERE id_product = '$id_product' ";


if ( mysqli_query($connection, $sql) ){
    $response['value'] = 1;
    $response['message'] = "Produk Berhasil dihapus";
    echo json_encode($response);
} else {
    $response['value'] = 2;
    $response['message'] = "Produk gagal dihapus";
    echo json_encode($response);
}