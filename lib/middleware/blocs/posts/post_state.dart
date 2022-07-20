import 'package:blog_app/domain/models/comment/comment_model.dart';
import 'package:blog_app/domain/models/post/post_model.dart';

class PostState {
  final bool isLoading;
  final List<PostModel> posts;
  final List<CommentModel> comments;
  final String? error;

  const PostState({
    this.isLoading = false,
    this.posts = const [],
    this.comments = const [],
    this.error,
  });

  PostState copyWith({
    bool? isLoading,
    List<PostModel>? posts,
    List<CommentModel>? comments,
    String? error,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      error: error ?? this.error,
    );
  }
}
