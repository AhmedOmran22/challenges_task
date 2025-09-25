import 'package:flutter/material.dart';

class DragDropView extends StatefulWidget {
  const DragDropView({super.key});

  @override
  State<DragDropView> createState() => _DragDropViewState();
}

class _DragDropViewState extends State<DragDropView> {
  final List<Color> colors = [Colors.red, Colors.green, Colors.yellow];

  final List<bool> accepted = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drag & Drop Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: List.generate(colors.length, (index) {
                return Draggable<Color>(
                  data: colors[index],
                  feedback: CircleAvatar(
                    radius: 30,
                    backgroundColor: colors[index],
                  ),
                  childWhenDragging: const SizedBox(width: 60, height: 60),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: colors[index],
                  ),
                );
              }),
            ),
            const SizedBox(height: 120),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(colors.length, (index) {
                return DragTarget<Color>(
                  onAcceptWithDetails: (ball) {
                    if (ball.data == colors[index]) {
                      setState(() {
                        accepted[index] = true;
                      });
                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: colors[index].withValues(alpha: 0.5),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: accepted[index]
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 40,
                              )
                            : const SizedBox(),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
