import 'package:get/get.dart';

class AnimeController extends GetxController {
  final RxList<String> animeList = <String>[].obs;
  int nextPage = 1; // Page number for pagination

  @override
  void onInit() {
    // Initialize the controller
    super.onInit();
    loadMoreItems();
  }

  void loadMoreItems() {
    // Simulate loading more items
    Future.delayed(Duration(seconds: 2), () {
      for (int i = 0; i < 10; i++) {
        animeList.add('Anime ${animeList.length + 1}');
      }
      nextPage++; // Increment page number for pagination
    });
  }
}
