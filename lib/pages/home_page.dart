import 'package:flutter/material.dart';
import 'package:flutter_animations_workshop/pickers/2/color_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ColorPicker(),
      ),
    );
  }
}
