import 'package:flutter/material.dart';
import 'package:wastegram/screens/new_post_screen.dart';

class newPhotoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewPostScreen()));
      },
      child: Icon(Icons.camera_alt),
    );
  }
}
