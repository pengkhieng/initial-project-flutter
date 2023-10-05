import 'package:get/utils.dart';

class ValidatorHelper {
  static bool isEmail(String s) => GetUtils.isEmail(s);
  static bool isValidPassword(String s) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(s);
}
