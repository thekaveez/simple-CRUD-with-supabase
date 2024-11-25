import 'package:flutter/material.dart';
import 'package:todo_with_superbase/services/supabase_services.dart';

import '../models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final todoController = TextEditingController();

  final todoDatabase = SupabaseServices();



  void addTodo({required bool isUpdate, ToDo? todo}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('${isUpdate ? 'Update' : 'Add '} Todo'),
              content: TextField(
                controller: todoController,
                decoration: const InputDecoration(hintText: 'Enter your todo'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      final newTodo = ToDo(title: todoController.text);
                      if(isUpdate){
                        todoDatabase.updateTodo(todo!, todoController.text);
                        Navigator.pop(context);
                        todoController.clear();
                      } else {
                        todoDatabase.saveTodo(newTodo);
                        Navigator.pop(context);
                        todoController.clear();
                      }

                    },
                    child: Text(isUpdate ? 'Update' : 'Add')
                )
              ],
            ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo(isUpdate: false);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: StreamBuilder(
            stream: todoDatabase.stream,
            builder: (context, snapshot){
              if(snapshot.hasData){
                final todos = snapshot.data!;
                return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index){
                      final todo = todos[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(todo.title),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    todoController.text = todo.title;
                                    addTodo(isUpdate: true, todo: todo);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    todoDatabase.deleteTodo(todo);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      )
    );
  }
}
