import 'package:flutter/material.dart';
import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride/ride_repository.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/states/ride_preference_state.dart';
import 'ui/theme/theme.dart';

///
/// Common app setup that receives repositories as dependencies
/// This allows for flexible environments (dev, prod, test)
///
class BlaBlaApp extends StatefulWidget {
  final LocationRepository locationRepository;
  final RideRepository rideRepository;
  final RidePreferenceRepository ridePreferenceRepository;

  const BlaBlaApp({
    super.key,
    required this.locationRepository,
    required this.rideRepository,
    required this.ridePreferenceRepository,
  });

  @override
  State<BlaBlaApp> createState() => _BlaBlaAppState();
}

class _BlaBlaAppState extends State<BlaBlaApp> {
  late final RidePreferenceState _ridePreferenceState;

  @override
  void initState() {
    super.initState();
    _ridePreferenceState = RidePreferenceState(widget.ridePreferenceRepository);
  }

  @override
  void dispose() {
    _ridePreferenceState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      locationRepository: widget.locationRepository,
      rideRepository: widget.rideRepository,
      ridePreferenceRepository: widget.ridePreferenceRepository,
      child: RidePreferenceStateProvider(
        state: _ridePreferenceState,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: blaTheme,
          home: Scaffold(body: HomeScreen()),
        ),
      ),
    );
  }
}

///
/// InheritedWidget to provide repositories down the widget tree
///
class RepositoryProvider extends InheritedWidget {
  final LocationRepository locationRepository;
  final RideRepository rideRepository;
  final RidePreferenceRepository ridePreferenceRepository;

  const RepositoryProvider({
    super.key,
    required this.locationRepository,
    required this.rideRepository,
    required this.ridePreferenceRepository,
    required super.child,
  });

  static RepositoryProvider of(BuildContext context) {
    final RepositoryProvider? result =
        context.dependOnInheritedWidgetOfExactType<RepositoryProvider>();
    assert(result != null, 'No RepositoryProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(RepositoryProvider oldWidget) {
    return locationRepository != oldWidget.locationRepository ||
        rideRepository != oldWidget.rideRepository ||
        ridePreferenceRepository != oldWidget.ridePreferenceRepository;
  }
}
