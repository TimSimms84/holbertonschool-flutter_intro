import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart';
import 'character_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<List<Character>> getCharacters() async {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      final List<Character> characters = body.map((dynamic item) => Character.fromJson(item)).toList();
      return characters;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text('Breaking Bad'),
      ),
      body: FutureBuilder<List<Character>>(
        future: getCharacters(),
        builder: (BuildContext context, AsyncSnapshot<List<Character>> snapshot) {
          if (snapshot.hasData) {
            final List<Character>? data = snapshot.data;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return CharacterTile(character: data[index]);
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

