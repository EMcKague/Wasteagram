import 'package:flutter/material.dart';
import 'package:wastegram/models/entries.dart';

class EntryDetails extends StatelessWidget {
  final Entry entry;

  EntryDetails({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Container(child: Image.network(entry.imageURL!)),
        ),
        Flexible(flex: 5, child: _getText()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
              'Location: ${entry.latitude.toString()}, ${entry.longitude.toString()}'),
        ),
      ],
    );
  }

  Widget _getText() {
    String text;
    if (entry.wastedItemCount! > 1) {
      text = 'items';
    } else {
      text = 'item';
    }
    return Text('${entry.wastedItemCount} ${text}');
  }
}
