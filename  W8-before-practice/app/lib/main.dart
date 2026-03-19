
import 'package:flutter/material.dart';
import 'data/repositories/location/location_repository_mock.dart';
import 'data/repositories/ride/ride_repository_mock.dart';
import 'data/repositories/ride_preference/ride_preference_repository_mock.dart';
import 'main_common.dart';

///
/// Main entry point (defaults to dev environment)
/// Injects mock repositories
///
void main() {
  runApp(
    BlaBlaApp(
      locationRepository: LocationRepositoryMock(),
      rideRepository: RideRepositoryMock(),
      ridePreferenceRepository: RidePreferenceRepositoryMock(),
    ),
  );
}

