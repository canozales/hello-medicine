<?php

require 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    
    $status = $_POST['status'];
    $invoice = $_POST['invoice'];
    $pengantar = $_POST['pengantar'];
    $id_driver = $_POST['id_driver'];

    $changeStatus = "UPDATE orders SET status='$status', pengantar='$pengantar', id_driver='$id_driver' WHERE invoice = '$invoice'";
    if (mysqli_query($connection, $changeStatus)) {
        $response['value'] = 1;
        $response['message'] = "Pesanan Dikonfirmasi";
        echo json_encode($response);
    } else {
        $response['value'] = 2;
        $response['message'] = "Gagal Mengkonfirmasi";
        echo json_encode($response);
    }
}