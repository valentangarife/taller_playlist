class Song {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final bool isFavorite;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    this.imageUrl = '',
    this.isFavorite = false,
  });

  /// Devuelve una copia de la canción cambiando solo lo que se indique.
  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}