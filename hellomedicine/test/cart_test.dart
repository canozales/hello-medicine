import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/cart_model.dart';
import 'package:http/http.dart' as http;

void main() {
  group("Memeriksa Fungsionalitas Cart", () {
    List<CartModel> listCart = [];

    getCart() async {
      listCart.clear();
      var urlGetCart = Uri.parse(BASEURL.getProductCart + "20");
      final response = await http.get(urlGetCart);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCart.add(CartModel.fromJson(item));
        }
        ;
      }
    }

    getCart();
    test("Quantity Verified", () {
      expect(listCart[0].quantity, equals("1"));
    });
    test("Name Verified", () {
      expect(listCart[0].name, equals("Narkoba"));
    });
    test("Price Verified", () {
      expect(listCart[0].price, equals("500000"));
    });
    test("Image Verified", () {
      expect(listCart[0].image, isNotEmpty);
    });
  });
}
