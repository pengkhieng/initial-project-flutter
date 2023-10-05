import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AssetHelper {
  static String imagePath(String assetName) {
    const assetImagesPath = 'assets/images';
    final path = '$assetImagesPath/$assetName';
    debugPrint(path);
    return path;
  }

  static String iconPath(String assetName) {
    const iconsPath = 'assets/icons';
    final path = '$iconsPath/$assetName';
    debugPrint(path);
    return path;
  }

  static String svgPath(String assetName) {
    const svgsPath = 'assets/svgs';
    final path = '$svgsPath/$assetName';
    debugPrint(path);
    return path;
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final data = await rootBundle.load(path);
    final codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width,);
    final fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
