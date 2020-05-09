import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshalainternshipproject/bloc_provider/single_movie_provider.dart';
import 'package:internshalainternshipproject/model/movies.dart';
import 'package:internshalainternshipproject/screens/bottom_single_movie.dart';
import 'package:provider/provider.dart';

class SingleMovie extends StatefulWidget {
  static const String route = "/single_movie";
  dynamic id;

  SingleMovie(this.id);
  @override
  _SingleMovieState createState() => _SingleMovieState();
}

class _SingleMovieState extends State<SingleMovie> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.id[1].original_title,
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w220_and_h330_face${widget.id[1].backdrop_path}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              color: Color.fromRGBO(38, 38, 38, 0.7),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  height: 200,
                  width: size.width,
                  child: Card(
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w220_and_h330_face${widget.id[1].poster_path}",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        widget.id[1].original_title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      AutoSizeText(
                        widget.id[1].release_date.substring(0, 4),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      AutoSizeText(
                        widget.id[1].overview,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                ChangeNotifierProvider.value(
                    value: SingleMovieProvider(),
                    child: BottomSingleMovie(widget.id[0])),
              ],
            )
          ],
        ));
  }
}
