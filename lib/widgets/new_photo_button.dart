import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastegram/screens/new_post_screen.dart';
import 'dart:io';

class newPhotoButton extends StatefulWidget {
  newPhotoButton({Key? key}) : super(key: key);

  @override
  _newPhotoButtonState createState() => _newPhotoButtonState();
}

class _newPhotoButtonState extends State<newPhotoButton> {
  late File imageFile;
  final picker = ImagePicker();

  Future<File> uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(pickedFile!.path);

    var filename = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    print(url);
    return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        var imageFile = await uploadImage();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewPostScreen(imageFile: imageFile)));
      },
      child: Icon(Icons.camera_alt),
    );
  }
}
