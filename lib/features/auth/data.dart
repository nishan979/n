import 'package:firebase_auth/firebase_auth.dart';
import 'package:n/core/errors.dart';

abstract class AuthDataSource {
  Future<void> signInAnonymously();
}

class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException {
      throw NetworkError();
    }
  }
}