import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animations_workshop/colors.dart';
import 'package:flutter_animations_workshop/pickers/1/color_item.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int _selectedColorIndex = 0;
  bool _pickerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              _pickerVisible = !_pickerVisible;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Toggle Picker',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 0.5),
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  colors.length,
                  (index) => ColorItem(
                    onTap: () {
                      setState(() {
                        _selectedColorIndex = index;
                      });
                    },
                    isSelected: _selectedColorIndex == index,
                    color: colors[index],
                    size: 60,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                ignoring: _pickerVisible ? true : false,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 500),
                      tween: Tween<double>(
                          begin: 12, end: _pickerVisible ? 0 : 12),
                      builder: (context, double value, _) => BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: value, sigmaX: value),
                        child: Container(
                          color: Colors.white.withOpacity(0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
