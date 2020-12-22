import 'package:flutter/material.dart';
import 'package:myNotes/utils/database_helper.dart';

class NoteItem extends StatefulWidget {
  final int id, priority, status;
  final String title, desc, createdAt;
  NoteItem(this.id, this.title, this.desc, this.createdAt, this.priority,
      this.status);
  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  DatabaseHelper databaseHelper;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper.databaseHelper;
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = widget.status == 0 ? false : true;
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 3.0),
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 12.0,
                  width: 12.0,
                  decoration: BoxDecoration(
                      color: Colors.orange, shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  '${widget.title}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  '${widget.createdAt}',
                  style: TextStyle(fontWeight: FontWeight.w300),
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Text('${widget.desc}'),
            SizedBox(height: 18.0),
            GestureDetector(
              onTap: () {
                isCompleted
                    ? databaseHelper.setAsDone(widget.status)
                    : databaseHelper.setAsInProgress(widget.status);
                setState(() {
                  isCompleted = !isCompleted;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isCompleted == true
                      ? Icon(
                          Icons.check_box_rounded,
                          color: Colors.green[400],
                        )
                      : Icon(
                          Icons.check_box_rounded,
                          color: Colors.red[400],
                        ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    isCompleted == true
                        ? "Task completed."
                        : "Task still in progress",
                    style: TextStyle(
                        color:
                            isCompleted ? Colors.green[400] : Colors.red[400]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
