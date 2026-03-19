import '../../../model/ride/locations.dart';

///
/// Abstract repository for managing locations
///
abstract class LocationRepository {
  /// Get all available locations
  List<Location> getAvailableLocations();
}
