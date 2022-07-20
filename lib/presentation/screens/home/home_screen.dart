import 'package:blog_app/domain/models/post/post_model.dart';
import 'package:blog_app/middleware/blocs/posts/post_bloc.dart';
import 'package:blog_app/middleware/blocs/posts/post_state.dart';
import 'package:blog_app/presentation/core/ui_utils.dart';
import 'package:blog_app/presentation/screens/create_post/create_post.dart';
import 'package:blog_app/presentation/screens/edit_post/edit_post_screen.dart';
import 'package:blog_app/presentation/screens/home/widgets/post_widget.dart';
import 'package:blog_app/presentation/screens/post_screen/post_screen.dart';
import 'package:blog_app/presentation/widgets/design_button.dart';
import 'package:blog_app/presentation/widgets/design_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const roteName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _postCubit = PostCubit();

  @override
  void initState() {
    _postCubit.getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<PostCubit, PostState>(
      bloc: _postCubit,
      listener: (context, state) {
        if (state.error != null) {
          UiUtils.showErrorSnackBar(context, '${state.error}');
        }
      },
      builder: (_, state) {
        if (state.isLoading) {
          return UiUtils.loadingView();
        } else {
          var posts = state.posts;
          return 
          Column(
            children: [
              SizedBox(
                height: UiUtils.getEffectiveHeight(context) - 40,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: posts.length,
                  itemBuilder: (context, index) =>
                      UiUtils.withHorizontalPadding(
                    PostWidget(
                      post: posts[index],
                      delete: () => _onDeleteTap(state.posts[index].id),
                      edit: () => _onEditTap(posts[index]),
                      onPostTap: () => _onPostTap(posts[index]),
                      hasButtons: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: DesignButton(
                  title: "Create Post",
                  onTap: () => _onCreatePostTap(),
                ),
              )
            ],
          );
        }
      },
    );
  }

  void _onDeleteTap(int id) {
    UiUtils.showMaterialDialog(
      context: context,
      confirmTap: () => _deletePost(id),
      message: 'Delete this post?',
      cancelText: 'No',
      confirmText: 'Yes',
    );
  }

  void _onCreatePostTap() {
    Navigator.pushNamed(context, CreatePost.routeName);
  }

  void _onPostTap(PostModel post) {
    Navigator.pushNamed(context, PostScreen.routeName, arguments: post);
  }

  void _onEditTap(PostModel post) {
    Navigator.pushNamed(context, EditPostScreen.routeName, arguments: post);
  }

  void _deletePost(int id) {
    Navigator.of(context).pop();
    _postCubit.deletePost(id);
  }
}
