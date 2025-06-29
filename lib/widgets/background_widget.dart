import 'package:flutter/material.dart';
import 'dart:math' as math;

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final bool isLoginScreen;
  
  const BackgroundWidget({
    super.key,
    required this.child,
    this.isLoginScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isLoginScreen 
            ? _buildLoginGradient(context)
            : _buildHomeGradient(context),
      ),
      child: Stack(
        children: [
          // Animated background patterns
          if (isLoginScreen) _buildLoginPatterns() else _buildHomePatterns(),
          
          // Main content
          child,
        ],
      ),
    );
  }

  LinearGradient _buildLoginGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.secondary,
        Theme.of(context).colorScheme.tertiary,
      ],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  LinearGradient _buildHomeGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      ],
      stops: const [0.0, 0.7, 1.0],
    );
  }

  Widget _buildLoginPatterns() {
    return Stack(
      children: [
        // Floating circles
        Positioned(
          top: 100,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ),
        // Animated dots
        ...List.generate(20, (index) {
          return Positioned(
            top: math.Random().nextDouble() * 800,
            left: math.Random().nextDouble() * 400,
            child: AnimatedContainer(
              duration: Duration(seconds: 3 + (index % 3)),
              width: 4 + (index % 3) * 2.0,
              height: 4 + (index % 3) * 2.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHomePatterns() {
    return Stack(
      children: [
        // Subtle geometric patterns
        Positioned(
          top: 50,
          right: 20,
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 30,
          child: Transform.rotate(
            angle: -math.pi / 6,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        // Subtle dots
        ...List.generate(15, (index) {
          return Positioned(
            top: 100 + (index * 50.0),
            left: 20 + (index % 3) * 30.0,
            child: Container(
              width: 2,
              height: 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// Alternative: Simple gradient background
class SimpleGradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  
  const SimpleGradientBackground({
    super.key,
    required this.child,
    this.colors = const [Colors.blue, Colors.purple],
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
        ),
      ),
      child: child,
    );
  }
} 