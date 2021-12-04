// ignore_for_file: prefer_const_constructors
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
  // late AnimationController animationController;
  // late Animation translationAnimation;
  bool showOtp = false;

  @override
  void initState() {
    // animationController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 2000));
    // translationAnimation = Tween(begin: Offset(-900, 0), end: Offset(10.0, 0.0))
    //     .animate(animationController);
    // animationController.forward();
    // animationController.addListener(() {
    //   setState(() {});
    // });
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
                  delay: Duration(milliseconds: 1000),
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
          // AnimatedBuilder(
          //   animation: animationController,
          //   builder: (context, child) {
          //     return Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Transform.translate(
          //           offset: translationAnimation.value,
          //           // angle: translationAnimation.value,
          //           child: Container(
          //             padding: EdgeInsets.symmetric(horizontal: 20),
          //             margin: EdgeInsets.only(bottom: 50),
          //             child: Text(
          //               Strings.trackExpenses,
          //               style: TextStyle(color: Colors.white, fontSize: 22),
          //             ),
          //           ),
          //         ),
          //         Transform.translate(
          //           offset: translationAnimation.value,
          //           // angle: translationAnimation.value,
          //           child: Container(
          //             padding: EdgeInsets.symmetric(horizontal: 20),
          //             margin: EdgeInsets.only(bottom: 50),
          //             child: Text(
          //               Strings.manageFinances,
          //               style: TextStyle(color: Colors.white, fontSize: 22),
          //             ),
          //           ),
          //         ),
          //         Transform.translate(
          //           offset: translationAnimation.value,
          //           // angle: translationAnimation.value,
          //           child: Container(
          //             padding: EdgeInsets.symmetric(horizontal: 20),
          //             margin: EdgeInsets.only(bottom: 50),
          //             child: Text(
          //               Strings.trackSavingsAndGoal,
          //               style: TextStyle(color: Colors.white, fontSize: 22),
          //             ),
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
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
                if (phoneController.text.length == 10) ...[
                  OtpEntryWidget(),
                  SizedBox(height: 30),
                ],
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Submit",
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