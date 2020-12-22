import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myNotes/main_screen.dart';
import 'package:myNotes/models/note.dart';
import 'package:myNotes/utils/database_helper.dart';

Color lightGray = Color(0XFFe6e6e6);
TextEditingController titleCtrl = new TextEditingController();
TextEditingController descCtrl = new TextEditingController();
TextEditingController priorityCtrl = new TextEditingController();

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        primary: true,
        title: Text("ADD NOTE"),
        elevation: 4.0,
        backgroundColor: Colors.indigo,
        leading: null,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.all(14.0),
        height: MediaQuery.of(context).size.height,
        child: SafeArea(child: AddNotesBody()),
      ),
    );
  }
}

class AddNotesBody extends StatefulWidget {
  @override
  _AddNotesBodyState createState() => _AddNotesBodyState();
}

class _AddNotesBodyState extends State<AddNotesBody> {
  DatabaseHelper databaseHelper;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper.databaseHelper;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Material(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: lightGray,
          child: TextField(
            controller: titleCtrl,
            cursorColor: Colors.indigo,
            maxLines: 1,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                border: InputBorder.none,
                hintText: "Title",
                prefix: Icon(
                  Icons.title,
                  color: Colors.indigo,
                )),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: lightGray,
          child: TextField(
            controller: descCtrl,
            cursorColor: Colors.indigo,
            maxLines: 10,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              border: InputBorder.none,
              hintText: "Description",
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: lightGray,
          child: TextField(
            controller: priorityCtrl,
            cursorColor: Colors.indigo,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              border: InputBorder.none,
              hintText: "Level of priority (1-5)",
            ),
          ),
        ),
        SizedBox(
          height: 22.0,
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                  child: CupertinoButton(
                      color: Colors.indigo,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "ADD NOTE",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        int p = int.parse(priorityCtrl.text.toString());
                        String ca = DateTime.now().toString().substring(0, 10);
                        Note newNote = new Note(
                            title: titleCtrl.text.toString(),
                            description: descCtrl.text.toString(),
                            timestamp: ca,
                            priority: p,
                            isDone: 0);
                        databaseHelper.insertNote(newNote);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      }))
            ],
          ),
        )
      ],
    );
  }
}
