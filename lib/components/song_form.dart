import 'package:flutter/material.dart';

/// Formulario para agregar canciones.
/// Es StatefulWidget porque guarda el borrador (lo que se está escribiendo).
/// No toca la lista: cuando el borrador es válido, se lo entrega a la Screen.
class SongForm extends StatefulWidget {
  final void Function(String title, String artist, String imageUrl) onAdd;

  const SongForm({super.key, required this.onAdd});

  @override
  State<SongForm> createState() => _SongFormState();
}

class _SongFormState extends State<SongForm> {
  // El borrador
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    final artist = _artistController.text.trim();
    final imageUrl = _imageController.text.trim();

    if (title.isEmpty || artist.isEmpty) {
      // Falta un dato: solo se reconstruye el formulario, la lista no.
      setState(() {
        _errorMessage = 'Escribe el nombre de la canción y el artista';
      });
      return;
    }

    widget.onAdd(title, artist, imageUrl);

    // Se limpia el borrador una vez entregado.
    _titleController.clear();
    _artistController.clear();
    _imageController.clear();
    setState(() {
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build SongForm');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          key: const Key('title_field'),
          controller: _titleController,
          decoration: const InputDecoration(
            hintText: 'Canción',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          key: const Key('artist_field'),
          controller: _artistController,
          decoration: const InputDecoration(
            hintText: 'Artista',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          key: const Key('image_field'),
          controller: _imageController,
          decoration: const InputDecoration(
            hintText: 'URL de la imagen',
            border: OutlineInputBorder(),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton(
          key: const Key('add_button'),
          onPressed: _submit,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF6650A4),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}