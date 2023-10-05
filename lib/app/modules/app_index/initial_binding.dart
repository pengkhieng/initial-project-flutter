import 'package:annotation/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get
      //   ..put(InternetConnectionController())
      //   ..put(SplashScreenController())
      ..put(HomeController());
  }
}
