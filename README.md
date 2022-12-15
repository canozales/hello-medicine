# HelloMedicine+

HelloMedicine+ adalah Apotek Online yang dibuat menggunakan Flutter. <br/> <br />
Berikut ini beberapa deskripsi dan fungsionalitas HelloMedicine+
1. Terdapat 3 roles yaitu Admin, Customer, dan Driver
2. Admin dapat melakukan Operasi CRUD terhadap produk Apotek (Nama Produk, Gambar, Deskripsi, Stok, dst)
3. Admin dapat melacak keberadaan Produk Customer setelah dijemput oleh Driver
4. User dapat mencari dan melihat berbagai deskripsi obat-obatan dan menambahkannya ke Cart
5. User dapat melakukan checkout sehingga pesanannya akan diproses oleh Admin dan diantar oleh Driver
6. Aplikasi ini memiliki Fitur menghitung harga berdasarkan jarak apotek dengan jarak alamat Customer
7. Alamat customer disimpan berupa Langtitude dan Longtitude dari Google Maps
8. Aplikasi ini menggunakan MySQL sebagai Database dan PHP sebagai REST API yang menghubungkannya (localhost)

## Berikut ini contoh tampilan HelloMedicine+
![image](https://user-images.githubusercontent.com/64438437/207833291-f0c1baf5-10c4-43e2-9796-459d87762617.png)
![image](https://user-images.githubusercontent.com/64438437/207833400-5bfa7a74-8ae7-4049-961d-7be60b63552a.png)


## Cara Menjalankan HelloMedicine+

1. Silahkan Clone atau Download Source Code ini terlebih dahulu
2. Folder hellomedicine adalah Project Flutter
3. Folder hellomed adalah File PHP yang berfungsi sebagai API
4. hellomed.sql adalah Database
5. Buka xampp, nyalakan apache dan mysql
6. Import hellomed.sql pada MySQL
7. Pergi ke folder xampp/htdocs, tambahkan folder hellomed (Point 3)


Sampai tahap ini, HelloMedicine sudah dapat dijalankan. Namun tidak dapat terhubung dengan Database. Untuk dapat menghubungkannya dengan localhost Database pada Laptop, maka smartphone Anda harus berbagi Network yang sama dengan Laptop Anda. 

Salah satu caranya adalah sebagai berikut.
1. Buka hotspot pada laptop, handphone Anda selain terhubung dengan kabel ke Laptop, juga terhubung dengan WiFi laptop
2. Buka cmd, ketik ipconfig dan cari IPv4 Address pada Local Area Network
3. Buka project flutter, pergi ke lib/network/api/url_api.dart kemudian ganti ipAddress dengan ipAddress Anda pada Point No. 2

HelloMedicine+ sudah dapat dijalankan. Selamat belajar. 
