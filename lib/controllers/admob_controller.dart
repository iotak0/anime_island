import 'package:flutter_application_1/helper/ad_helper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobController extends GetxController {
  // TODO: Add _bannerAd
  BannerAd? bannerAd;

  // TODO: Add interstitialAd
  InterstitialAd? interstitialAd;

  // TODO: Add _rewardedAd
  RewardedAd? rewardedAd;

  @override
  void onInit() async {
    super.onInit();
    bannerAd = await loadBannerAd();
  }

  loadBannerAd() async {
    // TODO: Load a banner ad
    await BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          update();
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  // TODO: Implement _loadInterstitialAd()
  loadInterstitialAd(doSomething) async {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              doSomething();
            },
          );

          interstitialAd = ad;
          update();
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  // TODO: Implement _loadRewardedAd()
  loadRewardedAd() async {
    SmartDialog.showLoading(msg: 'يرجى الإنتظار...');
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              rewardedAd = null;
              SmartDialog.dismiss();
              update();
              SmartDialog.showLoading(msg: 'يرجى الإنتظار...');

              loadRewardedAd();
              SmartDialog.dismiss();
            },
          );
          SmartDialog.dismiss();
          rewardedAd = ad;
          update();
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }
}
