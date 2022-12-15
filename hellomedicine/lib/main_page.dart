import 'package:flutter/material.dart';
import 'package:medhealth/rolecustomer/pages/history_page.dart';
import 'package:medhealth/rolecustomer/pages/home_page.dart';
import 'package:medhealth/rolecustomer/pages/profile_page.dart';
import 'package:medhealth/theme.dart';

class MainPages extends StatefulWidget {
  int _selectIndex;
  MainPages(this._selectIndex);

  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  final _pageList = [
    HomePages(),
    HistoryPages(),
    ProfilePages(),
  ];

  onTappedItem(int index) {
    setState(() {
      widget._selectIndex = index;
    });
  }

  Color cekWarna(index) {
    if (index == 0) {
      return redColor;
    } else if (index == 1) {
      return Color.fromRGBO(203, 132, 114, 1);
    } else {
      return redColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(widget._selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Profile"),
        ],
        currentIndex: widget._selectIndex,
        onTap: onTappedItem,
        selectedItemColor: cekWarna(widget._selectIndex),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 26,
        unselectedItemColor: grey35Color,
      ),
    );
  }
}
