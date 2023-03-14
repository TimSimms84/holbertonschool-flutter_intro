import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PokemonListPage extends StatefulWidget {
  final String type;

  const PokemonListPage({Key? key, required this.type}) : super(key: key);

  @override
  PokemonListPageState createState() => PokemonListPageState();
}

class PokemonListPageState extends State<PokemonListPage> {
  List<dynamic> _pokemon = [];

  @override
  void initState() {
    super.initState();
    _getPokemonList();
  }

  Future<void> _getPokemonList() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/type/${widget.type}'));
    final data = jsonDecode(response.body);
    setState(() {
      _pokemon = data['pokemon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Pokemon'),
      ),
      body: ListView.builder(
        itemCount: _pokemon.length,
        itemBuilder: (BuildContext context, int index) {
          final pokemonUrl = _pokemon[index]['pokemon']['url'];
          final pokemonId = pokemonUrl.split('/').reversed.elementAt(1);
          final name = _pokemon[index]['pokemon']['name'];
          final imageUrl =
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';
          return ListTile(
            leading: Image.network(imageUrl),
            title: Text(name),
          );
        },
      ),
    );
  }
}
