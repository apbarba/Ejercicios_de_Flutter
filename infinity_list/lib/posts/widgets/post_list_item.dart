import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/movies.dart';

import '../models/movie.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.movies});

  final Movies movies;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${movies.id}', style: textTheme.bodySmall),
        title: Text(movies.title),
        isThreeLine: true,
        subtitle: Text(movies.popularity as String),
        dense: true,
      ),
    );
  }
}
