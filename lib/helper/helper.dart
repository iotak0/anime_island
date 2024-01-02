import 'package:flutter/material.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/services/anime_service.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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
                      onTap: () => Get.toNamed(Routs.kWebPlayer, parameters: {
                        'url': servers.serverList![index].serverUrl
                      }),
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
