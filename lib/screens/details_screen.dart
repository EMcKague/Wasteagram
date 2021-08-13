import 'package:flutter/material.dart';
import 'package:wastegram/models/entries.dart';
import 'package:wastegram/widgets/entry_details.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final Entry entry;

  DetailScreen({Key? key, required this.title, required this.entry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${title} - ${entry.wastedItemCount.toString()}"),
      ),
      body: EntryDetails(entry: entry),
    );
  }
}
