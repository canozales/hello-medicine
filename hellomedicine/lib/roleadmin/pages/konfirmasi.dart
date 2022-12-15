import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/main_page_admin.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/history_model.dart';

import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:http/http.dart' as http;

class Konpirmasi extends StatefulWidget {
  final HistoryOrdelModel model;

  Konpirmasi(this.model);

  @override
  _KonpirmasiState createState() => _KonpirmasiState();
}

class _KonpirmasiState extends State<Konpirmasi> {
  int total = 0;
  final price = NumberFormat("#,##0", "EN_US");

  ubahStatus(
      String status, String invoice, String pengantar, String id_driver) async {
    var urlUbahStatus = Uri.parse(BASEURL.ubahStatus);
    final response = await http.post(urlUbahStatus, body: {
      "invoice": invoice,
      "status": status,
      "pengantar": pengantar,
      "id_driver": id_driver
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
                  style: TextStyle(color: Color.fromRGBO(203, 132, 114, 1)),
                ),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPagesAdmin(1)),
                            (route) => false);
                      },
                      child: Text(
                        "OK",
                        style:
                            TextStyle(color: Color.fromRGBO(203, 132, 114, 1)),
                      ))
                ],
              ));
    }
  }

  getDriver() async {
    var urlGetDriver = Uri.parse(BASEURL.getDriver);
    final response = await http.get(urlGetDriver);
    if (response.statusCode == 200) {
      pengantar.clear();
      final List data = jsonDecode(response.body);
      setState(() {
        terisi = true;
      });
      data.forEach((element) {
        setState(() {
          pengantar.add(element['name']);
          idPengantar.add(element['id_user']);
        });
      });
    }
    print(idPengantar);
  }

  getPrice() async {
    widget.model.detail.forEach((element) {
      total += int.parse(element.price) * int.parse(element.quantity);
    });
    widget.model.detail.map((x) => {
          print(x.price),
          setState(() {
            total = total + int.parse(x.price);
          })
        });
  }

  final priceFormat = NumberFormat("#,##0", "EN_US");

  int urutan = 0;
  bool terisi = false;
  var pengantar = [''];
  var idPengantar = [];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPrice();
    getDriver();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                height: 70,
                child: Row(children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 28,
                      color: Color.fromRGBO(203, 132, 114, 1),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Pengantaran",
                    style: regulerTextStyle.copyWith(
                        fontSize: 22, color: Color.fromRGBO(203, 132, 114, 1)),
                  ),
                ])),
            Container(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Informasi Pengantaran",
                  //   style: regulerTextStyle.copyWith(fontSize: 18),
                  // ),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nama",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        widget.model.name,
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Alamat",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        widget.model.address,
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Telepon",
                        // style: boldTextStyle.copyWith(fontSize: 16),
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        widget.model.phone,
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        // style: boldTextStyle.copyWith(fontSize: 16),
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "Rp " + widget.model.totalprice,
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      // itemCount: entries.length,
                      itemCount: widget.model.detail.length,
                      itemBuilder: (BuildContext context, int index) {
                        final x = widget.model.detail[index];
                        return Container(
                          height: 70,

                          // child: Center(child: Text('Entry ${entries[index]}')),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(
                                      base64.decode(x.gambar),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  x.nameProduct + " " + x.quantity + "x",
                                  style: regulerTextStyle.copyWith(
                                      fontSize: 16, color: greyBoldColor),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Pilih Pengantar",
                    style: regulerTextStyle.copyWith(fontSize: 18),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromRGBO(203, 132, 114, 1), width: 2)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: pengantar[urutan],
                        items: terisi
                            ? pengantar.map(buildMenuItem).toList()
                            : null,
                        iconSize: 38,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromRGBO(203, 132, 114, 1),
                        ),
                        isExpanded: true,
                        onChanged: (x) =>
                            setState(() => urutan = pengantar.indexOf(x)),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      color: Color.fromRGBO(203, 132, 114, 1),
                      onTap: () {
                        ubahStatus("2", widget.model.invoice, pengantar[urutan],
                            idPengantar[urutan]);
                      },
                      text: "KONFIRMASI",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: regulerTextStyle.copyWith(fontSize: 18),
        ),
      );
}
