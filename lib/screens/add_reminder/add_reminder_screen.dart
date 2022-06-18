import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/common/widgets/category_icon.dart';
import 'package:reminder/models/category/category.dart';
import 'package:reminder/models/category/category_collection.dart';
import 'package:reminder/models/reminder/reminder.dart';
import 'package:reminder/models/todo_list/todo_list.dart';
import 'package:reminder/screens/add_reminder/select_reminder_category_screen.dart';
import 'package:reminder/screens/add_reminder/select_reminder_screen.dart';
import 'package:reminder/services/db_service.dart';

class AddReminderScreen extends StatefulWidget {
  AddReminderScreen({Key? key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _notesTextController = TextEditingController();
  TodoList? _selectedList;
  Category _selectedCategory = CategoryCollection().categories.first;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

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

  void _updateSelectedList(TodoList? list) {
    setState(() {
      _selectedList = list;
    });
  }

  void _updateSelectedCategory(Category category) {
    setState(() {
      _selectedCategory = category;
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
    final _todoLists = Provider.of<List<TodoList>>(context);
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('New Reminder'),
        actions: [
          TextButton(
            onPressed:
                _title.isEmpty || _selectedDate == null || _selectedTime == null
                    ? null
                    : () async {
                        _selectedList ??= _todoLists.first;
                        var newReminder = Reminder(
                          id: null,
                          title: _title,
                          notes: _notes,
                          categoryId: _selectedCategory.id,
                          dueDate: _selectedDate!.millisecondsSinceEpoch,
                          list: _selectedList!.toJson(),
                          dueTime: {
                            "hour": _selectedTime!.hour,
                            "minute": _selectedTime!.minute,
                          },
                        );
                        try {
                          await DbService(uid: user.uid)
                              .addReminder(reminder: newReminder);
                        } catch (e) {
                          print(e);
                        }
                        Navigator.pop(context);
                      },
            child: Text(
              'Add',
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectReminderListScreen(
                            onSelectList: _updateSelectedList,
                            selectedList: _selectedList ?? _todoLists.first,
                            todoLists: _todoLists,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
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
                        Text(_selectedList?.title ?? _todoLists.first.title),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectReminderCategoryScreen(
                            onSelectCategory: _updateSelectedCategory,
                            selectedCategory: _selectedCategory,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CategoryIcon(
                          bgColor: _selectedCategory.icon.bgColor,
                          iconData: _selectedCategory.icon.iconData,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(_selectedCategory.name),
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
                    leading: Text('Date',
                        style: Theme.of(context).textTheme.headline6),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      ).then((date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      });
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CategoryIcon(
                          bgColor: Colors.red.shade300,
                          iconData: CupertinoIcons.calendar_badge_plus,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(_selectedDate != null
                            ? DateFormat.yMMMMd()
                                .format(_selectedDate!)
                                .toString()
                            : "Select Date"),
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
                    leading: Text(
                      'Time',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((time) {
                        setState(() {
                          _selectedTime = time;
                        });
                      });
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CategoryIcon(
                          bgColor: Colors.red.shade300,
                          iconData: CupertinoIcons.time,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _selectedTime != null
                              ? _selectedTime!.format(context).toString()
                              : "Select Time",
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
