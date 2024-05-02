import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class AddApartmentScreen extends StatefulWidget {
  @override
  _AddApartmentScreenState createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _bedsController = TextEditingController();
  final TextEditingController _spaceController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _image; // Variable to store the selected image

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}

  // Function to add an apartment
  Future<void> _addApartment() async {
    String name = _nameController.text;
    String location = _locationController.text;
    String price = _priceController.text;
    String beds = _bedsController.text;
    String space = _spaceController.text;
    String phoneNumber = _phoneNumberController.text;

    if (name.isEmpty || location.isEmpty || price.isEmpty || beds.isEmpty || space.isEmpty || phoneNumber.isEmpty) {
      _showErrorMessage('Please fill in all fields');
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://localhost:3000/api/apartments/add'));
      request.fields['name'] = name;
      request.fields['location'] = location;
      request.fields['price'] = price;
      request.fields['beds'] = beds;
      request.fields['space'] = space;
      request.fields['phoneNumber'] = phoneNumber;

      if (_image != null) {
        request.files.add(http.MultipartFile('image', _image!.readAsBytes().asStream(), _image!.lengthSync(), filename: _image!.path.split('/').last));
      }

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 201) {
        _showSuccessMessage('Apartment added successfully');
      } else {
        _showErrorMessage('Failed to add apartment: ${response.body}');
      }
    } catch (e) {
      _showErrorMessage('Failed to add apartment: $e');
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Apartment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _bedsController,
              decoration: InputDecoration(labelText: 'Beds'),
            ),
            TextField(
              controller: _spaceController,
              decoration: InputDecoration(labelText: 'Space'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            _image == null
                ? ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Select Image'),
                  )
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addApartment,
              child: Text('Add Apartment'),
            ),
          ],
        ),
      ),
    );
  }
}
