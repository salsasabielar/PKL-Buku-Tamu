import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Tamu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          hintColor: Colors.blue[200],
          primaryColor: Colors.blue[250],
          fontFamily: "Montserrat",
          canvasColor: Colors.transparent),
      home: LoginPage(),
          //UploadImageDemo(),
          //Dashboard(),
      // Profile(),
      // DetailList(),
      // EntryForm(),
      // Report(),
    );
  }
}
