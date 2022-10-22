import 'package:flutter/material.dart';

class ColorItem extends StatefulWidget {
  const ColorItem({
    super.key,
    this.size = 50,
    required this.color,
    this.isSelected = false,
    this.onTap,
    required this.itemIndex,
    required this.itemsCount,
  });

  final double size;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;
  final int itemIndex;
  final int itemsCount;

  @override
  State<ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.forward();

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          widget.itemIndex / widget.itemsCount,
          1,
          curve: Curves.ease,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isSelected ? Colors.white : Colors.transparent,
              width: widget.isSelected ? 3 : 0,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: widget.isSelected
                    ? Colors.white.withOpacity(0.5)
                    : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
