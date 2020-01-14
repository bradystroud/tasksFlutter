import 'dart:convert';

Task taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String taskToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task {
  int id;
  String heading;
  String context;
  bool status;

  Task({
    this.id,
    this.heading,
    this.context,
    this.status,
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
        id: json["id"],
        heading: json["heading"],
        context: json["context"],
        status: json["status"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "heading": heading,
        "context": context,
        "status": status,
      };
}
