import 'package:flutter/material.dart';

class NoteItem extends StatefulWidget {
  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
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
                  "LORUM IPSUM",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  DateTime.now().toString().substring(0, 10),
                  style: TextStyle(fontWeight: FontWeight.w300),
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
                "Lorem aliquip cillum ex consequat aliquip. Elit consectetur fugiat quis sunt enim sint. Elit aliquip eiusmod labore adipisicing proident eiusmod in adipisicing nostrud laborum magna. Officia consectetur cillum ut magna non reprehenderit minim nulla magna occaecat ad est Lorem ad."),
            SizedBox(height: 18.0),
            GestureDetector(
              onTap: () {
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
