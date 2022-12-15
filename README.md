Cara Menjalankan Aplikasi HelloMedicine

1. Download semua Source Code terlebih dahulu
2. Folder hellomedicine adalah Project Flutter

Notes: Jika folder lib pada folder hellomedicine isinya kosong, silahkan isi folder lib tersebut dengan file pada link berikut.
https://gitlab.com/ncanozales/tubes-rpl/-/tree/main

3. Folder hellomed adalah File PHP
4. hellomed.sql adalah File Databasenya
5. Buka xampp, nyalakan apache dan mysql
6. Buat database bernama hellomed, kemudian import hellomed.sql
7. Pergi ke folder xampp/htdocs, paste folder hellomed (Point 3)
8. Pergi ke project flutter, pada folder assets, isi dengan semua image yang ada pada https://drive.google.com/drive/folders/1kKO-eBmr3Prxzd8z5OBMv8S8QbMBJoLu?usp=sharing

Sampai tahap ini, HelloMedicine sudah dapat dijalankan. Namun tidak dapat terhubung dengan Database. Untuk dapat menghubungkannya dengan localhost Database pada Laptop, maka handphone Anda harus berbagi Network yang sama dengan Laptop Anda. 

Salah satu caranya adalah sebagai berikut.
1. Buka hotspot pada laptop, handphone Anda selain terhubung dengan kabel ke Laptop, juga terhubung dengan WiFi laptop
2. Buka cmd, ketik ipconfig dan cari IPv4 Address pada Local Area Network
3. Buka project flutter, pergi ke lib/network/api/url_api.dart kemudian ganti ipAddress dengan ipAddress Anda pada Point No. 2

HelloMedicine sudah dapat dijalankan
