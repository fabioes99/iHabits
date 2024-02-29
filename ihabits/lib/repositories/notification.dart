import 'package:ihabits/repositories/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:ihabits/model/notification.dart';
import 'package:ihabits/services/notification_service.dart';

class NotificationRepository {
  final _customDio = CustomDio();

  Future<Notification> createNotification(CustomNotification notification, String habitId, String time) async {
    Map<String, String> requestBody = {
      'title': notification.title! ,
      'body': notification.body!,
      'payload': notification.payload!,
      'time': time,
      'habitId': habitId
    };
    Response response = await _customDio.dio.post('/notification', data: requestBody);
    Notification notificationModel = Notification.fromJson(response.data);
    return notificationModel;
  }

  Future<Map<String, String>> getNotificationHabit(String? id) async {
    Response response = await _customDio.dio.get('/notification?id=$id');
    String time = response.data['Notification']['time'];
    String title = response.data['habit']['title'];
    String habitID = response.data['habit_id'];
    Map<String, String> result = {
    'title': title,
    'time': time,
    'habitId': habitID
  };

  return result;
  }

  
 
}
