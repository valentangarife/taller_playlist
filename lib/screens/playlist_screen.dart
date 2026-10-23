import 'package:flutter/material.dart';

import '../components/playlist_summary.dart';
import '../components/song_form.dart';
import '../components/song_list.dart';
import '../models/song.dart';

/// Dueña del estado: la lista de canciones y el filtro de favoritas.
/// Todo cambio pasa por una función de esta clase, dentro de setState.
class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final List<Song> _songs = [
    const Song(id: '1', title: 'Imagine', artist: 'John Lennon'),
    const Song(id: '2', title: 'Yellow', artist: 'Coldplay', isFavorite: true),
    const Song(id: '3', title: 'Levitating', artist: 'Dua Lipa'),
  ];

  bool _onlyFavorites = false;

  void _addSong(String title, String artist, String imageUrl) {
    setState(() {
      _songs.add(
        Song(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          artist: artist,
          imageUrl: imageUrl,
        ),
      );
    });
  }

  void _toggleFavorite(Song song) {
    setState(() {
      final index = _songs.indexWhere((s) => s.id == song.id);
      if (index == -1) return;
      _songs[index] = _songs[index].copyWith(
        isFavorite: !_songs[index].isFavorite,
      );
    });
  }

  void _deleteSong(Song song) {
    setState(() {
      _songs.removeWhere((s) => s.id == song.id);
    });
  }

  void _toggleOnlyFavorites() {
    setState(() {
      _onlyFavorites = !_onlyFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build PlaylistScreen');

    // La Screen filtra; SongList solo pinta lo que le llega.
    final visibleSongs = _onlyFavorites
        ? _songs.where((s) => s.isFavorite).toList()
        : _songs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi playlist'),
        backgroundColor: const Color(0xFFCDBDFB),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PlaylistSummary(
                count: _songs.length,
                onlyFavorites: _onlyFavorites,
                onToggleFavorites: _toggleOnlyFavorites,
              ),
              const SizedBox(height: 8),
              SongForm(onAdd: _addSong),
              const SizedBox(height: 16),
              SongList(
                songs: visibleSongs,
                emptyMessage: _onlyFavorites
                    ? 'No tienes favoritas'
                    : 'Aún no hay canciones',
                onToggleFavorite: _toggleFavorite,
                onDelete: _deleteSong,
              ),
            ],
          ),
        ),
      ),
    );
  }
}