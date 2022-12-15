import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/rolecustomer/pages/buatTab3/page/edit_profile_page.dart';
import 'package:medhealth/rolecustomer/pages/login_page.dart';
import 'package:medhealth/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;

class ProfilePages extends StatefulWidget {
  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  _getRequests() async {}
  String fullName, createdDate, phone, email, address, idUser;
  var id = "9";

  var model;
  getUser() async {
    var urlGetUser = Uri.parse(BASEURL.getUserDetail + idUser);
    final response = await http.get(urlGetUser);
    if (response.statusCode == 200) {
      setState(() {
        model = jsonDecode(response.body);
        fullName = model['name'];
        phone = model['phone'];
        email = model['email'];
        address = model['address'];
      });
    }
  }

  getUserRefresh() async {
    var urlGetUser = Uri.parse(BASEURL.getUserDetail + idUser);
    final response = await http.get(urlGetUser);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await setState(() {
      createdDate = sharedPreferences.getString(PrefProfile.cretedAt);
      idUser = sharedPreferences.getString(PrefProfile.idUSer);
      getUser();
    });
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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Profile",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                Container(
                  child: Row(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditProfilePage(model, idUser)));
                        },
                        child: Icon(
                          Icons.settings,
                          color: redColor,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        signOut();
                      },
                      child: Icon(
                        Icons.exit_to_app,
                        color: redColor,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName != null ? fullName : 'Handoko',
                  style: boldTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  createdDate != null
                      ? "Tanggal Bergabung " +
                          formatDate(DateTime.parse(createdDate),
                              [dd, '/', mm, '/', yyyy])
                      : 'Handoko',
                  style: lightTextStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  phone != null ? phone : 'Handoko',
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  email != null ? email : 'Handoko',
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  address != null ? address : 'Handoko',
                  style: boldTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
