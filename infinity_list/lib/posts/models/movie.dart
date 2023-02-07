import 'package:equatable/equatable.dart';

class Movies extends Equatable {
  const Movies(
      {required this.adult,
      required this.backdropPath,
      required this.genresIds,
      required this.id,
      required this.originalLanguaje,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  final int id;
  final bool adult;
  final String backdropPath;
  final List<int> genresIds;
  final OriginalLanguaje originalLanguaje;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object> get props => [
        id,
        adult,
        backdropPath,
        genresIds,
        originalLanguaje,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount
      ];
}

enum OriginalLanguaje { En, Ko, It, Es }
