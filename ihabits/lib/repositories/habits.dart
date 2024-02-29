import 'package:ihabits/repositories/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:ihabits/model/habit_possible.dart';
import 'package:ihabits/model/habit_summary.dart';

class HabitsRepository {
  final _customDio = CustomDio();

  Future<ListaHabitSummary> getHabits() async {
    Response response = await _customDio.dio.get('/summary');
    ListaHabitSummary habitSummaryModel = ListaHabitSummary.fromJson(response.data);
    return habitSummaryModel;
  }

  Future<HabitPossible> possibleHabits(DateTime date) async {
    Response response = await _customDio.dio.get('/day?date=$date');    
    HabitPossible habitSummaryModel = HabitPossible.fromJson(response.data);
    return habitSummaryModel;
  }

  Future<void> completeHabit(String id) async {
    Dio dio = Dio();
    await dio.patch('http://10.0.2.2:3333/habits/$id/toggle');    
  }

  Future<Map<String, dynamic>> createHabit(String title, List<int> weekDays) async {
    Map<String, dynamic> requestBody = {
      'title': title,
      'weekDays': weekDays,
    };
    Response response = await _customDio.dio.post('/habits', data: requestBody);  
    int statusCode = response.statusCode!;

    Map<String, dynamic> responseReturn = {
      'statusCode': statusCode,
      'habitId': response.data['id'],
    };

    return responseReturn;
  }
 
}
