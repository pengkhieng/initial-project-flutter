import 'package:annotation/app/modules/app_index/initial_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cores/index.dart';
import '../../routes/app_page.dart';
import '../../routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = AppTranslations();
    final localeCode = StorageUtil.getString(LocalStorageKey.LOCALE_CODE);

    var locale = const Locale(
      AppTranslations.enCode,
    );
    if ([
      AppTranslations.enCode,
      AppTranslations.khCode,
      AppTranslations.spCode,
    ].any((code) => code == localeCode)) {
      locale = Locale(localeCode);
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH_SCREEN,
      getPages: AppPages.pages,
      theme: AppTheme.instance.lightTheme(),
      darkTheme: AppTheme.instance.darkTheme(),
      initialBinding: InitialBinding(),
      themeMode: ThemeMode.light,
      locale: locale,
      fallbackLocale: locale,
      translationsKeys: translation.keys,
      translations: translation,
      scrollBehavior: AppScrollBehavior(),
      // home: DocumentDetailPage(),
      // routingCallback: (value) {
      // if (value != null) {
      //   if (!(value.isBack ?? true) || value.runtimeType == GetPageRoute) {
      //     analyticService.setCurrentScreen(value.current);
      //   }
      // }
      // },
    );
  }
}
