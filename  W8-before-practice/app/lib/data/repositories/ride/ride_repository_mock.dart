import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../dummy_data.dart';
import 'ride_repository.dart';

///
/// Mock implementation of RideRepository using fake data
///
class RideRepositoryMock implements RideRepository {
  @override
  List<Ride> getAllRides() {
    return fakeRides;
  }

  @override
  List<Ride> getRidesFor(RidePreference preferences) {
    return fakeRides
        .where(
          (ride) =>
              ride.departureLocation == preferences.departure &&
              ride.arrivalLocation == preferences.arrival &&
              ride.availableSeats >= preferences.requestedSeats,
        )
        .toList();
  }
}
