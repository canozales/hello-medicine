import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/cart_model.dart';
import 'package:http/http.dart' as http;

void main() {
  int value;

  registerSubmit() async {
    var registerUrl = Uri.parse(BASEURL.apiRegister);
    final response = await http.post(registerUrl, body: {
      "fullname": "Unit Testing",
      "email": "unittesting@gmail.com",
      "phone": '123456789',
      "address": "Unit Testing",
      "password": "unittesting",
    });

    final data = jsonDecode(response.body);
    value = data['value'];
  }

  registerSubmit();
  test("Register Successful", () {
    expect(value, equals(0));
  });
}
