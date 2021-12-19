import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savings_app/bloc/auth_bloc.dart';
import 'package:savings_app/repository/auth_repo.dart';
import 'package:savings_app/screens/home_screen.dart/loading_screen.dart';
import 'package:savings_app/screens/signup_screen/signup_screen.dart';
import 'package:savings_app/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepo: AuthRepo(firebaseAuth: FirebaseAuth.instance)),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          var child;
          if (state is OtpVerifiedSuccess) {
            child = LoadingScreen();
          } else {
            child = SignupScreen();
          }
          return AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: MaterialApp(
              theme: dark,
              home: child,
            ),
          );
        },
      ),
    );
    //   MaterialApp(
    //     title: 'Flutter Demo',
    //     theme: dark,
    //     builder: (context, child) => BlocListener<AuthBloc, AuthState>(
    //       listener: (context, state) {
    //         if (state is OtpVerified) {
    //           // Navigator.of(context).pushAndRemoveUntil(
    //           //     MaterialPageRoute(
    //           //       builder: (context) => const LoadingScreen(),
    //           //     ),
    //           //     (route) => false);
    //           child = const LoadingScreen();
    //         } else {
    //           // Navigator.of(context).pushAndRemoveUntil(
    //           //     MaterialPageRoute(
    //           //       builder: (context) => const SignupScreen(),
    //           //     ),
    //           //     (route) => false);
    //           child = const SignupScreen();
    //         }
    //       },
    //       child: child,
    //     ),
    //   ),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
