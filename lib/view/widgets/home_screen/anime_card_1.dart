import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_application_1/utils/icons.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/view/widgets/custom_cached_network_image.dart';
import 'package:flutter_application_1/view/widgets/custom_titel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AnimeCardHomeScreen1 extends StatelessWidget {
  final Anime anime;
  final double width, height;
  const AnimeCardHomeScreen1({
    super.key,
    required this.anime,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => Get.toNamed(Routs.kAnimeDetails,
            parameters: {'url': anime.animeUrl}),
        onLongPress: () => Get.bottomSheet(
            Container(
              // height: Get.height,
              decoration: BoxDecoration(
                  color: PColors.darkBackground,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTitle(tital: 'القصة'),
                        InkWell(
                          onTap: () => Get.back(),
                          child: SvgPicture.string(
                            PIcons.deny,
                            width: 30,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        anime.description,
                        style: CustomTheme.darkTextTheme.bodySmall!,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            enableDrag: true),
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImage(
                  radius: 15,
                  width: width,
                  height: height,
                  imageUrl: anime.imageUrl)
              // Container(
              //   alignment: Alignment.topCenter,
              //   height: height,
              //   width: width,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: NetworkImage(anime.imageUrl),
              //         fit: BoxFit.cover,
              //       ),
              //       borderRadius: BorderRadius.circular(15),
              //       color: PColors.darkColor),
              // ),
              ,
              Text(
                anime.title,
                maxLines: 1,
                style: CustomTheme.darkTextTheme.bodyMedium!
                    .copyWith(decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
