import 'package:flutter/material.dart';
import 'package:ihabits/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:ihabits/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    checkNotifications();
    checkLastTimeOpened();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
  }

  checkLastTimeOpened() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastOpenedString = prefs.getString('lastOpened') ?? '';
    DateTime lastOpened = DateTime.parse(lastOpenedString);
    DateTime now = DateTime.now();
    DateTime lastOpened7Days = lastOpened.add(const Duration(days: 7));

    if (now.isAfter(lastOpened7Days)) {
      
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 77, 31, 156)),
        useMaterial3: true,
        brightness: Brightness.dark
      ),
      routes: Routes.list,
      initialRoute: Routes.initial,
      navigatorKey: Routes.navigatorKey,
    );
  }
}

