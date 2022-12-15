<?php

require "config.php";

$response = array();
$query_select_order = mysqli_query($connection, "SELECT orders.*, user.name, user.phone, user.address FROM orders JOIN user ON orders.id_user = user.id_user WHERE orders.status = 1");

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
    $key['status'] = $row_order['status'];
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
