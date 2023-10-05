import 'dart:ui';

import 'package:annotation/app/cores/translations/en_US/en_us_translations.dart';
import 'package:annotation/app/cores/translations/es_ES/es_es_translations.dart';
import 'package:annotation/app/cores/translations/km_KH/km_kh_translations.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  static const enCode = 'en_US';
  static const khCode = 'km_KH';
  static const spCode = 'es_ES';
  static const enLocale = Locale(enCode);
  static const khLocale = Locale(khCode);
  static const spLocale = Locale(spCode);

  @override
  Map<String, Map<String, String>> get keys =>
      {enCode: enUS, khCode: kmKH, spCode: esES};
}
