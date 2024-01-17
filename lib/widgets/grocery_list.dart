import 'package:flutter/material.dart';

import 'package:handling_user_inputs/models/grocery_item.dart';
import 'package:handling_user_inputs/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> groceryItems = [];

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("Nothing to show.... try adding items"),
    );

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (context, index) => Dismissible(
                key: ValueKey(groceryItems[index].id),
                onDismissed: (direction) {
                  setState(() {
                    groceryItems.remove(groceryItems[index]);
                  });
                },
                child: ListTile(
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: groceryItems[index].category.color,
                  ),
                  title: Text(groceryItems[index].name),
                  trailing: Text(
                    groceryItems[index].quantity.toString(),
                  ),
                ),
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Groceries',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var item = await Navigator.of(context).push<GroceryItem>(
                MaterialPageRoute(
                  builder: (ctx) => const NewItem(),
                ),
              );

              setState(() {
                groceryItems.add(item!);
              });
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: content,
    );
  }
}
