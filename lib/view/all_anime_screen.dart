import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/all_anime_controller.dart';
import 'package:flutter_application_1/view/widgets/error_screen.dart';
import 'package:flutter_application_1/view/widgets/home_screen/anime_card_1.dart';
import 'package:flutter_application_1/view/widgets/shimmer_loading.dart';
import 'package:get/get.dart';

import '../utils/theme.dart';

class AllAnimeScreen extends GetView<AllAnimeController> {
  const AllAnimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(slivers: [
      SliverAppBar(
        pinned: false,
        elevation: 0,
        stretch: true,
        centerTitle: false,
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text(
          'انمي',
          style: CustomTheme.darkTextTheme.bodyMedium!,
        ),
      ),
      SliverToBoxAdapter(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Obx(
            () => controller.error.value
                ? ErrorPage(
                    ontTap: () => controller
                        .scrapeWebsiteData(Get.parameters['page'] ?? ''),
                  )
                : (!controller.error.value &&
                        !controller.loading.value &&
                        controller.animeList.isEmpty)
                    ? SizedBox(
                        height: Get.height - 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'لم يتم العثور على انميات',
                              style: CustomTheme.darkTextTheme.bodyMedium!,
                            ),
                          ],
                        ),
                      )
                    : Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 8,
                        spacing: 8,
                        children: List.generate(
                            controller.loading.value
                                ? 30
                                : controller.animeList.length,
                            (index) => controller.loading.value
                                ? ShimmerLoading(
                                    height: 220,
                                    width: 160,
                                    radius: 15,
                                  )
                                : AnimeCardHomeScreen1(
                                    anime: controller.animeList[index],
                                    height: 220,
                                    width: 160,
                                  )),
                      ),
          ),
        ),
      )
    ])));
  }
}
