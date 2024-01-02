class Episode {
  final int episodeNumber;
  final String title;
  final String description;
  final String imageUrl;
  final String episodeUrl;
  final String animeUrl; // Added animeUrl property

  Episode({
    required this.episodeNumber,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.episodeUrl,
    required this.animeUrl, // Added animeUrl parameter
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeNumber: json['episodeNumber'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      episodeUrl: json['episodeUrl'] ?? '',
      animeUrl: json['animeUrl'] ?? '', // Added animeUrl parsing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'episodeNumber': episodeNumber,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'episodeUrl': episodeUrl,
      'animeUrl': animeUrl, // Added animeUrl serialization
    };
  }
}

class EpisodeResults {
  EpisodeResults({
    required this.episodeList,
  });

  final List<Episode>? episodeList;
}
