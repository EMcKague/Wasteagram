import 'package:flutter/material.dart';
import 'package:wastegram/models/entries.dart';
import 'package:wastegram/widgets/entry_details.dart';

class DetailScreen extends StatelessWidget {
  final Entry entry;

  DetailScreen({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Wasteagram - ${entry.wastedItemCount.toString()}"),
      ),
      body: EntryDetails(entry: entry),
    );
  }
}
