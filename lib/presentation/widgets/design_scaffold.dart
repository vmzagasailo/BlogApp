import 'package:blog_app/presentation/core/ui_utils.dart';
import 'package:blog_app/presentation/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DesignScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;
  final bool resizeToAvoidBottomInset;

  const DesignScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onScreenTap(context),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: AppColors.background,
        appBar: appBar,
        body: UiUtils.intoSafeArea(body),
      ),
    );
  }

  void _onScreenTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
