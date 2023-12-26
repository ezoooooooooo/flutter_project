// custom_search_delegate.dart
// custom_search_delegate.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/property_listing_card.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final CollectionReference apartmentsCollection =
      FirebaseFirestore.instance.collection('housing');
  final RangeValues selectedPriceRange;
  final int? selectedBeds;

  CustomSearchDelegate({required this.selectedPriceRange, required this.selectedBeds});

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
    return _buildFilteredResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildFilteredResults();
  }

  Widget _buildFilteredResults() {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: _getFilteredApartments(query, selectedPriceRange, selectedBeds),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<DocumentSnapshot>? apartments = snapshot.data;

        if (apartments == null || apartments.isEmpty) {
          return Text('No apartments found.');
        }

        return ListView.builder(
          itemCount: apartments.length,
          itemBuilder: (context, index) {
            return PropertyListingCard(
              apartmentData: apartments[index].data() as Map<String, dynamic>,
              // Pass isSaved based on the saved state in Firestore
              isSaved: apartments[index]['isSaved'] ?? false,
              onSaved: (isSaved) async {
                // Update the saved state in the Firestore collection
                await apartmentsCollection
                    .doc(apartments[index].id)
                    .update({'isSaved': isSaved});
              },
            );
          },
        );
      },
    );
  }

  Future<List<DocumentSnapshot>> _getFilteredApartments(String location, RangeValues priceRange, int? beds) async {
    Query query = apartmentsCollection;

    // Apply filters
    if (location.isNotEmpty) {
      query = query.where('location', isEqualTo: location);
    }

    if (beds != null) {
      query = query.where('beds', isEqualTo: beds);
    }

    if (priceRange.end < 2000) {
      query = query.where('price', isGreaterThanOrEqualTo: priceRange.start);
      query = query.where('price', isLessThanOrEqualTo: priceRange.end);
    }

    final QuerySnapshot snapshot = await query.get();
    return snapshot.docs;
  }
}
