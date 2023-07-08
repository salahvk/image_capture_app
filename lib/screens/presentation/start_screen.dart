import 'package:flutter/material.dart';
import 'package:image_capture_app/config/route_manager.dart';
import 'package:image_capture_app/utils/color_manager.dart';
import 'package:image_capture_app/utils/style_manager.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.imageDisplayScreen);
            },
            child: Text(
              "Start",
              style: getMediumtStyle(color: ColorManager.textColor),
            )),
      ),
    );
  }
}
