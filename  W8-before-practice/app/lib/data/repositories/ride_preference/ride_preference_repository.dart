import '../../../model/ride_pref/ride_pref.dart';

///
/// Abstract repository for managing ride preferences
///
abstract class RidePreferenceRepository {
  /// Get the history of ride preferences.
  List<RidePreference> getPreferenceHistory();

  /// Add a preference to history.
  void addPreferenceToHistory(RidePreference preference);

  /// Get the currently selected preference.
  RidePreference? getSelectedPreference();

  /// Set the selected preference and keep history in sync.
  void selectPreference(RidePreference preference);

  /// Get the maximum allowed seats.
  int getMaxAllowedSeats();
}