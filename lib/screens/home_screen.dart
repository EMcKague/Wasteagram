import 'package:flutter/material.dart';
import 'package:wastegram/widgets/new_photo_button.dart';

class homeScreen extends StatelessWidget {
  final String title;

  homeScreen({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'G',
      'K',
      'L'
    ];
    final List<int> colorCodes = <int>[
      600,
      500,
      400,
      300,
      600,
      500,
      400,
      300,
      600,
      500,
      400,
      300,
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wasteagram - 2'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colors.green[colorCodes[index]],
                    child: Center(child: Text('Entry ${entries[index]}')),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: Semantics(
              child: newPhotoButton(),
              button: true,
              enabled: true,
              label: 'Select a Photo',
            ),
          )
        ],
      ),
    );
  }
}
