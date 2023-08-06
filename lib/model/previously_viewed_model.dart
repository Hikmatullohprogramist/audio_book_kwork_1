class PreviouslyViewedModel {
  final int? id;
  final String title;
  final String artist;
  final String duration;
  final String path;

  PreviouslyViewedModel({
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

  factory PreviouslyViewedModel.fromMap(Map<String, dynamic> map) {
    return PreviouslyViewedModel(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      duration: map['duration'],
      path: map['path'],
    );
  }
}
