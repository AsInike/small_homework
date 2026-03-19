import '../../../model/ride_pref/ride_pref.dart';
import '../../dummy_data.dart';
import 'ride_preference_repository.dart';

///
/// Mock implementation of RidePreferenceRepository using fake data
///
class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  final List<RidePreference> _preferenceHistory = List.from(fakeRidePrefs);
  final int _maxAllowedSeats = 8;
  RidePreference? _selectedPreference;

  @override
  List<RidePreference> getPreferenceHistory() {
    return List.unmodifiable(_preferenceHistory);
  }

  @override
  void addPreferenceToHistory(RidePreference preference) {
    _preferenceHistory.add(preference);
  }

  @override
  RidePreference? getSelectedPreference() {
    return _selectedPreference;
  }

  @override
  void selectPreference(RidePreference preference) {
    if (_selectedPreference != preference) {
      _selectedPreference = preference;
      addPreferenceToHistory(preference);
    }
  }

  @override
  int getMaxAllowedSeats() {
    return _maxAllowedSeats;
  }
}