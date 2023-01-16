import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Pokemon> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10&#'));

  if (response.statusCode == 200) {
    return Pokemon.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class Pokemon {
  final String? name;

  Pokemon({this.name});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Pokemon> post;

  MyApp({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Pokemon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista Pokemon'),
        ),
        body: Center(
          child: FutureBuilder<Pokemon>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData != null) {
                return Text(snapshot.data?.name ?? '');
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // Por defecto, muestra un loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
