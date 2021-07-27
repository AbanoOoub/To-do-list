import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/shared/cubit/cubit.dart';
import 'package:flutter_app_test/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: state is! AppGetDatabaseLoadingState
                ? cubit.screens[cubit.currentIndex]
                : Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: dateController.text,
                        date: timeController.text);

                    titleController.clear();
                    dateController.clear();
                    timeController.clear();
                  }
                } else {
                  scaffoldkey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.blue[100],
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "title must not be empty!";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.title),
                                    labelText: 'Task Title',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: timeController,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) => timeController.text =
                                            value.format(context));
                                  },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "time must not be empty!";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.timer),
                                    labelText: 'Task Time',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  readOnly: true,
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: dateController,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month + 1,
                                                DateTime.now().day))
                                        .then((value) => dateController.text =
                                            DateFormat.yMMMd().format(value));
                                  },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "date must not be empty!";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today_rounded),
                                    labelText: 'Task date',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeButtomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeButtomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_outlined), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archived"),
              ],
            ),
          );
        },
      ),
    );
  }
}
