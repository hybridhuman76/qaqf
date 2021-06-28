import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:qaqf/CourseSections.dart';
import 'package:qaqf/studentCourses.dart';

import 'InstructorAssignment.dart';
import 'InstructorLectureNotes.dart';
import 'Login.dart';
import 'StudentAssignment.dart';
import 'StudentDashboard.dart';
import 'StudentList.dart';


class InstructorRoom extends StatefulWidget {
  @override
  _InstructorRoomState createState() => _InstructorRoomState();
}

class _InstructorRoomState extends State<InstructorRoom> {
  

  List<dynamic> roomData = [];

   dynamic email;
dynamic userid;
dynamic first_name;
dynamic last_name;
dynamic profile_image;


  void initState(){

    super.initState();
  
    getUserDetails();
  }

  _joinMeeting(roomid,username,roomName) async {
    try {
	  FeatureFlag featureFlag = FeatureFlag();
	  featureFlag.welcomePageEnabled = false;
    featureFlag.inviteEnabled = false;
    featureFlag.kickOutEnabled = false;
    featureFlag.liveStreamingEnabled = false;
    featureFlag.recordingEnabled = false;
    featureFlag.addPeopleEnabled = false;
    featureFlag.meetingPasswordEnabled=false;
    featureFlag.videoShareButtonEnabled=false;
    
    
	  featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p
	  
      var options = JitsiMeetingOptions()..room = roomid
      ..userDisplayName = username
      ..featureFlag = featureFlag;
      
      
      

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  getUserDetails()async {



 dynamic temp_userid = await FlutterSession().get("userid");

 setState(() {
 
   userid = temp_userid;

 });

 print('User ID is $userid');

  fetchRoom();
}

Future fetchRoom() async{
  
  var url = "https://learning.qaqf.co.uk/InstructorRoom.php";

  var data = {'userid':userid};

    var response = await http.post(Uri.parse(url),
  
  body: json.encode(data));
  
   setState(() {
     roomData = jsonDecode(response.body);
   });
  

  print(roomData);


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
       iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Rooms',
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
     
      body: SafeArea(
        child:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'My Rooms'.toUpperCase(),
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
                itemCount: roomData.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {

              

                String course_name = roomData[index]['course_name'];
                String batch_name = roomData[index]['batch_name'];
                String room_name = roomData[index]['room_name'];
                String room_id = roomData[index]['meeting_id'];
               
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
                                  'assets/meeting.jpg',
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
                                      'Room Name : $room_name',
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

                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: RaisedButton(
                                        child: Text('Join Now'),
                                        onPressed: ()=>_joinMeeting(room_id,first_name,room_name),
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
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}