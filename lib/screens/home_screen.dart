import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/osama.jpg'), // Replace with your image
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),

            // Featured Listings
            Text(
              'Featured Listings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Placeholder: List of featured listing widgets
            SizedBox(height: 150),
            // Add a carousel or grid view for featured listings

            SizedBox(height: 20),

            // Categories
            Text(
              'Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Placeholder: List of category widgets
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCard('Studio', Icons.apartment, Colors.blue,
                      () {
                    // Add logic for Studio category
                    print('Studio category pressed');
                  }),
                  _buildCategoryCard('1 Bedroom', Icons.apartment, Colors.green,
                      () {
                    // Add logic for 1 Bedroom category
                    print('1 Bedroom category pressed');
                  }),
                  _buildCategoryCard(
                      '2 Bedrooms', Icons.apartment, Colors.orange, () {
                    // Add logic for 2 Bedrooms category
                    print('2 Bedrooms category pressed');
                  }),
                  _buildCategoryCard('Shared', Icons.people, Colors.purple, () {
                    // Add logic for Shared category
                    print('Shared category pressed');
                  }),
                ],
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
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search for housing...',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // User Preferences & Services
            Text(
              'Preferences & Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Placeholder: List of preference and service widgets
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPreferenceCard('Furnished', Icons.home, Colors.red, () {
                    // Add logic for Furnished preference
                    print('Furnished preference pressed');
                  }),
                  _buildPreferenceCard(
                      'Utilities Included', Icons.light, Colors.yellow, () {
                    // Add logic for Utilities Included preference
                    print('Utilities Included preference pressed');
                  }),
                  _buildPreferenceCard('Pet Friendly', Icons.pets, Colors.teal,
                      () {
                    // Add logic for Pet Friendly preference
                    print('Pet Friendly preference pressed');
                  }),
                  _buildPreferenceCard(
                      'Parking', Icons.local_parking, Colors.pink, () {
                    // Add logic for Parking preference
                    print('Parking preference pressed');
                  }),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Nearby Experiences
            Text(
              'Nearby Experiences',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Placeholder: Horizontal scrollable list of experience widgets
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildExperienceCard(
                      'Local Restaurants', Icons.restaurant, Colors.blue, () {
                    // Add logic for Local Restaurants experience
                    print('Local Restaurants experience pressed');
                  }),
                  _buildExperienceCard('Parks', Icons.park, Colors.green, () {
                    // Add logic for Parks experience
                    print('Parks experience pressed');
                  }),
                  _buildExperienceCard(
                      'Gyms', Icons.fitness_center, Colors.orange, () {
                    // Add logic for Gyms experience
                    print('Gyms experience pressed');
                  }),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Recommended for You
            Text(
              'Recommended for You',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Placeholder: Grid or carousel of recommended widgets
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildRecommendedCard('Modern Studio Apartment', '\$1200',
                      'assets/apartment1.jpg', Colors.purple, () {
                    // Add logic for Modern Studio Apartment recommendation
                    print('Modern Studio Apartment recommendation pressed');
                  }),
                  _buildRecommendedCard('Cozy 1 Bedroom', '\$1500',
                      'assets/apartment2.jpg', Colors.orange, () {
                    // Add logic for Cozy 1 Bedroom recommendation
                    print('Cozy 1 Bedroom recommendation pressed');
                  }),
                  _buildRecommendedCard('Spacious 2 Bedrooms', '\$2000',
                      'assets/apartment3.jpg', Colors.blue, () {
                    // Add logic for Spacious 2 Bedrooms recommendation
                    print('Spacious 2 Bedrooms recommendation pressed');
                  }),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Explore Listings Button
            ElevatedButton(
              onPressed: () {
                // Add logic for exploring listings
                print('Explore Listings button pressed');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Replace with your preferred color
              ),
              child: Text('Explore Listings'),
            ),
            SizedBox(height: 20),

            // Preferences & Services Button
            ElevatedButton(
              onPressed: () {
                // Add logic for user preferences and services
                print('Preferences & Services button pressed');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Replace with your preferred color
              ),
              child: Text('Preferences & Services'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      String title, IconData icon, Color color, VoidCallback onPressed) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(height: 8),
              Text(title, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceCard(
      String title, IconData icon, Color color, VoidCallback onPressed) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(height: 8),
              Text(title, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceCard(
      String title, IconData icon, Color color, VoidCallback onPressed) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(height: 8),
              Text(title, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedCard(String title, String price, String imagePath,
      Color color, VoidCallback onPressed) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Price: $price',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
