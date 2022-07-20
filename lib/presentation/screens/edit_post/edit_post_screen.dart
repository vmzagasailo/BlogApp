import 'package:blog_app/domain/models/post/post_model.dart';
import 'package:blog_app/middleware/blocs/posts/post_bloc.dart';
import 'package:blog_app/presentation/core/ui_utils.dart';
import 'package:blog_app/presentation/resources/resources.dart';
import 'package:blog_app/presentation/screens/home/home_screen.dart';
import 'package:blog_app/presentation/widgets/design_app_bar.dart';
import 'package:blog_app/presentation/widgets/design_scaffold.dart';
import 'package:blog_app/presentation/widgets/design_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditPostScreen extends StatefulWidget {
  static const routeName = '/EditPostScreen';
  const EditPostScreen({Key? key}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _postBloc = PostCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final postData = ModalRoute.of(context)?.settings.arguments as PostModel;
    _titleController.text = postData.title ?? '';
    _bodyController.text = postData.body ?? '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final postData = ModalRoute.of(context)?.settings.arguments as PostModel;
    return DesignScaffold(
      appBar: DesignAppBar(
        actions: [
          IconButton(
            onPressed: () => _onSaveTap(postData.id),
            icon: SvgPicture.asset(AppIcons.save, height: 24),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return UiUtils.withHorizontalPadding(
      Column(
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
    );
  }

  void _onSaveTap(int id) {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      UiUtils.showMaterialDialog(
          context: context,
          confirmTap: Navigator.of(context).pop,
          message: 'All fields must be filled',
          cancelText: 'Ok',
          confirmText: 'Retry');
    } else if (_titleController.text.isNotEmpty &&
        _bodyController.text.isNotEmpty) {
      UiUtils.showMaterialDialog(
        context: context,
        confirmTap: () => _updatePost(id),
        confirmText: 'Yes',
        cancelText: 'No',
        message: 'Save shanges?',
      );
    }
  }

  void _updatePost(int id) {
    _postBloc.updatePost(id, _titleController.text, _bodyController.text);
    Navigator.pushReplacementNamed(context, HomeScreen.roteName);
  }
}
