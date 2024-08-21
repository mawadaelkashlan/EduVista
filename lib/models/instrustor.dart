class Instructor {
  String? id;
  String? name;
  String? graduation_from;
  int? years_of_experience;

  Instructor.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    graduation_from = data['graduation_from'];
    years_of_experience = data['years_of_experience'];
  }
}