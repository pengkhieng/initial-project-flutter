import 'package:annotation/app/modules/home/home_binding.dart';
import 'package:annotation/app/modules/home/home_page.dart';
import 'package:annotation/app/modules/splash_screen/splash_screen.dart';
import 'package:annotation/app/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: SplashScreen.new,
    ),
    GetPage(
      name: Routes.HOME_PAGE,
      page: HomePage.new,
      binding: HomeBinding(),
    ),
  ];
}
