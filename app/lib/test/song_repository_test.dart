import '../data/repositories/songs/song_repository_mock.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  final songRepository = SongRepositoryMock();
  // Test both the success and the failure of the post request
  // Handle the Future using 2 ways  (2 tests)
  //test1  // - Using then() with .catchError().

  print("TEST 1: Using then() and catchError()");

  songRepository
      .fetchSongById("s1")
      .then((song) {
        print("Song found: ${song?.title}");
      })
      .catchError((error) {
        print("Error: $error");
      });

  // Failure case
  songRepository
      .fetchSongById("25")
      .then((song) {
        print("Song found: ${song?.title}");
      })
      .catchError((error) {
        print("Error: $error");
      });

  //test2  // - Using async/await with try/catch.

  print("\nTEST 2: Using async/await with try/catch");

  try {
    final song = await songRepository.fetchSongById("s2");
    print("Song found: ${song?.title}");
  } catch (error) {
    print("Error: $error");
  }

  try {
    final song = await songRepository.fetchSongById("25");
    print("Song found: ${song?.title}");
  } catch (error) {
    print("Error: $error");
  }
}
