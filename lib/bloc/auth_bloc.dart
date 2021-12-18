import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth firebaseAuth;
  AuthBloc(this.firebaseAuth) : super(AuthInitial()) {
    on<VerifyPhone>((event, emit) async {
      await _verifyPhone(emit);
    });
    on<VerifyOTP>((event, emit) async {
      await _verifyOtp(emit);
    });
  }

  Future<void> _verifyPhone(Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(Duration(milliseconds: 500));
      emit(PhoneVerified());
    } catch (e) {
      print("object");
      emit(AuthFailedError());
    }
  }

  Future<void> _verifyOtp(Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(Duration(milliseconds: 500));
      emit(OtpVerified());
    } catch (e) {
      print("object");
      emit(AuthFailedError());
    }
  }

  // @override
  // Stream<AuthState> mapEventToState(AuthEvent event) async* {
  //   if (event is VerifyPhone) {
  //     print("check Verify");
  //     yield PhoneVerified();
  //   }
  //   if (event is VerifyOTP) {
  //     print("check OTP");
  //     yield OtpVerified();
  //   }
  //   yield AuthInitial();
  // }
}
