import 'package:flutter/material.dart';
import 'package:internshalainternshipproject/screens/single_movie.dart';

import '../main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MyApp(),
        );

      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      case "/single_movie":
        return MaterialPageRoute(
            builder: (_) => SingleMovie(
                  args
                ));

        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
