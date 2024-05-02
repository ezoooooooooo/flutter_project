import 'package:flutter/material.dart';
import '../models/apartment.dart'; // Import the Apartment model

class ApartmentDetailsScreen extends StatelessWidget {
  final Apartment apartment; // Update the type to Apartment

  ApartmentDetailsScreen({required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apartment Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${apartment.name}'), // Access properties directly
            Text('Location: ${apartment.location}'),
            Text('Price: ${apartment.price}'),
            Text('Beds: ${apartment.beds}'),
            Text('Space: ${apartment.space}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
