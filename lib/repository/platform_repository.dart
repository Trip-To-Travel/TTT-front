import 'dart:io';

class PlatformRepository {
  static getPlatform() {
    if(Platform.isAndroid) return "AND";
    else if (Platform.isIOS) return "IOS";
    else return "ETC";
  }
}