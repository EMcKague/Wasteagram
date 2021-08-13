import 'package:flutter/material.dart';
import 'package:wastegram/models/entries.dart';

class EntryDetails extends StatelessWidget {
  final Entry entry;

  EntryDetails({Key? key, required this.entry}) : super(key: key);

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
        // need to add longitude and latitude
      ],
    );
  }
}
