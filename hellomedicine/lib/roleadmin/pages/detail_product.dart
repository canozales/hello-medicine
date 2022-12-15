import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/page/edit_product.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  DetailProduct(this.productModel);
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat = NumberFormat("#,##0", "EN_US");

  String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer);
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
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
                      color: redColor,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Informasi Produk",
                    style: regulerTextStyle.copyWith(
                        fontSize: 22, color: redColor),
                  )
                ])),
            SizedBox(
              height: 24,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .6,
              height: MediaQuery.of(context).size.width * .6,
              child: Image.memory(
                base64.decode(widget.productModel.imageProduct),
              ),
            ),
            // Container(
            //   height: 200,
            //   // color: whiteColor,
            //   child: Image.network(widget.productModel.imageProduct),
            // ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productModel.nameProduct,
                    style: regulerTextStyle.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.productModel.description,
                    style: regulerTextStyle.copyWith(
                        fontSize: 14, color: greyBoldColor),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "Rp " +
                            priceFormat
                                .format(int.parse(widget.productModel.price)),
                        style: boldTextStyle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(widget.productModel)));
                      },
                      text: "Edit Produk",
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
}
