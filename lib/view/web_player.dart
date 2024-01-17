import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/web_player_controller.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/utils/icons.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPlayer extends GetView<WebPlayerController> {
  WebPlayer({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => controller.onPopInvoked(didPop),
      child: Scaffold(
          body: 1 == 1
              ? Column(
                  children: [
                    SizedBox(
                      height: Get.width - 50,
                      child: Stack(
                        children: [
                          InAppWebView(
                            //key: webViewKey,
                            initialUrlRequest: URLRequest(
                                url: WebUri(Get.parameters['url']!
                                    .replaceAll('%0A', '')
                                    .trim())),
                            initialSettings: InAppWebViewSettings(
                                contentBlockers: controller.contentBlockers),
                            onWebViewCreated: (con) {
                              controller.webViewController = con;
                            },

                            onProgressChanged: (con, progress) =>
                                controller.progress.value = progress,
                            onEnterFullscreen: (con) {
                              controller.fullscreen.value = true;
                              Get.printInfo(info: 'Fullscreen: true');
                            },
                            onExitFullscreen: (con) {
                              controller.fullscreen.value = false;
                              Get.printInfo(info: 'Fullscreen: false');
                            },
                          ),
                          Obx(
                            () => controller.progress.value == 100
                                ? SizedBox()
                                : LinearPercentIndicator(
                                    width: Get.width,
                                    lineHeight: 5.0,
                                    percent: controller.progress.value / 100,
                                    backgroundColor: Colors.grey,
                                    progressColor: Get.theme.primaryColor,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => controller.fullscreen.value
                          ? SizedBox()
                          : SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () async => await controller
                                              .webViewController!
                                              .canGoForward()
                                          ? controller.webViewController!
                                              .goForward()
                                          : null,
                                      borderRadius: BorderRadius.circular(50),
                                      child: SvgPicture.string(PIcons.right2)),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  InkWell(
                                      onTap: () =>
                                          Helper.showServersListWebPlayer(
                                              Get.arguments ?? [], controller.webViewController, ),
                                      borderRadius: BorderRadius.circular(50),
                                      child: SvgPicture.string(PIcons.menu)),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  InkWell(
                                      onTap: () =>
                                          controller.onPopInvoked(false),
                                      borderRadius: BorderRadius.circular(50),
                                      child: SvgPicture.string(PIcons.left2)),
                                ],
                              ),
                            ),
                    ),
                  ],
                )
              : WebViewWidget(controller: controller.controller)),
    );
  }
}
