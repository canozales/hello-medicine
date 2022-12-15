<?php

require 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    
    $name = $_POST['name'];
    $description = $_POST['description'];
    $gambar = $_POST['gambar'];
    $harga = $_POST['harga'];
    $nilaiKategori;


    if($_POST['id_category'] == "Batuk"){
        $nilaiKategori = 1;
    } else if ($_POST['id_category'] == "Demam"){
        $nilaiKategori = 2;
    } else if ($_POST['id_category'] == "Pusing"){
        $nilaiKategori = 3;
    } else if ($_POST['id_category'] == "Perut"){
        $nilaiKategori = 4;
    } else if ($_POST['id_category'] == "Tenggorokan"){
        $nilaiKategori = 5;
    } else {
        $nilaiKategori = 6;
    }

    $insertToCart = "INSERT INTO product VALUE ('', '$nilaiKategori', '$name', '$description', '$harga', '1' ,  NOW(), '$gambar')";
    if (mysqli_query($connection, $insertToCart)) {
        $response['value'] = 1;
        $response['message'] = "Produk Berhasil ditambahkan";
        echo json_encode($response);
    } else {
        $response['value'] = 2;
        $response['message'] = "Penambahan Produk Gagal";
        echo json_encode($response);
    }
}