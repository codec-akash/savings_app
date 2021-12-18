part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailedError extends AuthState {}

class PhoneVerified extends AuthState {}

class OtpVerified extends AuthState {}
