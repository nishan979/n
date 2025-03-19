// # UI components & state management

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n/core/errors.dart';
import 'package:n/features/post/data.dart';
import 'package:n/features/post/domain.dart';

// Events
abstract class PostEvent {}
class LoadPostsEvent extends PostEvent {}
class CreatePostEvent extends PostEvent {
  final String content;
  CreatePostEvent(this.content);
}

// States
abstract class PostState {}
class PostInitial extends PostState {}
class PostsLoading extends PostState {}
class PostsLoaded extends PostState {
  final List<Post> posts;
  PostsLoaded(this.posts);
}
class PostError extends PostState {
  final String message;
  PostError(this.message);
}

// BLoC
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<CreatePostEvent>(_onCreatePost);
  }

  Future<void> _onLoadPosts(
    LoadPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostsLoading());
    try {
      final posts = await repository.getPosts();
      emit(PostsLoaded(posts));
    } on AppError catch (e) {
      emit(PostError(e.message));
    }
  }

  Future<void> _onCreatePost(
    CreatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    try {
      await repository.createPost(event.content);
      add(LoadPostsEvent());
    } on AppError catch (e) {
      emit(PostError(e.message));
    }
  }
}