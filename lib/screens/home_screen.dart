import 'package:flutter/material.dart';
import 'package:wastegram/widgets/new_photo_button.dart';

class homeScreen extends StatelessWidget {
  final String title;
  homeScreen({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wasteagram - 2'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 200,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: const Center(
                      child: Text('Entry A'),
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[500],
                    child: const Center(
                      child: Text('Entry B'),
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[100],
                    child: const Center(
                      child: Text('Entry C'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.all(55.0),
            child: Semantics(
              child: newPhotoButton(),
              button: true,
              enabled: true,
              label: 'Select a Photo',
            ),
          )
        ],
      ),
    );
  }
}
