import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'apartment_details_screen.dart';
import 'add_apartment_screen.dart';
import 'settings_screen.dart';
import '../widgets/custom_card.dart';
import '../widgets/search_delegate.dart';
import '../models/apartment.dart';
const String loginRoute = './login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Apartment> _apartments;
  late List<Apartment> _filteredApartments;
  TextEditingController _searchController = TextEditingController();
  String userName = ''; // Variable to store user name

  @override
  void initState() {
    super.initState();
    _apartments = [];
    _filteredApartments = [];

    // Fetch apartments from the backend when the screen initializes
    fetchApartments();
    // Fetch user name from the backend when the screen initializes
    fetchUserName();
  }

  void fetchApartments() async {
    // Make an HTTP GET request to fetch apartments from your Node.js backend
    var response =
        await http.get(Uri.parse('http://localhost:3000/api/apartments'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      List<dynamic> data = json.decode(response.body);
      List<Apartment> apartments =
          data.map((json) => Apartment.fromJson(json)).toList();

      setState(() {
        _apartments = apartments;
        _filteredApartments = apartments;
      });
    } else {
      // Handle error cases
      print('Failed to fetch apartments: ${response.statusCode}');
    }
  }

  void fetchUserName() async {
    // Make an HTTP GET request to fetch user name from your Node.js backend
    var response =
        await http.get(Uri.parse('http://localhost:3000/api/user/details'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON response
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        userName = data['name']; // Update user name
      });
    } else {
      // Handle error cases
      print('Failed to fetch user name: ${response.statusCode}');
    }
  }

  void filterApartmentsByBeds(int beds) {
    List<Apartment> filteredList =
        _apartments.where((apartment) => apartment.beds == beds).toList();
    setState(() {
      _filteredApartments = filteredList;
    });
  }

  void filterApartmentsByPriceRange(double minPrice, double maxPrice) {
    List<Apartment> filteredList = _apartments.where((apartment) {
      double apartmentPrice =
          double.tryParse(apartment.price.replaceAll('\$', '')) ?? 0;
      return apartmentPrice >= minPrice && apartmentPrice <= maxPrice;
    }).toList();
    setState(() {
      _filteredApartments = filteredList;
    });
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
              delegate: ApartmentSearchDelegate(_apartments),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            showFilterOptions(context);
          },
        ),
      ],
    ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Welcome, $userName'), // Display user name
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(
              'Profile Settings'), // Changed from 'Settings' to 'Profile Settings'
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              logout(); // Call logout function
            },
          ),
        ],
      ),
    ),
    body: _filteredApartments.isNotEmpty
        ? ListView.builder(
            itemCount: _filteredApartments.length,
            itemBuilder: (context, index) {
              final apartment = _filteredApartments[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApartmentDetailsScreen(apartment: apartment),
                    ),
                  );
                },
                child: CustomCard(
                  title: apartment.name,
                  subTitle: apartment.location,
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddApartmentScreen()),
        );
      },
      child: Icon(Icons.add),
    ),
  );
}


  void showFilterOptions(BuildContext context) {
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
                  filterApartmentsByBeds(2); // Example: Filter by 2 beds
                  Navigator.pop(context);
                },
                child: Text('Filter by 2 Beds'),
              ),
              ElevatedButton(
                onPressed: () {
                  filterApartmentsByPriceRange(1000,
                      2000); // Example: Filter by price range $1000 - $2000
                  Navigator.pop(context);
                },
                child: Text('Filter by Price Range'),
              ),
            ],
          ),
        );
      },
    );
  }

 void logout() async {
  // Make an HTTP GET request to logout from your Node.js backend
  var response = await http.get(Uri.parse('http://localhost:/api/auth/logout'));

  if (response.statusCode == 200) {
    // If logout is successful, navigate back to login screen
    Navigator.pushReplacementNamed(context, loginRoute);
  } else {
    // Handle error cases
    print('Failed to logout: ${response.statusCode}');
  }
}

}
