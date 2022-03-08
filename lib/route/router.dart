import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_zadaniya/screens/home_page.dart';

class RouteGeneratorr {
  static generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
