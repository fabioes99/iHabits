import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
//import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:ihabits/routes.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // ignore: avoid_print
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
  }

  

class CustomNotification{
  int id;
   final String? title;
   final String? body;
   final String? payload;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
  
}

class NotificationService{
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_details',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes!',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

  static const AndroidNotificationDetails androidNotificationDetailsActions =
    AndroidNotificationDetails(
      'lembretes_notifications_details_actions',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes com actions!',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('marcar', 'Marcar tarefa ', showsUserInterface: true, cancelNotification: false),
        AndroidNotificationAction('adiar', 'Adiar tarefa', showsUserInterface: true, cancelNotification: false),
      ],
    );



  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
   var plugin = localNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (plugin != null) {
      plugin.requestNotificationsPermission();
    }
    _setupNotifications();
  }


  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
       onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _onSelectNotification;
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == 'marcar') {
              _onSelectNotification('/home');
            }
            else if (notificationResponse.actionId == 'adiar') {
              _onSelectNotification('/adiar/${notificationResponse.id}');
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      List<String> parts = payload.split('/');
      String rota = parts[1]; 
      String id = parts[2]; 
      Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed('/$rota', arguments: id);
    }
  }

  showNotification(CustomNotification customNotification){

    localNotificationsPlugin.show(
      customNotification.id, 
      customNotification.title, 
      customNotification.body, 
      NotificationDetails(
        android: androidDetails
      ),
      payload: customNotification.payload
      );
  }


  showNotificationScheduled(CustomNotification customNotification, int hour, int minute){

    localNotificationsPlugin.zonedSchedule(
      customNotification.id, 
      customNotification.title, 
      customNotification.body, 
      _nextInstanceOfSpecificTime( hour , minute),
      NotificationDetails(
        android: androidDetails
      ),
      payload: customNotification.payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
  }

  Future<void> showNotificationScheduledWithActions(CustomNotification customNotification, int hour, minute) async {
    
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetailsActions);

    await localNotificationsPlugin.zonedSchedule(
      customNotification.id,
      customNotification.title,
      customNotification.body,
     _nextInstanceOfSpecificTime( hour , minute),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );

  }

  Future<void> scheduleWeeklyDayAndTimeNotification(CustomNotification customNotification, int day, int hour, int minute) async {
    await localNotificationsPlugin.zonedSchedule(
        customNotification.id,
        customNotification.title,
        customNotification.body,
        _nextInstanceOfSpecificDayAndTime( day, hour, minute),
        const NotificationDetails(
          android: androidNotificationDetailsActions,
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

   Future<void> scheduleEveryDayNotification(CustomNotification customNotification, int hour, int minute) async {
    await localNotificationsPlugin.zonedSchedule(
        customNotification.id,
        customNotification.title,
        customNotification.body,
        _nextInstanceOfSpecificTime( hour , minute),
        const NotificationDetails(
          android: androidNotificationDetailsActions,
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }



  tz.TZDateTime _nextInstanceOfSpecificTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfSpecificDayAndTime(int day,int hour, int minute) {
    tz.TZDateTime scheduledDate = _nextInstanceOfSpecificTime(hour, minute);
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }


   checkForNotifications() async {
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.notificationResponse!.payload);
    }
  }

  Future<List<PendingNotificationRequest>> pending() async{
    
    final List<PendingNotificationRequest> pendingNotificationRequests =
      await localNotificationsPlugin.pendingNotificationRequests();
      print(pendingNotificationRequests.length);
      
      return pendingNotificationRequests;
  }  

  Future<void> deleteNotification(int id) async{
    //await localNotificationsPlugin.cancelAll();
    await localNotificationsPlugin.cancel(id);
  }

}