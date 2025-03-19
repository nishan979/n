import 'package:n/core/errors.dart';
import 'package:n/features/auth/data.dart';

abstract class AuthRepository {
  Future<void> initializeAnonymousSession();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<void> initializeAnonymousSession() async {
    try {
      await dataSource.signInAnonymously();
    } on NetworkError {
      throw NetworkError();
    }
  }
}