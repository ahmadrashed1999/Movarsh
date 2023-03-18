import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movarsh/constant/database/database.dart';
import 'package:movarsh/constant/theme.dart';
import 'package:movarsh/controllers/favcontroller.dart';
import 'package:movarsh/view/layout/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Sql().intialDataBase();
  runApp(const MyApp());
}

FavController favController = Get.find();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FavController _controller = Get.put(FavController(), permanent: true);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: 300,
          backgroundColor: secondaryColor,
          splash: Container(
            color: secondaryColor,
            width: 500,
            height: 500,
            child: Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_cbrbre30.json'),
          ),
          nextScreen: HomePage()),
    );
  }
}
