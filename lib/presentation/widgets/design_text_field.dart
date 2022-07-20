import 'package:blog_app/presentation/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef Validator = bool Function(String);

class DesignTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;
  final String? suffixIcon;
  final bool isError;
  final bool obscureText;
  final bool showObscureStatus;
  final bool emptyAlwaysValid;
  final Validator? validator;
  final ValueNotifier<bool>? isValid;
  final int maxLines;
  final TextInputAction? inputAction;
  final VoidCallback? onSuffIconTap;

  const DesignTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hint,
    this.suffixIcon,
    this.isError = false,
    this.obscureText = false,
    this.showObscureStatus = false,
    this.emptyAlwaysValid = false,
    this.validator,
    this.isValid,
    this.inputAction,
    this.maxLines = 1,
    this.onSuffIconTap,
  }) : super(key: key);

  @override
  State<DesignTextField> createState() => _DesignTextFieldState();
}

class _DesignTextFieldState extends State<DesignTextField> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.obscureText;
    if (widget.validator != null && widget.isValid != null) {
      widget.controller.addListener(_onChanged);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.inputAction,
      style: TextStyles.body16,
      cursorColor: AppColors.black,
      cursorHeight: 18,
      cursorWidth: 1.4,
      textAlignVertical: TextAlignVertical.bottom,
      obscureText: _obscureText,
      maxLines: widget.maxLines,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('[ ]')),
      ],
      decoration: InputDecoration(
        hintText: widget.hint,
        isDense: true,
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        hintStyle: TextStyles.body16.copyWith(color: AppColors.grey),
        suffixIcon: _getObscureStatusIcon(),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 24,
          minWidth: 40,
        ),
        border: _getBorder(AppColors.softGrey),
        enabledBorder: _getBorder(AppColors.softGrey),
        disabledBorder: _getBorder(AppColors.softGrey),
        focusedBorder: _getBorder(AppColors.blue),
      ),
    );
  }

  OutlineInputBorder _getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: widget.isError ? AppColors.red : color),
    );
  }

  Widget? _getObscureStatusIcon() {
    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffIconTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SvgPicture.asset(widget.suffixIcon!),
        ),
      );
    }
    if (widget.showObscureStatus) {
      return GestureDetector(
        onTap: _onObscureIconPressed,
        child: SvgPicture.asset(
          _obscureText ? AppIcons.eye : AppIcons.eyeHidden,
          alignment: Alignment.centerLeft,
          color: AppColors.grey,
        ),
      );
    }
    return null;
  }

  void _onObscureIconPressed() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onChanged() {
    bool valid = (widget.controller.text.isEmpty && widget.emptyAlwaysValid)
        ? true
        : widget.validator!(widget.controller.text);
    if (widget.isValid!.value != valid) {
      widget.isValid!.value = valid;
    }
  }
}
