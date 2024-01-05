import 'package:flutter_application_1/models/anime_model.dart';
import 'package:flutter_application_1/models/anime_results.dart';
import 'package:flutter_application_1/models/anime_type_model.dart';
import 'package:flutter_application_1/models/episode_model.dart';
import 'package:flutter_application_1/models/genres_model.dart';
import 'package:flutter_application_1/models/server_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

//import 'package:uuid/uuid.dart';

/// [AnimeService] contains a lot of convenience methods that allow easier
/// access, management and data handling from remote APIs with the goal of
/// providing the user with the best anime experience.
class AnimeService {
  // final _uuid = const Uuid();

  Future<AnimeResults> getAnimes(response, type) async {
    List<Anime> animeList = [];
    //${URLs.pinAnime}
    final dom.Document documen0 = parser.parse(response.body);
//body > div.header > div > div
    final List<dom.Document> documents = documen0
        .querySelectorAll(type ?? "div.anime-card-container")
        .map((e) => parser.parse(e.outerHtml.trim()))
        .toList();
    for (var document in documents) {
      var imageUrl = document
              .querySelector(
                  '  div.anime-card-poster > div.hover.ehover6 > img')!
              .attributes['src'] ??
          '?';
      var animeUrl = document
          .querySelector(' div.anime-card-title > h3 > a ')!
          .attributes['href']!
          .replaceAll('https://cloudanime.site/', '');
      var title = document
              .querySelector(
                  ' div.anime-card-poster > div.hover.ehover6 > img')!
              .attributes['alt'] ??
          '?';
      var description = document
          .querySelector("div.anime-card-details > div.anime-card-title")!
          .attributes['data-content']!;
      var animeType;
      try {
        animeType = AnimeType(
            type: document
                .querySelector(
                    "div.anime-card-details > div.anime-card-type > a")!
                .innerHtml
                .trim(),
            url: animeType = document
                .querySelector(
                    "div.anime-card-details > div.anime-card-type > a")!
                .attributes['href']!);
      } catch (e) {}

      Anime animeInfo = Anime(
        animeType: animeType,
        id: ' _uuid.v4()',
        title: title,
        description: description,
        animeUrl: animeUrl,
        imageUrl: imageUrl,
        genres: [],
        episodes: [],
        malPage: '',
        moreInfo: [],
        youtubeTrailer: '',
      );
      animeList.add(animeInfo);
    }
    return AnimeResults(animeList: animeList);
  }

  Future<String> getAnimeSeason(response) async {
    final dom.Document document = parser.parse(response.body);
    var animeSeason =
        document.querySelector('#menu-item-3508 > a')!.attributes['href'] ??
            'anime-season/صيف-2023';
    return animeSeason.replaceFirst('https://cloudanime.site/', '');
  }

  Future<EpisodeResults> getAnimesEpisodesHome(response, type) async {
    List<Episode> episodeList = [];
    final dom.Document documen0 = parser.parse(response.body);
    final List<dom.Document> documents = documen0
        .querySelectorAll(type ?? 'episodes-card-container')
        .map((e) => parser.parse(e.outerHtml.trim()))
        .toList();

    for (var document in documents) {
      var imageUrl = document
              .querySelector(' div.episodes-card > div > img')!
              .attributes['src'] ??
          '?';
      var animeUrl = document
          .querySelector(' div.ep-card-anime-title > h3 > a ')!
          .attributes['href']!
          .replaceAll('https://cloudanime.site/', '');

      var episodeUrl = document
          .querySelector(' div > div.episodes-card-title > h3 > a')!
          .attributes['href']!;
      var description = document
              .querySelector('div.episodes-card > div > img')!
              .attributes['alt'] ??
          '?';
      var title = document
          .querySelector(' div > div.episodes-card-title > h3 > a')!
          .innerHtml
          .trim();

      Episode episodeInfo = Episode(
        episodeNumber: 0,
        title: title,
        description: description,
        episodeUrl: episodeUrl,
        animeUrl: animeUrl,
        imageUrl: imageUrl,
      );
      episodeList.add(episodeInfo);
    }

    return EpisodeResults(episodeList: episodeList);
  }

  Future<EpisodeResults> getAnimesEpisodes(request) async {
    List<Episode> episodeList = [];
    final response = await http.get(Uri.parse('https://cloudanime.site'));
    final dom.Document documen0 = parser.parse(response.body);
    final List<dom.Document> documents = documen0
        .querySelectorAll("div.anime-card-container")
        .map((e) => parser.parse(e.outerHtml.trim()))
        .toList();

    for (var document in documents) {
      var imageUrl = document
              .querySelector(
                  '  div.anime-card-poster > div.hover.ehover6 > img')!
              .attributes['src'] ??
          '?';
      var animeUrl = document
          .querySelector(' div.anime-card-title > h3 > a ')!
          .attributes['href']!
          .replaceAll('https://cloudanime.site/', '');
      var episodeUrl;
      try {
        episodeUrl = document
            .querySelector(' div > div > div.episodes-card > div > a')!
            .attributes['href']!;
      } catch (e) {
        episodeUrl = '';
      }
      var title = document
              .querySelector(
                  ' div.anime-card-poster > div.hover.ehover6 > img')!
              .attributes['alt'] ??
          '?';
      var description = document
          .querySelector("div.anime-card-details > div.anime-card-title")!
          .attributes['data-content']!;

      Episode episodeInfo = Episode(
        episodeNumber: 0,
        title: title,
        description: description,
        episodeUrl: episodeUrl,
        animeUrl: animeUrl,
        imageUrl: imageUrl,
      );
      episodeList.add(episodeInfo);
    }

    return EpisodeResults(episodeList: episodeList);
  }

  Future<Anime> fetchAnimeDetails(String url, RxBool loading) async {
    final response = await http.get(Uri.parse(url));
    final dom.Document document = parser.parse(response.body);
    var imageUrl = document
        .querySelector(" div.anime-info-right > div > img")!
        .attributes['src']!;
    var description = document
        .querySelector(" div.anime-info-left > div > p")!
        .innerHtml
        .trim();

    var genresName = document
        .querySelectorAll(" div.anime-info-left > div > ul > li > a")
        .map((e) => e.innerHtml.trim())
        .toList();
    var genresUrl = document
        .querySelectorAll(" div.anime-info-left > div > ul > li > a")
        .map((e) =>
            e.attributes['href']!.replaceAll('https://cloudanime.site/', ''))
        .toList();
    final genres = List.generate(genresName.length, (index) {
      return Genre(name: genresName[index], link: genresUrl[index]);
    });

    var malPage = document
            .querySelector(" div.anime-external-links > a.anime-mal")!
            .attributes['href'] ??
        '';
    var youtubeTrailer;
    try {
      youtubeTrailer = document
              .querySelector("div.anime-external-links > a.anime-trailer")!
              .attributes['href'] ??
          '';
    } catch (e) {
      youtubeTrailer = '';
    }

    var title = document
        .querySelector(" div.anime-info-left > div > h1")!
        .innerHtml
        .trim();
    final moreInfo = document
        .querySelectorAll("div.anime-info-left > div > div.row > div > div")
        .map((e) => e.outerHtml.trim())
        .toList();
    var episodeUrls = document
        .querySelectorAll(
            "#DivEpisodesList > div > div > div > div > div > h3 > a")
        .map((e) => e.attributes['href']!)
        .toList();
    var episodeDescriptions = document
        .querySelectorAll("#DivEpisodesList > div > div > div > div > img")
        .map((e) => e.attributes['alt'] ?? '')
        .toList();
    var episodesTitles = document
        .querySelectorAll(
            "#DivEpisodesList > div > div > div > div > div > h3 > a")
        .map((e) => e.innerHtml.trim())
        .toList();
    var episodesImgs = document
        .querySelectorAll("#DivEpisodesList > div> div > div > div > img")
        .map((e) => e.attributes['src'] ?? '')
        .toList();

    final List<Episode> episodes = List.generate(
        episodesTitles.length,
        (index) => Episode(
            animeUrl: url,
            episodeNumber: index + 1,
            title: episodesTitles[index],
            description: episodeDescriptions[index],
            imageUrl: episodesImgs[index],
            episodeUrl: episodeUrls[index]));

    Anime anime = Anime(
        id: '',
        title: title,
        description: description,
        imageUrl: imageUrl,
        genres: genres,
        youtubeTrailer: youtubeTrailer,
        malPage: malPage,
        moreInfo: moreInfo,
        animeUrl: url,
        animeType: null,
        episodes: episodes);
    loading.value = false;

    return anime;
  }

  Future<ServerResults> fetchIframeEmbedded(url) async {
    final response = await http.get(Uri.parse(url));
    final dom.Document document = parser.parse(response.body);
    Get.printInfo(info: url);
    var serversUrls = document
        .querySelectorAll("div.tab-content > div > div > ul > li > a")
        .map((e) => e.attributes['data-ep-url']!)
        .toList();
    var serversNames = document
        .querySelectorAll("div.tab-content > div > div > ul > li > a")
        .map((e) => e.innerHtml.trim())
        .toList();
    Get.printInfo(info: serversUrls.first);
    return ServerResults(
        serverList: List.generate(
            serversNames.length,
            (index) => ServerModel(
                serverName: serversNames[index],
                serverUrl: serversUrls[index])));
  }

//   Future<Map<String, String>> fetchCdnStreamLink(url) async {
//     final response = await RequestService.create().requestCdnVideoLink(
//         url.toString().replaceFirst('streaming.php', 'download'));
//     Map<String, String> streamingDatas = {};
//     dom.Document doc = parse(response.body);
//     final streamingInfo = doc
//         .getElementsByClassName('mirror_link')
//         .first
//         .getElementsByClassName('dowload');

//     for (var link in streamingInfo) {
//       final url = link.getElementsByTagName('a').first.attributes.values.first;
//       final resolutionText = link.getElementsByTagName('a').first.text;
//       var resolution =
//           resolutionRegExp.firstMatch(resolutionText)!.group(0).toString();

//       streamingDatas.putIfAbsent(resolution, () => url);
//     }
//     return streamingDatas;
//   }

//   Future<Map<String, String>> getVideoWithResolution(url) async {
//     final iframeEmbedded = await fetchIframeEmbedded(url);
//     final resolutions = await fetchCdnStreamLink(iframeEmbedded);
//     return resolutions;
//   }

//   Future<AnimeResults> getRecentlyAddedAnimes() async {
//     List<Anime> animeList = [];
//     final response =
//         await RequestService.create().requestRecentlyAddedResponse();
//     dom.Document document = parse(response.body);
//     var list = document.getElementsByClassName('items').first.children;

//     for (var element in list) {
//       var info = element
//           .getElementsByClassName('name')
//           .first
//           .getElementsByTagName('a')
//           .first
//           .attributes
//           .values;
//       var img = element
//           .getElementsByClassName('img')
//           .first
//           .getElementsByTagName('a')
//           .first
//           .getElementsByTagName('img')
//           .first
//           .attributes
//           .values
//           .first;

//       var name = info.last;
//       var animeUrl = info.first;
//       var currentEp = element.getElementsByClassName('episode').first.text;
//       Anime animeInfo = Anime(
//         id: '$name',
//         title: name,
//         animeUrl: animeUrl,
//         imageUrl: img,
//         description: '',
//         genres: [],
//         malPage: '',
//         moreInfo: [],
//         youtubeTrailer: '',
//       );
//       animeList.add(animeInfo);
//     }
//     return AnimeResults(animeList: animeList);
//   }
}
