import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:internshalainternshipproject/model/movies.dart';

class SingleGrid extends StatelessWidget {
  Movies _movies;
  SingleGrid(this._movies);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/single_movie",
            arguments: [_movies.id, _movies]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 300,
            height: 170,
            padding: EdgeInsets.all(0),
            child: FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                placeholder: "assets/images/avengers2.jpg",
                image:
                    "https://image.tmdb.org/t/p/w220_and_h330_face${_movies.poster_path}"),
          ),
          Container(
            margin: EdgeInsets.only(top: 0),
            padding: EdgeInsets.all(5),
            width: 300,
            height: 60,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  _movies.original_title.length > 20
                      ? _movies.original_title.substring(0, 20) + ".."
                      : _movies.original_title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                AutoSizeText(
                  _movies.release_date.substring(0, 4),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
