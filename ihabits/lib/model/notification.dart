class Notification {
  final int id;
  final String title;
  final String body;
  final String paylod;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.paylod,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      paylod: json['payload'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class HabitPossible {
  final List<Notification> possibleHabits;
  final List<String> completedHabits;

  HabitPossible({
    required this.possibleHabits,
    required this.completedHabits,
  });

  factory HabitPossible.fromJson(Map<String, dynamic> json) {

    List<dynamic>? possibleHabitsJson = json['possibleHabits'];
    List<Notification> possibleHabits = possibleHabitsJson?.map((habitJson) => Notification.fromJson(habitJson)).toList() ?? [];

    List<dynamic>? completedHabitsJson = json['completedHabits'];
    List<String> completedHabits = completedHabitsJson?.cast<String>() ?? []; // Convertendo para List<String>

    return HabitPossible(
      possibleHabits: possibleHabits,
      completedHabits: completedHabits,
    );
  }
}
