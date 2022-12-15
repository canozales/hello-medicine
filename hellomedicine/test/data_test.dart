import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:medhealth/network/model/product_model.dart';

void main() {
  group("Memeriksa Keberhasilan Fetching Data", () {
    List<ProductModel> listProduct = [];
    getProduct() async {
      listProduct.clear();
      var urlProduct = Uri.parse(BASEURL.getProduct);
      final response = await http.get(urlProduct);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (Map product in data) {
          listProduct.add(ProductModel.fromJson(product));
        }
        ;
      }
    }

    getProduct();
    test("First Data Retrieved", () {
      expect(listProduct[0].idProduct, equals("46"));
    });
    test("Last Data Retrieved", () {
      expect(listProduct[8].idProduct, equals("59"));
    });
    test("Data's Details Shown Correctly", () {
      expect(listProduct[4].description, equals("Sederhana"));
      expect(listProduct[5].nameProduct, equals("Urinal Sirup"));
      expect(listProduct[6].price, equals("15000"));
    });
  });
}
