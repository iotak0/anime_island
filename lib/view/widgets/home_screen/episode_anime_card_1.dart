import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/models/episode_model.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/view/widgets/custom_cached_network_image.dart';

class EpisodeAnimeCard_1 extends StatelessWidget {
  final Episode episode;
  final double width, height;
  const EpisodeAnimeCard_1({
    super.key,
    required this.episode,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Helper.showServersList(episode.episodeUrl);
        },
        onLongPress: () => Helper.showStory('عنوان الحلقة',episode.description),
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
                  imageUrl: episode.imageUrl),

              // Container(
              //   alignment: Alignment.topCenter,
              //   height: height,
              //   width: width,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: NetworkImage(episode.imageUrl),
              //         fit: BoxFit.cover,
              //       ),
              //       borderRadius: BorderRadius.circular(15),
              //       color: PColors.darkColor),
              // ),

              Text(
                episode.description,
                maxLines: 1,
                style: CustomTheme.darkTextTheme.bodyMedium!,
              ),
              Text(
                episode.title,
                maxLines: 1,
                style: CustomTheme.darkTextTheme.bodySmall!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
