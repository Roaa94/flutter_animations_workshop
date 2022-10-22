import 'package:flutter/material.dart';
import 'package:flutter_animations_workshop/colors.dart';
import 'package:flutter_animations_workshop/pickers/6/color_item.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker>
    with SingleTickerProviderStateMixin {
  int _selectedColorIndex = 0;
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
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
              itemIndex: index,
              itemsCount: colors.length,
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
    );
  }
}
