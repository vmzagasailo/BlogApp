import 'package:blog_app/domain/models/comment/comment_model.dart';
import 'package:blog_app/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final CommentModel comment;
  const Comment({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Text('${comment.body}'),
      ),
    );
  }
}
