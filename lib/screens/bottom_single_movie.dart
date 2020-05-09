import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:internshalainternshipproject/bloc_provider/single_movie_provider.dart';
import 'package:provider/provider.dart';

class BottomSingleMovie extends StatefulWidget {
  int id;
  BottomSingleMovie(this.id);
  @override
  _BottomSingleMovieState createState() => _BottomSingleMovieState();
}

class _BottomSingleMovieState extends State<BottomSingleMovie> {
  bool _init = false;
  bool _is_loading = false;

  @override
  void didChangeDependencies() {
    if (_init == false) {
      setState(() {
        _is_loading = true;
      });
      Provider.of<SingleMovieProvider>(context)
          .fetch_movies(widget.id)
          .then((_) {
        setState(() {
          _is_loading = false;
          _init = true;
        });
      }).catchError((onError) {
        print("onError");
        print(onError);
        _showDialogue("some error occurred");
        setState(() {
          _is_loading = false;
          _init = true;
        });
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _showDialogue(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured'),
        content: msg == null ? Text('') : Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _refresh() {
    setState(() {
      _is_loading = true;
    });
    Provider.of<SingleMovieProvider>(context, listen: false)
        .fetch_movies(widget.id)
        .then((_) {
      setState(() {
        _is_loading = false;
        _init = true;
      });
    }).catchError((onError) {
      print("onError");
      print(onError);
      _showDialogue("some error occurred");
      setState(() {
        _is_loading = false;
        _init = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final info = Provider.of<SingleMovieProvider>(context).movies;
    print(info.length);
    return _is_loading == true
        ? Center(child: CircularProgressIndicator())
        : info.length > 0
            ? Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Color.fromRGBO(38, 38, 38, 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            AutoSizeText(
                              info[index].name.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            AutoSizeText(
                              info[index].site.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            AutoSizeText(
                              info[index].size.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: info.length,
                ),
              )
            : Container(
                child: Center(
                  child: FlatButton(
                    child: Text('Refresh'),
                    onPressed: _refresh,
                  ),
                ),
              );
  }
}
