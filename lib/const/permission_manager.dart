import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<void> requestPermission() async {
    final serviceStatus = await Permission.manageExternalStorage.isGranted ;

    final status = await Permission.manageExternalStorage.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

}