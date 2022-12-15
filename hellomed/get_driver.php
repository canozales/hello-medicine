<?php  

    require 'config.php';

    $response = array();

    $cek_product = mysqli_query($connection, "SELECT * FROM user WHERE status ='3'");

    while ($row_product = mysqli_fetch_array($cek_product)) {

        $key['name'] = $row_product['name'];
        $key['id_user'] = $row_product['id_user'];

        array_push($response, $key);
    }

echo json_encode($response);
