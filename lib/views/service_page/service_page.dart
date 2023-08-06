// ignore_for_file: unrelated_type_equality_checks

import 'package:audio_book_kwork_1/views/home_page/home_controller.dart';
import 'package:audio_book_kwork_1/views/info/info_screen.dart';
import 'package:audio_book_kwork_1/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'previously_viewed_model_controller.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  HomeController controller = Get.put(HomeController());
  PVModelController controllerPVController = Get.put(PVModelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () {
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
              },
            ),
            Obx(() {
              if (controllerPVController.isLoading == true) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controllerPVController.musicList.isEmpty) {
                return Center(child: Lottie.asset("assets/empty_list.json"));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ранее просмотренные',
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
                          itemCount: controllerPVController.musicList.length,
                          itemBuilder: (context, index) {
                            // final musicPath = savedMusicPaths[index];
                            // Customize how you want to display the saved music, e.g., use ListTile
                            final item =
                                controllerPVController.musicList[index];
                            print(
                                "$item ========================================================================================================");
                            return InkWell(
                              onTap: () {
                                Get.to(() => InfoScreen(
                                      title: item.title,
                                      musicFilePaths: item.path,
                                    ));
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
            })
          ],
        ),
      ),
    );
  }
}
