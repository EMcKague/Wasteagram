import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:location/location.dart';
import 'package:wastegram/models/entries.dart';
import 'package:wastegram/screens/home_screen.dart';

class NewPostScreen extends StatefulWidget {
  final File imageFile;
  NewPostScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();
  final entry = Entry();
  late LocationData locationData;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  Future _getLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    entry.latitude = locationData.latitude;
    entry.longitude = locationData.longitude;
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
      body: FutureBuilder(
        future: _getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
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
            );
          }
        },
      ),
    );
  }

  Widget _displayImage() {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 300, maxWidth: 350),
        child: Image.file(widget.imageFile),
      ),
    );
  }

  Widget wastedForm() {
    return Form(
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
          onSaved: (value) {},
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter a Number';
            }
          },
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _upload_image_button() {
    return Semantics(
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
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => homeScreen(title: 'Wasteagram')),
                    (route) => false);
              }
            },
          ),
        ),
      ),
    );
  }
}
