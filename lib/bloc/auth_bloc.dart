import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savings_app/model/auth_model.dart';
import 'package:savings_app/model/user_model.dart';
import 'package:savings_app/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  late UserModel user;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<VerifyPhone>((event, emit) async {
      await _verifyPhone(event, emit);
    });
    on<OtpAutoRetrevalTimeOut>((event, emit) =>
        (OtpAutoRetrevalTimeoutComplete(event.verificationId)));
    on<OtpSent>((event, emit) =>
        emit(PhoneVerifiedSuccess(verificationId: event.verificationId)));
    on<VerificationFailed>(
        (event, emit) => emit(AuthFailedError(message: event.message)));
    on<VerificationComplete>(
        (event, emit) => emit(OtpVerifiedSuccess(uid: event.uid)));
    on<VerifyOTP>((event, emit) async {
      await _verifyOtp(event, emit);
    });
    on<CheckAuthToken>((event, emit) => _checkAuthToken(emit));
    on<Logout>((event, emit) => _logout(emit));
  }

  Future<void> _verifyPhone(VerifyPhone event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        onCodeAutoRetrievalTimeout: _onCodeAutoRetrievalTimeout,
        onCodeSent: _onCodeSent,
        onVerificationFailed: _onVerificationFailed,
        onVerificationCompleted: _onVerificationComplete,
      );
    } catch (e) {
      emit(AuthFailedError(message: e.toString()));
    }
  }

  Future<void> _verifyOtp(VerifyOTP event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      AuthModel authModel = await authRepo.verifySMSCode(
          smsCode: event.otp, verificationId: event.verificationId);
      user = await authRepo.getuser();
      emit(OtpVerifiedSuccess(uid: authModel.uid));
    } catch (e) {
      emit(AuthFailedError(message: e.toString()));
    }
  }

  Future<void> _checkAuthToken(Emitter<AuthState> emit) async {
    emit(CheckTokenLoading());
    try {
      String? token = await authRepo.checkAuthToken();
      if (token != null) {
        user = await authRepo.getuser();
        emit(TokenFound(token: token));
      } else {
        emit(NoTokenFound());
      }
    } catch (e) {
      emit(AuthFailedError(message: e.toString()));
    }
  }

  Future<void> _logout(Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(AuthFailedError(message: e.toString()));
    }
  }

  void _onCodeAutoRetrievalTimeout(String verificationId) {
    add(OtpAutoRetrevalTimeOut(verificationId: verificationId));
  }

  void _onCodeSent(String verificationId, int? token) {
    add(OtpSent(verificationId: verificationId, token: token));
  }

  void _onVerificationFailed(FirebaseAuthException exception) {
    add(VerificationFailed(message: e.toString()));
  }

  void _onVerificationComplete(PhoneAuthCredential credential) async {
    final AuthModel authModel =
        await authRepo.verifyWithCredential(authCredential: credential);
    if (authModel.phoneAuthModelState == AuthModelStatus.verified) {
      add(VerificationComplete(authModel.uid));
    }
  }
}
