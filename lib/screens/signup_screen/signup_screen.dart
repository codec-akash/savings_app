// ignore_for_file: prefer_const_constructors
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:savings_app/bloc/auth_bloc.dart';
import 'package:savings_app/screens/home_screen.dart/loading_screen.dart';
import 'package:savings_app/utils/page_navigation.dart';
import 'package:savings_app/utils/strings.dart';
import 'package:savings_app/widgets/otp_entry_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<OtpEntryWidgetState> _otpKey =
      GlobalKey<OtpEntryWidgetState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool showOtp = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Container()),
          AnimationLimiter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 1000),
                  // delay: Duration(milliseconds: 1000),
                  childAnimationBuilder: (widget) => FlipAnimation(
                        // horizontalOffset: MediaQuery.of(context).size.width / 2,
                        child: FadeInAnimation(child: widget),
                      ),
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 50),
                      child: Text(
                        Strings.trackExpenses,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 50),
                      child: Text(
                        Strings.manageFinances,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(bottom: 50),
                      child: Text(
                        Strings.trackSavingsAndGoal,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    prefixText: '+91',
                    label: const Text(Strings.phoneTextFieldName),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).scaffoldBackgroundColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      if (val.length == 10) {
                        showOtp = true;
                      } else {
                        showOtp = false;
                      }
                    });
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                if (showOtp) ...[
                  OtpEntryWidget(key: _otpKey),
                  SizedBox(height: 30),
                ],
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is PhoneVerified) {
                      setState(() {
                        showOtp = true;
                      });
                    } else {
                      setState(() {
                        showOtp = false;
                      });
                    }
                  },
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () async {
                    showOtp
                        ? {
                            context
                                .read<AuthBloc>()
                                .add(VerifyOTP(otp: '123456'))
                          }
                        : {
                            context
                                .read<AuthBloc>()
                                .add(VerifyPhone(phoneNumber: '8422022077'))
                          };
                    // await auth.verifyPhoneNumber(
                    //   phoneNumber: "+91${phoneController.text}",
                    //   verificationCompleted: (PhoneAuthCredential credential) {
                    //     print("Verification failed ${credential.smsCode}");
                    //   },
                    //   verificationFailed: (FirebaseAuthException e) {
                    //     print(
                    //         "OTP failed - ${e.message} phoneNumber - ${e.phoneNumber}");
                    //   },
                    //   codeSent:
                    //       (String verificationId, int? resendToken) async {
                    //     String smsCode =
                    //         _otpKey.currentState?.otpController.text ?? "";
                    //     PhoneAuthCredential credential =
                    //         PhoneAuthProvider.credential(
                    //             verificationId: verificationId,
                    //             smsCode: smsCode);
                    //     await auth.signInWithCredential(credential);
                    //   },
                    //   codeAutoRetrievalTimeout: (String verificationId) {},
                    // );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Less Goo",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            height: 30,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "Already, have an account ?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
