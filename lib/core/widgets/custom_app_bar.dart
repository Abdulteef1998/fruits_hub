import 'package:ecomerce_market/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(context, {required String title}) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios_new),
    ),
    centerTitle: true,
    title: Text(
      'تسجيل دخول',
      style: TextStyles.bold19,
      textAlign: TextAlign.center,
    ),
  );
}
