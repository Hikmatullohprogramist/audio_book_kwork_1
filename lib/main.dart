import 'package:audio_book_kwork_1/utils/theme_controller.dart';
import 'package:audio_book_kwork_1/utils/theme_data.dart';
import 'package:audio_book_kwork_1/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


void main() {
  runApp(const MyApp());
  requestPermission();
}
void requestPermission() async {
  PermissionStatus status = await Permission.storage.request();
  print('========================================================Permission status: $status ===============================');
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme:AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      theme: AppThemes.lightTheme,
      home: const SplashScreen(),
    );
  }
}
