import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/custom_drawer.dart';
import 'package:loja_virtual/ui/home_page.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomePage(),
          drawer: CustomDrawer(),
        ),
      ],
    );
  }
}
