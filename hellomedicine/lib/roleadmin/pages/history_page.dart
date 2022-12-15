import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/history_model.dart';
import 'package:medhealth/roleadmin/pages/buatTab3/widget/card_history.dart';
import 'package:medhealth/theme.dart';
import 'package:http/http.dart' as http;

class HistoryPages extends StatefulWidget {
  @override
  _HistoryPagesState createState() => _HistoryPagesState();
}

class _HistoryPagesState extends State<HistoryPages> {
  List tabBarList = ["Konfirmasi", "Pengantaran"];
  int tabBarIndex = 0;
  int balanceBalance = 0;
  bool isBrush = false;
  bool isCollapseNavBottom = true;
  var _scrollController = ScrollController();

  List<HistoryOrdelModel> list = [];
  String userID;
  String nama;

  getHistory() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder);
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

  getHistory2() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder2);
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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0) {
        isBrush = true;
        setState(() {});
      } else {
        isBrush = false;
      }
    });
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBarItem(int index) {
      return Expanded(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.all(5),
                height: double.infinity,
                decoration: BoxDecoration(
                    color: (tabBarIndex == index)
                        ? Colors.white // Warna Tiga
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(100)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (tabBarIndex != index) {
                        tabBarIndex = index;
                        if (index == 0) {
                          getHistory();
                        } else if (index == 1) {
                          getHistory2();
                        }
                      }
                    });
                  },
                  child: Center(
                    child: Text(
                      tabBarList[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: (tabBarIndex == index)
                              ? Color.fromRGBO(203, 132, 114, 1) // Warna Empat
                              : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      );
    }

    Widget tabBar() {
      return Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromRGBO(203, 132, 114, 1), // Warna Dua
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          children: [
            tabBarItem(0),
            tabBarItem(1),
          ],
        ),
      );
    }

    ;
    return Scaffold(
      body: SafeArea(
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Text(
                "Sedang Berlangsung",
                style: regulerTextStyle.copyWith(
                    fontSize: 24, color: Color.fromRGBO(203, 132, 114, 1)),
              )),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: tabBar(),
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
                          height: 40,
                        ),
                        Text(
                          "Belum ada History",
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
                      child: CardHistory(x),
                    );
                  }),
        ]),
      ),
    );
  }
}
