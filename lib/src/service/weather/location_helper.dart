import 'package:geolocator/geolocator.dart';

class LocationHelper {
  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
