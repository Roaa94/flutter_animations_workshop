import 'package:flutter/material.dart';
import 'package:flutter_animations_workshop/colors.dart';
import 'package:flutter_animations_workshop/pickers/5/color_item.dart';

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
  Widget build(BuildContext context) {
    return GradientTransition(
      gradientStop: _gradientStopAnimation,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
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
    );
  }
}

class GradientTransition extends AnimatedWidget {
  const GradientTransition({
    Key? key,
    required this.gradientStop,
    this.child,
    this.color = Colors.white,
  }) : super(key: key, listenable: gradientStop);

  final Animation<double> gradientStop;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0),
            color.withOpacity(0.15),
            color.withOpacity(0),
          ],
          stops: [0, gradientStop.value, 1],
        ),
      ),
      child: child,
    );
  }
}
