import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todo_app_v1/BottomNavigator/BottomNavigatorBar.dart';
import 'package:todo_app_v1/Global/SecureStorage.dart';
import 'package:todo_app_v1/Login/Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    bool alreadyLoginFromStorage = await SecureStorage.getAlreadyLogin() == 'true' ? true : false;

    FlutterNativeSplash.remove();

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => alreadyLoginFromStorage ? BottomNavigator() : Login(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/reqres.jpeg',
        ),
      ),
    );
  }
}
