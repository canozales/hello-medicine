<?php

require 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    
    $name = $_POST['name'];
    $description = $_POST['description'];
    $gambar = $_POST['gambar'];
    $harga = $_POST['harga'];
    $id_product = $_POST['id_product'];
    

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


    $editProduct = "UPDATE product SET name='$name', description='$description', price='$harga', gambar='$gambar', id_category='$nilaiKategori' WHERE id_product = '$id_product'";
    if (mysqli_query($connection, $editProduct)) {
        $response['value'] = 1;
        $response['message'] = "Produk Berhasil diubah";
        echo json_encode($response);
    } else {
        $response['value'] = 2;
        $response['message'] = "Pengubahan Produk Gagal";
        echo json_encode($response);
    }
}