import 'package:flutter/services.dart';
import 'package:flutter_application_1/controllers/home_controller.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPlayerController extends GetxController {
  final adUrlFilters = [
    ".*.bybeldumor.com/.*",
    ".*.ooloptou.net/.*",
    ".*.oaritisascham.life/.*",
    ".*.s.click/.*",
    ".*.sa.opensooq.com/.*",
    ".*.livreshymnal.digital/.*",
    ".*.rtb.astrodsp.com/.*",
    ".*.oaritisascham.life/.*",
    ".*.peethach.com/.*",
    ".*.ak.peethach.com/.*",
    ".*.strungcourthouse.com/.*",
    ".*.pushagim.com/.*",
    ".*.cms.quantserve.com/.*",
    ".*.secure-freevpn.com/.*",
    ".*.fleraprt.com/.*",
    ".*.phesheet.net/.*",
    ".*.google-analytics.com/.*",
    ".*.phesheet.net/.*",
    ".*.eu.download4you.click/.*",
    ".*.doubleclick.net/.*",
    ".*.ads.pubmatic.com/.*",
    ".*.googlesyndication.com/.*",
    ".*.google-analytics.com/.*",
    ".*.adservice.google.*/.*",
    ".*.adbrite.com/.*",
    ".*.exponential.com/.*",
    ".*.quantserve.com/.*",
    ".*.scorecardresearch.com/.*",
    ".*.zedo.com/.*",
    ".*.adsafeprotected.com/.*",
    ".*.teads.tv/.*",
    ".*.outbrain.com/.*"
  ];
  final List<ContentBlocker> contentBlockers = [];
  var contentBlockerEnabled = true;
  InAppWebViewController? webViewController;
  late WebViewController controller;
  var fullscreen = false.obs;
  var progress = 0.obs;
  @override
  void onInit() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    adBockerControllerInit();
    //WebViewControllerInit();
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.onClose();
  }

  WebViewControllerInit() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(PColors.darkBackground)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (error) {},
        ),
      )
      ..loadRequest(
          Uri.parse(Get.parameters['url']!.replaceAll('%0A', '').trim()));
  }

  adBockerControllerInit() async {
    // for each ad URL filter, add a Content Blocker to block its loading
    final finalAdUrlFilters =
        await Get.find<HomeController>().adUrlFilters ?? adUrlFilters;
    for (final adUrlFilter in finalAdUrlFilters) {
      contentBlockers.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }
    // apply the "display: none" style to some HTML elements
    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));
  }

  onPopInvoked(bool didPop) async {
    if (didPop) {
      return;
    }
    final canGoBack = await webViewController!.canGoBack();
    if (canGoBack) {
      webViewController!.goBack();
    } else {
      Get.back();
    }
  }
}
