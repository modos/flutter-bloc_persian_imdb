import 'package:equatable/equatable.dart';
import 'package:persian_imdb/model/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieFailure extends MovieState {}

class MovieSuccess extends MovieState {
  final List<Movie> movies;

  const MovieSuccess({this.movies});

  @override
  List<Object> get props => [this.movies];
}
