import 'package:flutter_application_1/models/anime_type_model.dart';
import 'package:flutter_application_1/models/episode_model.dart';
import 'package:flutter_application_1/models/genres_model.dart';

class Anime {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<Genre> genres;
  final String youtubeTrailer;
  final String malPage;
  final List<String> moreInfo; // Changed to List of strings
  final String animeUrl;
  final List<Episode> episodes;
  final AnimeType? animeType; // Change animeType to AnimeType

  Anime({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.genres,
    required this.youtubeTrailer,
    required this.malPage,
    required this.moreInfo,
    required this.animeUrl,
    required this.episodes,
    required this.animeType, // Change animeType to AnimeType
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? genresJson = json['genres'];
    final List<Genre> genresList = genresJson != null
        ? genresJson.map((genreJson) => Genre.fromJson(genreJson)).toList()
        : [];

    final List<dynamic>? episodesJson = json['episodes'];
    final List<Episode> episodesList = episodesJson != null
        ? episodesJson
            .map((episodeJson) => Episode.fromJson(episodeJson))
            .toList()
        : [];

    final List<dynamic>? moreInfoJson = json['moreInfo'];
    final List<String> moreInfo = moreInfoJson != null
        ? moreInfoJson.map((infoJson) => infoJson.toString()).toList()
        : [];

    final Map<String, dynamic>? animeTypeJson = json['animeType'];
    final AnimeType animeType = animeTypeJson != null
        ? AnimeType.fromJson(animeTypeJson)
        : AnimeType(type: '', url: ''); // Default value if animeType is not provided

    return Anime(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      genres: genresList,
      youtubeTrailer: json['youtubeTrailer'] ?? '',
      malPage: json['malPage'] ?? '',
      moreInfo: moreInfo,
      animeUrl: json['animeUrl'] ?? '',
      episodes: episodesList,
      animeType: animeType, // Change animeType to AnimeType
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'genres': genres.map((genre) => genre.toJson()).toList(),
      'youtubeTrailer': youtubeTrailer,
      'malPage': malPage,
      'moreInfo': moreInfo,
      'animeUrl': animeUrl,
      'episodes': episodes.map((episode) => episode.toJson()).toList(),
      'animeType': animeType!.toJson(), // Change animeType to AnimeType
    };
  }
}
