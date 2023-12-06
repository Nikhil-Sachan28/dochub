
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_tut/controller/login_controller.dart";
import 'package:firebase_tut/Screens/otpVerificationScreen.dart';
import "package:firebase_tut/utils/colors.dart";
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:get/get.dart";
import "package:get/route_manager.dart";
import "package:pinput/pinput.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController countryCode = TextEditingController(text: "+91");
   LoginController loginController = Get.put(LoginController());
   bool isClicked = false;

  @override
  void initState() {
    // pinputController = Get.put(pinputController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Enter your Mobile Number", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border:  Border.all(width: 2, color: AppColors.carrot),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: SizedBox(
                        width : 40, child: TextFormField(
                        controller: countryCode,
                        decoration: InputDecoration(
                          border: InputBorder.none
                        ),
                      )
                      ),
                    ),
                    Text("|", style: TextStyle(
                      fontSize: 28
                    ),),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Mobile Number",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("By continuing you agree our ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                      fontFamily: "Finlandia"
                    ),),
                  // term and Condintions
                  Text("term and Conditions",
                    style: TextStyle(
                      fontFamily: "Finlandia",
                        fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      ),
                  ),
                ]
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
                    onPressed: (){
                    setState(() {
                      isClicked = !isClicked;
                    });

                  FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted: (PhoneAuthCredential credential) async {
                        // await FirebaseAuth.instance.signInWithCredential(credential);
                        loginController.pinpuController.setText(credential.smsCode??"123456");
                      },
                      verificationFailed: (ex){
                        print(ex.code);
                        setState(() {
                          isClicked = !isClicked;
                        });
                        if(ex.code == "invalid-phone-number") {
                          Fluttertoast.showToast(msg: "Invalid Phone Number");
                        }else{
                          Fluttertoast.showToast(msg: ex.code);
                        }


                      },
                      codeSent: (verificationId, resendToken){
                        Get.to(OtpVerificationScreen(verificationId: verificationId,number: countryCode.text+phone.text,)
                        );
                        setState(() {
                          isClicked = !isClicked;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId){

                      },
                    phoneNumber: "+91" + phone.text.trim().toString(),
                    timeout: const Duration(seconds: 30)
                  );
                },
                    child: Text("Continue", style: TextStyle(
                          color: Colors.white
                        ),
                    )
                ): Container(
                  width: double.infinity,
                  height: 45,
                  color: AppColors.carrot,
                  child: SpinKitWave(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ),
              SizedBox(height: 20,)

            ],
          ),
        ),
      ),
    );
  }
}
