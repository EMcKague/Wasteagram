import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:wasteagram/models/entries.dart';
import 'package:wastegram/models/entries.dart';
import 'package:wastegram/screens/home_screen.dart';

class PostsList extends StatefulWidget {
  final String title;
  PostsList({Key? key, required this.title}) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<PostsList> {
  final Stream<QuerySnapshot> _postsStream = FirebaseFirestore.instance
      .collection('wastePosts')
      .orderBy('datePosted', descending: true)
      .snapshots();
  // Entry _currentEntry = Entry();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _postsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // bool snapshots_available = snapshot.hasData && snapshot.data!.exists;
        if (snapshot.hasError) {
          return Text("something went wrong");
        }
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return _postList(snapshot: snapshot);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _postList({required AsyncSnapshot snapshot}) {
    return Expanded(
        child: SizedBox(
            child: ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return _postEntry(context, _buildEntry(snapshot.data.documents[index]));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: snapshot.data.documents.length,
    )));
  }

  Entry _buildEntry(DocumentSnapshot document) {
    return Entry.fromMap({
      'datePosted': document['date_posted'],
      'wastedItemCount': document['count'],
      'latitude': document['latitude'],
      'longitude': document['longitude'],
      'imageURL': document['image_url']
    });
  }

  Widget _postEntry(BuildContext context, Entry entry) {
    return Semantics(
      button: false,
      child: _entryTile(context, entry),
      label:
          "List element of a wasteagram post made on ${entry.timeSinceEntry}",
    );
  }

  Widget _entryTile(BuildContext context, Entry entry) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              entry.timeSinceEntry,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              entry.wastedItemsCount.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homeScreen(
              title: 'should be detail screen',
            ),
          ),
        );
      },
    );
  }
}
