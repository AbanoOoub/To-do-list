import 'package:flutter/material.dart';
import 'package:flutter_app_test/shared/Components/myWidgets.dart';
import 'package:flutter_app_test/shared/cubit/cubit.dart';
import 'package:flutter_app_test/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return tasks.length == 0
            ? Center(
                child: Text(
                "Done Tasks",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ))
            : ListView.separated(
                itemBuilder: (context, index) =>
                    buildTaskItem(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                itemCount: tasks.length);
      },
    );
  }
}
