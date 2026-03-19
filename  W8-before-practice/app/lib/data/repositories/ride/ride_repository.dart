import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// Abstract repository for managing rides
///
abstract class RideRepository {
  /// Get all available rides
  List<Ride> getAllRides();
  
  /// Get rides matching the given preferences
  List<Ride> getRidesFor(RidePreference preferences);
}
