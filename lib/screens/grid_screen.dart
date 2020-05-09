import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshalainternshipproject/bloc_provider/home_screen.dart';
import 'package:internshalainternshipproject/model/movies.dart';
import 'package:internshalainternshipproject/screens/single_grid.dart';
import 'package:internshalainternshipproject/search/search_toggle.dart';
import 'package:provider/provider.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  bool _init = false;
  bool _is_loading = false;
  @override
  void didChangeDependencies() {
    if (_init == false) {
      setState(() {
        _is_loading = true;
      });
      Provider.of<HomeScreenProvider>(context).fetch_movies().then((_) {
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
          FlatButton(
            child: Text('Refresh'),
            onPressed: _refresh,
          )
        ],
      ),
    );
  }

  Future<void> _refresh() {
    Navigator.of(context).pop();
    setState(() {
      _is_loading = true;
    });
    Provider.of<HomeScreenProvider>(context, listen: false)
        .fetch_movies()
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
    final search_toggle = Provider.of<SearchToggle>(context);
    List<Movies> _movies = Provider.of<HomeScreenProvider>(context)
        .find_by_name(search_toggle.search_string);

    final size = MediaQuery.of(context).size;
    return _is_loading == true
        ? Center(
            child: Container(
                color: Colors.white, child: CircularProgressIndicator()))
        : _movies.length > 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height),
                ),
                itemCount: _movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleGrid(_movies[index]);
                },
              )
            : Container(
                child: Center(
                  child: Text(
                    "No item to display",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              );
  }
}
