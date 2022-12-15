<?php

require "config.php";

$response = array();
$userID = $_GET['userID'];

$query_select_order = mysqli_query($connection, "SELECT orders.*, user.name, user.phone, user.address FROM orders JOIN user ON orders.id_user = user.id_user 
WHERE orders.id_driver = '$userID'");

while ($row_order = mysqli_fetch_array($query_select_order)) {
    # code...
    $key['name'] = $row_order['name'];
    $key['phone'] = $row_order['phone'];
    $key['address'] = $row_order['address'];
    $key['totalprice'] = $row_order['totalprice'];
    $noInvoice = $row_order['invoice'];
    $key['invoice'] = $noInvoice;
    $key['id_user'] = $row_order['id_user'];
    $key['order_at'] = $row_order['order_at'];

    if ($row_order['status'] == 1){
        $key['status'] = "Menunggu Konfirmasi";
    } else if ($row_order['status'] == 2){
        $key['status'] = "Menunggu Pengantar";
    } else if ($row_order['status'] == 3){
        $key['status'] = "Bersama Pengantar";
    } else if ($row_order['status'] == 4){
        $key['status'] = "Menuju Alamat Penerima";
    } else {
        $key['status'] = "Pesanan Selesai";
    }

    $key['pengantar'] = $row_order['pengantar'];
    $key['detail'] = array();



    $query_select_order_detail = mysqli_query($connection, "SELECT order_details.*, product.name, product.gambar FROM order_details JOIN product on 
    order_details.id_product = product.id_product WHERE order_details.invoice = '$noInvoice'");

// $query_select_order_detail = mysqli_query($connection, "SELECT order_details.*, product.name FROM order_details JOIN product on 
// order_details.id_product = product.id_product WHERE order_details.invoice = '$noInvoice' LIMIT 5");

    while ($row_order_detail = mysqli_fetch_array($query_select_order_detail)) {
        # code...
        $key['detail'][] = array(
            "id_orders" => $row_order_detail['id_orders'],
            "invoice" => $row_order_detail['invoice'],
            "id_product" => $row_order_detail['id_product'],
            "nameProduct" => $row_order_detail['name'],
            "quantity" => $row_order_detail['quantity'],
            "price" => $row_order_detail['price'],
            "gambar" => $row_order_detail['gambar'],
        );
    }
    array_push($response, $key);
}
echo json_encode($response);
