# 🎵 Mi playlist

App en Flutter para armar una playlist: agregar canciones, marcarlas como favoritas, borrarlas y filtrar para ver solo las favoritas.

Proyecto del taller **"Playlist con estado elevado"** del seminario de Ingeniería de Software. La idea central del taller es pasar de una sola pantalla con todo adentro a una app armada con piezas pequeñas, donde el estado vive en un solo lugar.

---

## ✨ Funcionalidades

- **Agregar canciones** con nombre, artista y URL de imagen (opcional).
- **Validación:** si falta el nombre o el artista, no agrega y muestra un aviso.
- **Marcar favoritas** con el corazón de cada canción.
- **Borrar canciones** con el icono de papelera.
- **El resumen** (mejora 1): arriba del formulario muestra cuántas canciones hay (`3 canciones`) y un corazón.
- **Solo favoritas** (mejora 2): el corazón del resumen alterna entre ver todas las canciones o solo las favoritas. Si no hay ninguna, muestra *"No tienes favoritas"*.

---

## 🗂️ Estructura del proyecto

Un archivo por clase:

```
lib/
├── main.dart                     → App y tabla de rutas
├── models/
│   └── song.dart                 → Song con copyWith
├── components/
│   ├── playlist_summary.dart     → Stateless
│   ├── song_card.dart            → Stateless
│   ├── song_form.dart            → StatefulWidget (guarda el borrador)
│   └── song_list.dart            → Stateless
└── screens/
    └── playlist_screen.dart      → StatefulWidget (guarda _songs y _onlyFavorites)
```

---

## 🧠 Cómo funciona el estado

Solo **dos** clases guardan estado:

| Clase | Qué guarda | Por qué |
|---|---|---|
| `PlaylistScreen` | `_songs` y `_onlyFavorites` | Es el ancestro común: varias piezas necesitan los mismos datos |
| `SongForm` | El borrador (lo que se está escribiendo) | Solo le importa al formulario hasta que se agrega |

**Estado elevado:** los datos suben a la Screen y bajan a los componentes por el constructor. Los componentes **nunca modifican `_songs`**: cuando algo pasa, avisan con un callback y la Screen hace el cambio dentro de `setState`.

```
              PlaylistScreen
        (_songs, _onlyFavorites)
        │          │           │
   datos ↓    datos ↓     datos ↓
 PlaylistSummary  SongForm   SongList → SongCard
        │          │           │
   avisos ↑    avisos ↑    avisos ↑
 (toggle ♥)    (onAdd)   (favorito / borrar)
```

El filtro de favoritas también lo decide la Screen: `SongList` recibe la lista **ya filtrada** y solo la pinta.

---

## 🧪 La prueba de los `print`

Cada pieza tiene un `print` en su `build` para ver quién se reconstruye en cada caso:

| Acción | Qué se reconstruye |
|---|---|
| Escribir en un campo | Nada (el texto vive en los controllers, sin `setState`) |
| Pulsar *Agregar* con un dato faltante | Solo `SongForm` (para mostrar el error) |
| Marcar una favorita | La Screen y todo lo que cuelga de ella |

> Los avisos `avoid_print` del analizador son esperados y no cuentan.

---

## 🚀 Cómo correrlo

Requisitos: [Flutter](https://docs.flutter.dev/get-started/install) instalado (Dart SDK `^3.13.5`).

```bash
flutter pub get      # instalar dependencias
flutter analyze      # revisar el código
flutter test         # correr los tests
flutter run          # ejecutar la app
```

### Tests

Los 6 tests en `test/widget_test.dart` cubren:

1. El resumen muestra `3 canciones` y las tres canciones iniciales.
2. El corazón del resumen filtra solo favoritas.
3. Sin favoritas aparece *"No tienes favoritas"*.
4. Agregar una canción actualiza el contador.
5. Con un dato faltante no agrega y muestra el aviso.
6. Borrar una canción la quita de la lista.

---

## 🛠️ Tecnologías

- Flutter / Dart
- Material 3 (`ColorScheme.fromSeed`)

---

## 👩‍💻 Autora

Valentina — Seminario de Ingeniería de Software
