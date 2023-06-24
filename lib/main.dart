import 'package:flutter/material.dart';
import 'package:state_management_part_2/inherited_model.dart';
import 'package:state_management_part_2/inherited_notifier.dart';
import 'package:state_management_part_2/inherited_widget.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // home: ApiProvider(
      //   api: Api(),
      //   child: const MyInheritWidget(),
      // ),
      home: const MyInheritNotifier(),
    ),
  );
}
