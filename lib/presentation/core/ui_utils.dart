import 'package:blog_app/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

class UiUtils {
  static Widget intoSafeArea(Widget child) {
    return SafeArea(child: child);
  }

  static Widget withHorizontalPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }

  static double getEffectiveHeight(BuildContext context) {
    var data = MediaQuery.of(context);
    return data.size.height - (data.padding.top + data.padding.bottom);
  }

  static Widget loadingView() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.softGrey, borderRadius: BorderRadius.circular(10)),
        child: const CircularProgressIndicator(color: AppColors.purple,),
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error,
          style: TextStyles.body14,
        ),
        backgroundColor: AppColors.red));
  }

  static void showMaterialDialog({
    required BuildContext context,
    required VoidCallback confirmTap,
    required String confirmText,
    required String cancelText,
    required String message,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    cancelText,
                    style: TextStyles.body14,
                  )),
              TextButton(
                  onPressed: confirmTap,
                  child: Text(
                    confirmText,
                    style: TextStyles.body14.copyWith(color: AppColors.red),
                  )),
            ],
          );
        });
  }
}
