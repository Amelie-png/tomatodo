import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tomatodo/models/music_service.dart';
import 'package:tomatodo/models/song.dart';

class MusicPlayer implements MusicService {
  final _state = ValueNotifier(PlaybackState.stopped);
  final _currentSong = ValueNotifier<Song?>(null);
  var player = AudioPlayer();

  @override
  ValueListenable<Song?> get currentSong => _currentSong;
  @override
  ValueListenable<PlaybackState> get playbackState => _state;

  MusicPlayer() {
    player.playerEventStream.listen((playerState) {
      final playing = playerState.playing;
      final processing = playerState.playbackEvent;

      if (processing == ProcessingState.loading ||
          processing == ProcessingState.buffering) {
        _state.value = PlaybackState.loading;
      } else if (processing == ProcessingState.completed) {
        _state.value = PlaybackState.stopped;
      } else if (playing) {
        _state.value = PlaybackState.playing;
      } else {
        _state.value = PlaybackState.paused;
      }
    });
  }

  @override
  Future<void> loadSongs(List<Song> songs) async {
    //load audios
  }

  @override
  Future<void> play() async {
    await player.play();
  }

  @override
  Future<void> pause() async {
    await player.pause();
  }

  @override
  Future<void> dispose() async {
    await player.dispose();
    _state.dispose();
    _currentSong.dispose();
  }

  @override
  Future<void> next() async {
    await player.seekToNext();
  }

  @override
  Future<void> previous() async {
    await player.seekToPrevious();
  }
}
