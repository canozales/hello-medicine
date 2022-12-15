import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CardProduct extends StatelessWidget {
  final String imageProduct;
  final String nameProduct;
  final String price;
  CardProduct({this.imageProduct, this.nameProduct, this.price});
  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat("#,##0", "EN_US");
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.memory(
            base64.decode(imageProduct),
            width: MediaQuery.of(context).size.width * .5,
            height: MediaQuery.of(context).size.width * .2,
          ),
          // Image.network(
          //   imageProduct,
          //   width: MediaQuery.of(context).size.width * .5,
          //   height: MediaQuery.of(context).size.width * .2,
          // ),
          SizedBox(
            height: 16,
          ),
          AutoSizeText(
            nameProduct,
            style: regulerTextStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Rp " + priceFormat.format(int.parse(price)),
            style: boldTextStyle,
          )
        ],
      ),
    );
  }
}
