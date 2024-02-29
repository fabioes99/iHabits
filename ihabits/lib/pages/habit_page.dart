import 'package:flutter/material.dart';
import 'package:ihabits/repositories/habits.dart';
import 'package:ihabits/repositories/notification.dart';
import 'package:ihabits/services/notification_service.dart';
import 'package:ihabits/shared/widgets/label_text.dart';
import 'package:ihabits/shared/widgets/snackbar.dart';
import 'package:ihabits/utils/transform_date.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:provider/provider.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  TextEditingController tarefaAnteriorController = TextEditingController();
  String horarioSelecionado = '';
  HabitsRepository habitsRepository = HabitsRepository();
  NotificationRepository notificationRepository = NotificationRepository();
  
  final selectedDays = List.filled(7, false);
  
  Future<void> _selectTime() async {
  TimeOfDay? selectedTime = await showTimePicker(
    initialTime: TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.inputOnly,
    context: context,
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );

  if (selectedTime != null) {
    setState(() {
      horarioSelecionado = "${selectedTime.hour}:${selectedTime.minute}" ;  
    });
    
  } 
}


  void scheduleNotification(CustomNotification customNotification, String time, List<int> selectedDays){
    
    List<String> parts = time.split(':');
  
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    if (selectedDays.length == 1) {
       int day = retornaDiaDateTime(selectedDays[0]);
       setState(() {
        Provider.of<NotificationService>(context, listen: false).scheduleWeeklyDayAndTimeNotification(
        customNotification, day, hour, minute );
      });
       
    }else if(selectedDays.length == 7){
      setState(() {
        Provider.of<NotificationService>(context, listen: false).scheduleEveryDayNotification(
        customNotification, hour, minute );
      });
    }else{
      selectedDays.forEach((day) {
        int transformedDay = retornaDiaDateTime(day);
        setState(() {
          Provider.of<NotificationService>(context, listen: false).scheduleWeeklyDayAndTimeNotification(
          customNotification, transformedDay, hour, minute );
        });
      });
    }   
    
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('IHabits'),),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const TextLabel(texto: "Adicionar Habito"),
                const Text("Adicionar uma tarefa a uma rotina existente, faz com que ela se torne um hábito mais rapidamente. \n Ex: Ir para academia depois do trabalho "),
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 14),
                  child: Text("A qual tarefa você deseja adicionar?", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
                TextField( controller: tarefaAnteriorController, decoration: const InputDecoration(hintText: "Depois do Trabalho"),),
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 14),
                  child: Text("Horario e dia sugerido para tarefa",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700) ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: WeekdaySelector(
                    weekdays: const ["Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sábado"],
                    shortWeekdays: const ["D", "S", "T", "Q", "Q", "S", "S"],
                    onChanged: (int day) {
                      setState(() {
                        final index = day % 7;
                        selectedDays[index] = !selectedDays[index];
                      });
                    },
                    values: selectedDays,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text( horarioSelecionado.isEmpty ? "-:-"  :  horarioSelecionado, 
                      style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700) ),
                      IconButton(
                        onPressed: () {
                          _selectTime();
                        },
                        icon: const Icon(Icons.access_time),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: ()  {
                  List<int> transformedDate = transformDate(selectedDays);
                 
                  if( tarefaAnteriorController.text.isEmpty ){
                    CustomSnackbar.show(context, 'Por favor, preencha a descrição da tarefa', Colors.red);
                    return ;
                  }
                  if( transformedDate.isEmpty ){
                    CustomSnackbar.show(context, 'Por favor, preencha ao menos uma data', Colors.red);
                    return ;
                  }
                  if( horarioSelecionado.isEmpty ){
                    CustomSnackbar.show(context, 'Por favor, preencha o horário para a tarefa', Colors.red);
                    return ;
                  }
                  String tarefa = tarefaAnteriorController.text;
                  String time = horarioSelecionado;
                  habitsRepository.createHabit(tarefa, transformedDate).then((response) {
                    if (response['statusCode'] == 200) {
                      CustomNotification customNotification = CustomNotification(id: 0, title: 'Lembrete de Tarefa', body: 'Chegou a fazer a tarefa $tarefa', payload: '/home');
                      notificationRepository.createNotification( customNotification, response['habitId'], time  ).then((value) {
                        customNotification.id = value.id;
                        Navigator.pop(context);
                        scheduleNotification(customNotification, time, transformedDate);
                      });
                     CustomSnackbar.show(context, 'Hábito criado com sucesso', Colors.green );
                    }
                    else{
                      CustomSnackbar.show(context, 'Hábito não foi criado', Colors.red);
                    }
                  });
                  
                }, child: const Text("Adicionar a Rotina"))
              ]
            ),
          ),
        )
      ),
    );
  }
}