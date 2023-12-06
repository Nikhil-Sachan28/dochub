import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(LoginScreen());
              },
            ),
          ],
        ),
        body: Center(
            child : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 100,),
                  Text("In Development", style: TextStyle(
                      fontSize: 24
                  ),)
      
                ])
        ),
      ),
    );
  }
}
