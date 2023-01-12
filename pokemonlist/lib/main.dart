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
