import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_tutorial/env.dart';

import 'directions.dart';

class DirectionsRepository {
  static const String base_url =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({ Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
        base_url,
        queryParameters: {
          'origin': '${origin.latitude}, ${origin.longitude}',
          'destination': '${destination.latitude}, ${destination.longitude}',
          'key': googleApiKey,
        },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}