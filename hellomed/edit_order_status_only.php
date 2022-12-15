<?php

require 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    
    $status = $_POST['status'];
    $invoice = $_POST['invoice'];

    $changeStatus = "UPDATE orders SET status='$status' WHERE invoice = '$invoice'";
    if (mysqli_query($connection, $changeStatus)) {
        $response['value'] = 1;
        $response['message'] = "Status Berhasil Diupdate";
        echo json_encode($response);
    } else {
        $response['value'] = 2;
        $response['message'] = "Status Gagal Diupdate";
        echo json_encode($response);
    }
}