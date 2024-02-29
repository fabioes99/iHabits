import 'package:flutter/material.dart';
import 'package:ihabits/pages/home_page.dart';
import 'package:ihabits/pages/adiar_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/home': (_) => const HomePage(),
    '/adiar': (context) {
      final String? id = ModalRoute.of(context)?.settings.arguments as String?;
      return AdiarPage(id: id!);
    },
  };

  static String initial = '/home';
  static String home = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}