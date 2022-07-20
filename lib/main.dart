import 'package:blog_app/middleware/blocs/auth/auth_bloc.dart';
import 'package:blog_app/middleware/blocs/auth/auth_state.dart';
import 'package:blog_app/middleware/blocs/posts/post_bloc.dart';
import 'package:blog_app/middleware/blocs/posts/post_state.dart';
import 'package:blog_app/presentation/screens/auth/auth_screen.dart';
import 'package:blog_app/presentation/screens/create_post/create_post.dart';
import 'package:blog_app/presentation/screens/edit_post/edit_post_screen.dart';
import 'package:blog_app/presentation/screens/home/home_screen.dart';
import 'package:blog_app/presentation/screens/post_screen/post_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => AuthCubit(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (!state.isAuthorized) {
              return const AuthScreen();
            }
            return BlocProvider(
              create: (_) => PostCubit(),
              child: BlocBuilder<PostCubit, PostState>(
                builder: (context, state) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        HomeScreen.roteName: (context) => const HomeScreen(),
        CreatePost.routeName: (context) => const CreatePost(),
        PostScreen.routeName:(context) => const PostScreen(),
        EditPostScreen.routeName: (context) => const EditPostScreen(),
      },
    );
  }
}
