import 'package:blog_app/domain/models/post/post_model.dart';
import 'package:blog_app/presentation/resources/app_colors.dart';
import 'package:blog_app/presentation/resources/app_icons.dart';
import 'package:blog_app/presentation/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  final VoidCallback? delete;
  final VoidCallback? edit;
  final VoidCallback? onPostTap;
  final bool hasButtons;
  final bool hasSubtitle;

  const PostWidget({
    Key? key,
    required this.post,
    this.delete,
    this.edit,
    this.onPostTap,
    this.hasButtons = false,
    this.hasSubtitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onPostTap,
        child: Container(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 5),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasButtons)
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: edit,
                      icon: SvgPicture.asset(AppIcons.edit, height: 24),
                    ),
                    IconButton(
                      onPressed: delete,
                      icon: SvgPicture.asset(AppIcons.delete, height: 24),
                    ),
                  ],
                ),
              const SizedBox(height: 5),
              Text(
                '${post.title}',
                style: TextStyles.body16,
              ),
              const Divider(height: 1),
              Text(
                '${post.body}',
                style: TextStyles.body14,
              ),
              if (hasSubtitle) _buildSubtitle()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Column(
      children: [
        const Divider(height: 1),
        const SizedBox(height: 10),
        Text(
          'Leave comment...',
          style: TextStyles.body14.copyWith(color: AppColors.blue),
        ),
      ],
    );
  }
}
