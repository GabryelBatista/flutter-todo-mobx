import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_mobx/app/lib/stores/login_store.dart';
import 'package:provider/provider.dart';
import 'app/lib/screens/login_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => LoginStore(),
      child: MaterialApp(
        home: LoginScreen(),
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
