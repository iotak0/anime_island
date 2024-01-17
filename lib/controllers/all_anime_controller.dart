// ignore_for_file: invalid_return_type_for_catch_error

import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/models/anime_results.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllAnimeController extends GetxController {
  final _animeList = <Anime>[].obs;
  late AnimeResults animeResults;
  List<Anime> get animeList => _animeList;
  var loading = true.obs;
  var error = false.obs;
  var nextPage = 1;
  var allPage = 0;
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
    animeResults = list;
    animeList.addAll(animeList);
    allPage = (list.animeList!.length / 50).ceil();

    loadMoreItems();
  }

  void loadMoreItems() {
    Future.delayed(Duration(seconds: 2), () {
      for (int i = getRange(nextPage)['start'];
          i < getRange(nextPage)['end'];
          i++) {
        animeList.add(animeResults.animeList![i]);
      }
      loading.value = false;
      nextPage++; // Increment page number for pagination
    });
  }

  Map<String, dynamic> getRange(int index) {
    int start = ((50 * index) - 50).abs();
    int end = ((animeResults.animeList!.length - start) >= 50)
        ? index * 50
        : (animeResults.animeList!.length - start) + start;
    return {'start': start, "end": end};
  }
}
