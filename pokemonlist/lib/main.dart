import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 void main() {
      runApp(
        MaterialApp(
          home: MyApp(),
        ),
      );
    }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon List',

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon List'),
        ),
        body: PokemonList(),
      ),
    );
  }
}

class PokemonList extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  List pokemons = [];

  @override
  void initState() {
    super.initState();
    _fetchPokemons();
  }

  _fetchPokemons() async {
    var response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10'));
    var decodedJson = jsonDecode(response.body);
    setState(() {
      pokemons = decodedJson['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemons')),
      body: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return _pokemonCard(pokemons[index]);
        },
      ),
    );
  }

  Widget _pokemonCard(pokemon) {
    return Card(
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: _getPokemonInfo(pokemon['url']),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return Column(
                  children: <Widget>[
                    Image.network(data['sprites']['front_default']),
                    Text(data['name']),
                    Text(data['types'][0]['type']['name']),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

_getPokemonInfo(String url) async {
    var response = await http.get(url as Uri);
    return jsonDecode(response.body);
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
