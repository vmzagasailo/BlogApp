import 'package:blog_app/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

class DesignAppBar extends AppBar {
  DesignAppBar(
      {Key? key, Widget? title, Widget? leading, List<Widget>? actions})
      : super(
          key: key,
          title: title,
          leading: leading,
          actions: actions,
        );

  static const double height = 52;
  static const double splashRadius = height / 2;

  @override
  State<DesignAppBar> createState() => _DesignAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(height);
}

class _DesignAppBarState extends State<DesignAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: widget.title,
      leading: widget.leading,
      actions: widget.actions,
      backgroundColor: AppColors.white,
      iconTheme: const IconThemeData(color: AppColors.black),
    );
  }
}
