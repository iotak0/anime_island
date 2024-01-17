import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/route_management/all_pages.dart';
import 'package:flutter_application_1/route_management/routs.dart';
import 'package:flutter_application_1/route_management/screen_bindings.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:native_flutter_proxy/custom_proxy.dart';
import 'package:native_flutter_proxy/native_proxy_reader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  if (!kIsWeb &&
      kDebugMode &&
      defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  // bool enabled = true;
  // String? host;
  // int? port;
  // try {
  //   //ProxySetting settings = await NativeProxyReader.proxySetting;
  //   enabled = true; //settings.enabled;
  //   host = '46.105.124.74';
  //   //settings.host;
  //   port = 7497; // settings.port;
  // } catch (e) {
  //   print(e);
  // }
  // if (enabled && host != null) {
  //   final proxy = CustomProxy(ipAddress: host, port: port);
  //   proxy.enable();
  //   print("proxy enabled");
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      // here
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(
          //default toast widget
          // toastBuilder: (String msg) => CustomToastWidget(msg: msg),
          // //default loading widget
          // loadingBuilder: (String msg) => CustomLoadingWidget(msg: msg),
          ),
      debugShowCheckedModeBanner: false,
      title: 'AnimeIsland',
      theme: CustomTheme.dark(),
      darkTheme: CustomTheme.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: Routs.kHomePage,
      getPages: AllPages.getPages(),
      initialBinding: ScreenBindings(),
      locale: Locale('ar', 'SA'),
      //locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      supportedLocales: <Locale>[Locale('en', 'US'), Locale('ar', 'SA')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
