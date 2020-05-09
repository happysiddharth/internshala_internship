import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:internshalainternshipproject/model/movies.dart';
import 'package:http/http.dart' as http;

class HomeScreenProvider with ChangeNotifier {
  List<Movies> _movies = [];
  List<Movies> get movies {
    return List.from(_movies);
  }

  Future<void> fetch_movies() async {
    final String url =
        "http://api.themoviedb.org/3/movie/popular?api_key=802b2c4b88ea1183e50e6b285a27696e";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)['results'];
      //print(extractedData);
      if (extractedData == null) {
        throw HttpException("null entry");
      }
      List<Movies> _loadedProducts = [];
      extractedData.forEach((data) {
        _loadedProducts.add(Movies(
          id: data['id'],
          title: data['title'].toString(),
          adult: data['adult'],
          backdrop_path: data['backdrop_path'],
          original_language: data['original_language'],
          original_title: data['original_title'],
          overview: data['overview'],
          popularity: data['popularity'],
          poster_path: data['poster_path'],
          release_date: data['release_date'],
          video: data['video'],
          vote_count: data['vote_count'],
        ));
      });
      print("object" + _loadedProducts.length.toString());
      _movies = _loadedProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  List<Movies> find_by_name(String name) {
    if (name == "") {
      return [..._movies];
    }
    List<Movies> l = _movies
        .where((data) => data.original_title
            .toLowerCase()
            .toString()
            .toLowerCase()
            .contains(name))
        .toList();
    return l;
  }
}
