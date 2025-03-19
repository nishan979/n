import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:n/features/post/domain.dart';
import 'features/post/data.dart';
import 'features/auth/data.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize Firebase Firestore
  final firestore = FirebaseFirestore.instance;
  locator.registerLazySingleton(() => firestore);

  // Initialize Post Dependencies
  locator.registerLazySingleton(() => PostRemoteDataSource(locator()));
  locator.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(locator()));
  
  // Initialize Auth Dependencies
  locator.registerLazySingleton<AuthDataSource>(() => FirebaseAuthDataSource());
}