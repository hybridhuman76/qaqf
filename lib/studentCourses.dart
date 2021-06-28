import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:qaqf/CourseSections.dart';

import 'Login.dart';
import 'StudentAssignment.dart';
import 'StudentDashboard.dart';
import 'StudentRooms.dart';


class StudentCourse extends StatefulWidget {
  @override
  _StudentCourseState createState() => _StudentCourseState();
}

class _StudentCourseState extends State<StudentCourse> {
  

  List<dynamic> courseData = [];

   dynamic email;
dynamic userid;
dynamic first_name;
dynamic last_name;
dynamic profile_image;


  void initState(){
    getUserDetails();
  }

  getUserDetails()async {

   dynamic temp_email =  await FlutterSession().get("email");

 dynamic temp_userid = await FlutterSession().get("userid");

 dynamic temp_first_name = await FlutterSession().get("first_name");

 dynamic temp_last_name = await FlutterSession().get("last_name");

dynamic temp_profile_image = await FlutterSession().get("profile_image");
 setState(() {
   
   email = temp_email;
   userid = temp_userid;
   first_name = temp_first_name;
   last_name = temp_last_name;
   profile_image = temp_profile_image;

 });

  fetchCourse();
}

Future fetchCourse() async{
  
  var url = "https://learning.qaqf.co.uk/studentCourses.php";

  var data = {'userid':userid};

    var response = await http.post(Uri.parse(url),
  
  body: json.encode(data));
  
   setState(() {
     courseData = jsonDecode(response.body);
   });
  

  print(courseData);


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
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
     drawer: new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
      margin: EdgeInsets.only(top:70),
      padding: EdgeInsets.zero,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            width:120,
            height:120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

            image: DecorationImage(
              image: NetworkImage(profile_image== null?'https://learning.qaqf.co.uk/uploads/user_image/placeholder.png':profile_image),
              fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height:10,
          ),

          SizedBox(
            height:10,
          ),

      ],),
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
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentDashboard())),
  ),
   ListTile(
    title: Row(
      children: <Widget>[
        Icon(Icons.menu_book_sharp),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Courses'),
        )
      ],
    ),
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourse())),
  ),
   ListTile(
    title: Row(
      children: <Widget>[
        Icon(Icons.video_call),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Join Class'),
        )
      ],
    ),
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentRooms())),
  ),
   ListTile(
    title: Row(
      children: <Widget>[
        Icon(Icons.assignment),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Assignments'),
        )
      ],
    ),
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAssignment())),
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
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())),
  ),
          ListTile(
            title: Text('QAQF 0.0.1',textAlign: TextAlign.center,),
            onTap: () {},
          ),
        ],
      ),
    ),
     
      body: SafeArea(
        child:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'My Courses'.toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: courseData.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {

                double coursePercentage = courseData[index]['course_progress'];

                String course_id = courseData[index]['course_id'];
                String batch_id = courseData[index]['batch_id'];
                String image_url = courseData[index]['thumbnail'];
               
               
                  return GestureDetector(
                    child:Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        child: InkWell(
                          highlightColor: Colors.white.withAlpha(50),
                          onTap: () {
                            
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  '$image_url',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      courseData[index]['courseName'].toString().toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text(
                                      'Total Lesson : ${courseData[index]['lesson']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: RaisedButton(
                                        child: Text('View'),
                                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseSections(course_id: course_id,batch_id: batch_id,))),
                                      ),
                                    ),
                                   
                                    
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ),
                    onDoubleTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseSections(course_id: course_id,batch_id: batch_id,)));
                    }
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}