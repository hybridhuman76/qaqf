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

import 'Login.dart';
import 'StudentAssignment.dart';
import 'StudentDashboard.dart';


class StudentRooms extends StatefulWidget {
  @override
  _StudentRoomsState createState() => _StudentRoomsState();
}

class _StudentRoomsState extends State<StudentRooms> {
  

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

  fetchRoom();
}

Future fetchRoom() async{
  
  var url = "https://learning.qaqf.co.uk/StudentRooms.php";

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