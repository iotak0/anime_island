import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllAnimeController extends GetxController {
  final _animeList = <Anime>[].obs;
  List<Anime> get animeList => _animeList;
  var loading = true.obs;
  var error = false.obs;
  @override
  void onInit() {
    super.onInit();
    scrapeWebsiteData(Get.parameters['page'] ?? '');
  }

  Future<void> scrapeWebsiteData(String page) async {
    error.value = false;
    loading.value = true;
    final response = await http
        .get(Uri.parse('https://cloudanime.site/$page'))
        .catchError((e) {
      error.value = true;
      loading.value = false;
      return '';
    });

    final list = await AnimeService().getAnimes(response, null);
    animeList.addAll(list.animeList!);
    loading.value = false;
  }
}
