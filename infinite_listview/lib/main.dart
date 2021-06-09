import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview/bloc/post_bloc.dart';
import 'package:infinite_listview/ui/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<PostBloc>(
        create: (context) => PostBloc(PostUninitialized())..add(PostEvent()),
        child: MainPage(),
      ),
    );
  }
}
