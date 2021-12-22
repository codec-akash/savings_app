import 'package:flutter/material.dart';
import 'package:savings_app/screens/home_screen.dart/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      switchToHome();
    });
  }

  switchToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    // Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Text("Loading"),
        ),
      ),
    );
  }
}
