// lib/models/apartment.dart

class Apartment {
  final String name;
  final String location;
  final String price;
  final int beds;
  final double space;

  Apartment({
    required this.name,
    required this.location,
    required this.price,
    required this.beds,
    required this.space,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      name: json['name'],
      location: json['location'],
      price: json['price'],
      beds: json['beds'],
      space: json['space'],
    );
  }
}
