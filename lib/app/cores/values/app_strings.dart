// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

import 'package:get/get.dart';

import '../index.dart';

class APIPath {}

class AppStrings {}

class IconAsset {}

class ImageAsset {
  static final splash_image = _getImgPath('splash_image.png');

  static String _getImgPath(String pngName) => AssetHelper.imagePath(pngName);
}

class LocalStorageKey {
  static String ACCESS_TOKEN = '__access_token__';
  static String ACCESS_TOKEN_EXPIRE = '__access_token_expire__';
  static String REFRESH_TOKEN = '__refresh_token__';
  static String REFRESH_TOKEN_EXPIRE = '__refresh_token_expire__';
  static String USER_INFO = 'user_info';
  static String LOCALE_CODE = 'locale_code';
  static String DEVICE_ID = 'device_id';
}

class SvgAsset {
  static final eye_close = _getSvgPath('eye_close.svg');

  static String _getSvgPath(String svgName) => AssetHelper.svgPath(svgName);
}

class TranslationData {
  static String get about_us => 'about_us'.tr;
}
