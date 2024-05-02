import 'package:flutter/material.dart';

class ApartmentSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> apartments;

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
    List<dynamic> searchResults = apartments
        .where((apartment) =>
            apartment['name'].toLowerCase().contains(query.toLowerCase()) ||
            apartment['location'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]['name']),
          subtitle: Text(searchResults[index]['location']),
          onTap: () {
            Navigator.pop(context, searchResults[index]);
          },
        );
      },
    );
  }
}
