import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wave_app/shared/utils/functions.dart';
import 'package:wave_app/shared/network/local/cache_helper.dart';

String langCode = "en";

bool isLogin = true;
void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(context, Container() // ShopLoginScreen(),
          );
    }
  });
}
