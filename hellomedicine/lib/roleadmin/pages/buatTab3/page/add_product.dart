import 'dart:convert';
import 'dart:typed_data';
import 'package:medhealth/main_page_admin.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/model/product.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/utils/product_detail.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/widget/profile_widget.dart';
import '../../../../theme.dart';
import '../widget/appbar_widget.dart';
import 'package:medhealth/rolecustomer/pages/buatTab3/widget/textfield_widget.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final kurir = ['Batuk', 'Demam', 'Pusing', 'Perut', 'Tenggorokan', 'Lainnya'];

  String value = "Batuk";

  Product product;

  tambahProduk(String imagePath, String name, String kategori, String harga,
      String informasi) async {
    if (name == "" ||
        imagePath == "" ||
        kategori == "" ||
        harga == "" ||
        informasi == "") {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Pengumuman",
                  style: TextStyle(color: redColor),
                ),
                content: Text("Terdapat Kekosongan"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: redColor),
                      ))
                ],
              ));
      return;
    }
    var urlTambahProduk = Uri.parse(BASEURL.addProduct);
    final response = await http.post(urlTambahProduk, body: {
      "id_category": kategori,
      "name": name,
      "description": informasi,
      "gambar": imagePath,
      "harga": harga
    });
    final data = jsonDecode(response.body);
    int responValue = data['value'];
    String message = data['message'];
    if (responValue == 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Pengumuman",
                  style: TextStyle(color: redColor),
                ),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPagesAdmin(0)),
                            (route) => false);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: redColor),
                      ))
                ],
              ));
      print(message);
    }
  }

  @override
  void initState() {
    super.initState();

    product = ProductDetail.getProduct();
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: product.imagePath,
                isEdit: true,
                onClicked: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  if (image == null) return;

                  // final directory = await getApplicationDocumentsDirectory();
                  // final name = basename(image.path);

                  // final imageFile = File('${directory.path}/$name');
                  // final newImage = await File(image.path).copy(imageFile.path);

                  // setState(() => user = user.copy(imagePath: newImage.path));
                  Uint8List bytes = await image.readAsBytes();
                  String encodedImage = base64Encode(bytes);

                  setState(
                      () => product = product.copy(imagePath: encodedImage));
                },
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Nama Produk',
                text: product.name,
                onChanged: (name) => product = product.copy(name: name),
              ),
              const SizedBox(height: 24),
              Text(
                "Kategori",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 9),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Color.fromRGBO(165, 165, 165, 1), width: 1)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: value,
                      items: kurir.map(buildMenuItem).toList(),
                      iconSize: 31,
                      icon: Icon(
                        Icons.policy,
                        color: redColor,
                      ),
                      isExpanded: true,
                      onChanged: (value) => {
                            product = product.copy(kategori: value),
                            setState(() => this.value = value)
                          }),
                ),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Harga',
                text: product.harga,
                onChanged: (harga) => product = product.copy(harga: harga),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Informasi',
                text: product.informasi,
                maxLines: 5,
                onChanged: (informasi) =>
                    product = product.copy(informasi: informasi),
              ),
              const SizedBox(height: 24),
              ButtonPrimary(
                text: 'Tambah Produk',
                onTap: () {
                  // print(product.name);
                  // print(value);
                  // print(product.harga);
                  // print(product.informasi);
                  // print(product.imagePath);

                  tambahProduk(product.imagePath, product.name, value,
                      product.harga, product.informasi);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      );
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}
