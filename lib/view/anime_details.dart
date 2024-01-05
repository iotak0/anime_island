import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/anime_details_controller.dart';
import 'package:flutter_application_1/controllers/loading_controller.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_application_1/utils/icons.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/view/widgets/custom_back_button.dart';
import 'package:flutter_application_1/view/widgets/custom_cached_network_image.dart';
import 'package:flutter_application_1/view/widgets/custom_expansion_list.dart';
import 'package:flutter_application_1/view/widgets/custom_titel.dart';
import 'package:flutter_application_1/view/widgets/error_screen.dart';
import 'package:flutter_application_1/view/widgets/plot_summary.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AnimeDetails extends GetView<AnimeDetailsController> {
  AnimeDetails({super.key});
  final loadingController = Get.find<LoadingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.error.value
            ? Column(
                children: [
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: CustomBackButton(),
                  ),
                  ErrorPage(
                    ontTap: () => controller.scrapeWebsiteData(),
                  ),
                ],
              )
            : controller.loading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        pinned: true,
                        elevation: 0,
                        surfaceTintColor: Colors.transparent,
                        stretch: true,
                        centerTitle: false,
                        leading: CustomBackButton(),
                        expandedHeight: 300,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: [StretchMode.blurBackground],
                          background: SizedBox(
                            height: 300,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                CustomImage(
                                    radius: 0,
                                    width: Get.width,
                                    height: 400,
                                    imageUrl: controller.anime.imageUrl),
                                InkWell(
                                  onTap: () {
                                    if (controller.anime.episodes.isEmpty) {
                                      SmartDialog.showToast(
                                          'لا توجدت حلقات لعرضها!');
                                    }
                                    Helper.showServersList(controller
                                        .anime.episodes[0].episodeUrl);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color:
                                            PColors.darkColor.withOpacity(.5)),
                                    child: SvgPicture.string(PIcons.play,
                                        theme: CustomTheme.svgTheme),
                                  ),
                                ),
                                Positioned(
                                  bottom: -15,
                                  width: Get.width,
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(15)),
                                        color:
                                            Get.theme.scaffoldBackgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8.0),
                                child: Text(
                                  controller.anime.title,
                                  style: CustomTheme.darkTextTheme.bodyLarge!,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      controller.anime.genres.length,
                                      (index) => InkWell(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            onTap: () {
                                              Get.printInfo(
                                                  info: controller.anime
                                                      .genres[index].link);
                                              Get.toNamed(Routs.kAnimeScreen,
                                                  parameters: {
                                                    'page': controller.anime
                                                        .genres[index].link
                                                        .trim()
                                                  });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: PColors.darkColor),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 16.0),
                                                  child: Text(
                                                    controller.anime
                                                        .genres[index].name,
                                                    style: CustomTheme
                                                        .darkTextTheme
                                                        .bodySmall!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: CustomTitle(tital: 'معلومات إضافية'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Wrap(
                                  runSpacing: 4,
                                  spacing: 8,
                                  children: List.generate(
                                      controller.anime.moreInfo.length,
                                      (index) => Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('●'),
                                              Html(
                                                  shrinkWrap: true,
                                                  data: controller
                                                      .anime.moreInfo[index],
                                                  onLinkTap: (url, attributes,
                                                      element) {
                                                    Get.toNamed(
                                                        Routs.kAnimeScreen,
                                                        parameters: {
                                                          'page': url!.replaceAll(
                                                              'https://cloudanime.site/',
                                                              '')
                                                        });
                                                  },
                                                  style: {
                                                    'span': Style(
                                                        fontSize:
                                                            FontSize.large),
                                                    'div': Style(
                                                        fontFamily: CustomTheme
                                                            .darkTextTheme
                                                            .bodySmall!
                                                            .fontFamily,
                                                        fontSize:
                                                            FontSize.large),
                                                    'a': Style(
                                                      fontSize: FontSize.medium,
                                                      textDecoration:
                                                          TextDecoration.none,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  }),
                                            ],
                                          )),
                                ),
                              ),
                              PlotSummary(
                                  summary: controller.anime.description),
                              ExpansionList(title: 'العرض التشويقي', children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: YoutubePlayer(
                                    controller:
                                        controller.youtubePlayerController,
                                    showVideoProgressIndicator: true,
                                    bottomActions: [],
                                    progressIndicatorColor:
                                        PColors.premiumColor,
                                  ),
                                ),
                              ]),
                              ExpansionList(
                                  title: 'الحلقات',
                                  children: List.generate(
                                      controller.episodesGroups,
                                      (index0) => ExpansionList(
                                          title:
                                              '${controller.getEpisodeRange(index0 + 1)['end']} - ${controller.getEpisodeRange(index0 + 1)['start'] + 1}',
                                          children: List.generate(
                                            (controller.getEpisodeRange(
                                                        index0 + 1)['end'] -
                                                    controller.getEpisodeRange(
                                                        index0 + 1)['start'])
                                                .abs(),
                                            (index) {
                                              int lastIndex =
                                                  controller.getEpisodeRange(
                                                          index0 + 1)['end'] -
                                                      (index + 1);
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () =>
                                                        Helper.showServersList(
                                                            controller
                                                                .anime
                                                                .episodes[
                                                                    lastIndex]
                                                                .episodeUrl),
                                                    child: ListTile(
                                                      trailing: Container(
                                                        height:
                                                            double.maxFinite,
                                                        width: Get.width / 3,
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(controller
                                                                      .anime
                                                                      .episodes[
                                                                          lastIndex]
                                                                      .imageUrl),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: PColors
                                                                    .darkColor),
                                                      ),
                                                      title: Text(
                                                        controller
                                                            .anime
                                                            .episodes[lastIndex]
                                                            .title,
                                                        style: CustomTheme
                                                            .darkTextTheme
                                                            .bodyMedium!,
                                                      ),
                                                      subtitle: Text(
                                                        controller
                                                            .anime
                                                            .episodes[lastIndex]
                                                            .description,
                                                        maxLines: 3,
                                                        style: CustomTheme
                                                            .darkTextTheme
                                                            .bodySmall!,
                                                      ),
                                                    ),
                                                  ));
                                            },
                                          ))))
                            ]),
                      ))
                    ],
                  ),
      ),
    );
  }
}
