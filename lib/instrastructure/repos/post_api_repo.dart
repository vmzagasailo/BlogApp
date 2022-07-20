import 'dart:convert';

import 'package:blog_app/domain/models/post/post_model.dart';
import 'package:blog_app/domain/models/comment/comment_model.dart';
import 'package:blog_app/domain/repos/post_repo.dart';
import 'package:dio/dio.dart';

class PostApiRepo extends PostRepo {
  final String _postsUrl = 'https://bloggy-api.herokuapp.com/posts';
  final String _commentsUrl = 'https://bloggy-api.herokuapp.com/comments';
  final Dio _dio = Dio(
    BaseOptions(headers: {
      "Content-Type": "application/json",
    }),
  );

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      var response = await _dio.get(_postsUrl);
      final posts = response.data as List<dynamic>;
      return posts.map((data) => PostModel.fromJson(data)).toList();
    } catch (error) {
      print('$error');
      rethrow;
    }
  }

  @override
  Future<List<CommentModel>> getComments() async {
    try {
      var response = await _dio.get(_commentsUrl);
      final comments = response.data as List<dynamic>;
      return comments.map((data) => CommentModel.fromJson(data)).toList();
    } catch (error) {
      print('$error');
      rethrow;
    }
  }

  @override
  Future<void> createComment(CommentModel comment) async {
    try {
      await _dio.post(_commentsUrl, data: comment);
    } catch (error) {
      print('$error');
    }
  }

  @override
  Future<void> createPost(PostModel post) async {
    try {
      await _dio.post(_postsUrl, data: post);
    } catch (error) {
      print('$error');
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      await _dio.delete('$_postsUrl/$id');
    } catch (error) {
      print('$error');
    }
  }

  @override
  Future<void> updatePost(int id, String title, String body) async {
    try {
      await _dio.put('$_postsUrl/$id',
          data: json.encode({
            'title': title,
            'body': body,
          }));
    } catch (error) {
      print('$error');
    }
  }
}
