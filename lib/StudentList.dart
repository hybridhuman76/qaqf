import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:qaqf/InstructorAssignment.dart';
import 'package:qaqf/InstructorLectureNotes.dart';
import 'package:qaqf/InstructorRoom.dart';

import 'Login.dart';

import 'package:http/http.dart' as http;

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<dynamic> studentList = [];

  dynamic userid;

  @override
  void initState() {
    getUserDetails();
    fetchStudentList();
  }

  getUserDetails() async {
    dynamic temp_userid = await FlutterSession().get("userid");

    setState(() {
      userid = temp_userid;
    });

    print("user ID is $userid");
  }

  Future fetchStudentList() async {
    var url = "https://learning.qaqf.co.uk/InstructorStudentList.php";

    dynamic userid = await FlutterSession().get("userid");

    var data = {'userid': userid};

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    setState(() {
      studentList = jsonDecode(response.body);
    });

    print('studentList is $studentList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://learning.qaqf.co.uk/uploads/user_image/placeholder.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.dashboard),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Dashboard'),
                  )
                ],
              ),
              onTap: () => null,
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(
                    Icons.verified_user,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Join Class'),
                  )
                ],
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InstructorRoom())),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.video_camera_back),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('My Student'),
                  )
                ],
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StudentList())),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.video_camera_back),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Assignments'),
                  )
                ],
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InstructorAssignment())),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.video_camera_back),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Lecture Notes'),
                  )
                ],
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InstructorLectureNotes())),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.lock_open),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Logout'),
                  )
                ],
              ),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login())),
            ),
            ListTile(
              title: Text(
                'QAQF 0.0.1',
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(),
          child: SingleChildScrollView(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: studentList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  String Student_name =
                      "${studentList[index]['student_first_name']} ${studentList[index]['student_last_name']}";

                  String student_email = studentList[index]['student_email'];
                  String course_enrolled =
                      studentList[index]['course_enrolled'];
                  String group_name = studentList[index]['group_name'];
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width / 3.5,
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://learning.qaqf.co.uk/uploads/user_image/placeholder.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                        '${Student_name}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        '${student_email}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        '${course_enrolled}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        '${group_name}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
