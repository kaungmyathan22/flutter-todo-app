import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/add_page.dart';
import 'package:todo_app/providers/todo_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo app"),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Slidable(
              child: ListTile(title: Text(todos[index].content)),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      ref.watch(todoProvider.notifier).deleteTodo(todos[index]);
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  )
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      ref.watch(todoProvider.notifier).completeTodo(index);
                    },
                    icon: Icons.check,
                    backgroundColor: Colors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
