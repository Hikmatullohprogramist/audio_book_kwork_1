// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import, prefer_const_constructors_in_immutables, unused_local_variable, unrelated_type_equality_checks, depend_on_referenced_packages

import 'dart:io';
import 'package:audio_book_kwork_1/model/book_model.dart';
import 'package:audio_book_kwork_1/model/previously_viewed_model.dart';
import 'package:audio_book_kwork_1/service/service.dart';
import 'package:audio_book_kwork_1/views/home_page/home_controller.dart';
import 'package:audio_book_kwork_1/views/info/info_screen.dart';
import 'package:audio_book_kwork_1/views/service_page/previously_viewed_model_controller.dart';
import 'package:audio_book_kwork_1/widgets/book_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController musicNameController = TextEditingController();
    HomeController controller = Get.put(HomeController());
    PVModelController pvModelController = Get.put(PVModelController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.pickFile();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              if (controller.isLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.musicList.isEmpty) {
                return Center(
                  child: Lottie.asset("assets/empty_list.json"),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Избранные',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.musicList.length,
                          itemBuilder: (context, index) {
                            // final musicPath = savedMusicPaths[index];
                            // Customize how you want to display the saved music, e.g., use ListTile
                            final item = controller.musicList[index];
                            return InkWell(
                              onTap: () {
                                pvModelController.addMusic(
                                  PreviouslyViewedModel(
                                    title: item.title,
                                    artist: item.artist,
                                    duration: item.duration,
                                    path: item.path,
                                  ),
                                );

                                Get.to(
                                  () => InfoScreen(
                                    title: item.title,
                                    musicFilePaths: item.path,
                                  ),
                                );
                              },
                              child: BookItem(
                                title: item.title,
                                img: QueryArtworkWidget(
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget:
                                      const Icon(Icons.music_note),
                                  id: index,
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              //   controller.checkAndRequestPermissions(retry: true)
            },
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
