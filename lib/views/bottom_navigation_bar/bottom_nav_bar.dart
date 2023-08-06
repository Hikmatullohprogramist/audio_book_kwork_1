// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:audio_book_kwork_1/views/home_page/home_page.dart';
import 'package:audio_book_kwork_1/views/service_page/service_page.dart';
import 'package:audio_book_kwork_1/views/settings_page/settings_page.dart';
import 'package:audio_book_kwork_1/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _pages = [
    HomePage(),
    const ServicePage(),
    const SettingsPage(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const TitleWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.extension),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "",
          ),
        ],
      ),
      body: _pages[selectedIndex],
    );
  }
}
