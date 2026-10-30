import 'package:ecomerce_market/core/utils/app_images.dart';
import 'package:ecomerce_market/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          shape: OvalBorder(),
          color: Color(0xFFEEF8ED),
        ),
        child: SvgPicture.asset(Assets.imagesNotification),
      ),
      leading: Image.asset(Assets.imagesProfileImage),

      title: Text(
        'صباح الخير !..',
        textAlign: TextAlign.right,
        style: TextStyles.regular16.copyWith(color: const Color(0xFF949D9E)),
      ),
      subtitle: Text(
        ' عبد اللطيف الجنابي',
        textAlign: TextAlign.right,
        style: TextStyles.bold16,
      ),
    );
  }
}
