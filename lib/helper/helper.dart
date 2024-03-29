import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/github_model.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/icons.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/view/widgets/custom_titel.dart';
import 'package:flutter_application_1/view/widgets/update_alert_dialog.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Helper {
  static void showServersList(String episodeUrl) async {
    SmartDialog.showLoading(msg: 'يرجى الإنتظار...');
    final servers = await AnimeService().fetchIframeEmbedded(episodeUrl);
    SmartDialog.dismiss();
    Get.bottomSheet(BottomSheet(
      onClosing: () {},
      builder: (context) => Container(
        height: Get.height / 2,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            color: PColors.darkColor),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
                servers.serverList!.length,
                (index) => InkWell(
                      onTap: () => Get.toNamed(Routs.kWebPlayer,
                          parameters: {
                            'url': servers.serverList![index].serverUrl,
                          },
                          arguments: servers.serverList),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(8),
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: PColors.darkBackground),
                          child: Text(
                            ' سيرفر ${servers.serverList![index].serverName}',
                            style: CustomTheme.darkTextTheme.bodyMedium!,
                          )),
                    )),
          ),
        ),
      ),
    ));
  }

  static void showServersListWebPlayer(
      servers, InAppWebViewController? controller) async {
    Get.bottomSheet(BottomSheet(
      onClosing: () {},
      builder: (context) => Container(
        height: Get.height / 2,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            color: PColors.darkColor),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
                servers.length,
                (index) => InkWell(
                      onTap: () async {
                        Get.back();
                        controller!.loadUrl(
                            urlRequest: URLRequest(
                                url: WebUri(servers[index].serverUrl)));
                        await Future.delayed(const Duration(seconds: 3))
                            .then((value) => controller.clearHistory());
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(8),
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: PColors.darkBackground),
                          child: Text(
                            ' سيرفر ${servers[index].serverName}',
                            style: CustomTheme.darkTextTheme.bodyMedium!,
                          )),
                    )),
          ),
        ),
      ),
    ));
  }

  static showStory(tital, text) {
    return Get.bottomSheet(
        isScrollControlled: true,
        Container(
          decoration: BoxDecoration(
              color: PColors.darkBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTitle(tital: tital),
                    InkWell(
                      onTap: () => Get.back(),
                      child: SvgPicture.string(
                        PIcons.deny,
                        width: 30,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: CustomTheme.darkTextTheme.bodySmall!,
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        enableDrag: true);
  }

  static checkForUpdate(response) async {
    final json = jsonDecode(response.body);
    var adUrlFilters;
    final github = Github.fromJson(json);
    if (version.compareTo(github.version.toString().trim()) == 0 &&
        versionNumber.compareTo(github.versionNumber.toString().trim()) == 0) {
      isSameVersion = true;
      // ignore: avoid_print
      print('same version');
    } else {
      adUrlFilters = github.adUrlFilters;
      isSameVersion = false;
      updateLink = github.downloadLink.toString();
      if (GetPlatform.isAndroid) {
        await Get.dialog(UpdateAlertDialog(
          downloadLink: github.downloadLink.toString(),
          body: github.newFeatures.toString(),
        ));
      }
    }
    return adUrlFilters;
    // } catch (e) {
    //   // ignore: avoid_print
    //   print(e.toString());
    // }
  }

  static const key = 'customCacheKey';
  static CacheManager cacheManager = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: key),
      // fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );
}
