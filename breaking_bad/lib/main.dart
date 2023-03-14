import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:breaking_bad/list_pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PokemonTypesPage(),
    );
  }
}

class PokemonTypesPage extends StatefulWidget {
  const PokemonTypesPage({Key? key}) : super(key: key);

  @override
  PokemonTypesPageState createState() => PokemonTypesPageState();
}

class PokemonTypesPageState extends State<PokemonTypesPage> {
  List<dynamic> _types = [];

  @override
  void initState() {
    super.initState();
    _getPokemonTypes();
  }

  Future<void> _getPokemonTypes() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/type'));
    final data = jsonDecode(response.body);
    final types = data['results'];

    setState(() {
      _types = types;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Types'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ),
        itemCount: _types.length,
        itemBuilder: (BuildContext context, int index) {
          final type = _types[index];
          final name = type['name'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonListPage(type: name),
                ),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
