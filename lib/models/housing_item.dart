// housing_item.dart

class HousingItem {
  final String name;
  final String location;
  final String price;
  final int beds;
  final String space;
  final List<String> images;
  final String contactNumber;

  HousingItem({
    required this.name,
    required this.location,
    required this.price,
    required this.beds,
    required this.space,
    required this.images,
    required this.contactNumber,
  });
}
