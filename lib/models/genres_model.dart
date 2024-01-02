class Genre {
  final String name;
  final String link;

  Genre({
    required this.name,
    required this.link,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      name: json['name'] ?? '',
      link: json['link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'link': link,
    };
  }
  static List<Genre> genresList=[];
}
