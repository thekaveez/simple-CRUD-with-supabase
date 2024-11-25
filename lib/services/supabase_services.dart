

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/todo_model.dart';

class SupabaseServices {

final database = Supabase.instance.client.from('todo');

  // Save todos to the database
  Future saveTodo(ToDo newTodo) async {
    await database.insert(newTodo.toMap());
  }

  // Get all todos from the database
  final stream = Supabase.instance.client.from('todo').stream(
    primaryKey: ['id'],
  ).map((data) => data.map((todoMap) => ToDo.fromMap(todoMap)).toList());

  // Update a todo in the database
  Future updateTodo(ToDo oldTodo, String updatedTodo) async {
    await database.update({'title': updatedTodo}).eq('id', oldTodo.id!);
  }

  // Delete a todo from the database
  Future deleteTodo(ToDo todo) async {
    await database.delete().eq('id', todo.id!);
  }
}