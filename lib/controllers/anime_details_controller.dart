import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AnimeDetailsController extends GetxController {
  late Anime anime;
  var loading = true.obs;
  var error = false.obs;
  int episodesGroups = 1;
  late YoutubePlayerController youtubePlayerController;
  @override
  void onInit() async {
    super.onInit();
    await scrapeWebsiteData();
    episodesGroups =
        anime.episodes.length < 50 ? 1 : (anime.episodes.length / 50).ceil();
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
      // ignore: invalid_return_type_for_catch_error
      return '';
    });
    // ignore: unnecessary_null_comparison
    if (anime == null) {
      loading.value = false;
    } else {
      loading.value = false;
    }
    await loadYoutube();
  }

  loadYoutube() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(anime.youtubeTrailer).toString(),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  Map<String, dynamic> getEpisodeRange(int index) {
    int start = ((50 * index) - 50).abs();
    int end = ((anime.episodes.length - start) >= 50)
        ? index * 50
        : (anime.episodes.length - start) + start;
    return {'start': start, "end": end};
  }
}
