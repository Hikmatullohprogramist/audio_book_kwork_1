import 'package:audio_book_kwork_1/utils/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeController controller = Get.put(ThemeController(context));
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.dark_mode,weight: 60,color: Get.theme.colorScheme.secondary,),
                Text("Dark mode",style: TextStyle(color: Get.theme.colorScheme.secondary),),
                CupertinoSwitch(value: Get.isDarkMode, onChanged: (value) {
                  Get.changeTheme(Get.isDarkMode?ThemeData.light():ThemeData.dark());
                  Get.changeThemeMode(Get.isDarkMode?ThemeMode.light:ThemeMode.dark);
                  setState(() {
                    print('Qayta chizildi');
                    print("Current theme mode is dark 2 ${Get.isDarkMode}");
                    print(Get.isDarkMode);
                  });
                },)
              ],
            )
          ],
        ),
      ),

    );
  }
}