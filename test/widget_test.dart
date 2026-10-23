import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:miapp6/main.dart';

void main() {
  testWidgets('Muestra el resumen con 3 canciones', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('3 canciones'), findsOneWidget);
    expect(find.text('Imagine'), findsOneWidget);
    expect(find.text('Yellow'), findsOneWidget);
    expect(find.text('Levitating'), findsOneWidget);
  });

  testWidgets('El corazón del resumen filtra solo favoritas', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const Key('summary_favorites_button')));
    await tester.pump();

    expect(find.text('Yellow'), findsOneWidget);
    expect(find.text('Imagine'), findsNothing);
    expect(find.text('Levitating'), findsNothing);
    // El resumen sigue contando todas las canciones
    expect(find.text('3 canciones'), findsOneWidget);
  });

  testWidgets('Sin favoritas muestra el aviso', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Quitar la única favorita (Yellow, id 2)
    await tester.tap(find.byKey(const Key('favorite_2')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('summary_favorites_button')));
    await tester.pump();

    expect(find.text('No tienes favoritas'), findsOneWidget);
  });

  testWidgets('Agregar una canción actualiza el resumen', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key('title_field')), 'Hello');
    await tester.enterText(find.byKey(const Key('artist_field')), 'Adele');
    await tester.ensureVisible(find.byKey(const Key('add_button')));
    await tester.tap(find.byKey(const Key('add_button')));
    await tester.pump();

    expect(find.text('4 canciones'), findsOneWidget);
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('Falta un dato: no agrega y avisa', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key('title_field')), 'Solo título');
    await tester.ensureVisible(find.byKey(const Key('add_button')));
    await tester.tap(find.byKey(const Key('add_button')));
    await tester.pump();

    expect(find.text('3 canciones'), findsOneWidget);
    expect(find.text('Escribe el nombre de la canción y el artista'),
        findsOneWidget);
  });

  testWidgets('Borrar una canción la quita de la lista', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const Key('delete_1')));
    await tester.pump();

    expect(find.text('2 canciones'), findsOneWidget);
    expect(find.text('Imagine'), findsNothing);
  });
}