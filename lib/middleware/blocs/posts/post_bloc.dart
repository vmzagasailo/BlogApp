import 'package:blog_app/domain/models/comment/comment_model.dart';
import 'package:blog_app/domain/models/post/post_model.dart';
import 'package:blog_app/instrastructure/repos/post_api_repo.dart';
import 'package:blog_app/middleware/blocs/posts/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());

  final _postApiRepo = PostApiRepo();

  Future<void> getPosts() async {
    try {
      emit(state.copyWith(isLoading: true));
      await _postApiRepo.getPosts().then((posts) {
        emit(state.copyWith(posts: posts, isLoading: false));
      });
    } catch (error) {
      print('$error');
      emit(state.copyWith(isLoading: false, error: '$error'));
    }
  }

  Future<void> getComments() async {
    emit(state.copyWith(isLoading: true));
    try {
      await _postApiRepo.getComments().then((comments) {
        emit(state.copyWith(isLoading: false, comments: comments));
      });
    } catch (error) {
      print('$error');
      emit(state.copyWith(isLoading: false, error: '$error'));
    }
  }

  Future<void> deletePost(int id) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _postApiRepo.deletePost(id);
      getPosts();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      print('$error');
    }
  }

  Future<void> createComment(CommentModel comment) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _postApiRepo.createComment(comment);
      getComments();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      print('$error');
    }
  }

  Future<void> createPost(PostModel post) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _postApiRepo.createPost(post);
      getPosts();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      print('$error');
    }
  }

  Future<void> updatePost(int id, String title, String body) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _postApiRepo.updatePost(id, title, body);
      getPosts();
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      print('$error');
    }
  }
}
