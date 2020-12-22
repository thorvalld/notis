import 'package:flutter/material.dart';
import 'package:myNotes/add_note.dart';
import 'package:myNotes/models/note.dart';
import 'package:myNotes/utils/database_helper.dart';
import 'package:myNotes/widgets/note_item.dart';

ScrollController _scrollCtrl = new ScrollController();

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
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
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
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper.databaseHelper;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Note>>(
        future: databaseHelper.fetchAllNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              controller: _scrollCtrl,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return NoteItem(
                    snapshot.data[index].nid,
                    snapshot.data[index].title,
                    snapshot.data[index].description,
                    snapshot.data[index].timestamp,
                    snapshot.data[index].priority,
                    snapshot.data[index].isDone);
              },
            );
          } else {
            return Center(
              child: Text("LIST EMPTY"),
            );
          }
        },
      ),
    );
  }
}
