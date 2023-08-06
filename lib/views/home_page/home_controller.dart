// ignore_for_file: unnecessary_null_comparison

import 'package:audio_book_kwork_1/model/book_model.dart';
import 'package:audio_book_kwork_1/service/service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController() {
    getMusics();
    // _loadMusicFilePaths();
  }

  var isLoading = false.obs;
  var musicList = [].obs;
  var _musicFilePaths = <String>[].obs;
  List<String> get musicFilePaths => _musicFilePaths.toList();

  pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.audio, dialogTitle: "Select Musics");

    final file = result!.files.first;
    if (result == null) return;
    Music music = Music(
      title: file.name.toString(),
      artist: "artist",
      duration: "",
      path: file.path.toString(),
    );

    LocalDatabase().addMusic(music);

    Get.snackbar("MUSIC ", "SUCCESS ADDED");
    getMusics();
  }

  getMusics() async {
    changeLoading();
    musicList.value = await LocalDatabase().getAllMusics();

    changeLoading();
  }

  deleteMusic(){}
  // Future<void> _loadMusicFilePaths() async {
  //   _musicFilePaths = (await LocalDatabase().getAllMusics()) as RxList<String>;
  // }
  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
