import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static bool testMode = true;
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return testMode
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-8361517083614667/1458168275';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return testMode
          ? "ca-app-pub-3940256099942544/1033173712"
          : "ca-app-pub-8361517083614667/2068504371";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return testMode
          ? "ca-app-pub-3940256099942544/5224354917"
          : "ca-app-pub-8361517083614667/3190014357";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static Future<BannerAd> loadBannerAd() async {
    // TODO: Load a banner ad
    BannerAd? bannerAd;
    await BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    return bannerAd!;
  }
}
