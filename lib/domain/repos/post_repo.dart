import 'package:blog_app/domain/models/comment/comment_model.dart';
import 'package:blog_app/domain/models/post/post_model.dart';

abstract class PostRepo {
  Future<List<PostModel>> getPosts();

  Future<List<CommentModel>> getComments();
  
  Future<void> createComment(CommentModel comment);

  Future<void> deletePost(int id);

  Future<void> createPost(PostModel post);

  Future<void> updatePost(int id, String title, String body);
}
