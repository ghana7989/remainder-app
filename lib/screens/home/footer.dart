import 'package:flutter/material.dart';

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
            onPressed: () {},
            child: Text("Add List"),
          ),
        ],
      ),
    );
  }
}
