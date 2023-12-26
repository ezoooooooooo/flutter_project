// property_listing_card.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyListingCard extends StatelessWidget {
  final Map<String, dynamic> apartmentData;
  final bool? isSaved; // Add isSaved parameter
  final Function(bool?)? onSaved;

  PropertyListingCard({
    required this.apartmentData,
    this.isSaved,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            child: PageView.builder(
              itemCount: (apartmentData['images'] as List<dynamic>).length,
              itemBuilder: (context, index) {
                return Image.network(
                  (apartmentData['images'] as List<dynamic>)[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    isSaved ?? false ? Icons.favorite : Icons.favorite_border,
                    color: isSaved ?? false ? Colors.red : null,
                  ),
                  onPressed: () {
                    // Toggle the saved state
                    if (onSaved != null) {
                      onSaved!(isSaved ?? false);
                    }
                  },
                ),
                if (apartmentData['contactNumber'] != null)
                  ElevatedButton.icon(
                    onPressed: () => _launchPhoneCall(apartmentData['contactNumber']),
                    icon: Icon(Icons.phone),
                    label: Text('Call'),
                  ),
                Text(
                  apartmentData['name'] as String,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(apartmentData['location'] as String),
                SizedBox(height: 8),
                Text('Price: ${apartmentData['price'] as String}'),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.king_bed),
                    Text(' ${apartmentData['beds'].toString()}'),
                    SizedBox(width: 16),
                    Icon(Icons.square_foot),
                    Text(' ${apartmentData['space'] as String}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error
      print('Could not launch $url');
    }
  }
}
