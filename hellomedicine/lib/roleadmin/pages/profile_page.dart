import 'package:flutter/material.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/rolecustomer/pages/login_page.dart';
import 'package:medhealth/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';

class ProfilePages extends StatefulWidget {
  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  String fullName, createdDate, phone, email, address;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = sharedPreferences.getString(PrefProfile.name);
      createdDate = sharedPreferences.getString(PrefProfile.cretedAt);
      phone = sharedPreferences.getString(PrefProfile.phone);
      email = sharedPreferences.getString(PrefProfile.email);
      address = sharedPreferences.getString(PrefProfile.address);
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Administrator",
                        style: regulerTextStyle.copyWith(
                            fontSize: 25, color: redColor),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName != null ? fullName : 'Handoko',
                        style: boldTextStyle.copyWith(fontSize: 18),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * .55,
                    child: Image.asset("assets/70.png"),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
