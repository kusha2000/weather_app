import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationService {
  Future<String> getCityNameFromCurrentLocation() async {
    //get the permission from the user to access the location
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      //get the current Location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      print(position.latitude);
      print(position.longitude);

      //convert the location in to list of place marks
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      //extract the city name from the place marks
      String cityName = placeMarks[0].locality!;
      print(cityName);
      return cityName;
    } catch (e) {
      print("Error:$e");
      throw Exception("Error");
    }
  }
}
