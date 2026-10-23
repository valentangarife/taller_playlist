import 'package:flutter/material.dart';

/// Resumen de la playlist: cuántas canciones hay y el corazón de "solo favoritas".
/// No guarda estado: todo llega por el constructor.
class PlaylistSummary extends StatelessWidget {
  final int count;
  final bool onlyFavorites;
  final VoidCallback onToggleFavorites;

  const PlaylistSummary({
    super.key,
    required this.count,
    required this.onlyFavorites,
    required this.onToggleFavorites,
  });

  @override
  Widget build(BuildContext context) {
    print('build PlaylistSummary');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          count == 1 ? '1 canción' : '$count canciones',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          key: const Key('summary_favorites_button'),
          tooltip: onlyFavorites ? 'Ver todas' : 'Ver solo favoritas',
          onPressed: onToggleFavorites,
          icon: Icon(
            onlyFavorites ? Icons.favorite : Icons.favorite_border,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}