import 'package:flutter/material.dart';
import 'settings_screen.dart'; // Import the SettingsScreen
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Apartment> _apartments;
  late List<Apartment> _filteredApartments;
  TextEditingController _searchController = TextEditingController();
  int? _selectedBedsFilter;
  double? _minPriceFilter;
  double? _maxPriceFilter;

  @override
  void initState() {
    super.initState();
    _apartments = [];
    _filteredApartments = [];
    fetchApartments();
  }

  void fetchApartments() async {
    // Simulated data fetching or initialization
    List<Apartment> apartments = [
      Apartment(
        name: 'Apartment 1',
        price: '\$1000',
        location: 'Location 1',
        beds: 2,
        space: '1000 sqft',
        images: ['image_url_1', 'image_url_2'],
        contactNumber: '1234567890',
      ),
      Apartment(
        name: 'Apartment 2',
        price: '\$1200',
        location: 'Location 2',
        beds: 3,
        space: '1200 sqft',
        images: ['image_url_3', 'image_url_4'],
        contactNumber: '0987654321',
      ),
      // Add more sample data if needed
    ];

    setState(() {
      _apartments = apartments;
      _filteredApartments = apartments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apartments'),
        actions: [
          ElevatedButton(
            onPressed: () {
              showFilterDialog(context);
            },
            child: Text('Filter Options'),
          ),
          ElevatedButton(
            onPressed: () {
              resetFilters();
            },
            child: Text('Reset Filters'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'User Name', // Replace with the user's name
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Navigate to the SettingsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _filteredApartments.isNotEmpty
          ? ListView.builder(
              itemCount: _filteredApartments.length,
              itemBuilder: (context, index) {
                return buildApartmentCard(_filteredApartments[index]);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildApartmentCard(Apartment apartment) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            child: PageView(
              children: apartment.images.map((imageUrl) {
                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  apartment.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Price: ${apartment.price}'),
                Text('Location: ${apartment.location}'),
                Text('Beds: ${apartment.beds}'),
                Text('Space: ${apartment.space}'),
                GestureDetector(
                  onTap: () {
                    _launchPhoneCall(apartment.contactNumber);
                  },
                  child: Icon(Icons.phone, color: Colors.blue),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    _launchPhoneCall(apartment.contactNumber);
                  },
                  child: Text('Call'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Apply beds filter
                  showBedsFilterDialog(context);
                },
                child: Text('Beds Filter'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Apply price filter
                  showPriceFilterDialog(context);
                },
                child: Text('Price Filter'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showBedsFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Beds Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select the number of beds:'),
              DropdownButton<int>(
                value: _selectedBedsFilter,
                items: List.generate(5, (index) => index + 1)
                    .map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBedsFilter = value;
                  });
                  applyBedsFilter();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showPriceFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Price Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter the price range:'),
              Row(
                children: [
                  Text('Min Price:'),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _minPriceFilter = double.tryParse(value);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Max Price:'),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _maxPriceFilter = double.tryParse(value);
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  applyPriceFilter();
                  Navigator.pop(context);
                },
                child: Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }

  void applyBedsFilter() {
    if (_selectedBedsFilter != null) {
      List<Apartment> filteredList = _apartments
          .where((apartment) => apartment.beds == _selectedBedsFilter)
          .toList();

      setState(() {
        _filteredApartments = filteredList;
      });
    }
  }

  void applyPriceFilter() {
    if (_minPriceFilter != null && _maxPriceFilter != null) {
      List<Apartment> filteredList = _apartments
          .where((apartment) {
            double apartmentPrice =
                double.tryParse(apartment.price.replaceAll('\$', '')) ?? 0;
            return apartmentPrice >= _minPriceFilter! &&
                apartmentPrice <= _maxPriceFilter!;
          })
          .toList();

      setState(() {
        _filteredApartments = filteredList;
      });
    } else {
      // If no price filter is selected, reset to all apartments
      resetFilters();
    }
  }

  void resetFilters() {
    setState(() {
      _selectedBedsFilter = null;
      _minPriceFilter = null;
      _maxPriceFilter = null;
      _filteredApartments = _apartments;
    });
  }

  void _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Apartment {
  final String name;
  final String price;
  final String location;
  final int beds;
  final String space;
  final List<String> images;
  final String contactNumber;

  Apartment({
    required this.name,
    required this.price,
    required this.location,
    required this.beds,
    required this.space,
    required this.images,
    required this.contactNumber,
  });
}
