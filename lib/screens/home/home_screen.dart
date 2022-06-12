import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reminder/models/category/category_collection.dart';
import 'package:reminder/screens/auth/authenticate_screen.dart';
import 'package:reminder/screens/home/footer.dart';
import 'package:reminder/screens/home/grid_view_items.dart';
import 'package:reminder/screens/home/list_view_items.dart';
import 'package:reminder/screens/home/todo_lists.dart';
import 'package:reminder/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum LayoutType {
  grid,
  list,
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryCollection categoryCollection = CategoryCollection();

  String layoutType = LayoutType.grid.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
          TextButton(
            onPressed: () {
              if (layoutType == LayoutType.grid.toString()) {
                setState(() {
                  layoutType = LayoutType.list.toString();
                });
              } else {
                setState(() {
                  layoutType = LayoutType.grid.toString();
                });
              }
            },
            child: Text(
              layoutType == LayoutType.grid.toString() ? "Edit" : 'Done',
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  AnimatedCrossFade(
                    firstChild: GridViewItems(
                      categories: categoryCollection.selectedCategories,
                    ),
                    secondChild:
                        ListViewItems(categoryCollection: categoryCollection),
                    crossFadeState: layoutType == LayoutType.grid.toString()
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 300),
                  ),
                  TodoLists(),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
