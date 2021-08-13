import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastegram/models/entries.dart';

class EntryDetails extends StatelessWidget {
  final Entry entry;

  EntryDetails({Key? key, required this.entry}) : super(key: key);

  // XFile? image;

  // Future getImage() async {
  //   image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   StorageReference storageReference =
  //       FirebaseStorage.instance.ref().child(DateTime.now().toString());
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.85;
    double width = MediaQuery.of(context).size.width * 0.90;
    var url = entry.imageURL;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 10,
          child: Text(entry.timeSinceEntry),
        ),
        Flexible(
          flex: 10,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height, maxWidth: width),
            child: Image.network(url!),
          ),
        )
      ],
    );
  }
}
