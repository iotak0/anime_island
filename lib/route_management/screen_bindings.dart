import 'package:flutter_application_1/controllers/admob_controller.dart';
import 'package:flutter_application_1/controllers/all_anime_controller.dart';
import 'package:flutter_application_1/controllers/anime_details_controller.dart';
import 'package:flutter_application_1/controllers/home_controller.dart';
import 'package:flutter_application_1/controllers/loading_controller.dart';
import 'package:flutter_application_1/controllers/web_player_controller.dart';
import 'package:get/get.dart';

class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AnimeDetailsController());
    Get.lazyPut(() => AllAnimeController());
    Get.lazyPut(() => WebPlayerController());
        Get.lazyPut(() => AdMobController());

    Get.put(LoadingController());
  }
}
