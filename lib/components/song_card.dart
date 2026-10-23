import 'package:flutter/material.dart';

import '../models/song.dart';

/// Una canción de la lista. No guarda estado: avisa con callbacks.
class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete;

  const SongCard({
    super.key,
    required this.song,
    required this.onToggleFavorite,
    required this.onDelete,
  });

  Widget _cover() {
    final placeholder = Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF9C84DB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.music_note, color: Colors.white),
    );

    if (song.imageUrl.isEmpty) return placeholder;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        song.imageUrl,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => placeholder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build SongCard (${song.title})');
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE6E0F5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _cover(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(song.artist),
                ],
              ),
            ),
            IconButton(
              key: Key('favorite_${song.id}'),
              onPressed: onToggleFavorite,
              icon: Icon(
                song.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
            ),
            IconButton(
              key: Key('delete_${song.id}'),
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}