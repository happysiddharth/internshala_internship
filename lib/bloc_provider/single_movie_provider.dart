import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:internshalainternshipproject/model/single_movie.dart';

class SingleMovieProvider with ChangeNotifier {
  List<SingleMovieModel> _movies = [];
  List<SingleMovieModel> get movies {
    return List.from(_movies);
  }

  Future<void> fetch_movies(int id) async {
    final String url =
        "http://api.themoviedb.org/3/movie/${id}/videos?api_key=802b2c4b88ea1183e50e6b285a27696e";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)['results'];
      //print(extractedData);
      if (extractedData == null) {
        throw HttpException("null entry");
      }
      List<SingleMovieModel> _loadedProducts = [];
      extractedData.forEach((data) {
        _loadedProducts.add(SingleMovieModel(
          id: data['id'],
          iso_639_1: data['iso_639_1'],
          iso_3166_1: data['iso_3166_1'],
          key: data['key'],
          site: data['site'],
          type: data['type'],
          size: data['size'],
          name: data['name'],
        ));
      });
      print("object" + _loadedProducts.length.toString());
      _movies = _loadedProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
