import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';

class CardCategory extends StatelessWidget {
  final String imageCategory;
  final String nameCategory;

  CardCategory({this.imageCategory, this.nameCategory});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageCategory,
          width: MediaQuery.of(context).size.width * .2,
          height: 70,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          nameCategory,
          style: mediumTextStyle.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
