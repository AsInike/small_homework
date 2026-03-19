import '../../../model/ride/locations.dart';
import '../../dummy_data.dart';
import 'location_repository.dart';

///
/// Mock implementation of LocationRepository using fake data
///
class LocationRepositoryMock implements LocationRepository {
  @override
  List<Location> getAvailableLocations() {
    return fakeLocations;
  }
}
