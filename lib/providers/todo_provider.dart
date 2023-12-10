import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';

final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);
  void addTodo(String content) {
    state = [
      ...state,
      Todo(
          completed: false,
          content: content,
          todoId: state.isEmpty ? 0 : state.length + 1),
    ];
  }

  void completeTodo(int todoId) {
    state = [
      for (final todo in state)
        if (todo.todoId == todoId)
          Todo(todoId: todo.todoId, content: todo.content, completed: true)
        else
          todo
    ];
  }

  void deleteTodo(Todo todo) {
    state = state.where((element) => element.todoId != todo.todoId).toList();
  }
}
