import 'package:flutter_application_1/utils/constants.dart';

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

  static List genresList = [
    ACTION ,
ADVENTURE ,
CARS ,
COMEDY ,
//CRIME = 'anime-genre/جريمة';
//DEMENTIA = 'anime-genre/dementia';
DEMONS,
DRAMA ,
//DUB = 'anime-genre/dub';
ECCHI,
//FAMILY = 'anime-genre/family';
FANTASY ,
GAME ,
HAREM ,
HISTORICAL ,
HORROR ,
JOSEI ,
KIDS ,
MAGIC ,
MECHA ,
MILITARY ,
MUSIC ,
MYSTERY ,
PARODY ,
POLICE ,
PSYCHOLOGICAL,
ROMANCE ,
SAMURAI ,
SCHOOL ,
SCI_FI ,
SEINEN ,
//SHOUJO ,
//SHOUJO_AI,
SHOUNEN ,
//SHOUNEN_AI,
SLICE_OF_LIFE,
SPACE ,
SPORTS ,
SUPER_POWER ,
SUPER_NATURAL ,
SUSPENSE,
THRILLER ,
VAMPIRE ];
}
