import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/all_anime_controller.dart';
import 'package:flutter_application_1/view/widgets/animeisland_titel.dart';
import 'package:flutter_application_1/view/widgets/error_screen.dart';
import 'package:flutter_application_1/view/widgets/home_screen/anime_card_1.dart';
import 'package:flutter_application_1/view/widgets/shimmer_loading.dart';
import 'package:get/get.dart';
import '../utils/theme.dart';

class AllAnimeScreen extends StatelessWidget {
  AllAnimeScreen({super.key});
  final controller = Get.find<AllAnimeController>(tag: Get.parameters['page']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true,
        elevation: 0,
        stretch: true,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: const AnimeIslandTtle(),
        // title: Text(
        //   'أكشن',
        //   style: CustomTheme.darkTextTheme.bodyLarge,
        // ),
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
      ),
      //   leading: CustomBackButton(),
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
                                : controller.animeList.length, (index) {
                          if (index == controller.animeList.length - 1) {
                            // Reached the end of the list, load more items
                            controller.loadMoreItems();
                          }
                          return controller.loading.value
                              ? ShimmerLoading(
                                  height: 220,
                                  width: 160,
                                  radius: 15,
                                )
                              : AnimeCardHomeScreen1(
                                  anime: controller.animeList[index],
                                  height: 220,
                                  width: 160,
                                );
                        }),
                      ),
          ),
        ),
      )
    ])));
  }
}
