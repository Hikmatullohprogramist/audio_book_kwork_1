// ignore_for_file: avoid_unnecessary_containers

import 'package:audio_book_kwork_1/views/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:audio_book_kwork_1/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 2)).then((value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        )));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: TitleWidget(),
        ),
      ),
    );
  }
}
