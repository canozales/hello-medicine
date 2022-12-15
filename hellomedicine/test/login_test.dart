import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/cart_model.dart';
import 'package:http/http.dart' as http;

void main() {
  String value, idUser, name, email, phone, address;
  group("Memeriksa Login System", () {
    submitLogin() async {
      var urlLogin = Uri.parse(BASEURL.apiLogin);
      final response = await http.post(urlLogin, body: {
        "email": "adelacorissa@gmail.com",
        "password": "adelacorissa"
      });
      final data = jsonDecode(response.body);
      value = data['value'];
      idUser = data['user_id'];
      name = data['name'];
      email = data['email'];
      phone = data['phone'];
    }

    submitLogin();
    test("Login Successful", () {
      expect(value, equals("1"));
    });
    test("Information Retrieved Correctly", () {
      expect(name, equals("Adela Corissa"));
      expect(email, equals("adelacorissa@gmail.com"));
      expect(phone, equals("089677885540"));
      expect(idUser, equals("20"));
    });
  });
}
