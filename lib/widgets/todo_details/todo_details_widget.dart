import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/todo_item.dart';
import 'package:themoviedb/widgets/todo_details/todo_details_model.dart';

class TodoDetailsWidget extends StatefulWidget {
  final int todoId;
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
            return TodoDetailsScreenWidget(todoItem: todoItem);
            //return Center(child: new Text('${snapshot.data}'));
            //  // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        }
      },
    );
  }
}

class TodoDetailsScreenWidget extends StatefulWidget {
  TodoDetailsScreenWidget({
    Key? key,
    required this.todoItem,
  }) : super(key: key);

  final TodoItem todoItem;

  @override
  _TodoDetailsScreenWidgetState createState() =>
      _TodoDetailsScreenWidgetState();
}

class _TodoDetailsScreenWidgetState extends State<TodoDetailsScreenWidget> {
//   TodoItem todoItem;
// _TodoDetailsScreenWidgetState(this.todoItem);
  bool _completed = false;
  TextEditingController titleController = TextEditingController.fromValue(null);

  @override
  void initState() {
    super.initState();
    setState(() {
      _completed = widget.todoItem.isCompleted;
      titleController.text = widget.todoItem.title;
    });
  }

  Future<void> updateTodoItem() async {
    if (widget.todoItem.id == 0) {
      await createTodoItem();
      return;
    }

    final TodoItem todoItemToUpdate = TodoItem(
      id: widget.todoItem.id,
      title: titleController.text,
      isCompleted: _completed,
    );
    
    final updatedTodoItemId = await context
        .findAncestorStateOfType<_TodoDetailsWidgetState>()
        ?.todoDetailsModel
        .updateTodoItem(todoItemToUpdate);
              Navigator.of(context).pop(updatedTodoItemId);
              //context.findAncestorStateOfType<_TodoListWidgetState>()?.loadTodoItems();
  }

  Future<void> deleteTodoItem() async {
    await context
        .findAncestorStateOfType<_TodoDetailsWidgetState>()
        ?.todoDetailsModel
        .deleteTodoItem(widget.todoItem.id);
              Navigator.of(context).pop(-1);
  }
  Future<void> createTodoItem() async {
    final TodoItem todoItemToCreate = TodoItem(
      id: 0,
      title: titleController.text,
      isCompleted: _completed,
    );
    final createdTodoItemId = await context
        .findAncestorStateOfType<_TodoDetailsWidgetState>()
        ?.todoDetailsModel
        .createTodoItem(todoItemToCreate);
              Navigator.of(context).pop(createdTodoItemId);
              //context.findAncestorStateOfType<_TodoListWidgetState>()?.loadTodoItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TODO Details',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: CustomMultiChildLayout(
        delegate: FormLayoutDelegate(position: Offset(0, 0)),
        children: [
          LayoutId(
            id: 'Title',
            child: TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              maxLines: 5,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          LayoutId(
            id: 'id',
            child: Text('Id: ' + widget.todoItem.id.toString()),
          ),
          LayoutId(
            id: 'isCompletedLabel',
            child: Text('Выполнено: '),
          ),
          LayoutId(
              id: 'isCompleted',
              child: Switch(
                value: _completed,
                onChanged: (bool newValue) {
                  setState(() {
                    _completed = newValue;
                  });
                },
              ) //Text('Completed: ' + todoItem.isCompleted.toString()),
              ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            tooltip: 'удалить',
            onPressed: () => deleteTodoItem(),
            heroTag: null,
            child: Icon(Icons.delete),
          ),
          SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            backgroundColor: Colors.green,
            tooltip: 'создать',
            onPressed: () => createTodoItem(),
            heroTag: null,
            child: Icon(Icons.create),
          ),
          SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            backgroundColor: Colors.green,
            tooltip: 'сохранить',
            onPressed: () => updateTodoItem(),
            heroTag: null,
            child: Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}

class FormLayoutDelegate extends MultiChildLayoutDelegate {
  FormLayoutDelegate({required this.position});

  final Offset position;

  @override
  void performLayout(Size size) {
    // `size` is the size of the `CustomMultiChildLayout` itself.

    // ignore: unused_local_variable
    Size leadingSize = Size.zero;
    if (hasChild('Title')) {
      leadingSize = layoutChild(
        'Title', // The id once again.
        BoxConstraints(
          maxWidth: 300,
          maxHeight: 400,
        ),
      );
      // No need to position this child if we want to have it at Offset(0, 0).
      positionChild('Title', Offset(90, 40));
    }
    if (hasChild('id')) {
      leadingSize = layoutChild('id', BoxConstraints.loose(size));
      positionChild('id', Offset(30, 16));
    }
    if (hasChild('isCompletedLabel')) {
      leadingSize = layoutChild('isCompletedLabel', BoxConstraints.loose(size));
      positionChild('isCompletedLabel', Offset(90, 16));
    }
    if (hasChild('isCompleted')) {
      leadingSize = layoutChild('isCompleted', BoxConstraints.loose(size));
      positionChild('isCompleted', Offset(162, 0));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}

// hasChild, which lets you check whether a particular id 
//(remember LayoutId?) was passed to the children, i.e. if a child 
//of that id is present.

// layoutChild, which you need to call for every id, every child, 
//provided exactly once and it will give you the Size of that child.

// positionChild, which allows you to change the position 
//from Offset(0, 0) to any offset you specify.

// class YourLayoutDelegate extends MultiChildLayoutDelegate {
//   YourLayoutDelegate({this.position});

//   final Offset position;

//   @override
//   void performLayout(Size size) {
//     // `size` is the size of the `CustomMultiChildLayout` itself.

//     Size leadingSize = Size.zero; // If there is no widget with id `1`, the size will remain at zero.
//     // Remember that `1` here can be any **id** - you specify them using LayoutId.
//     if (hasChild(1)) {
//       leadingSize = layoutChild(
//         1, // The id once again.
//         BoxConstraints.loose(size), // This just says that the child cannot be bigger than the whole layout.
//       );
//       // No need to position this child if we want to have it at Offset(0, 0).
//     }

//     if (hasChild(2)) {
//       final secondSize = layoutChild(
//         2,
//         BoxConstraints(
//           // This is exactly the same as above, but this can be anything you specify.
//           // BoxConstraints.loose is a shortcut to this.
//           maxWidth: size.width,
//           maxHeight: size.height,
//         ),
//       );

//       positionChild(
//         2,
//         Offset(
//           leadingSize.width, // This will place child 2 to the right of child 1.
//           size.height / 2 - secondSize.height / 2, // Centers the second child vertically.
//         ),
//       );
//     }
//   }
// }