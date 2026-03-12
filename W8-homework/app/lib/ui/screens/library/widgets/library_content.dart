import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the global song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),
      
          Expanded(
            child: _buildContent(mv),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(LibraryViewModel mv) {
    // Handle the 3 states: loading, error, success
    switch (mv.state) {
      case AsyncState.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
      
      case AsyncState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Error loading songs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                mv.errorMessage ?? 'Unknown error',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: mv.retry,
                child: Text('Retry'),
              ),
            ],
          ),
        );
      
      case AsyncState.success:
        if (mv.songs.isEmpty) {
          return Center(
            child: Text('No songs available'),
          );
        }
        return ListView.builder(
          itemCount: mv.songs.length,
          itemBuilder: (context, index) => SongTile(
            song: mv.songs[index],
            isPlaying: mv.isSongPlaying(mv.songs[index]),
            onTap: () {
              mv.start(mv.songs[index]);
            },
          ),
        );
    }
  }
}
