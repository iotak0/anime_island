import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/route_management/screen_bindings.dart';
import 'package:flutter_application_1/view/all_anime_screen.dart';
import 'package:flutter_application_1/view/anime_details.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_application_1/view/web_player.dart';
import 'package:get/get.dart';

class AllPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: Routs.kHomePage,
        page: () => const HomePage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routs.kAnimeDetails,
        page: () => AnimeDetails(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routs.kWebPlayer,
        page: () => WebPlayer(),
        binding: ScreenBindings(),
      ),
       GetPage(
        name: Routs.kAnimeScreen,
        page: () => AllAnimeScreen(),
        binding: ScreenBindings(),
      ),
    ];
  }
}
