import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as goa;

class LocationService {
  late Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _grantedPermission;

  LocationService() {
    _location = Location();
    // _location.enableBackgroundMode(enable: true);
  }

  Future<bool> _checkPermission() async {
    if (await _checkService()) {
      _grantedPermission = await _location.hasPermission();
      if (_grantedPermission == PermissionStatus.denied) {
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }

  // ignore: unused_element
  Future<bool> _checkService() async {
    try {
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
      }
    } on PlatformException catch (error) {
      // ignore: avoid_print
      print('error code is ${error.code} and message');
      _serviceEnabled = false;
      await _checkService();
    }

    return _serviceEnabled;
  }

  Future<LocationData?> getLocation() async {
    if (await _checkPermission()) {
      final locationData = _location.getLocation();
      return locationData;
    }
    return null;
  }

  Future<goa.Placemark?> getPlaceMark({required LocationData locationData}) async{
    final List<goa.Placemark> placeMark = await goa.placemarkFromCoordinates(locationData.latitude!, locationData.longitude!);
    // ignore: unnecessary_null_comparison
    if (placeMark != null && placeMark.isNotEmpty) {
      return placeMark[0];
    }
    return null;
  }
}
