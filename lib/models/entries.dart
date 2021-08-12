import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Entry {
  Timestamp? datePosted;
  String? imageURL;
  double? latitude;
  double? longitude;
  int? wastedItemsCount;

  // Entry(
  //     {required this.datePosted,
  //     required this.imageURL,
  //     required this.latitude,
  //     required this.longitude,
  //     required this.wastedItemsCount});

  Entry.fromMap(Map entry) {
    // return Entry.fromMap({
    this.datePosted = entry[datePosted];
    this.imageURL = entry[imageURL];
    this.latitude = entry[latitude];
    this.longitude = entry[longitude];
    this.wastedItemsCount = entry[wastedItemsCount];
    // )};
  }

  String get timeSinceEntry {
    return DateFormat('EEEE, MMMM d, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(datePosted!.seconds * 1000))
        .toString();
  }
}
