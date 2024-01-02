import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:get/get.dart';

class AnimeDetailsController extends GetxController {
  late Anime anime;
  var loading = true.obs;
  var error = false.obs;
  @override
  void onInit() async {
    super.onInit();
    scrapeWebsiteData();
  }

  scrapeWebsiteData() async {
    error.value = false;
    loading.value = true;
    anime = await AnimeService()
        .fetchAnimeDetails(
            'https://cloudanime.site/${Get.parameters['url']!}', loading)
        .then((value) {
      loading = false.obs;
      return value;
    }).catchError((e) {
      error.value = true;
      loading.value = false;
      return '';
    });
    if (anime == null) {
      loading.value = false;
    } else {
      loading.value = false;
    }
  }
}
