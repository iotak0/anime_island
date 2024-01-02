import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/anime_controller.dart';
import 'package:get/get.dart';

class AnimeListView extends StatelessWidget {
  final AnimeController controller = Get.put(AnimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime List'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.animeList.length,
          itemBuilder: (context, index) {
            if (index == controller.animeList.length - 1) {
              // Reached the end of the list, load more items
              controller.loadMoreItems();
            }
            final anime = controller.animeList[index];
            return ListTile(
              title: Text(anime),
              // Add more UI elements as needed
            );
          },
        ),
      ),
    );
  }
}
