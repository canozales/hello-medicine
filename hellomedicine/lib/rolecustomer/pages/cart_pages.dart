import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/cart_model.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/rolecustomer/pages/success_checkout.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cool_alert/cool_alert.dart';

class CartPages extends StatefulWidget {
  final VoidCallback method;
  CartPages(this.method);
  @override
  _CartPagesState createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  final price = NumberFormat("#,##0", "EN_US");
  String userID, fullName, address, phone, lat, lng, tempat;

  int delivery = 0;
  var sumPrice = "0";
  int totalPayment = 0;

  hitungDelivery() {
    if (lat == "" || lng == "") {
      return;
    } else {
      double x = Geolocator.distanceBetween(-6.9694673693534295,
          107.62813581578477, double.parse(lat), double.parse(lng));
      if (x > 15000) {
        setState(() {
          delivery = -1;
        });
        return;
      }
      while (x > 0) {
        x -= 1000;
        setState(() {
          delivery += 5000;
        });
      }
    }
  }

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer);
    });
    await getUser();
    getCart();
    cartTotalPrice();
    hitungDelivery();
  }

  getUser() async {
    var urlGetUser = Uri.parse(BASEURL.getUserDetail + userID);
    final response = await http.get(urlGetUser);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        fullName = result['name'];
        address = result['address'];
        phone = result['phone'];
        lat = result['latitude'];
        lng = result['longtitude'];
        tempat = result['address'];
      });
    }
  }

  List<CartModel> listCart = [];
  getCart() async {
    listCart.clear();
    var urlGetCart = Uri.parse(BASEURL.getProductCart + userID);
    final response = await http.get(urlGetCart);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
    }
  }

  updateQuantity(String tipe, String model) async {
    var urlUpdateQuantity = Uri.parse(BASEURL.updateQuantityProductCart);
    final response = await http
        .post(urlUpdateQuantity, body: {"cartID": model, "tipe": tipe});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        getCart();
        cartTotalPrice();
        widget.method();
      });
    } else {
      print(message);
      setState(() {
        getCart();
        cartTotalPrice();
      });
    }
  }

  checkout() async {
    if (tempat == "Tidak Terdefinisi") {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Pengumuman",
                  style: TextStyle(color: redColor),
                ),
                content: Text("Silahkan Atur Alamat Anda"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: redColor),
                      ))
                ],
              ));
      return;
    } else if (lat == "0" || lng == "0") {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Pengumuman",
                  style: TextStyle(color: redColor),
                ),
                content: Text("Atur Alamat Anda via Google Maps"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: redColor),
                      ))
                ],
              ));
      return;
    } else if (delivery == -1) {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Pengumuman",
                  style: TextStyle(color: redColor),
                ),
                content: Text("Alamat Anda Terlalu Jauh"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: redColor),
                      ))
                ],
              ));
      return;
    }
    var urlCheckout = Uri.parse(BASEURL.checkout);
    final response = await http.post(urlCheckout, body: {
      "idUser": userID,
      "totalprice": price.format(delivery + int.parse(sumPrice))
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      CoolAlert.show(
          context: context,
          barrierDismissible: false,
          type: CoolAlertType.info,
          text: 'Lakukan Transfer\nSebesar Rp ' +
              price.format(delivery + int.parse(sumPrice)) +
              '\n\nBank BCA 82844560\nAdela Corissa',
          confirmBtnText: 'OK',
          title: "Pengumuman",
          confirmBtnColor: redColor,
          backgroundColor: Color.fromARGB(255, 234, 196, 196),
          onConfirmBtnTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SuccessCheckout(
                      price.format(delivery + int.parse(sumPrice)))),
              (route) => false));
    } else {
      print(message);
    }
  }

  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(BASEURL.totalPriceCart + userID);
    final response = await http.get(urlTotalPrice);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var total = data['Total'];
      setState(() {
        total == null ? sumPrice = "0" : sumPrice = total;
      });
      print(sumPrice);
    }
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listCart.length == 0
          ? SizedBox()
          : Container(
              padding: EdgeInsets.all(24),
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 234, 196, 196),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Items",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "Rp " + price.format(int.parse(sumPrice)),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        delivery == -1
                            ? "UNAVAILABLE"
                            : "Rp " + price.format(delivery),
                        style: boldTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: regulerTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        delivery == -1
                            ? "Rp " + price.format(int.parse(sumPrice))
                            : "Rp " +
                                price.format(delivery + int.parse(sumPrice)),
                        style: boldTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      onTap: () {
                        checkout();
                      },
                      text: "CHECKOUT NOW",
                    ),
                  )
                ],
              ),
            ),
      body: SafeArea(
          child: ListView(
        padding: listCart.length == 0 || listCart.length == null
            ? EdgeInsets.only(bottom: 0)
            : EdgeInsets.only(bottom: 220),
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Row(children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_rounded,
                      size: 32,
                      color: listCart.length == 0 || listCart.length == null
                          ? Color.fromRGBO(254, 90, 78, 1)
                          : redColor),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Keranjang",
                  style: regulerTextStyle.copyWith(
                      fontSize: 25,
                      color: listCart.length == 0 || listCart.length == null
                          ? Color.fromRGBO(254, 90, 78, 1)
                          : redColor),
                )
              ])),
          listCart.length == 0 || listCart.length == null
              ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Text(
                        "Belum ada Keranjang",
                        style: regulerTextStyle.copyWith(
                            fontSize: 20,
                            color: Color.fromRGBO(254, 90, 78, 1)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .014,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * .79,
                        child: Image.asset("assets/64.png"),
                      )
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(24),
                  height: 166,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Destination",
                        style: regulerTextStyle.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: 16,
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
                            "$fullName",
                            style: boldTextStyle.copyWith(fontSize: 16),
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
                            "Address",
                            style: regulerTextStyle.copyWith(
                                fontSize: 16, color: greyBoldColor),
                          ),
                          Text(
                            "$address".length <= 20
                                ? "$address"
                                : "$address".substring(0, 20) + " ...",
                            style: boldTextStyle.copyWith(fontSize: 16),
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
                            "Phone",
                            style: regulerTextStyle.copyWith(
                                fontSize: 16, color: greyBoldColor),
                          ),
                          Text(
                            "$phone",
                            style: boldTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          ListView.builder(
              itemCount: listCart.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, i) {
                final x = listCart[i];
                return Container(
                  padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.memory(
                            base64.decode(x.image),
                            width: 115,
                            height: 100,
                          ),
                          // Image.network(
                          //   x.image,
                          //   width: 115,
                          //   height: 100,
                          // ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 9),
                                  child: Text(
                                    x.name,
                                    style:
                                        regulerTextStyle.copyWith(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: redColor,
                                          ),
                                          onPressed: () {
                                            updateQuantity("kurang", x.idCart);
                                          }),
                                      Text(x.quantity),
                                      IconButton(
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: greenColor,
                                          ),
                                          onPressed: () {
                                            updateQuantity("tambah", x.idCart);
                                          }),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 9),
                                  child: Text(
                                    "Rp " + price.format(int.parse(x.price)),
                                    style: boldTextStyle.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Divider()
                    ],
                  ),
                );
              })
        ],
      )),
    );
  }
}
