import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CurveBottomNavBar extends StatefulWidget {
  final Function(int)? onTap;
  const CurveBottomNavBar({
    super.key,
    required this.onTap,
  });

  @override
  State<CurveBottomNavBar> createState() => _CurveBottomNavBarState();
}

class _CurveBottomNavBarState extends State<CurveBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60,
      backgroundColor: Colors.grey.shade400,
      color: Colors.blueGrey,
      animationDuration: const Duration(milliseconds: 300),
      onTap: widget.onTap,
      items: const [
        Icon(Icons.person, color: Colors.white),
        Icon(Icons.chat_bubble, color: Colors.white),
        Icon(Icons.search, color: Colors.white),
        Icon(Icons.settings, color: Colors.white),
      ],
    );
  }
}
