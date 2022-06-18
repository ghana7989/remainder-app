import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/category/category.dart';
import 'package:reminder/models/reminder/reminder.dart';
import 'package:reminder/screens/view_list/view_list_by_category_screen.dart';

class GridViewItems extends StatelessWidget {
  const GridViewItems({
    Key? key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 16 / 9,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: categories
          .map(
            (category) => InkWell(
              onTap: getCategoryCount(category.id, allReminders) > 0
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => ViewListByCategoryScreen(
                                category: category,
                              )),
                        ),
                      );
                    }
                  : null,
              child: Ink(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xDD1A191d),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            category.icon,
                            Text(
                              getCategoryCount(category.id, allReminders)
                                  .toString(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        Text(
                          category.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

int getCategoryCount(id, List<Reminder> allReminders) {
  if (id == "all") {
    return allReminders.length;
  }
  final categories = allReminders.where((element) => element.categoryId == id);

  return categories.length;
}
