import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/rolecustomer/pages/login_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userID;
  // getPref() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     userID = sharedPreferences.getString(PrefProfile.idUSer);
  //     userID == null ? sessionLogout() : sessionLogin();
  //   });
  // }

  sessionLogout() {}
  sessionLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPages(0)));
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              "assets/logomed.png",
              width: 260,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Melayani dengan Sepenuh Hati",
              style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonPrimary(
              text: "MEMULAI",
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPages()));
              },
            ),
          ],
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * .57,
              child: Image.asset("assets/61.png"),
            )),
      ],
    ));
  }
}
