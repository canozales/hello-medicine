import 'dart:convert';

import 'dart:typed_data';
import 'package:medhealth/main_page_admin.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/model/product.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/utils/product_detail.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/widget/profile_widget.dart';
import '../../../../theme.dart';
import '../widget/appbar_widget.dart';
import 'package:medhealth/rolecustomer/pages/buatTab3/widget/textfield_widget.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  final ProductModel productModel;
  EditProfilePage(this.productModel);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final kurir = ['Batuk', 'Demam', 'Pusing', 'Perut', 'Tenggorokan', 'Lainnya'];

  Product product;

  deleteProduk() async {
    var urlHapusProduk =
        Uri.parse(BASEURL.deleteProduct + widget.productModel.idProduct);
    final response = await http.get(urlHapusProduk);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var pesan = data['message'];
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Pengumuman",
                  style: TextStyle(color: redColor),
                ),
                content: Text(pesan),
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
    } else {}
  }

  editProduk(String imagePath, String name, String kategori, String harga,
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
    var urlEditProduk = Uri.parse(BASEURL.editProduct);
    final response = await http.post(urlEditProduk, body: {
      "id_category": kategori,
      "name": name,
      "description": informasi,
      "gambar": imagePath,
      "harga": harga,
      "id_product": widget.productModel.idProduct
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
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
    }
  }

  @override
  void initState() {
    super.initState();
    product = ProductDetail.getProduct();

    setState(() => product = product.copy(
          imagePath: widget.productModel.imageProduct,
          name: widget.productModel.nameProduct,
          harga: widget.productModel.price,
          informasi: widget.productModel.description,
        ));
    if (widget.productModel.idCategory == "1") {
      setState(() => product = product.copy(kategori: "Batuk"));
    } else if (widget.productModel.idCategory == "2") {
      setState(() => product = product.copy(kategori: "Demam"));
    } else if (widget.productModel.idCategory == "3") {
      setState(() => product = product.copy(kategori: "Pusing"));
    } else if (widget.productModel.idCategory == "4") {
      setState(() => product = product.copy(kategori: "Perut"));
    } else if (widget.productModel.idCategory == "5") {
      setState(() => product = product.copy(kategori: "Tenggorokan"));
    } else {
      setState(() => product = product.copy(kategori: "Lainnya"));
    }
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
                // imagePath: widget.productModel.imageProduct,
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
                    value: product.kategori,
                    items: kurir.map(buildMenuItem).toList(),
                    iconSize: 31,
                    icon: Icon(
                      Icons.policy,
                      color: redColor,
                    ),
                    isExpanded: true,
                    onChanged: (value) => setState(() {
                      product = product.copy(kategori: value);
                    }),
                  ),
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
                onChanged: (about) => product = product.copy(informasi: about),
              ),
              const SizedBox(height: 24),
              ButtonPrimary(
                text: 'Hapus Item',
                onTap: () {
                  deleteProduk();
                },
              ),
              const SizedBox(height: 15),
              ButtonPrimary(
                text: 'Save',
                onTap: () {
                  editProduk(product.imagePath, product.name, product.kategori,
                      product.harga, product.informasi);
                  Navigator.of(context).pop();
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
