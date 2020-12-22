import 'package:flutter/material.dart';
import 'package:myNotes/widgets/note_item.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        primary: true,
        title: Text("MY NOTES"),
        elevation: 4.0,
        backgroundColor: Colors.indigo,
        leading: null,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.all(14.0),
        height: MediaQuery.of(context).size.height,
        child: SafeArea(child: NotesList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        NoteItem(),
      ],
    );
  }
}
