import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Collection of all app related constants go here

const String version = 'v1.6.3';
String updateLink = '';
bool isSameVersion = true;
const license = 'MIT License';
const String latestRelease =
    'https://api.github.com/repos/kaungsatthe1n/Tako-Play/releases/latest';

const String baseUrl = 'https://cloudanime.site/';
const String search = 'https://cloudanime.site/?search_param=animes&s=';
final mediaFileRegExp =
    RegExp(r"(https)://[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+[.m3u8]");
final resolutionRegExp = RegExp(r'[0-9]+(P)');
// final hostRegExp = RegExp(r"(Server )[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+[,]");

//const String takoPlay = 'https://github.com/kaungsatthe1n/Tako-Play';
//const String takoTracker = 'https://github.com/kaungsatthe1n/Tako-AnimeTracker';
//const String mailing =
//    'mailto:parrotksh@gmail.com?subject=[TakoPlay: (Ver: $version)]';
// const userAgent =
//     'Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36';
// const origin = 'https://goload.one';
// const referer = 'https://gogoplay.io';
// Map<String, String> header = {
//   'User-Agent': userAgent,
//   // 'Origin': origin,
//   'Referer': referer,
// };
//ايسيكاي
//فنون قتالية
// [ACTION,ADVENTURE,FANTASY,HORROR,SPORTS,THRILLER,FANTASY,MAGIC,MYSTERY]
const String ACTION = 'anime-genre/أكشن';
const String ADVENTURE = 'anime-genre/مغامرات';
const String CARS = 'anime-genre/سيارات';
const String COMEDY = 'anime-genre/كوميدي';
//const String CRIME = 'anime-genre/جريمة';
//const String DEMENTIA = 'anime-genre/dementia';
const String DEMONS = 'anime-genre/شياطين';
const String DRAMA = 'anime-genre/دراما';
//const String DUB = 'anime-genre/dub';
const String ECCHI = 'anime-genre/إيتشي';
//const String FAMILY = 'anime-genre/family';
const String FANTASY = 'anime-genre/خيال علمي';
const String GAME = 'anime-genre/العاب';
const String HAREM = 'anime-genre/حريم';
const String HISTORICAL = 'anime-genre/تاريخي';
const String HORROR = 'anime-genre/رعب';
const String JOSEI = 'anime-genre/جوسي';
const String KIDS = 'anime-genre/أطفال';
const String MAGIC = 'anime-genre/سحر';
const String MECHA = 'anime-genre/ميكا';
const String MILITARY = 'anime-genre/حربي';
const String MUSIC = 'anime-genre/موسيقي';
const String MYSTERY = 'anime-genre/غموض';
const String PARODY = 'anime-genre/محاكاة ساخرة';
const String POLICE = 'anime-genre/بوليسي';
const String PSYCHOLOGICAL = 'anime-genre/نفسي';
const String ROMANCE = 'anime-genre/رومانسي';
const String SAMURAI = 'anime-genre/ساموراي';
const String SCHOOL = 'anime-genre/مدرسي';
const String SCI_FI = 'anime-genre/sci-fi';
const String SEINEN = 'anime-genre/سينين';
const String SHOUJO = 'anime-genre/شوجو';
const String SHOUJO_AI = 'anime-genre/شوجو اَي';
const String SHOUNEN = 'anime-genre/شونين';
const String SHOUNEN_AI = 'anime-genre/شونين اي';
const String SLICE_OF_LIFE = 'anime-genre/شريحة من الحياة';
const String SPACE = 'anime-genre/فضائي';
const String SPORTS = 'anime-genre/رياضي';
const String SUPER_POWER = 'anime-genre/قوى خارقة';
const String SUPER_NATURAL = 'anime-genre/خارق للعادة';
const String SUSPENSE = 'anime-genre/تشويق';
const String THRILLER = 'anime-genre/اثارة';
const String VAMPIRE = 'anime-genre/مصاصي دماء';
//const String YAOI = 'anime-genre/yaoi';
//const String YURI = 'anime-genre/yuri';

// Color

const Color tkDarkBlue = Color(0xFF0D1321);
const Color tkDarkerBlue = Color(0xFF060B16);
const Color tkDarkGreen = Color(0xFF1D4C4F);
const Color tkGrey = Color(0xFF323435);
const Color tkGradientBlue = Color(0xFF133F6E);
const Color tkGradientBlack = Color(0xFF28313B);

const loadingIndicator = SpinKitSquareCircle(
  color: Colors.white,
);

const int takoAnimationDuration = 1800;
