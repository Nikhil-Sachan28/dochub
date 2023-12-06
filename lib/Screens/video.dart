import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.video_call, size: 100,),
                    Text("In Development", style: TextStyle(
                        fontSize: 24
                    ),)

                  ])
          )),
    );
  }
}
