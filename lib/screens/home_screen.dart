import 'package:flutter/material.dart';
import 'package:internshalainternshipproject/bloc_provider/home_screen.dart';
import 'package:internshalainternshipproject/screens/grid_screen.dart';
import 'package:internshalainternshipproject/search/search_toggle.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final search_toggle = Provider.of<SearchToggle>(context);

    void searchResult(String name) {
      search_toggle.add_string(name.toLowerCase());
    }

    return Scaffold(
      appBar: search_toggle.search == false
          ? AppBar(
              elevation: 0,
              title: Text(
                "Movies",
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: search_toggle.toggle,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => search_toggle.toggle(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 170,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 170,
                        child: TextField(
                          onChanged: (data) => searchResult(data),
                          autofocus: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: 'Search By Title',
                            border: InputBorder.none,
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FlatButton.icon(
                    onPressed: () => search_toggle.toggle(),
                    label: Text(
                      'cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.cancel,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/avengers.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Grid(),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
