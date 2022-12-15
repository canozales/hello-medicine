import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:medhealth/network/model/history_model.dart';

void main() {
  group("Memeriksa Fungsionalitas History", () {
    List<HistoryOrdelModel> list = [];

    getHistory0() async {
      list.clear();
      var urlHistory = Uri.parse(BASEURL.historyOrder3 + "20");
      final response = await http.get(urlHistory);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          list.add(HistoryOrdelModel.fromJson(item));
        }
      }
    }

    getHistory0();
    test("Name Retrieved Correctly", () {
      expect(list[0].name, equals("Adela Corissa"));
    });
    test("Phone Retrieved Correctly", () {
      expect(list[0].phone, equals("089677885540"));
    });
    test("Price Retrieved Correctly", () {
      expect(list[0].totalprice, equals("20,000"));
    });
    test("Invoice Retrieved Correctly", () {
      expect(list[0].invoice, equals("20220613045817"));
    });
    test("Driver Retrieved Correctly", () {
      expect(list[0].pengantar, equals("Farelia Elma Shelina"));
    });
    test("Price Detail Retrieved Correctly", () {
      expect(list[0].detail[0].price, equals("10000"));
    });
    test("Quantity Retrieved Correctly", () {
      expect(list[0].detail[0].quantity, equals("1"));
    });
    test("Name Detail Retrieved Correctly", () {
      expect(list[0].detail[0].nameProduct, equals("Panadol Anak"));
    });
    test("Image Retrieved Correctly", () {
      expect(list[0].detail[0].gambar, isNotNull);
    });
    test("Address Retrieved Correctly", () {
      expect(list[0].address, "PURI KHARISMA");
    });
  });
}
