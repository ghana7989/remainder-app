import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:reminder/common/widgets/category_icon.dart';

class AddReminderScreen extends StatefulWidget {
  AddReminderScreen({Key? key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _notesTextController = TextEditingController();
  String _title = "";
  String _notes = "";

  @override
  void initState() {
    super.initState();
    _titleTextController.addListener(() {
      setState(() {
        _title = _titleTextController.text;
      });
    });
    _notesTextController.addListener(() {
      setState(() {
        _notes = _notesTextController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
    _notesTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Reminder'),
        actions: [
          TextButton(
            onPressed: _title.isEmpty
                ? null
                : () {
                    print("add to DB");
                  },
            child: Text(
              'Add',
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                children: [
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _titleTextController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  SizedBox(
                    height: 100,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _notesTextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Notes",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  tileColor: Theme.of(context).cardColor,
                  leading: Text('List',
                      style: Theme.of(context).textTheme.headline6),
                  onTap: () {},
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                        bgColor: Colors.blueAccent,
                        iconData: Icons.calendar_today,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("New List"),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  tileColor: Theme.of(context).cardColor,
                  leading: Text('Category',
                      style: Theme.of(context).textTheme.headline6),
                  onTap: () {},
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CategoryIcon(
                        bgColor: Colors.blueAccent,
                        iconData: Icons.calendar_today,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Scheduled"),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
