import 'package:flutter/material.dart';
import 'package:ihabits/model/habit_summary.dart';
import 'package:ihabits/pages/habit_page.dart';
import 'package:ihabits/repositories/habits.dart';
import 'package:ihabits/services/notification_service.dart';
import 'package:ihabits/shared/widgets/square_habit.dart';
import 'package:ihabits/utils/same_date.dart';
import 'package:provider/provider.dart';
import 'package:ihabits/utils/generate_day.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 HabitsRepository habitsRepository = HabitsRepository();
 late ListaHabitSummary habitSummaryModel;
 bool isDataLoaded = false;
 List<DateTime> yearDates = generateDaysFromYearBegin();

  showPending(){
    setState(() {
      Provider.of<NotificationService>(context, listen: false).deleteNotification(1);
      Provider.of<NotificationService>(context, listen: false).pending();
    });
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
    saveLastTimeOpened();
  }
  carregarDados() async{
    FlutterNativeSplash.remove();
    ListaHabitSummary loadedData = await habitsRepository.getHabits();
    print(loadedData);
    setState(() {
      habitSummaryModel = loadedData;
      isDataLoaded = true; 
    });
  } 


  saveLastTimeOpened() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    await prefs.setString('lastOpened', now.toString());
  }

  List<Widget> buildWidgetList(List<DateTime> items) {
  List<Widget> widgetList = [];

  final weekDays = [ 'S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

  for (var i = 0; i < weekDays.length; i++) {
    Widget widget = Container(
      alignment: Alignment.center,
      width: 35, 
      height: 100, 
      child: Text(
      weekDays[i],
      style: const TextStyle(color: Colors.white),
    ));
    widgetList.add(widget);
  }

  items.forEach( (item) {
   
   var habit = habitSummaryModel.listaHabitos.firstWhere(
    (element) => isSameDate(element.date, item),
    orElse: () => HabitSummaryModel.empty(), );
    Widget widget = SquareHabit(
      id: habit.id,
      amount: habit.amount,
      date: item,
      completed: habit.completed,
    );
    widgetList.add(widget);
  } );
  
  return widgetList;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('IHabits'),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showPending();
                
              },
            ),
        ],
      ),
      body: !isDataLoaded ? const Center(
          child: CircularProgressIndicator(), 
        )  : 
        Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: GridView.count(
          crossAxisCount: 7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: buildWidgetList(yearDates),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "adicionar Habito",
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HabitPage()));
        }),
    );
  }

  
}

