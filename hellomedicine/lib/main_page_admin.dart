import 'package:flutter/material.dart';
import 'package:medhealth/roleadmin/pages/history_page.dart';
import 'package:medhealth/roleadmin/pages/home_page.dart';
import 'package:medhealth/roleadmin/pages/profile_page.dart';
import 'package:medhealth/theme.dart';

class MainPagesAdmin extends StatefulWidget {
  int _selectIndex;
  MainPagesAdmin(this._selectIndex);

  @override
  _MainPagesAdminState createState() => _MainPagesAdminState();
}

class _MainPagesAdminState extends State<MainPagesAdmin> {
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
