// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:qaqf/LessonDetail.dart';
import 'package:qaqf/Login.dart';
import 'package:qaqf/StudentRooms.dart';

import 'package:qaqf/studentCourses.dart';


void main()async {
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0XFF584BDD),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QAQF',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        primaryColor: Color(0XFF584BDD),
        accentColor: Color(0XFFFBF6FF),
        
      ),
      home: Login(),
    );
  }
}

