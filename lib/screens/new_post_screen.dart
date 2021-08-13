import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:location/location.dart';

class NewPostScreen extends StatefulWidget {
  final String imageURL;
  final File imageFile;
  NewPostScreen({Key? key, required this.imageURL, required this.imageFile})
      : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPostScreen> {
  late double? latitude;
  late double? longitude;
  late int? wastedItemCount;
  late LocationData locationData;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  Future _getLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;
    print('${latitude} ${longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Post',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 10,
            child: _displayImage(),
          ),
          Flexible(
            flex: 3,
            child: wastedForm(),
          ),
          Flexible(
            flex: 3,
            child: _upload_image_button(),
          ),
        ],
      ),
    );
  }

  Widget _displayImage() {
    return Semantics(
      label: 'photo selecetd for wasteagram',
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 300, maxWidth: 350),
          child: Image.file(widget.imageFile),
        ),
      ),
    );
  }

  Widget wastedForm() {
    return Semantics(
      label: 'Enter the number of wasted items',
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Number of items wasted'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9]'),
              ),
            ],
            onSaved: (value) {
              wastedItemCount = int.parse(value!);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a number that reflects the number of wasted items';
              }
            },
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _upload_image_button() {
    return Semantics(
      label: 'Submit wasteagram button',
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: ElevatedButton(
            child: Icon(Icons.upload),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                // submit the post
                FirebaseFirestore.instance.collection("wastePosts").add({
                  'imageURL': widget.imageURL,
                  'datePosted': Timestamp.now(),
                  'latitude': latitude,
                  'longitude': longitude,
                  'wastedItemCount': wastedItemCount
                });
                Navigator.pushNamed(context, 'homeScreen');
              }
            },
          ),
        ),
      ),
    );
  }
}
