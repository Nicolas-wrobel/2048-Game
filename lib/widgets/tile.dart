import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final int value;

  const Tile({required this.value});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialisation du controller pour les animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Animation de scale pour les apparitions et fusions
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.value > 0) {
      _triggerAppearAnimation();
    }
  }

  @override
  void didUpdateWidget(Tile oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si la valeur change, déclencher l'animation
    if (widget.value != oldWidget.value && widget.value > 0) {
      _triggerAppearAnimation();
    }
  }

  // Animation d'apparition et de fusion
  void _triggerAppearAnimation() {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              widget.value > 0 ? '${widget.value}' : '',
              style: TextStyle(
                fontSize: widget.value < 100 ? 24 : 20,
                fontWeight: FontWeight.bold,
                color: widget.value < 8 ? Colors.grey[800] : Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getBackgroundColor() {
    switch (widget.value) {
      case 2:
        return const Color(0xFFEEE4DA);
      case 4:
        return const Color(0xFFEDE0C8);
      case 8:
        return const Color(0xFFF2B179);
      case 16:
        return const Color(0xFFF59563);
      case 32:
        return const Color(0xFFF67C5F);
      case 64:
        return const Color(0xFFF65E3B);
      case 128:
        return const Color(0xFFEDCF72);
      case 256:
        return const Color(0xFFEDCC61);
      case 512:
        return const Color(0xFFEDC850);
      case 1024:
        return const Color(0xFFEDC53F);
      case 2048:
        return const Color(0xFFEDC22E);
      default:
        return Colors.black;
    }
  }
}
