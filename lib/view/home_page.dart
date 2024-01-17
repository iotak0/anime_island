import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/admob_controller.dart';
import 'package:flutter_application_1/controllers/home_controller.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/models/genres_model.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/icons.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/view/widgets/animeisland_titel.dart';
import 'package:flutter_application_1/view/widgets/custom_cached_network_image.dart';
import 'package:flutter_application_1/view/widgets/custom_titel.dart';
import 'package:flutter_application_1/view/widgets/error_screen.dart';
import 'package:flutter_application_1/view/widgets/glass_widget.dart';
import 'package:flutter_application_1/view/widgets/home_screen/anime_card_1.dart';
import 'package:flutter_application_1/view/widgets/home_screen/episode_anime_card_1.dart';
import 'package:flutter_application_1/view/widgets/search_dialog.dart';
import 'package:flutter_application_1/view/widgets/shimmer_loading.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const CustomImage(
                  height: 300,
                  width: double.infinity,
                  radius: 0,
                  imageUrl:
                      'https://animont.net/animeisland/assest/AsagiriGen.jpg',
                ),
                Positioned(
                  bottom: 10,
                  width: 180,
                  height: 60,
                  child: GlassWidget(child: SizedBox()),
                ),
                const AnimeIslandTtle()
              ],
            ),
            ListTile(
              title: Text(
                'الصفحة الرئسية',
                style: CustomTheme.darkTextTheme.bodyMedium,
              ),
              onTap: () {
                if (Get.currentRoute == Routs.kHomePage) {
                  Get.back();
                  return;
                }
                Get.offAllNamed(Routs.kHomePage);
              },
            ),
            ListTile(
              title: Text(
                'الموسم الحالي',
                style: CustomTheme.darkTextTheme.bodyMedium,
              ),
              onTap: () => Get.toNamed(Routs.kAnimeScreen, parameters: {
                'page': controller.animeSeason ?? 'anime-season/صيف-2023'
              }),
            ),
            ListTile(
              title: Text(
                'افلام الانمي',
                style: CustomTheme.darkTextTheme.bodyMedium,
              ),
              onTap: () => Get.toNamed(Routs.kAnimeScreen,
                  parameters: {'page': 'anime-type/movie'}),
            ),
            ListTile(
              title: Text(
                'انميات مدبلجة',
                style: CustomTheme.darkTextTheme.bodyMedium,
              ),
              onTap: () => Get.toNamed(Routs.kAnimeScreen,
                  parameters: {'page': 'anime-category/الانمي-المدبلج'}),
            ),
            ListTile(
              title: Text(
                'حول التطبيق',
                style: CustomTheme.darkTextTheme.bodyMedium,
              ),
              onTap: () => Helper.showStory('حول التطبيق', aboutApp),
            ),
          ],
        ),
      ),
      drawerEnableOpenDragGesture: true,
      endDrawerEnableOpenDragGesture: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              elevation: 0,
              stretch: true,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Container(child: Image.asset('images/animeisland.png')),
              ),
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              // title: const AnimeIslandTtle(),
              //?search_param=animes&s=hi
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [StretchMode.blurBackground],
              ),
              leading: InkWell(
                onTap: () => _key.currentState!.openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.string(
                    PIcons.menu,
                    theme: SvgTheme(currentColor: Colors.white),
                  ),
                ),
              ),
              actions: [
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(50),
                  //     color: Get.theme.primaryColor),
                  child: InkWell(
                    onTap: () => SmartDialog.show(
                        builder: (context) => SearchDialog(
                              controller: controller,
                            )),
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.string(
                        PIcons.search,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => controller.error.value
                    ? ErrorPage(
                        ontTap: () => controller.scrapeWebsiteData(),
                      )
                    : Column(
                        children: [
                          GetBuilder(
                            init: AdMobController(),
                            builder: (controller) {
                              return controller.bannerAd == null
                                  ? SizedBox()
                                  : Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: controller.bannerAd!.size.width
                                            .toDouble(),
                                        height: controller.bannerAd!.size.height
                                            .toDouble(),
                                        child:
                                            AdWidget(ad: controller.bannerAd!),
                                      ),
                                    );
                            },
                          ),

                          CustomTitle(tital: 'الأنميات المثبته'),

                          Obx(
                            () {
                              return CarouselSlider(
                                options: CarouselOptions(
                                    height: 200.0, autoPlay: true),
                                items: controller.loading.value
                                    ? List.generate(
                                        3,
                                        (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ShimmerLoading(
                                              height: 200,
                                              width: Get.width,
                                              radius: 15,
                                            )))
                                    : controller.pinAnimeList.map((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: controller.loading.value
                                                  ? ShimmerLoading(
                                                      height: 200,
                                                      width: Get.width,
                                                      radius: 15,
                                                    )
                                                  : InkWell(
                                                      onLongPress: () =>
                                                          Helper.showStory(
                                                              'القصة',
                                                              i.description),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      onTap: () async {
                                                        await Get.find<
                                                                AdMobController>()
                                                            .loadInterstitialAd(() =>
                                                                Get.toNamed(
                                                                    Routs
                                                                        .kAnimeDetails,
                                                                    parameters: {
                                                                      'url': i
                                                                          .animeUrl
                                                                    }));
                                                        if (Get.find<
                                                                    AdMobController>()
                                                                .interstitialAd !=
                                                            null) {
                                                          await Get.find<
                                                                  AdMobController>()
                                                              .interstitialAd
                                                              ?.show()
                                                              .then((value) => Get
                                                                      .find<
                                                                          AdMobController>()
                                                                  .interstitialAd!
                                                                  .dispose());
                                                          Get.toNamed(
                                                              Routs
                                                                  .kAnimeDetails,
                                                              parameters: {
                                                                'url':
                                                                    i.animeUrl
                                                              });
                                                        } else {
                                                          Get.toNamed(
                                                              Routs
                                                                  .kAnimeDetails,
                                                              parameters: {
                                                                'url':
                                                                    i.animeUrl
                                                              });
                                                        }
                                                      },
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        children: [
                                                          CustomImage(
                                                              radius: 15,
                                                              width: Get.width,
                                                              height: 200,
                                                              imageUrl:
                                                                  i.imageUrl),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.vertical(
                                                                    bottom: Radius
                                                                        .circular(
                                                                            15)),
                                                                color: PColors
                                                                    .darkColor
                                                                    .withOpacity(
                                                                        .6)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                i.title,
                                                                maxLines: 1,
                                                                style: CustomTheme
                                                                    .darkTextTheme
                                                                    .titleLarge!,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            );
                                          },
                                        );
                                      }).toList(),
                              );
                            },
                          ),
                          CustomTitle(tital: 'التصنيفات'),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Obx(
                                () => Row(
                                    children: List.generate(
                                        Genre.genresList.length,
                                        (index) => InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              onTap: () {
                                                if (controller.loading.value) {
                                                  return;
                                                }
                                                Get.toNamed(Routs.kAnimeScreen,
                                                    parameters: {
                                                      'page': Genre
                                                          .genresList[index]
                                                    });
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: PColors.darkColor
                                                        .withOpacity(.6)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16.0),
                                                  child: controller
                                                          .loading.value
                                                      ? ShimmerLoading(
                                                          height: 50,
                                                          width: (Random()
                                                                      .nextDouble() *
                                                                  100) +
                                                              50,
                                                          radius: 15,
                                                        )
                                                      : Text(
                                                          Genre
                                                              .genresList[index]
                                                              .replaceAll(
                                                                  'anime-genre/',
                                                                  ''),
                                                          style: CustomTheme
                                                              .darkTextTheme
                                                              .bodySmall!,
                                                        ),
                                                ),
                                              ),
                                            ))),
                              )),
                          CustomTitle(tital: 'حلقات الانمي المثبته'),
                          // CustomTitle(tital: 'اكمل المشاهدة'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(
                              () => Row(
                                children: List.generate(
                                    controller.loading.value
                                        ? 10
                                        : controller.pinEpisodesList.length,
                                    (index) => controller.loading.value
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ShimmerLoading(
                                              height: 150,
                                              width: 250,
                                              radius: 15,
                                            ),
                                          )
                                        : EpisodeAnimeCard_1(
                                            episode: controller
                                                .pinEpisodesList[index],
                                            height: 150,
                                            width: 250,
                                          )),
                              ),
                            ),
                          ),
                          CustomTitle(tital: 'آخر الأنميات المضافة'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(
                              () => Row(
                                children: List.generate(
                                    controller.loading.value
                                        ? 10
                                        : controller.lastAnimeList.length,
                                    (index) => controller.loading.value
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ShimmerLoading(
                                              height: 220,
                                              width: 160,
                                              radius: 15,
                                            ),
                                          )
                                        : AnimeCardHomeScreen1(
                                            anime:
                                                controller.lastAnimeList[index],
                                            height: 220,
                                            width: 160,
                                          )),
                              ),
                            ),
                          ),
                          CustomTitle(tital: 'آخر الحلقات المضافة'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(
                              () => Row(
                                children: List.generate(
                                    controller.loading.value
                                        ? 10
                                        : controller.lastEpisodesList.length,
                                    (index) => controller.loading.value
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ShimmerLoading(
                                              height: 150,
                                              width: 250,
                                              radius: 15,
                                            ),
                                          )
                                        : EpisodeAnimeCard_1(
                                            episode: controller
                                                .lastEpisodesList[index],
                                            height: 150,
                                            width: 250,
                                          )),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
