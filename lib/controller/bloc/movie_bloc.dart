import 'dart:convert';
import 'dart:async';
import 'package:persian_imdb/model/movie.dart';
import './bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({@required this.httpClient}) : super(MovieInitial());

  final http.Client httpClient;

  @override
  Stream<Transition<MovieEvent, MovieState>> transformEvents(
    Stream<MovieEvent> events,
    TransitionFunction<MovieEvent, MovieState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    final currentState = state;

    if (event is MovieFetched) {
      try {
        if (currentState is MovieInitial) {
          final movies = await _fetchMovies();
          yield MovieSuccess(movies: movies);
          return;
        }
      } catch (_) {
        yield MovieFailure();
      }
    }
  }

  Future<List<Movie>> _fetchMovies() async {
    final String topIMDB =
        "https://modos.github.io/persian-cinema-json/top-250.json";

    final response = await httpClient.get(topIMDB);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawMovie) {
        return Movie(
            name: rawMovie['name_persian'],
            director: rawMovie['director'],
            story: rawMovie['story'],
            thumb: rawMovie['thumbnail'],
            cast: rawMovie['cast'],
            year: rawMovie['year']);
      }).toList();
    } else {
      throw Exception('error fetching movies');
    }
  }
}
