import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/layout/home_layout.dart';
import 'package:flutter_app_test/shared/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
