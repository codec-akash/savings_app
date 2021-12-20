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
  final String verificationId;
  VerifyOTP({required this.otp, required this.verificationId});
}

class OtpAutoRetrevalTimeOut extends AuthEvent {
  final String verificationId;
  OtpAutoRetrevalTimeOut({required this.verificationId});
}

class OtpSent extends AuthEvent {
  final String verificationId;
  final int? token;
  OtpSent({required this.verificationId, required this.token});
}

class VerificationFailed extends AuthEvent {
  final String message;

  VerificationFailed({required this.message});
}

class VerificationComplete extends AuthEvent {
  final String? uid;
  VerificationComplete(this.uid);
}

class Logout extends AuthEvent {}

class CheckAuthToken extends AuthEvent {}
