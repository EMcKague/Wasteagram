import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wastegram/models/entries.dart';
import 'package:wastegram/screens/details_screen.dart';

class PostsList extends StatefulWidget {
  // final String title;
  PostsList({
    Key? key,
    // required this.title
  }) : super(key: key);

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<PostsList> {
  final Stream<QuerySnapshot> _postsStream = FirebaseFirestore.instance
      .collection('wastePosts')
      .orderBy('datePosted', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _postsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.length > 0) {
          return _postList(snapshot: snapshot);
        }
        return Center(
          child: Padding(
            padding: EdgeInsets.all(175),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _postList({required AsyncSnapshot snapshot}) {
    return Expanded(
      child: SizedBox(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            return _postEntry(context, _buildEntry(snapshot.data.docs[index]));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: snapshot.data.docs.length,
        ),
      ),
    );
  }

  Entry _buildEntry(DocumentSnapshot document) {
    return Entry.fromMap(
      {
        'datePosted': document['datePosted'],
        'wastedItemCount': document['wastedItemCount'],
        'latitude': document['latitude'],
        'longitude': document['longitude'],
        'imageURL': document['imageURL']
      },
    );
  }

  Widget _postEntry(BuildContext context, Entry entry) {
    // print("here is the entry: ${entry}");
    return Semantics(
      label: 'a entry in wasteagram made on ${entry.datePosted}',
      button: false,
      child: _entryTile(context, entry),
    );
  }

  Widget _entryTile(BuildContext context, Entry entry) {
    print("Number of wasted items = ${entry.wastedItemCount}");
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              entry.timeSinceEntry,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              entry.wastedItemCount.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              entry: entry,
            ),
          ),
        );
      },
    );
  }
}
