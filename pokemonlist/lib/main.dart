import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  Future<http.Response> getPokemons() {
  return http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&#'));
}

class Pokemon {
  final String name;
  final String url;

  Pokemon({this.name, this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }
}



Copy code
import 'package:http/http.dart' as http;

Future<http.Response> getPokemons() {
  return http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&#'));
}
Crea una clase Pokemon para almacenar la información de cada pokemon.
Copy code
class Pokemon {
  final String name;
  final String url;

  Pokemon({this.name, this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }
}

@override
Widget build(BuildContext context) {
  
  return Scaffold(
    
    body: FutureBuilder(
      
      future: getPokemons(),
      
      builder: (BuildContext context, AsyncSnapshot snapshot) {
       
        if (snapshot.hasData) {
         
          var data = json.decode(snapshot.data.body);
         
          var pokemons = (data['results'] as List).map((p) => Pokemon.fromJson(p)).toList();
       
          return ListView.builder(
       
            itemCount: pokemons.length,
       
            itemBuilder: (BuildContext context, int index) {
       
              return ListTile(
       
                title: Text(pokemons[index].name),
              );
            },
          );
        
        } else {
       
          return Center(
       
            child: CircularProgressIndicator(),
          );
        }
      },
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