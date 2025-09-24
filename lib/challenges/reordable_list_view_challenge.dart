import 'package:flutter/material.dart';

class ReordableListViewChallenge extends StatefulWidget {
  const ReordableListViewChallenge({super.key});

  @override
  State<ReordableListViewChallenge> createState() => _ReordableListViewChallengeState();
}

class _ReordableListViewChallengeState extends State<ReordableListViewChallenge> {
  List<String> items = List.generate(10, (index) => "Item ${index + 1}");

  String? _removedItem;
  int? _removedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reordable ListView Challenge")),
      body: ReorderableListView.builder(
        itemCount: items.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: ValueKey(item),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                _removedItem = items[index];
                _removedIndex = index;
                items.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Deleted $_removedItem"),
                  action: SnackBarAction(
                    label: "Undo",
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (_removedItem != null && _removedIndex != null) {
                          items.insert(_removedIndex!, _removedItem!);
                        }
                      });
                    },
                  ),
                ),
              );
            },
            child: ListTile(
              key: ValueKey(item),
              trailing: ReorderableDragStartListener(
                index: index,
                child: const Icon(Icons.drag_handle),
              ),

              title: Text(item),
            ),
          );
        },
      ),
    );
  }
}
