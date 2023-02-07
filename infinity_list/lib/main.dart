import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/app.dart';
import 'package:flutter_infinite_list/posts/view/movie_page.dart';
import 'package:flutter_infinite_list/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const App() as Widget);
}

class App extends MaterialApp {
  const App({super.key}) : super(home: const PostsPage());
}
