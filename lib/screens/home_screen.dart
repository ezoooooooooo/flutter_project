// home_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/property_listing_card.dart';
import '../models/custom_search_delegate.dart';
import '../screens/saved_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference apartmentsCollection =
      FirebaseFirestore.instance.collection('housing');
  List<Map<String, dynamic>> savedApartments = [];
  int? selectedBeds;
  RangeValues selectedPriceRange = const RangeValues(0, 2000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Housing App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  selectedPriceRange: selectedPriceRange,
                  selectedBeds: selectedBeds,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.attach_money),
            onPressed: () {
              _showPriceFilterDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.king_bed),
            onPressed: () {
              _showBedsFilterDialog(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome, User!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    selectedPriceRange: selectedPriceRange,
                    selectedBeds: selectedBeds,
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Saved'),
              onTap: () {
                _navigateToSavedScreen();
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Filter Price'),
              onTap: () {
                _showPriceFilterDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.king_bed),
              title: Text('Filter Beds'),
              onTap: () {
                _showBedsFilterDialog(context);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: apartmentsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No apartments found.');
          }

          List<DocumentSnapshot> apartments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: apartments.length,
            itemBuilder: (context, index) {
              return PropertyListingCard(
                apartmentData: apartments[index].data() as Map<String, dynamic>,
                isSaved: savedApartments.contains(apartments[index].reference),
                onSaved: (isSaved) async {
                  await _handleSavedStateChange(apartments[index].reference, isSaved);
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (index) {
          switch (index) {
            case 0:
              // Home tab
              break;
            case 1:
              // Search tab
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  selectedPriceRange: selectedPriceRange,
                  selectedBeds: selectedBeds,
                ),
              );
              break;
            case 2:
              _navigateToSavedScreen();
              break;
          }
        },
      ),
    );
  }

  Future<void> _showPriceFilterDialog(BuildContext context) async {
    RangeValues? newValues = await showDialog<RangeValues>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Price'),
          content: RangeSlider(
            values: selectedPriceRange,
            min: 0,
            max: 3000,
            onChanged: (RangeValues values) {
              setState(() {
                selectedPriceRange = values;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedPriceRange);
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );

    if (newValues != null) {
      setState(() {
        selectedPriceRange = newValues;
      });
    }
  }

  Future<void> _showBedsFilterDialog(BuildContext context) async {
    int? newBeds = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Beds'),
          content: DropdownButton<int>(
            value: selectedBeds,
            onChanged: (int? value) {
              setState(() {
                selectedBeds = value;
              });
            },
            items: List.generate(
              5,
              (index) => DropdownMenuItem<int>(
                value: index + 1,
                child: Text((index + 1).toString()),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedBeds);
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );

    if (newBeds != null) {
      setState(() {
        selectedBeds = newBeds;
      });
    }
  }

  Future<void> _handleSavedStateChange(DocumentReference apartmentRef, bool isSaved) async {
    DocumentSnapshot snapshot = await apartmentRef.get();

    await apartmentRef.update({'isSaved': !isSaved});

    setState(() {
      if (!isSaved) {
        savedApartments.add(snapshot.data() as Map<String, dynamic>);
      } else {
        savedApartments.remove(snapshot.data() as Map<String, dynamic>);
      }
    });
  }

  void _navigateToSavedScreen() async {
    List<Future<DocumentSnapshot>> futures = savedApartments
        .map((apartment) => apartmentsCollection.doc(apartment['id']).get())
        .toList();

    List<DocumentSnapshot> documentSnapshots = await Future.wait(futures);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedScreen(savedApartments: documentSnapshots),
      ),
    );
  }
}
