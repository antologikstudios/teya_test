import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_teya_test/src/app_config/app_text_theme.dart';

class AlbumDetailsText extends StatelessWidget {
  final String title;
  final String value;

  const AlbumDetailsText({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: AppTextTheme.title, textAlign: TextAlign.center),
        Text(value, style: AppTextTheme.text, textAlign: TextAlign.center),
      ],
    ).marginOnly(bottom: 16);
  }
}
