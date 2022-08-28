import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:singer_app/app/routes/setup_routes.router.dart';
import 'package:singer_app/config/size_config.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'config/color_config.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskColor = Colors.black.withOpacity(0.5)
      ..maskType = EasyLoadingMaskType.custom
      ..backgroundColor = ColorConfig.accentColor.withAlpha(1)
      ..textColor = Colors.white
      ..indicatorColor = Colors.white;

    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'Chat App',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cursorColor: ColorConfig.accentColor,
        accentColor: ColorConfig.accentColor,
        primaryColor: ColorConfig.primaryColor,
        dividerColor: Colors.black26,
        fontFamily: 'Poppins',
      ), //authService().handleAuth()//SubScriptionView()//KycViewHolder()//RegistrationViewHolder(currentPageToShow: 3,),
    );
  }
}
