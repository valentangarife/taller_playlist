import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CounterScreenState();
  }
}

class CounterScreenState extends State<CounterScreen> {
  //Aquí vive el estado
  int _counter = 0;
  String _name = "";

  TextEditingController micontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(controller: micontrol),
            Text('La cuenta va en $_counter'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _name = micontrol.text;
                });
              },
              child: Text("$_name"),
            ),
          ],
        ),
      ),
    );
  }
}