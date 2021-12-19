import 'package:firebase_auth/firebase_auth.dart';
import 'package:savings_app/model/auth_model.dart';

class AuthRepo {
  final FirebaseAuth firebaseAuth;
  AuthRepo({required this.firebaseAuth});

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required onVerificationCompleted,
    required onVerificationFailed,
    required onCodeSent,
    required onCodeAutoRetrievalTimeout,
  }) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 10),
    );
  }

  Future<AuthModel> verifyWithCredential(
      {required AuthCredential authCredential}) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(authCredential);
    User? user = userCredential.user;
    if (user != null) {
      return AuthModel(
          phoneAuthModelState: AuthModelStatus.verified, uid: user.uid);
    } else {
      return AuthModel(phoneAuthModelState: AuthModelStatus.error);
    }
  }

  Future<AuthModel> verifySMSCode(
      {required String smsCode, required String verificationId}) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;
    if (user != null) {
      return AuthModel(
          phoneAuthModelState: AuthModelStatus.verified, uid: user.uid);
    } else {
      return AuthModel(phoneAuthModelState: AuthModelStatus.error);
    }
  }
}
