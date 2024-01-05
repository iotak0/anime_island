import 'package:flutter_application_1/helper/ad_helper.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/models/episode_model.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:flutter_application_1/utils/urls.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final _pinAnimeList = <Anime>[].obs;
  List<Anime> get pinAnimeList => _pinAnimeList;
  final _lastAnimeList = <Anime>[].obs;
  List<Anime> get lastAnimeList => _lastAnimeList;
  final _pinEpisodesList = <Episode>[].obs;
  List<Episode> get pinEpisodesList => _pinEpisodesList;
  final _lastEpisodesList = <Episode>[].obs;
  List<Episode> get lastEpisodesList => _lastEpisodesList;
  var loading = true.obs;
  var error = false.obs;
  var animeSeason;
  @override
  void onInit() {
    super.onInit();
    scrapeWebsiteData();
  }

  Future<void> scrapeWebsiteData() async {
    error.value = false;
    loading.value = true;
    await newVersoin();
    final response =
        await http.get(Uri.parse('https://cloudanime.site')).catchError((e) {
      error.value = true;
      loading.value = false;
      return '';
    });

    final list = await AnimeService().getAnimes(response, URLs.pinAnime);
    pinAnimeList.addAll(list.animeList!);
    final list2 = await AnimeService().getAnimes(response, URLs.latestAnime);
    lastAnimeList.addAll(list2.animeList!);
    final list3 =
        await AnimeService().getAnimesEpisodesHome(response, URLs.pinEpisodes);
    pinEpisodesList.addAll(list3.episodeList!);
    final list4 =
        await AnimeService().getAnimesEpisodesHome(response, URLs.lastEpisodes);
    lastEpisodesList.addAll(list4.episodeList!);
    animeSeason = await AnimeService().getAnimeSeason(response);
    loading.value = false;
  }

  newVersoin() async {
    final response =
        await http.get(Uri.parse('https://cloudanime.site')).catchError((e) {
      error.value = true;
      loading.value = false;
      return '';
    });
    Helper.checkForUpdate(response);
  }
}
