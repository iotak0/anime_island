import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/anime_details_controller.dart';
import 'package:flutter_application_1/controllers/loading_controller.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_application_1/utils/icons.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/view/anime_list_view.dart';
import 'package:flutter_application_1/view/widgets/custom_titel.dart';
import 'package:flutter_application_1/view/widgets/plot_summary.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnimeDetails extends GetView<AnimeDetailsController> {
  AnimeDetails({super.key});
  final loadingController = Get.find<LoadingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.error.value
            ? SizedBox(
                height: Get.height - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('حدث خطأ ما الرجاء اعادة المحاولة'),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: PColors.premiumColor),
                        onPressed: () => controller.scrapeWebsiteData(),
                        child: Text('اعادة المحاولة'))
                  ],
                ),
              )
            : controller.loading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        pinned: false,
                        elevation: 0,
                        stretch: true,
                        centerTitle: false,
                        expandedHeight: 300,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: [StretchMode.blurBackground],
                          background: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image(
                                width: Get.width,
                                image: NetworkImage(controller.anime.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              InkWell(
                                onTap: () {
                                  YoutubePlayerController _controller =
                                      YoutubePlayerController(
                                    initialVideoId:
                                        YoutubePlayer.convertUrlToId(
                                                controller.anime.youtubeTrailer)
                                            .toString(),
                                    flags: YoutubePlayerFlags(
                                      autoPlay: true,
                                      mute: false,
                                    ),
                                  );

                                  Get.dialog(
                                      useSafeArea: true,
                                      Dialog(
                                        child: Container(
                                          //height: 220,
                                          width: Get.width,
                                          color: Colors.black.withOpacity(.8),
                                          child: YoutubePlayer(
                                            controller: _controller,
                                            showVideoProgressIndicator: true,
                                            // videoProgressIndicatorColor: Colors.amber,
                                            // progressColors: ProgressColors(
                                            //     playedColor: Colors.amber,
                                            //     handleColor: Colors.amberAccent,
                                            // ),
                                            // onReady () {
                                            //     _controller.addListener(listener);
                                            // },
                                          ),
                                        ),
                                      ),
                                      barrierColor: PColors.darkBackground
                                          .withOpacity(.5));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: PColors.darkColor.withOpacity(.5)),
                                  child: SvgPicture.string(PIcons.play,
                                      theme: CustomTheme.svgTheme),
                                ),
                              )
                            ],
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
                                      style:
                                          CustomTheme.darkTextTheme.bodyLarge!,
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
                                                  Get.toNamed(
                                                      Routs.kAnimeScreen,
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
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          color: PColors
                                                              .darkColor),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: CustomTitle(tital: 'معلومات إضافية'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Wrap(
                                      children: List.generate(
                                          controller.anime.moreInfo.length,
                                          (index) => Html(
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
                                                    'a': Style(
                                                      fontSize: FontSize.medium,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  })),
                                    ),
                                  ),
                                  PlotSummary(
                                      summary: controller.anime.description),
                                  ExpansionTile(
                                      textColor:
                                          Color.fromARGB(255, 104, 208, 240),
                                      iconColor:
                                          Color.fromARGB(255, 104, 208, 240),
                                      title: Text(
                                        'الحلقات',
                                        style: CustomTheme
                                            .darkTextTheme.displaySmall!,
                                      ),
                                      childrenPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10),
                                      children: [
                                        ...List.generate(
                                          controller.anime.episodes.length,
                                          (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                //onTap: () => Get.toNamed(Routs.kWebPlayer),
                                                onTap: () {
                                                  Helper.showServersList(
                                                      controller
                                                          .anime
                                                          .episodes[index]
                                                          .episodeUrl);
                                                },
                                                child: ListTile(
                                                  trailing: Container(
                                                    height: double.maxFinite,
                                                    width: Get.width / 3,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              controller
                                                                  .anime
                                                                  .episodes[
                                                                      index]
                                                                  .imageUrl),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color:
                                                            PColors.darkColor),
                                                  ),
                                                  title: Text(
                                                    controller.anime
                                                        .episodes[index].title,
                                                    style: CustomTheme
                                                        .darkTextTheme
                                                        .bodyMedium!,
                                                  ),
                                                  subtitle: Text(
                                                    controller
                                                        .anime
                                                        .episodes[index]
                                                        .description,
                                                    maxLines: 3,
                                                    style: CustomTheme
                                                        .darkTextTheme
                                                        .bodySmall!,
                                                  ),
                                                ),
                                              )),
                                        )
                                      ])
                                ],
                              )))
                    ],
                  ),
      ),
    );
  }
}
