class Music {
  final int? id;
  final String title;
  final String artist;
  final String duration;
  final String path;

  Music({
    this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'duration': duration,
      'path': path,
    };
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    return Music(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      duration: map['duration'],
      path: map['path'],
    );
  }
}
