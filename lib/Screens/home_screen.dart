import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/Screens/chat_screen.dart';
import 'package:firebase_tut/Screens/homes_screen.dart';
import 'package:firebase_tut/Screens/profile_screen.dart';
import 'package:firebase_tut/Screens/search_screen.dart';
import 'package:firebase_tut/Screens/video.dart';
import 'package:firebase_tut/Screens/login.dart';
import 'package:firebase_tut/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = [
    HomesScreen(),
    SearchScreen(),
    VideoScreen(),
    ChatScreen(),
    ProfileScreen()


  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black54,
        elevation: 0,
        selectedItemColor: AppColors.carrot,
        showUnselectedLabels: true,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedFontSize: 12,
        selectedLabelStyle: TextStyle(
          fontFamily: "Finlandia",
          fontWeight: FontWeight.w500
        ),
        unselectedLabelStyle: TextStyle(
            fontFamily: "Finlandia",
            fontWeight: FontWeight.w500
        ),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label : "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label : "Profile"),
        ],

      ),
    );
  }
}
