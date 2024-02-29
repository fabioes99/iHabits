class HabitSummaryModel {
  final String id;
  final DateTime date;
  final int completed;
  final int amount;

  HabitSummaryModel({ 
    required this.id,
    required this.date,
    required this.completed,
    required this.amount
  });

   HabitSummaryModel.empty() :
    id = '',
    date = DateTime.now(),
    completed = 0,
    amount = 0;


  factory HabitSummaryModel.fromJson(Map<String, dynamic> json) {
    return HabitSummaryModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      completed: json['completed'],
      amount: json['amount'],
    );
  }

}


class ListaHabitSummary {
  late List<HabitSummaryModel> listaHabitos;

  ListaHabitSummary(this.listaHabitos);

  ListaHabitSummary.empty() {
    listaHabitos = [];
  }

  factory ListaHabitSummary.fromJson(List<dynamic> json) {
    List<HabitSummaryModel> habitSummaryList = json.map((item) => HabitSummaryModel.fromJson(item as Map<String, dynamic>)).toList();
    return ListaHabitSummary(habitSummaryList);
  }

  ListaHabitSummary.teste(Map<String, dynamic> json) {
    listaHabitos = <HabitSummaryModel>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        listaHabitos.add(HabitSummaryModel.fromJson(v));
      });
    }
  }

}