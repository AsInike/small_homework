import 'package:flutter/widgets.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final PlayerState _playerState;
  
  List<Song> _songs = [];

  LibraryViewModel({
    required SongRepository songRepository,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _playerState = playerState {
    // Listen to PlayerState changes
    _playerState.addListener(_onPlayerStateChanged);
  }

  // Initialize and fetch songs from repository
  void init() {
    _songs = _songRepository.fetchSongs();
    notifyListeners();
  }

  // Expose UI data through getters
  List<Song> get songs => _songs;

  Song? get currentSong => _playerState.currentSong;

  bool isPlaying(Song song) {
    return _playerState.currentSong == song;
  }

  // Expose user actions
  void playSong(Song song) {
    _playerState.start(song);
  }

  void stopSong() {
    _playerState.stop();
  }

  // Private method to handle PlayerState changes
  void _onPlayerStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _playerState.removeListener(_onPlayerStateChanged);
    super.dispose();
  }
}
