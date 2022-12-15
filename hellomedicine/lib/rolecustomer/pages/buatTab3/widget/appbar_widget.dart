import 'package:flutter/material.dart';
import 'package:medhealth/rolecustomer/pages/buatTab3/utils/user_preferences.dart';

AppBar buildAppBar(BuildContext context) {
  final user = UserPreferences.getUser();

  return AppBar(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
    elevation: 0,
  );
}
