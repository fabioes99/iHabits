import 'package:flutter/material.dart';
import 'package:ihabits/app.dart';
import 'package:ihabits/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:ihabits/model/square_habit_model.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(providers: [
      Provider<NotificationService>(create: (context) => NotificationService() ,),
      ChangeNotifierProvider(create: (context) => SquareHabitModel()), 
    ],
    child: const MyApp(),
    )
  );
}
