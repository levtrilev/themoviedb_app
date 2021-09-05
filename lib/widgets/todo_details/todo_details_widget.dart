import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/todo_item.dart';
//import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/widgets/todo_details/todo_details_model.dart';

class TodoDetailsWidget extends StatefulWidget {
  final todoId;
  const TodoDetailsWidget({
    Key? key,
    required this.todoId,
  }) : super(key: key);

  @override
  _TodoDetailsWidgetState createState() => _TodoDetailsWidgetState();
}

class _TodoDetailsWidgetState extends State<TodoDetailsWidget> {
  final todoDetailsModel = TodoDetailsModel();

  @override
  void initState() {
    // todoDetailsModel.loadTodoItem(widget.todoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.watch<TodoDetailsModel>(context);
    // if (model == null) return SizedBox.shrink();

    return FutureBuilder<void>(
      future: todoDetailsModel.loadTodoItem(widget.todoId),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            final todoItem = todoDetailsModel.todoItem;
            return Center(
              child: Text('TODO DETAILS HERE TEXT: ' + todoItem.title),
            );
            //return Center(child: new Text('${snapshot.data}'));
            //  // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        }
      },
    );
  }
}
