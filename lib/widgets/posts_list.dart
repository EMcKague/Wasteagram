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
          if (snapshot.hasData && snapshot.data!.docs.length > 0) {
            return _postList(snapshot: snapshot);
          }
          return Center(child: CircularProgressIndicator());
        }

        // bool snapshots_available = snapshot.hasData && snapshot.data!.exists;
        // if (snapshot.hasError) {
        //   return Text("something went wrong");
        // }
        // if (snapshot.hasData) {
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return CircularProgressIndicator();
        //   }
        //   return _postList(snapshot: snapshot);
        // }
        // return CircularProgressIndicator();
        );
  }

  Widget _postList({required AsyncSnapshot snapshot}) {
    print(
        "The snapshot timestamp here:  ${snapshot.data!.docs[0].get('datePosted')}\n"
        'The snapshot number of wasted items: ${snapshot.data!.docs[0].get('wastedItemCount')}\n');
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
    return Entry.fromMap({
      'datePosted': document['datePosted'],
      'wastedItemCount': document['wastedItemCount'],
      'latitude': document['latitude'],
      'longitude': document['longitude'],
      'imageURL': document['imageURL']
    });
  }

  Widget _postEntry(BuildContext context, Entry entry) {
    print("here is the entry: ${entry}");
    return Semantics(
      button: false,
      child: _entryTile(context, entry),
      label: "a better label shoudl be here",
      // "List element of a wasteagram post made on ${entry.timeSinceEntry}",
    );
  }

  Widget _entryTile(BuildContext context, Entry entry) {
    print("Number of wasted items = ${entry.wastedItemCount}");
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              // 'some time',
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
            builder: (context) => homeScreen(
              title: 'should be detail screen',
            ),
          ),
        );
      },
    );
  }
}
