import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  static const Color primaryColor = Color(0xFF4D51ED);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color accentYellow = Color(0xFFFFC107);
  static const Color accentOrange = Color(0xFFFF7043);

  static const Color textTitleColor = Color(0xFF2D2D2D);
  static const Color textSubTitleColor = Color(0xFF666666);
  static const Color inputFillColor = Color(0xFFF8F9FA);
  static const Color inputBorderColor = Color(0xFFE0E0E0);
  static const Color borderColor = inputBorderColor; 
  static const Color labelColor = Color(0xFF4A4A4A);

  final Widget child;
  final String title;
  final bool showAppBar;
  final List<Widget>? actions;

  const MainLayout({
    super.key,
    required this.child,
    this.title = '',
    this.showAppBar = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: showAppBar
          ? AppBar(
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              centerTitle: true,
              actions: actions,
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: Colors.black26,
            )
          : null,
      body: SafeArea(
        child: child,
      ),
    );
  }
}
