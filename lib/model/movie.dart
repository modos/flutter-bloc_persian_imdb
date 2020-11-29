import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Movie extends Equatable {
  final String name;
  final String director;
  final String story;
  final String thumb;
  final List cast;
  final int year;

  Movie(
      {@required this.name,
      @required this.director,
      @required this.story,
      @required this.thumb,
      @required this.cast,
      @required this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        name: json['name_english'] as String,
        director: json['director'] as String,
        story: json['story'] as String,
        thumb: json['thumbnail'] as String,
        cast: json['cast'] as List,
        year: json['year'] as int);
  }

  @override
  List<Object> get props => [name, director, story, thumb, cast, year];
}
