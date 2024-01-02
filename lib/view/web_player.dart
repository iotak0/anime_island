import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/web_player_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPlayer extends GetView<WebPlayerController> {
  WebPlayer({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        final canGoBack = await controller.controller.canGoBack();
        if (canGoBack) {
          controller.controller.goBack();
        } else {
          Get.back();
        }
      },
      child: Scaffold(body: WebViewWidget(controller: controller.controller)),
    );
  }
}
