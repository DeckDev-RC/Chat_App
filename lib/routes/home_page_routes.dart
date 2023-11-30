import 'package:chat_app/pages/initial_page.dart';
import 'package:chat_app/pages/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePageRoutes extends StatefulWidget {
  const HomePageRoutes({
    super.key,
  });

  @override
  State<HomePageRoutes> createState() => _HomePageRoutesState();
}

class _HomePageRoutesState extends State<HomePageRoutes> {
  int _currentPageIndex = 0;
  final PageController _currentPageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _currentPageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: const [
          InitialPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CurvedNavigationBar(
          index: _currentPageIndex,
          onTap: (index) {
            _currentPageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          items: const [
            Icon(Icons.chat, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
          ],
          height: 60,
          backgroundColor: const Color(0xFF626868),
          color: const Color(0xFF273C2C),
          animationDuration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
