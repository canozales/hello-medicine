import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/rolecustomer/pages/buatTab3/page/edit_address.dart';
import 'package:medhealth/theme.dart';
import '../widget/appbar_widget.dart';
import 'package:medhealth/rolecustomer/pages/buatTab3/widget/textfield_widget.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  var model;
  String idUser;
  EditProfilePage(this.model, this.idUser);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  setUser(String name, String phone, String email, String address) async {
    if (name == "" || phone == "" || email == "" || address == "") {
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
    var urlSetUser = Uri.parse(BASEURL.setUserDetail);
    final response = await http.post(urlSetUser, body: {
      'id_user': widget.idUser,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address
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
                                builder: (context) => MainPages(2)),
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
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              TextFieldWidget(
                label: 'Nama',
                text: widget.model['name'],
                onChanged: (name) => setState(() {
                  widget.model['name'] = name;
                }),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Phone',
                text: widget.model['phone'],
                onChanged: (phone) => setState(() {
                  widget.model['phone'] = phone;
                }),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: widget.model['email'],
                onChanged: (email) => setState(() {
                  widget.model['email'] = email;
                }),
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Alamat',
                text: widget.model['address'],
                maxLines: 5,
                onChanged: (address) => setState(() {
                  widget.model['address'] = address;
                }),
              ),
              const SizedBox(height: 24),
              ButtonPrimary(
                text: 'Ubah Alamat',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          EditAddressPage(widget.model, widget.idUser)));
                },
              ),
              const SizedBox(height: 16),
              ButtonPrimary(
                text: 'Simpan',
                onTap: () {
                  setUser(widget.model['name'], widget.model['phone'],
                      widget.model['email'], widget.model['address']);
                },
              ),
            ],
          ),
        ),
      );
}
