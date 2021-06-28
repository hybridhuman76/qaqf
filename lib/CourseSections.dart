import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:qaqf/CourseLesson.dart';

class CourseSections extends StatefulWidget {

  String course_id;

  String batch_id;

  CourseSections({required this.course_id, required this.batch_id});
  @override
  _CourseSectionsState createState() => _CourseSectionsState();
}

class _CourseSectionsState extends State<CourseSections> {


  List<dynamic> sections = [];
  List chapters = [
    'Introduction',
    'Adobe XD',
    'Sketch Basics',
    'Figma Mastery',
  ];

  List topics = [
    'Introduction to the course',
    'Detailed tutorials on adobe XD',
    'Introduction to the course',
    'Sketch beginner to expert series',
    'Figma from basic to advanced',
  ];

  late String instructor_name ="";

  late String profile = "";

  @override

  void initState(){
    getSectionDetails();
  }


  Future getSectionDetails()async{

    var url = "https://learning.qaqf.co.uk/fetchLessonList.php";

     var data = {'courseid':widget.course_id,'batchid':widget.batch_id};
    var response = await http.post(Uri.parse(url),

  
  
  body: json.encode(data));

    setState(() {
      sections = jsonDecode(response.body);
      profile = sections[0]['instructor_profile_image'];
      instructor_name = sections[0]['instructor_name'];
    });

    print(sections);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text('Course Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SECTIONS'.toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
           sections != null?ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('$profile'),
                backgroundColor: Colors.grey[300],
              ),
              title: Text(
                '$instructor_name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Instructor',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
              ),
            ):Container(),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sections.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text(
                          '${index+1}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        sections[index]['section_title'].toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        topics[index],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseLesson(lessons: sections[index]['lesson'])));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}