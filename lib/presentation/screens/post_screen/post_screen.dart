import 'dart:math';

import 'package:blog_app/domain/models/comment/comment_model.dart';
import 'package:blog_app/domain/models/post/post_model.dart';
import 'package:blog_app/middleware/blocs/posts/post_bloc.dart';
import 'package:blog_app/middleware/blocs/posts/post_state.dart';
import 'package:blog_app/presentation/core/ui_utils.dart';
import 'package:blog_app/presentation/resources/app_icons.dart';
import 'package:blog_app/presentation/screens/home/widgets/post_widget.dart';
import 'package:blog_app/presentation/screens/post_screen/widgets/comment.dart';
import 'package:blog_app/presentation/widgets/design_app_bar.dart';
import 'package:blog_app/presentation/widgets/design_scaffold.dart';
import 'package:blog_app/presentation/widgets/design_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/postScreen';
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _postCubit = PostCubit();
  final _commentController = TextEditingController();
  final _random = Random();

  @override
  void initState() {
    _postCubit.getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)?.settings.arguments as PostModel;
    final postId = post.id;
    return DesignScaffold(
      appBar: DesignAppBar(),
      body: _buildBody(post, postId),
    );
  }

  Widget _buildBody(PostModel post, int postId) {
    return Column(
      children: [
        _buildPostSection(post),
        Expanded(child: _buildCommentsSection(postId)),
        DesignTextField(
          controller: _commentController,
          suffixIcon: AppIcons.sendMessage,
          hint: 'Leave comment...',
          onSuffIconTap: () => _createComment(postId),
        )
      ],
    );
  }

  Widget _buildPostSection(post) {
    return PostWidget(
      hasSubtitle: false,
      post: post,
    );
  }

  Widget _buildCommentsSection(int postId) {
    return BlocConsumer<PostCubit, PostState>(
      bloc: _postCubit,
      listener: (context, state) {
        if (state.error != null) {
          UiUtils.showErrorSnackBar(context, '${state.error}');
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return UiUtils.loadingView();
        } else {
          List<CommentModel> comments = state.comments
              .where((comments) => comments.postId == postId)
              .toList();
          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Comment(comment: comments[index]);
            },
          );
        }
      },
    );
  }

  void _createComment(int postId) {
    if (_commentController.text.isEmpty) {
      UiUtils.showMaterialDialog(
        context: context,
        confirmTap: () => Navigator.of(context).pop(),
        confirmText: 'Retry',
        cancelText: 'Ok',
        message: 'Write something...',
      );
    } else {
      _postCubit.createComment(
        CommentModel(
          id: _random.nextInt(99),
          postId: postId,
          body: _commentController.text,
        ),
      );
      _commentController.clear();
      FocusScope.of(context).unfocus();
    }
  }
  @override
  void dispose() {
    _postCubit.close();
    _commentController.dispose();
    super.dispose();
  }
}
