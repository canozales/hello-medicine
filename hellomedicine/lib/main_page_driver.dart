import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/history_model.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/rolecustomer/pages/login_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/roledriver/card_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BuatDriver extends StatefulWidget {
  @override
  _BuatDriverState createState() => _BuatDriverState();
}

class _BuatDriverState extends State<BuatDriver> {
  List<HistoryOrdelModel> list = [];
  String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer);
    });
    getHistory0();
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefProfile.idUSer);
    sharedPreferences.remove(PrefProfile.name);
    sharedPreferences.remove(PrefProfile.email);
    sharedPreferences.remove(PrefProfile.phone);
    sharedPreferences.remove(PrefProfile.address);
    sharedPreferences.remove(PrefProfile.cretedAt);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPages()),
        (route) => false);
  }

  getHistory0() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder4 + userID);
    final response = await http.get(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          list.add(HistoryOrdelModel.fromJson(item));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tugas Pengantaran",
                  style:
                      regulerTextStyle.copyWith(fontSize: 25, color: redColor),
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      signOut();
                    },
                    child: Icon(
                      Icons.exit_to_app,
                      color: redColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          list.length == 0
              ? Column(
                  children: [
                    Container(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Belum ada Pengantaran",
                          style: regulerTextStyle.copyWith(
                              fontSize: 20,
                              color: Color.fromRGBO(203, 132, 114, 1)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          "assets/53.png",
                          width: MediaQuery.of(context).size.width * .6,
                        ),
                      ],
                    ))
                  ],
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      child: CardHistory(
                        model: x,
                      ),
                    );
                  }),
        ]),
      ),
    );
  }
}
