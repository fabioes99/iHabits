import 'package:flutter/material.dart';
import 'package:ihabits/model/habit_possible.dart';
import 'package:ihabits/repositories/habits.dart';
import 'package:ihabits/utils/same_date.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final DateTime date;
  final VoidCallback onConfirm;

  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.date,
    required this.onConfirm,
    
  });

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  HabitsRepository habitsRepository = HabitsRepository();
  late HabitPossible habitSummaryModel;
  bool isDataLoaded = false;
  DateTime today = DateTime.now();
  late DateTime date;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async{
    date = widget.date;
    HabitPossible loadedData = await habitsRepository.possibleHabits(date);
    setState(() {
      habitSummaryModel = loadedData;
      isDataLoaded = true; 
    });
  } 

  List<Widget> buildWidgetList(List<Habit> items) {
  List<Widget> widgetList = [];

  items.forEach( (item) { 

    Widget widget = CheckboxListTile( 
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(item.title), value: habitSummaryModel.completedHabits.contains(item.id) , 
      onChanged: isSameDate(date, today) ? (newValue) async { 
        await habitsRepository.completeHabit(item.id);
        carregarDados();
      } : null ); 
    widgetList.add(widget);
  } );
  
  return widgetList;
}

  @override
  Widget build(BuildContext context) {
  
    return isDataLoaded ?
    AlertDialog(
      title: Center(child: Text(widget.title)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
          buildWidgetList(habitSummaryModel.possibleHabits) ,
      ),
      actions: [
        TextButton(onPressed: (){
           Navigator.of(context).pop();
          
        }, child: const Text('Salvar'))
      ],
      //actions : []
    ) 
    :  const Center( child: CircularProgressIndicator() ) ;
  }
}
