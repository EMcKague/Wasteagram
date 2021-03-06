import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Entry {
  Timestamp? datePosted;
  String? imageURL;
  double? latitude;
  double? longitude;
  int? wastedItemCount;

  Entry(
      {this.datePosted,
      this.imageURL,
      this.latitude,
      this.longitude,
      this.wastedItemCount});

  Entry.fromMap(Map entry) {
    this.datePosted = entry['datePosted'];
    this.imageURL = entry['imageURL'];
    this.latitude = entry['latitude'];
    this.longitude = entry['longitude'];
    this.wastedItemCount = entry['wastedItemCount'];
  }

  String get timeSinceEntry {
    return DateFormat('EEEE, MMMM d, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(datePosted!.seconds * 1000))
        .toString();
  }
}
