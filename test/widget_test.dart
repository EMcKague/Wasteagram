import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastegram/models/entries.dart';
import 'dart:io';
import 'package:wastegram/screens/new_post_screen.dart';

void main() {
  test('Test creating a Post using preset values', () {
    final datePosted = Timestamp.now();
    const imageURL = 'TEST';
    const wastedItemCount = 50;
    const longitude = 111.0;
    const latitude = 232.0;

    Entry entry = Entry();

    entry.datePosted = datePosted;
    entry.imageURL = imageURL;
    entry.wastedItemCount = wastedItemCount;
    entry.longitude = longitude;
    entry.latitude = latitude;

    expect(entry.datePosted, datePosted);
    expect(entry.wastedItemCount, wastedItemCount);
    expect(entry.imageURL, imageURL);
    expect(entry.longitude, longitude);
    expect(entry.latitude, latitude);
  });

  test('Test passing arguments to the New Screen', () {
    final imageURL = 'test.com';
    final imageFile = File('');

    final newScreenArgs =
        NewPostScreen(imageURL: imageURL, imageFile: imageFile);

    expect(newScreenArgs.imageURL, imageURL);
    expect(newScreenArgs.imageFile, imageFile);
  });
}
