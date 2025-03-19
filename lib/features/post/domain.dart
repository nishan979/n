// # Domain layer (entities, usecases)

import 'package:n/core/errors.dart';
import 'package:n/features/post/data.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<void> createPost(String content);
}

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource dataSource;

  PostRepositoryImpl(this.dataSource);

  @override
  Future<List<Post>> getPosts() async {
    try {
      return await dataSource.getPosts();
    } on NetworkError {
      throw NetworkError();
    }
  }

  @override
  Future<void> createPost(String content) async {
    try {
      await dataSource.createPost(content);
    } on NetworkError {
      throw NetworkError();
    }
  }
}