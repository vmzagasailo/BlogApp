import 'package:blog_app/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

class DesignButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final ValueNotifier<bool>? enabled;

  const DesignButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.enabled,
  }) : super(key: key);

  @override
  State<DesignButton> createState() => _DesignButtonState();
}

class _DesignButtonState extends State<DesignButton> {
  late bool _enabled;

  @override
  void initState() {
    _enabled = widget.enabled?.value ?? true;
    widget.enabled?.addListener(_onEnabledChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        onPressed: _enabled ? widget.onTap : null,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(AppColors.purplePressed),
          backgroundColor: MaterialStateProperty.all(
              _enabled ? AppColors.purple : AppColors.grey),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyles.subheading16,
        ),
      ),
    );
  }

  void _onEnabledChanged() {
    setState(() {
      _enabled = widget.enabled!.value;
    });
  }

  @override
  void dispose() {
    widget.enabled?.removeListener(_onEnabledChanged);
    super.dispose();
  }
}
