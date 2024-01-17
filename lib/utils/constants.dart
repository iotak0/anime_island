import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Collection of all app related constants go here

const String version = '1.0.3';
const String versionNumber = '2';
String updateLink = '';
bool isSameVersion = true;
const license = 'MIT License';
const String latestRelease = 'https://animont.net/animeisland/release.json';

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

// const Color tkDarkBlue = Color(0xFF0D1321);
// const Color tkDarkerBlue = Color(0xFF060B16);
// const Color tkDarkGreen = Color(0xFF1D4C4F);
// const Color tkGrey = Color(0xFF323435);
// const Color tkGradientBlue = Color(0xFF133F6E);
// const Color tkGradientBlack = Color(0xFF28313B);
const Color tkDarkBlue = Color(0xFF5a189a);
const Color tkDarkerBlue = Color(0xFF10002b);
const Color tkDarkGreen = Color(0xFF491a74);
const Color tkGrey = Color(0xFF323435);
const Color tkGradientBlue = Color(0xFF721cb8);
const Color tkGradientBlack = Color(0xFF421869);
const loadingIndicator = SpinKitSquareCircle(
  color: Colors.white,
);

const int takoAnimationDuration = 1800;

const String aboutApp =
    '''تطبيق انمي ايلاند هو تطبيق رائع وممتاز مصمم خصيصًا لمحبي وعشاق الأنمي في العالم العربي. يوفر هذا التطبيق فرصة ممتازة لمشاهدة واستمتاع بأحدث وأشهر حلقات وأفلام الأنمي بسهولة ويسر، حيث يمتاز بالعديد من الميزات المذهلة التي تجعله واحدًا من أفضل التطبيقات لهذا الغرض.

يتميز انمي ايلاند بمكتبة ضخمة من الأنمي، حيث يمكن للمستخدمين الاختيار من بين مئات العناوين المختلفة، بدءًا من الأنمي الكلاسيكي إلى الأعمال الجديدة والمبتكرة. توفر الترجمة باللغة العربية لجميع الحلقات والأفلام التي تمتاز بجودة عالية، مما يجعلها مثالية لجميع الأعمار ومستويات الأنمي المختلفة.

بالإضافة إلى ذلك، يقدم التطبيق واجهة مستخدم سهلة الاستخدام تمكن المشاهدين من تصفح المحتوى والبحث عن الأنمي الذي يرغبون في مشاهدته بسهولة وسلاسة. كما يتيح لهم حفظ الحلقات في قائمة المفضلات والعودة إليها في وقت لاحق.

بالإضافة إلى ذلك، يُعد انمي ايلاند موثوقًا من حيث جودة البث وسرعة التحميل، مما يساعد في توفير تجربة مشاهدة ممتعة وبدون تأخير. ولا يتطلب التطبيق تسجيل الدخول أو الاشتراك، مما يعني أنه يمكن للجميع الوصول إلى المحتوى بسهولة دون أي تعقيدات.

باختصار، انمي ايلاند هو التطبيق المثالي لعشاق الأنمي في العالم العربي، حيث يقدم مجموعة ضخمة ومتنوعة من الأعمال الرائعة وتجربة مشاهدة مميزة تلبي احتياجات جميع محبي هذا النوع من الترفيه.''';
