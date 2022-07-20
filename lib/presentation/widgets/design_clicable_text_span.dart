import 'package:blog_app/presentation/resources/resources.dart';
import 'package:flutter/material.dart';

class DesignClickableTextSpan extends StatelessWidget {
  final VoidCallback onTap;
  final List<String> strings;
  final List<Color> colors;

  const DesignClickableTextSpan({
    required this.onTap,
    required this.strings,
    this.colors = const [],
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          children: List.generate(
            strings.length,
            (index) => TextSpan(
              text: strings[index],
              style: TextStyles.body16.copyWith(
                  color:
                      colors.length > index ? colors[index] : AppColors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
