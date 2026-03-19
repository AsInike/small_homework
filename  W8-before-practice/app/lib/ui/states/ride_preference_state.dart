import 'package:flutter/widgets.dart';

import '../../data/repositories/ride_preference/ride_preference_repository.dart';
import '../../model/ride_pref/ride_pref.dart';

///
/// Global state for ride preferences.
/// - Keeps the currently selected preference
/// - Reads/writes history through the repository
///
class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository _ridePreferenceRepository;

  RidePreference? _selectedPreference;

  RidePreferenceState(this._ridePreferenceRepository);

  RidePreference? get selectedPreference => _selectedPreference;

  List<RidePreference> get preferenceHistory =>
      _ridePreferenceRepository.getPreferenceHistory();

  int get maxAllowedSeats => _ridePreferenceRepository.getMaxAllowedSeats();

  void selectPreference(RidePreference newPreference) {
    if (_selectedPreference == newPreference) {
      return;
    }

    _selectedPreference = newPreference;
    _ridePreferenceRepository.addPreferenceToHistory(newPreference);
    notifyListeners();
  }
}

class RidePreferenceStateProvider
    extends InheritedNotifier<RidePreferenceState> {
  const RidePreferenceStateProvider({
    super.key,
    required RidePreferenceState state,
    required super.child,
  }) : super(notifier: state);

  static RidePreferenceState of(BuildContext context) {
    final RidePreferenceStateProvider? result =
        context.dependOnInheritedWidgetOfExactType<RidePreferenceStateProvider>();
    assert(result != null, 'No RidePreferenceStateProvider found in context');
    return result!.notifier!;
  }
}