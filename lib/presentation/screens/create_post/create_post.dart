import 'dart:math';

import 'package:blog_app/domain/models/post/post_model.dart';
import 'package:blog_app/middleware/blocs/posts/post_bloc.dart';
import 'package:blog_app/presentation/core/ui_utils.dart';
import 'package:blog_app/presentation/resources/app_icons.dart';
import 'package:blog_app/presentation/screens/home/home_screen.dart';
import 'package:blog_app/presentation/widgets/design_app_bar.dart';
import 'package:blog_app/presentation/widgets/design_scaffold.dart';
import 'package:blog_app/presentation/widgets/design_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreatePost extends StatefulWidget {
  static const routeName = '/createPostScreen';
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _postBloc = PostCubit();

  final _random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      appBar: DesignAppBar(
        actions: [
          IconButton(
              onPressed: _onSaveTap,
              icon: SvgPicture.asset(AppIcons.save, height: 24))
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return UiUtils.withHorizontalPadding(
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            DesignTextField(
              controller: _titleController,
              hint: 'Enter title...',
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            DesignTextField(
              controller: _bodyController,
              hint: 'Enter body...',
              maxLines: 7,
            ),
          ],
        ),
      ),
    );
  }

  void _onSaveTap() {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      UiUtils.showMaterialDialog(
          context: context,
          confirmTap: Navigator.of(context).pop,
          message: 'All fields must be filled',
          cancelText: 'Ok',
          confirmText: 'Retry');
    } else {
      _postBloc.createPost(
        PostModel(
            id: _random.nextInt(99),
            title: _titleController.text,
            body: _bodyController.text),
      );

      Navigator.pushReplacementNamed(context, HomeScreen.roteName);
    }
  }

  @override
  void dispose() {
    _bodyController.dispose();
    _postBloc.close();
    super.dispose();
  }
}
