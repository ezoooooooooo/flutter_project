// saved_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/property_listing_card.dart';

class SavedScreen extends StatefulWidget {
  final List<DocumentSnapshot> savedApartments;
  final Function(String, bool) onSavedStateChanged;

  SavedScreen({
    required this.savedApartments,
    required this.onSavedStateChanged,
  });

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Apartments'),
      ),
      body: widget.savedApartments.isEmpty
          ? Center(
              child: Text('No saved apartments.'),
            )
          : ListView.builder(
              itemCount: widget.savedApartments.length,
              itemBuilder: (context, index) {
                // Extract the apartment data from the document snapshot
                Map<String, dynamic> apartmentData = widget.savedApartments[index].data() as Map<String, dynamic>;

                return PropertyListingCard(
                  apartmentData: apartmentData,
                  isSaved: true,
                  onSaved: (isSaved) {
                    // Notify the parent widget about the save state change
                    widget.onSavedStateChanged(widget.savedApartments[index].id, isSaved ?? false);
                  },
                );
              },
            ),
    );
  }
}

