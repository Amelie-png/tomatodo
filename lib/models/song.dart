class Song {
  final String id;
  final String title;
  final String? artist;
  final String? thumbnailPath;
  final Duration? duration;
  final String audioPath;

  const Song({
    required this.id,
    required this.title,
    this.artist,
    this.thumbnailPath,
    this.duration,
    required this.audioPath,
  });
}
