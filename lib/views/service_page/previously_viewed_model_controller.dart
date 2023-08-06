import 'dart:io';

import 'package:audio_book_kwork_1/model/previously_viewed_model.dart';
import 'package:audio_book_kwork_1/service/service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
class PVModelController extends GetxController {
  final _isLoading = true.obs;
  final _musicList = <PreviouslyViewedModel>[].obs;

  bool get isLoading => _isLoading.value;
  List<PreviouslyViewedModel> get musicList => _musicList.toList();

  @override
  void onInit() {
    super.onInit();
    _loadMusicFilePaths();
    getMusics();
  }

  addMusic(PreviouslyViewedModel music) async {
    _changeLoading(true);
    await LocalDatabase().addPVModel(music);
    _changeLoading(false);
  }

  getMusics() async {
    _changeLoading(true);
    _musicList.value = await LocalDatabase().getAllPVModels();
    _changeLoading(false);
  }

  Future<void> _loadMusicFilePaths() async {
    final appDir = await getApplicationDocumentsDirectory();
    _musicList.forEach((pvModel) {
      final file = File('${appDir.path}/${pvModel.path}');
      if (!file.existsSync()) {
        _musicList.remove(pvModel);
      }
    });
  }

  _changeLoading(bool value) {
    _isLoading.value = value;
  }
}
