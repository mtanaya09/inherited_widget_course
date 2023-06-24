import 'package:flutter/material.dart';
import 'package:inherited_widget_course/inherited_widget.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ApiProvider(
        api: Api(),
        child: const MyInheritWidget(),
      ),
      
    ),
  );
}
