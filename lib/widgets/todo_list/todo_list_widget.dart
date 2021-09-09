import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/widgets/todo_list/todo_list_model.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const posterPath = 'https://i.imgur.com/OvMZBs9.jpg';
    final model = NotifierProvider.watch<TodoListModel>(context);
    if (model == null) return const SizedBox.shrink();
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.todoItems.length,
          itemExtent: 110,
          itemBuilder: (BuildContext context, int index) {
            final todoItem = model.todoItems[index];
            final isCompleted = todoItem.isCompleted.toString();
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image.network(
                          posterPath,
                          width: 95,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                todoItem.title,
                                maxLines: 1,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Выполнено: $isCompleted',
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                todoItem.id.toString(), // movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => model.onTodoItemTap(
                          // model.minApiTest()
                          context,
                          index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            //controller: _searchController,
            //onChanged: model.searchTodoItems(query),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder(),
              labelText: 'Поиск',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 610, left: 330),
          child: OutlinedButton(
            child: const Text('new'),
            onPressed: () => model.onTodoItemTap(
                // model.minApiTest()
                context,
                -1), // -1 - create new todo
          ),
        )
      ],
    );
  }
}
