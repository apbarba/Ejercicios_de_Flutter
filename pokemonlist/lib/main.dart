import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<PokemonDetails> getPokemonsList() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10'));

  if (response.statusCode == 200) {
    return PokemonDetails.fromJson(json.decode(response.body));
  } else {
    throw Exception("Lista de Pokemon no cargada");
  }
}

class PokemonDetails {
  final String name;

  PokemonDetails({this.name});

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      name: json['name'],
      url: json['url'],
    );
  }
}

void main() => runApp(MyApp(pokemonDetails: getPokemonsList()));

class MyApp extends StatelessWidget {
  final Future<PokemonDetails> pokemonDetails;

  MyApp({Key key, this.pokemonDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de Pokemon",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Pokemon"),
        ),
        body: Center(
            child: FutureBuilder<PokemonDetails>(
          future: pokemonDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.name);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        )),
      ),
    );
  }
}




/*
class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetail({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Column(
        children: <Widget>[
          Image.network(pokemon.sprites['front_default']),
          Text("Abilities: ${pokemon.abilities.join(', ')}"),
          Text("Pokedex Number: ${pokemon.id}"),
        ],
      ),
    );
  }
}

ListTile(
    title: Text(pokemons[index].name),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetail(pokemon: pokemons[index]),
        ),
      );
    },
),

Future<List<Pokemon>> getPokemons() async {
  var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&#'));
  var data = json.decode(response.body);
  var pokemons = (data['results'] as List).map((p) => Pokemon.fromJson(p)).toList();
  for(var pokemon in pokemons){
    var pokemonDetail = await http.get(pokemon.url);
    var data = json.decode(pokemonDetail.body);
    pokemon.sprites = data['sprites'];
    pokemon.abilities = data['abilities'].map((a) => a['ability']['name']).toList();
    pokemon.id = data['id'];
  }
  return pokemons;
}
*/
