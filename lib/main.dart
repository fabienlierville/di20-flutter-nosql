import 'dart:io';

import 'package:courses/global_vars.dart';
import 'package:courses/objectbox.g.dart';
import 'package:courses/pages/page_home.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appPath = await getApplicationDocumentsDirectory();
  GlobalVars.store = await openStore(directory: "${appPath.path}/database/");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PageHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
