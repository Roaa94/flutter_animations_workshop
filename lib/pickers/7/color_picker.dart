import 'package:flutter/material.dart';
import 'package:flutter_animations_workshop/colors.dart';
import 'package:flutter_animations_workshop/pickers/7/color_item.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60 + 20 * 2,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.horizontal,
        itemCount: colors2.length,
        cacheExtent: 0,
        itemBuilder: (context, index) => ColorItemWrapper(
          child: ColorItem(
            onTap: () {
              setState(() {
                _selectedColorIndex = index;
              });
            },
            isSelected: _selectedColorIndex == index,
            color: colors2[index],
            size: 60,
          ),
        ),
      ),
    );
  }
}

class ColorItemWrapper extends StatefulWidget {
  const ColorItemWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ColorItemWrapper> createState() => _ColorItemWrapperState();
}

class _ColorItemWrapperState extends State<ColorItemWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
