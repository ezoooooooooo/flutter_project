import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> halls = [];

  void filterHalls(String query) {
    _firestore
        .collection('halls')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          halls = snapshot.docs;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Housing App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add logic for search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Add logic for user profile or account
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    // Add user profile image here
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Add logic for settings page
                Navigator.pop(context);
                // Navigate to settings page
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                // Add logic for logout
                Navigator.pop(context);
                // Implement logout functionality
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('halls').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          if (halls.isEmpty) {
            halls = snapshot.data!.docs;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cover Photo
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/osama.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 20),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (query) {
                      filterHalls(query);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search for housing...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Hall Posts
                Text(
                  'Featured Halls',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8, // Adjusted the aspect ratio
                  ),
                  itemCount: halls.length,
                  itemBuilder: (context, index) {
                    var hall = halls[index].data() as Map<String, dynamic>;

                    return _buildHallCard(
                      context,
                      hall['name'] as String? ?? '',
                      hall['price'] as String? ?? '',
                      hall['location'] as String? ?? '',
                      hall['capacity'] as int? ?? 0,
                      hall['image'] as String? ?? '',
                      index,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHallCard(
    BuildContext context,
    String name,
    String price,
    String location,
    int capacity,
    String imageName,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        // Add logic for handling tap on the hall
        print('Tapped on hall: $name');
        // Navigate to hall details page or perform other actions
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.primaries[index % Colors.primaries.length],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Container(
                  height: 80, // Adjusted the height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/$imageName.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Price: $price',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Location: $location',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Capacity: $capacity',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
