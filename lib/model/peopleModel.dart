class People {
  final String id;
  final String name;
  final String age;
  final String city;

  People({this.id, this.name, this.age, this.city});

  factory People.fromJson(Map<String, dynamic> parsedJson) {
    return People(
      id: parsedJson['id'].toString(),
      name: parsedJson['name'] as String,
      age: parsedJson['age'].toString(),
      city: parsedJson['city'] as String,
    );
  }
}
