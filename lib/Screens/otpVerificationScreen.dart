import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/controller/login_controller.dart';
import 'package:firebase_tut/Screens/home_screen.dart';
import 'package:firebase_tut/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final String number;
  const OtpVerificationScreen({super.key, required this.verificationId, required this.number});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController sms = TextEditingController();
  int StartTime = 30;
   LoginController loginController = Get.put(LoginController());
   bool isClicked = false;

  @override
  void initState() {
    // pinputController = Get.put(pinputController);
    // Timer.periodic(Duration(seconds: 1), (timer){
    //   if(StartTime==0){
    //     setState(() {
    //       timer.cancel();
    //     });
    //     timer.cancel();
    //   }else{
    //     setState(() {
    //       StartTime--;
    //     });
    //   }
    // });
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.carrot),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
        border: Border.all(color: Colors.black54)
      ),
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Icon(
                Icons.help,
                size: 22,
              ),
              Text("Help", style: TextStyle(
                fontFamily: "Finlandia",
                fontWeight: FontWeight.w500,
                fontSize: 16
              ),),
              SizedBox(width: 10,)
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          // mainAxisSize:  MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter 6- Digit OTP sent to ${widget.number.toString()}", style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Finlandia"
              ),
            ),
            SizedBox(height: 20,),
            Text("Please input the code that was sent to you",
              style: TextStyle(
                fontFamily: "Finlandia",
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black54
              ),
            ),
            SizedBox(height: 20,),
            Pinput(
              length: 6,
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              controller: loginController.pinpuController,
                onCompleted: (pin) => print(pin),
             ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("Didn't receive it?  ",
                  style: TextStyle(
                      fontFamily: "Finlandia",
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black54
                  ),
                ) ,
                Text("Resend Code",
                  style: TextStyle(
                      fontFamily: "Finlandia",
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.carrot
                  ),
                ),
                Spacer(),
                // Text("00:${StartTime}",
                //   style: TextStyle(
                //       fontFamily: "Finlandia",
                //       fontWeight: FontWeight.w600,
                //       fontSize: 13,
                //       color: Colors.black54
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10,),
            Text("Get OTP on call", style: TextStyle(
                decoration:TextDecoration.underline,
              fontFamily: "finlandia",
              fontWeight: FontWeight.w600
            ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child:(!isClicked)? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:AppColors.carrot,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () async {
                    setState(() {
                      isClicked = !isClicked;
                    });
                    print(widget.verificationId.toString());
                    PhoneAuthCredential credential = PhoneAuthProvider.credential
                      (verificationId: widget.verificationId, smsCode: loginController.pinpuController.text);


                    try{
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                      if(userCredential.user !=null){
                        Get.offAll(HomeScreen());
                        setState(() {
                          isClicked = !isClicked;
                        });
                      }
                    } on FirebaseAuthException catch(ex){
                      setState(() {
                        isClicked = !isClicked;
                      });
                      print(ex.message);
                    }
                  },
                  child: Text("Submit", style: TextStyle(
                      color: Colors.white
                  ),
                  )
              ) :Container(
                width: double.infinity,
                height: 45,
                color: AppColors.carrot,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: SpinKitWave(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
