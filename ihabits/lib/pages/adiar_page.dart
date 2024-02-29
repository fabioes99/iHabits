import 'package:flutter/material.dart';
import 'package:ihabits/repositories/notification.dart';
import 'package:ihabits/services/notification_service.dart';
import 'package:ihabits/shared/widgets/label_text.dart';
import 'package:provider/provider.dart';

class AdiarPage extends StatefulWidget {
  final String id;
  const AdiarPage({Key? key, required this.id}) : super(key: key);

  @override
  State<AdiarPage> createState() => _AdiarPageState();
}

class _AdiarPageState extends State<AdiarPage> {
  NotificationRepository notificationRepository = NotificationRepository();
  String? horarioSelecionado;
  bool isDataLoaded = false;
  String? id;
  String? title;
  String? habitId;
  
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

@override
  void initState() {
    super.initState();
    id = widget.id;
    if (id != null) {
      carregarDados(id!);
    }
  }

  void carregarDados(String id) async {
    Map<String, String> dados = await notificationRepository.getNotificationHabit(id);
    setState(() {
      horarioSelecionado = dados['time'] ?? '';
      title = dados['title'];
      habitId = dados['habitId'];
      isDataLoaded = true;
    });
  }

   scheduleNotification(CustomNotification customNotification, String time ){
    List<String> parts = time.split(':');
  
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    setState(() {
      Provider.of<NotificationService>(context, listen: false).showNotificationScheduledWithActions(
      customNotification, hour, minute );
    });
    
  }

  @override
  Widget build(BuildContext context) {  
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adiar a tarefa'),
        centerTitle: true,
        elevation: 0,
      ),
      body: isDataLoaded ? 
       Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            const TextLabel( texto: 'Adiar a tarefa por quanto tempo?', ),
            TextLabel(texto: title!),
             Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( horarioSelecionado!, 
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
              onPressed: () {
                CustomNotification customNotification = CustomNotification(id: 0, title: 'Lembrete de Tarefa', body: 'Chegou a fazer a tarefa $title', payload: '/home');
                notificationRepository.createNotification( customNotification, habitId!, horarioSelecionado!  ).then((value) {
                  customNotification.id = value.id;
                  Navigator.pop(context);
                  scheduleNotification(customNotification, horarioSelecionado!);
                });
            }, child: const Text("Adiar a Tarefa"))
          ],
        ),
      ) : const Center(
          child: CircularProgressIndicator(), )
    );
  }
}