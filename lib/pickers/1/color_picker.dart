import 'package:flutter/material.dart';
import 'package:flutter_animations_workshop/colors.dart';
import 'package:flutter_animations_workshop/pickers/1/color_item.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
          colors.length,
          (index) => ColorItem(
            color: colors[index],
          ),
        ),
      ),
    );
  }
}
