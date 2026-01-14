import 'package:flutter/foundation.dart';
import 'package:tomatodo/models/song.dart';

enum PlaybackState { stopped, loading, playing, paused, error }

abstract class MusicService {
  // Current state
  ValueListenable<PlaybackState> get playbackState;
  ValueListenable<Song?> get currentSong;

  // Controls
  Future<void> play();
  Future<void> pause();
  Future<void> next();
  Future<void> previous();

  // Loading content
  Future<void> loadSongs(List<Song> songs);

  // Cleanup
  Future<void> dispose();
}
