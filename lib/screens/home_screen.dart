import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late List<Apartment> _apartments;
  late List<Apartment> _filteredApartments;
  TextEditingController _searchController = TextEditingController();
  int? _selectedBedsFilter;
  double? _minPriceFilter;
  double? _maxPriceFilter;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _apartments = [];
    _filteredApartments = [];

    // Fetch apartments from Firestore
    fetchApartments();
  }

  void fetchApartments() async {
    var snapshots =
        await FirebaseFirestore.instance.collection('housing').get();

    List<Apartment> apartments =
        snapshots.docs.map((doc) => Apartment.fromSnapshot(doc)).toList();

    setState(() {
      _apartments = apartments;
      _filteredApartments = apartments;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apartments'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: ApartmentSearchDelegate(_apartments));
            },
          ),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApartmentDetailsScreen(apartment: apartment),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              child: PageView(
                controller: _pageController,
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
                  Row(
                    children: [
                      Icon(Icons.monetization_on),
                      SizedBox(width: 8),
                      Text(apartment.price),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text(apartment.location),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.king_bed),
                      SizedBox(width: 8),
                      Text('${apartment.beds} Beds'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 8),
                      Text(apartment.space),
                    ],
                  ),
                  Row(
                    children: [
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
                ],
              ),
            ),
          ],
        ),
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
                        _minPriceFilter = double.parse(value);
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
                        _maxPriceFilter = double.parse(value);
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
          .where((apartment) =>
              double.parse(apartment.price) >= _minPriceFilter! &&
              double.parse(apartment.price) <= _maxPriceFilter!)
          .toList();

      setState(() {
        _filteredApartments = filteredList;
      });
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

  factory Apartment.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Apartment(
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      location: data['location'] ?? '',
      beds: data['beds'] ?? 0,
      space: data['space'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      contactNumber: data['contactNumber'] ?? '',
    );
  }
}

class ApartmentSearchDelegate extends SearchDelegate<String> {
  final List<Apartment> apartments;

  ApartmentSearchDelegate(this.apartments);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults(context);
  }

  Widget buildSearchResults(BuildContext context) {
    List<Apartment> searchResults = apartments
        .where((apartment) =>
            apartment.location.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].location),
          onTap: () {
            // Handle tapping on a search result
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ApartmentDetailsScreen(apartment: searchResults[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ApartmentDetailsScreen extends StatelessWidget {
  final Apartment apartment;

  ApartmentDetailsScreen({required this.apartment});

  @override
  Widget build(BuildContext context) {
    // Create an instance of _HomeScreenState to access launchPhoneCall
    final _HomeScreenState homeScreenState = _HomeScreenState();

    return Scaffold(
      appBar: AppBar(
        title: Text(apartment.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
            SizedBox(height: 16),
            Text(
              'Price: ${apartment.price}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Location: ${apartment.location}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Beds: ${apartment.beds}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Space: ${apartment.space}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    homeScreenState._launchPhoneCall(apartment.contactNumber);
                  },
                  child: Icon(Icons.phone, color: Colors.blue),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    homeScreenState._launchPhoneCall(apartment.contactNumber);
                  },
                  child: Text('Call'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}