import 'package:flutter/material.dart';
import 'package:savings_app/bloc/auth_bloc.dart';
import 'package:savings_app/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel get userModel => context.read<AuthBloc>().user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("${userModel.phoneNumber}"),
          Text("${userModel.token}"),
        ],
      ),
    );
  }
}
