import 'package:flutter/foundation.dart';

import '../../../../model/ride_pref/ride_pref.dart';
import '../../../states/ride_preference_state.dart';

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState _ridePreferenceState;

  HomeViewModel(this._ridePreferenceState);

  RidePreference? get selectedPreference => _ridePreferenceState.selectedPreference;

  List<RidePreference> get preferenceHistory =>
      _ridePreferenceState.preferenceHistory.reversed.toList();

  void selectPreference(RidePreference preference) {
    _ridePreferenceState.selectPreference(preference);
  }

  void startListening() {
    _ridePreferenceState.addListener(_onStateChanged);
  }

  void stopListening() {
    _ridePreferenceState.removeListener(_onStateChanged);
  }

  void _onStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
  }
}