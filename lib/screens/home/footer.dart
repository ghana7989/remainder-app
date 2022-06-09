import 'package:flutter/material.dart';
import 'package:reminder/screens/add_list/add_list_screen.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            icon: Icon(Icons.add_circle),
            label: Text("New Reminder"),
            onPressed: () {},
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddListScreen(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Text("Add List"),
          ),
        ],
      ),
    );
  }
}
