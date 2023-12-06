import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/utils/colors.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3),
            ()=>
                Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
              (FirebaseAuth.instance.currentUser!=null)?HomeScreen(): LoginScreen(),
            )
        )
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/splash.png"),
                Text("DocHub", style: TextStyle(
                  fontSize: 30,
                  color: AppColors.carrot,
                  fontFamily: "Finlandia",
                  fontWeight: FontWeight.w500
                ),)
              ],
            ),
          ),
      ),
    );
  }
}
