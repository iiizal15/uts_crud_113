import 'package:flutter/material.dart';
import 'databaseSewa/dbsewa_helper.dart';
import 'form_sewaps.dart';
import 'list_sewaps.dart';
import 'model/sewaps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Penyewaan Rental PS',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ListSewaPage(),
    );
  }
}
