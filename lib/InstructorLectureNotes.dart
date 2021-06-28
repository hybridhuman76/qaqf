import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import 'InstructorAssignment.dart';
import 'InstructorRoom.dart';
import 'Login.dart';
import 'StudentDashboard.dart';
import 'StudentList.dart';
import 'StudentRooms.dart';
import 'studentCourses.dart';


class InstructorLectureNotes extends StatefulWidget {


  @override
  _InstructorLectureNotesState createState() => _InstructorLectureNotesState();
}

class _InstructorLectureNotesState extends State<InstructorLectureNotes> {

var dio = Dio();

List<dynamic> notes =[];

List<dynamic> submittedAsignments = [];
   dynamic email;
dynamic userid;
dynamic first_name;
dynamic last_name;
dynamic profile_image;


@override

void initState(){
  getPermission();

  getUserDetails();

}


void getPermission() async {
    print("getPermission");
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      print(raf.path);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      print(raf);
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }


    getUserDetails()async {


 dynamic temp_userid = await FlutterSession().get("userid");

 setState(() {
 
   userid = temp_userid;


 });


  fetchNotes();
  submittedAssignment();
}

Future fetchNotes() async{
  
  var url = "https://learning.qaqf.co.uk/InstructorAssignment.php";

  var data = {'userid':userid};

    var response = await http.post(Uri.parse(url),
  
  body: json.encode(data));
  
   setState(() {
     notes = jsonDecode(response.body);
   });
    

  print('Uploaded assignment is $notes');


}

Future submittedAssignment() async{
  
  var url = "https://learning.qaqf.co.uk/InstructorSubmittedAssignment.php";

  var data = {'userid':userid};

    var response = await http.post(Uri.parse(url),
  
  body: json.encode(data));
  
   setState(() {
     submittedAsignments = jsonDecode(response.body);
   });
    

  print('Submitted assignment are : $submittedAsignments');


}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
      child:Scaffold(
       backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        
        title: Text('Assignments', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
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

        bottom: TabBar(
              tabs: [
                Tab(
                 
                  child:Text('Uploaded Notes',style: TextStyle(color: Colors.black),) ,
                ),
                
           
              ],
            ),
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
              image: NetworkImage('https://learning.qaqf.co.uk/uploads/user_image/placeholder.png'),
              fit: BoxFit.fill,
              ),
            ),
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
    onTap: ()=>null,
  ),
   ListTile(
    title: Row(
      children: <Widget>[
        Icon(Icons.verified_user,),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Join Class'),
        )
      ],
    ),
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>InstructorRoom())),
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
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentList())),
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
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>InstructorAssignment())),
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
    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>InstructorLectureNotes())),
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
    
      body: TabBarView(
            children: [
              Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
             Expanded(
              child: notes !=null? ListView.builder(
                itemCount: notes.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {

                

                String lecture_doc_name = notes[index]['lecture_doc_name'];
                String course_name = notes[index]['course_name'];
                String batch_name = notes[index]['batch_name'];
                String section_name = notes[index]['section_name'];
                String lesson_name = notes[index]['lesson_name'];
                String download_link = notes[index]['note_path'];

                print('download link is $download_link');
                  return 
                    Container(
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
                    child:GestureDetector( 
                      child:ClipRRect(
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
                                child: Image.asset(
                                  'assets/assignment.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Name: $lecture_doc_name',
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
                                      'Course Name : $course_name',
                                      

                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text(
                                      'Group Name : $batch_name',
                                     
                                      
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),

                                     Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text(
                                      'Section Name : $section_name',
                                     
                                      
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                     Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text(
                                      'Lesson Name : $lesson_name',
                                     
                                      
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
                                        child: Text('Download'),
                                        onPressed: ()async {
                                          String path =
                                          await ExtStorage.getExternalStoragePublicDirectory(
                                          ExtStorage.DIRECTORY_DOWNLOADS);
                  //String fullPath = tempDir.path + "/boo2.pdf'";
                                          String fullPath = "$path/$lecture_doc_name";
                                          print('full path ${fullPath}');

                                          download2(dio, download_link, fullPath);
                                        },
                                        
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
                    
                  );
                  }
                
              ):Container(
                child: Text('No Pending Assignments !')
              ),
            ),
          ],
        ),
      ),
          

          //submitted assignments

           Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
             Expanded(
              child: submittedAsignments !=null? ListView.builder(
                itemCount: submittedAsignments.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {

                

                String course_name = submittedAsignments[index]['course'];
                String batch_name = submittedAsignments[index]['batch'];
                String assignment_name = submittedAsignments[index]['assignment_name'];
                String instructor_name = submittedAsignments[index]['instructor_name'];
                String studentName = submittedAsignments[index]['student_name'];
             
                String assignment_link = submittedAsignments[index]['assignment_path'];
                print('submitted assignment path is $assignment_link');
                  return 
                    Container(
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
                    child:GestureDetector( 
                      child:ClipRRect(
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
                                child: Image.asset(
                                  'assets/assignment.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Name: $assignment_name',
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
                                      'Course Name : $course_name',
                                      

                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text(
                                      'Group Name : $batch_name',
                                     
                                      
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text(
                                      'Student Name : $studentName',
                                     
                                      
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                Padding(
                                      padding: EdgeInsets.only(top: 9),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('Submitted',
                                      style: TextStyle(
                                        color:Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      )
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: RaisedButton(
                                        child: Text('Download'),
                                        onPressed: ()async {
                                          String path =
                                          await ExtStorage.getExternalStoragePublicDirectory(
                                          ExtStorage.DIRECTORY_DOWNLOADS);
                  //String fullPath = tempDir.path + "/boo2.pdf'";
                                          String fullPath = "$path/$assignment_name";
                                          print('full path ${fullPath}');

                                          download2(dio, assignment_link, fullPath);
                                        },
                                        
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
                    
                  );
                  
                },
              ):Container(
                child: Text('No Submitted Assignments !')
              ),
            ),
          ],
        ),
      ),
             
            ],
          ),
      ), 
      ),
    );
  }
}