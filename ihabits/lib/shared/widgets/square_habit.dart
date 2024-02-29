import 'package:flutter/material.dart';
import 'package:ihabits/shared/widgets/alert_dialog.dart';


class SquareHabit extends StatelessWidget {
  final String id;
  final DateTime date;
  final int completed;
  final int amount;

  const SquareHabit({
    required this.id,
    required this.date,
    required this.completed,
    required this.amount,
    
  });

  @override
  Widget build(BuildContext context) {
    
    int completedPercent = amount > 0 ? ((completed / amount).round() * 100).round() : 0;
    

    return  GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (BuildContext context){
          return CustomAlertDialog(
            title: '${date.day}/${date.month} ',
            content: 'Conteúdo do Diálogo',
            date: date ,
            onConfirm: () {
              
              Navigator.of(context).pop(); 
            },
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(39, 39, 42, 1) , width: 2),
          borderRadius: BorderRadius.circular(12),
          color: id.isNotEmpty ? 
          completedPercent > 0 && completedPercent < 20 ? Color.fromARGB(255, 7, 7, 215) : 
          completedPercent >= 20 && completedPercent < 40 ? const Color.fromRGBO(76, 29, 149, 1) : 
          completedPercent >= 40 && completedPercent < 60 ? const Color.fromRGBO(109, 40, 217, 1) : 
          completedPercent >= 60 && completedPercent < 88 ? const Color.fromRGBO(124, 58, 237, 1) : 
          completedPercent >= 88 ? const Color.fromRGBO(139, 92, 246, 1) : const Color.fromRGBO(39, 39, 42, 1)
          : const Color.fromRGBO(39, 39, 42, 1)
        ),
        width: 35, 
        height: 35, 
      ),
    );
  }
}