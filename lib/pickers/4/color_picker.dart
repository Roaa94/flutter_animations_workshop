import 'package:flutter/material.dart';
import 'package:flutter_animations_workshop/colors.dart';
import 'package:flutter_animations_workshop/pickers/4/color_item.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _gradientStopAnimation;
  int _selectedColorIndex = 0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _gradientStopAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 0.5),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0),
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0),
            ],
            stops: [0, _gradientStopAnimation.value, 1],
          ),
        ),
        child: child,
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
    );
  }
}
