class AnimeType {
  final String type;
  final String url;

  AnimeType({
    required this.type,
    required this.url,
  });

  factory AnimeType.fromJson(Map<String, dynamic> json) {
    return AnimeType(
      type: json['type'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
    };
  }
}
