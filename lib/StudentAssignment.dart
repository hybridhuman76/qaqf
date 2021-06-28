import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import 'Login.dart';
import 'StudentDashboard.dart';
import 'StudentRooms.dart';
import 'studentCourses.dart';


class StudentAssignment extends StatefulWidget {


  @override
  _StudentAssignmentState createState() => _StudentAssignmentState();
}

class _StudentAssignmentState extends State<StudentAssignment> {

var dio = Dio();

List<dynamic> assignments =[];

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

 print('user name is $first_name');

  fetchAssignments();
  submittedAssignment();
}

Future fetchAssignments() async{
  
  var url = "https://learning.qaqf.co.uk/pending_assignments.php";

  var data = {'userid':userid};

    var response = await http.post(Uri.parse(url),
  
  body: json.encode(data));
  
   setState(() {
     assignments = jsonDecode(response.body);
   });
    

  print('pending assignment is $assignments');


}

Future submittedAssignment() async{
  
  var url = "https://learning.qaqf.co.uk/submitted_assignments.php";

  var data = {'userid':userid};

    var response = await http.post(Uri.parse(url),
  
  body: json.encode(data));
  
   setState(() {
     submittedAsignments = jsonDecode(response.body);
   });
    

  print(submittedAsignments);


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
                 
                  child:Text('Pending Assignment',style: TextStyle(color: Colors.black),) ,
                ),
                 Tab(
                 child:Text('Submitted Assignment',style: TextStyle(color: Colors.black),) ,
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
              image: NetworkImage(profile_image== null?'https://learning.qaqf.co.uk/uploads/user_image/placeholder.png':profile_image),
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
              child: assignments !=null? ListView.builder(
                itemCount: assignments.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {

                  if(assignments[index]['status'] ==0){
                    return Text('No data found');
                  }else{

                String course_name = assignments[index]['course_name'];
                String batch_name = assignments[index]['batch_name'];
                String assignment_name = assignments[index]['assignment_name'];
                String instructor_name = assignments[index]['instructor_name'];
                String download_link = assignments[index]['assignment_path'];
                String final_link = "https://learning.qaqf.co.uk/$download_link";

                print('download link is $final_link');
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
                                      'Instructor Name : $instructor_name',
                                     
                                      
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
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

                                          download2(dio, final_link, fullPath);
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
                },
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

                

                String course_name = submittedAsignments[index]['course_name'];
                String batch_name = submittedAsignments[index]['batch_name'];
                String assignment_name = submittedAsignments[index]['assignment_name'];
                String instructor_name = submittedAsignments[index]['instructor_name'];
             
               
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
                                      'Instructor Name : $instructor_name',
                                     
                                      
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text('Submitted',
                                      style: TextStyle(
                                        color:Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      )
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