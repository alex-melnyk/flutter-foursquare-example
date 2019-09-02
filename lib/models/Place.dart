
class Place {
  final String type;
  final String name;

  Place.fromMap(Map<String, Object> json)
      : type = json['type'],
        name = json['name'];
}