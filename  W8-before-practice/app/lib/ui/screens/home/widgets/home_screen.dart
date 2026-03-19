import 'package:flutter/material.dart';

import '../../../states/ride_preference_state.dart';
import '../view_model/home_model.dart';
import 'home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel? _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_viewModel != null) {
      return;
    }

    final ridePreferenceState = RidePreferenceStateProvider.of(context);
    _viewModel = HomeViewModel(ridePreferenceState);
    _viewModel!.startListening();
  }

  @override
  void dispose() {
    _viewModel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeContent(viewModel: _viewModel!);
  }
}