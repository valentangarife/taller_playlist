import 'package:flutter/material.dart';

import '../models/song.dart';
import 'song_card.dart';

/// Lista de canciones. Recibe la lista YA filtrada: no decide qué mostrar.
/// Si no hay nada que mostrar, enseña [emptyMessage].
class SongList extends StatelessWidget {
  final List<Song> songs;
  final String emptyMessage;
  final void Function(Song song) onToggleFavorite;
  final void Function(Song song) onDelete;

  const SongList({
    super.key,
    required this.songs,
    required this.emptyMessage,
    required this.onToggleFavorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    print('build SongList (${songs.length} canciones)');

    if (songs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(child: Text(emptyMessage)),
      );
    }

    // shrinkWrap + sin scroll propio: la Screen es la que hace scroll,
    // así el teclado no provoca overflow con el formulario.
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final song = songs[index];
        return SongCard(
          key: ValueKey(song.id),
          song: song,
          onToggleFavorite: () => onToggleFavorite(song),
          onDelete: () => onDelete(song),
        );
      },
    );
  }
}