import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/posts/movies.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'movie_event.dart';
part 'movie_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await _fetchPosts(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Movies>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'https://api.themoviedb.org/3/movie/popular?api_key=e375f35a8ed2c4c685f14c49cc598088',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'}
            as String,
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Movies(
            id: map['id'] as int,
            originalTitle: map['originalTitle'] as String,
            adult: map['adult'] as bool,
            backdropPath: map['backdropPath'] as String,
            genresIds: map['genresIds'] as List<int>,
            originalLanguaje: map['originalLanguaje'] as OriginalLanguaje,
            overview: map['overview'] as String,
            popularity: map['popularity'] as double,
            posterPath: map['posterPath'] as String,
            releaseDate: map['releaseDate'] as String,
            title: map['title'] as String,
            video: map['video'] as bool,
            voteAverage: map['voteAverage'] as double,
            voteCount: map['voteCount'] as int);
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}