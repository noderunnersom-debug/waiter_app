import 'package:flutter/material.dart';
import 'package:waiter_app/core/style/app_colors.dart';
import 'package:waiter_app/core/style/app_text_style.dart';

class DashboardCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          border: Border.all(color: AppColors.forBorderGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Text(widget.title, style: AppTextStyle.bodyMediumBold()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Text(
                  widget.subtitle,
                  style: AppTextStyle.headlineLarge(color: widget.color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
