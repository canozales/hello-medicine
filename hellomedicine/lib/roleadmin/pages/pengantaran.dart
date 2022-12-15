import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/network/model/history_model.dart';
import 'package:medhealth/theme.dart';
import 'package:http/http.dart' as http;

class Pengantaran extends StatefulWidget {
  final HistoryOrdelModel model;
  Pengantaran(this.model);

  @override
  _PengantaranState createState() => _PengantaranState();
}

class _PengantaranState extends State<Pengantaran> {
  final priceFormat = NumberFormat("#,##0", "EN_US");
  final kurir = [
    'Farel Edris Putra',
    'Farel Putra Edris',
    'Edrison Putra Farel'
  ];
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  String value = "Farel Edris Putra";

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
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
                    "Status Pengantaran",
                    style: regulerTextStyle.copyWith(
                        fontSize: 22, color: Color.fromRGBO(203, 132, 114, 1)),
                  ),
                ])),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
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
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pengantar",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        widget.model.pengantar == null
                            ? 'Tidak Ada'
                            : widget.model.pengantar,
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
                        "Status",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        widget.model.status,
                        // style: boldTextStyle.copyWith(fontSize: 16),
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
