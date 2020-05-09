import 'package:flutter/material.dart';
import 'package:internshalainternshipproject/bloc_provider/home_screen.dart';
import 'package:internshalainternshipproject/routes/routes.dart';
import 'package:internshalainternshipproject/screens/home_screen.dart';
import 'package:internshalainternshipproject/screens/single_movie.dart';
import 'package:internshalainternshipproject/search/search_toggle.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: HomeScreenProvider(),
      ),
      ChangeNotifierProvider.value(
        value: SearchToggle(),
      ),
    ], child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
