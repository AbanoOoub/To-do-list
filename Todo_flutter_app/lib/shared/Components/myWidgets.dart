import 'package:flutter/material.dart';
import 'package:flutter_app_test/shared/cubit/cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 40,
              child: Text('${model['date']}'),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['time']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            IconButton(
              color: Colors.green[300],
              icon: Icon(Icons.check_circle_outline),
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabase(status: 'Done', id: model['id']);
                Fluttertoast.showToast(
                    msg: 'Task Done successfully',
                    backgroundColor: Colors.blue[300]);
              },
            ),
            IconButton(
              color: Colors.blue[300],
              icon: Icon(Icons.archive),
              onPressed: () {
                AppCubit.get(context)
                    .updateDatabase(status: 'Archived', id: model['id']);
                Fluttertoast.showToast(
                    msg: 'Task archived successfully',
                    backgroundColor: Colors.blue[300]);
              },
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDatabase(id: model['id']);
        Fluttertoast.showToast(
            msg: 'Task deleted successfully',
            backgroundColor: Colors.blue[300]);
      },
    );
