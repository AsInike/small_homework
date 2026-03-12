import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

enum AsyncState { loading, success, error }

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  List<Song>? _songs;
  AsyncState _state = AsyncState.loading;
  String? _errorMessage;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  List<Song> get songs => _songs == null ? [] : _songs!;
  AsyncState get state => _state;
  String? get errorMessage => _errorMessage;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    // Set loading state
    _state = AsyncState.loading;
    notifyListeners();

    try {
      // 1 - Fetch songs
      _songs = await songRepository.fetchSongs();
      
      // 2 - Set success state
      _state = AsyncState.success;
      _errorMessage = null;
    } catch (e) {
      // 3 - Set error state
      _state = AsyncState.error;
      _errorMessage = e.toString();
      _songs = null;
    }

    // 4 - notify listeners
    notifyListeners();
  }

  void retry() {
    _init();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
