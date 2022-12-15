<?php

require "config.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    # code...
    $response = array();
    $email = $_POST['email'];
    $password = md5($_POST['password']);

    $query_cek_user = mysqli_query($connection, "SELECT * FROM user WHERE email = '$email'");
    $cek_user_result = mysqli_fetch_array($query_cek_user);

    if ($cek_user_result) {
        # code...
        $query_login = mysqli_query($connection, "SELECT * FROM user WHERE email = '$email' AND password = '$password'");
        $cek_query_login = mysqli_fetch_array($query_login);
        if ($cek_query_login) {
            # code...
            $response['value'] = $cek_user_result['status'];
            $response['user_id'] = $cek_user_result['id_user'];
            $response['name'] = $cek_user_result['name'];
            $response['email'] = $cek_user_result['email'];
            $response['phone'] = $cek_user_result['phone'];
            $response['address'] = $cek_user_result['address'];
            $response['created_at'] = $cek_user_result['created_at'];
            $response['message'] = "Selamat Datang Kembali";
            // $response['message'] = "Welcome, " . $response['name'];
            echo json_encode($response);
        } else {
            # code...
            $response['value'] = "4";
            $response['message'] = "Password Salah";
            echo json_encode($response);
        }
    } else {
        # code...
        $response['value'] = "4";
        $response['message'] = "Account tidak Terdaftar";
        echo json_encode($response);
    }
}
