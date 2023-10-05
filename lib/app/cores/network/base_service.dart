import 'dart:async';

import 'package:get/get.dart';

import '../index.dart';

class BaseService extends GetxService {
  RestClient restClient = Get.find<RestClient>();

  void init() {
    restClient = Get.find<RestClient>();
  }

  FutureOr<void> onTokenChange() async {
    restClient = await restClient.init();
  }
}
