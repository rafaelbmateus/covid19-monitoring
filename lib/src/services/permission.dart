import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static const _permission = PermissionGroup.location;
  PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> checkPermission() async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(_permission);
    if (permissionStatus != PermissionStatus.granted) {
      permissionStatus = await _requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<PermissionStatus> _requestPermission() async {
    var permissionsStatus =
        await _permissionHandler.requestPermissions([_permission]);
    return permissionsStatus[_permission];
  }
}
