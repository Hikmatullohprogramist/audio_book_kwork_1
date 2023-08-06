import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/Book.svg",
        ),
        const Text(
          'Аудио-книги',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
