part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailedError extends AuthState {
  final String message;
  AuthFailedError({required this.message});
}

class PhoneVerifiedSuccess extends AuthState {
  final String verificationId;
  PhoneVerifiedSuccess({required this.verificationId});
}

class OtpSentSuccess extends AuthState {
  final String verificationId;
  OtpSentSuccess({required this.verificationId});
}

class OtpVerifiedSuccess extends AuthState {
  final String? uid;
  OtpVerifiedSuccess({required this.uid});
}

class OtpAutoRetrevalTimeoutComplete extends AuthState {
  final String verificationId;

  OtpAutoRetrevalTimeoutComplete(this.verificationId);
  @override
  List<Object> get props => [verificationId];
}
