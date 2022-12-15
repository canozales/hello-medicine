import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';

class SuccessCheckout extends StatelessWidget {
  String price;
  SuccessCheckout(this.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/logomed.png",
              width: 260,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Pesanan Anda Menunggu Konfirmasi",
              style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Lakukan Pembayaran Rp " + price,
              style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor),
            ),
            Text(
              "BCA 8210530655 - Adela Corissa",
              style: regulerTextStyle.copyWith(
                  fontSize: 16, color: greyLightColor),
            ),
            SizedBox(
              height: 25,
            ),
            ButtonPrimary(
              color: Color.fromRGBO(62, 67, 90, 1),
              text: "BACK TO HOME",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPages(0)),
                    (route) => false);
              },
            )
          ],
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * .57,
              child: Image.asset("assets/62.png"),
            )),
      ],
    ));
  }
}
