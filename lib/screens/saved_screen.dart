// saved_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/property_listing_card.dart';

class SavedScreen extends StatelessWidget {
  final List<DocumentSnapshot> savedApartments;

  SavedScreen({required this.savedApartments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Apartments'),
      ),
      body: savedApartments.isEmpty
          ? Center(
              child: Text('No saved apartments.'),
            )
          : ListView.builder(
              itemCount: savedApartments.length,
              itemBuilder: (context, index) {
                return PropertyListingCard(
                  apartmentData: savedApartments[index].data() as Map<String, dynamic>,
                  isSaved: true,
                  onSaved: (isSaved) {
                    // Handle saving state changes if needed
                  },
                );
              },
            ),
    );
  }
}
