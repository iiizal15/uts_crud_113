// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls, unused_local_variable, unused_import, use_key_in_widget_constructors

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
