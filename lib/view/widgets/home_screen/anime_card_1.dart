import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/view/widgets/custom_cached_network_image.dart';
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
        onLongPress: () => Helper.showStory('القصة', anime.description),
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
                  imageUrl: anime.imageUrl),
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
