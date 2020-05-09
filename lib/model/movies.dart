import 'package:flutter/cupertino.dart';

class Movies with ChangeNotifier {
  double popularity;
  int vote_count;
  bool video;
  String poster_path;
  int id;
  bool adult;
  String backdrop_path;
  String original_language;
  String original_title;
  List<String> genre_ids;
  String title;
  String overview;
  String release_date;
  Movies({
    this.id,
    this.title,
    this.adult,
    this.backdrop_path,
    this.genre_ids,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.release_date,
    this.video,
    this.vote_count,
  });
}
