import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child : Column(
                mainAxisSize: MainAxisSize.min,
                  children: [
                Icon(Icons.search, size: 100,),
                Text("In Development", style: TextStyle(
                  fontSize: 24
                ),)

              ])
          )),
    );
  }
}
