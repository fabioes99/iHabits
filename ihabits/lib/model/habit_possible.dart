class Habit {
  final String id;
  final String title;
  final DateTime createdAt;

  Habit({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class HabitPossible {
  final List<Habit> possibleHabits;
  final List<String> completedHabits;

  HabitPossible({
    required this.possibleHabits,
    required this.completedHabits,
  });

  factory HabitPossible.fromJson(Map<String, dynamic> json) {

    List<dynamic>? possibleHabitsJson = json['possibleHabits'];
    List<Habit> possibleHabits = possibleHabitsJson?.map((habitJson) => Habit.fromJson(habitJson)).toList() ?? [];

    List<dynamic>? completedHabitsJson = json['completedHabits'];
    List<String> completedHabits = completedHabitsJson?.cast<String>() ?? []; // Convertendo para List<String>

    return HabitPossible(
      possibleHabits: possibleHabits,
      completedHabits: completedHabits,
    );
  }
}
