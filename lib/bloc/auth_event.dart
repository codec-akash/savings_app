part of 'auth_bloc.dart';

abstract class AuthEvent {
  AuthEvent();
}

class VerifyPhone extends AuthEvent {
  final String phoneNumber;
  VerifyPhone({required this.phoneNumber});
}

class VerifyOTP extends AuthEvent {
  final String otp;
  VerifyOTP({required this.otp});
}
