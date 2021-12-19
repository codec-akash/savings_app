import 'dart:convert';

enum AuthModelStatus {
  codeSent,
  autoVerified,
  error,
  verified,
}

class AuthModel {
  final AuthModelStatus phoneAuthModelState;
  final String? verificationId;
  final int? verificationToken;
  final String? uid;

  AuthModel({
    required this.phoneAuthModelState,
    this.verificationId,
    this.verificationToken,
    this.uid,
  });

  AuthModel copyWith({
    AuthModelStatus? phoneAuthModelState,
    String? verificationId,
    int? verificationToken,
    String? uid,
  }) {
    return AuthModel(
      phoneAuthModelState: phoneAuthModelState ?? this.phoneAuthModelState,
      verificationId: verificationId ?? this.verificationId,
      verificationToken: verificationToken ?? this.verificationToken,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneAuthModelState': phoneAuthModelState.index,
      'verificationId': verificationId,
      'verificationToken': verificationToken,
      'uid': uid,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic>? map) {
    return AuthModel(
      phoneAuthModelState: AuthModelStatus.values[map?['phoneAuthModelState']],
      verificationId: map?['verificationId'],
      verificationToken: map?['verificationToken'],
      uid: map?['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthModel(phoneAuthModelState: $phoneAuthModelState, verificationId: $verificationId, verificationToken: $verificationToken, uid: $uid)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AuthModel &&
        o.phoneAuthModelState == phoneAuthModelState &&
        o.verificationId == verificationId &&
        o.verificationToken == verificationToken &&
        o.uid == uid;
  }

  @override
  int get hashCode {
    return phoneAuthModelState.hashCode ^
        verificationId.hashCode ^
        verificationToken.hashCode ^
        uid.hashCode;
  }
}
