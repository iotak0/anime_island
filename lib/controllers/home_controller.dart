import 'package:flutter_application_1/controllers/admob_controller.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/models/episode_model.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/urls.dart';
import 'package:flutter_application_1/view/widgets/ads_dialog.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
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
  var adUrlFilters;
  var loading = true.obs;
  var error = false.obs;
  var searchKey = '';
  var animeSeason;
  @override
  void onInit() {
    super.onInit();
    scrapeWebsiteData();
  }

  Future<void> scrapeWebsiteData() async {
    error.value = false;
    loading.value = true;

    final response =
        //'https://rq.anim4dt.site/' 'https://cloudanime.site'
        await http.get(Uri.parse('https://cloudanime.site')).catchError((e) {
      error.value = true;
      loading.value = false;
      printError(info: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return '';
    });
    printInfo(info: response.body);
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
    await Future.delayed(Duration(seconds: 5))
        .then((value) => adUrlFilters = newVersoin());
  }

  newVersoin() async {
    final response = await http.get(Uri.parse(latestRelease)).catchError((e) {
      // ignore: invalid_return_type_for_catch_error
      return '';
    });
    Helper.checkForUpdate(response);
  }

  searchAnime() {
    if (searchKey.isEmpty) {
      SmartDialog.showToast('هذا الحقل مطلوب');
      return;
    }
    SmartDialog.dismiss();
    Get.dialog(AdsDialog(
      onPressed: () async {
        Get.back();
        if (Get.find<AdMobController>().rewardedAd == null) {
          await Get.find<AdMobController>().loadRewardedAd();
        }
        await Get.find<AdMobController>().rewardedAd?.show(
          onUserEarnedReward: (_, reward) {
            SmartDialog.dismiss();
            Get.toNamed(
              Routs.kAnimeScreen,
              parameters: {'page': '?search_param=animes&s=$searchKey'},
            );
          },
        );
      },
    ));
  }
}
