import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:qaqf/Login.dart';
import 'package:qaqf/StudentAssignment.dart';
import 'package:qaqf/StudentRooms.dart';
import 'package:qaqf/studentCourses.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  print("Email address is $email");

  print("user ID is $userid");
  print("First Name is $first_name");
  print("Last Name is $last_name");
  print(profile_image);
}


 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     key:_scaffoldKey,
     backgroundColor: Theme.of(context).accentColor,
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
          child:SingleChildScrollView(
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(left:15,top:15),
              child:Text('Hi $first_name $last_name',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),
              ),
            ),
             
             Container(
               margin: EdgeInsets.only(top:20,left:10,right: 10),
               width:MediaQuery.of(context).size.width,
               height:300,
               child: ListView(
                 scrollDirection: Axis.horizontal,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width/1.5,
                    height:300,
                    
                    child: Card(
                      
                      color: Colors.black,
                      shadowColor: Colors.grey,
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.0),
                      child: Image.asset("assets/qaqf1.jpg",fit: BoxFit.fill,),
                        )
                    ),
                  ),
                      Container(
                    width: MediaQuery.of(context).size.width/1.5,
                    height:300,
                    
                    child: Card(
                      
                      color: Colors.black,
                      child:ClipRRect(
                      borderRadius: BorderRadius.circular(2.0),
                      child: Image.asset("assets/qaqf2.jpg",fit: BoxFit.fill,),
                        ), 
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.5,
                    height:300,
                    
                    child: Card(
                      
                      color: Colors.black,
                      child:ClipRRect(
                      borderRadius: BorderRadius.circular(2.0),
                      child: Image.asset("assets/qaqf3.jpg",fit: BoxFit.fill,),
                        ), 
                    ),
                  ),
                   Container(
                    width: MediaQuery.of(context).size.width/1.5,
                    height:300,
                    
                    child: Card(
                      
                      color: Colors.black,
                      child:ClipRRect(
                      borderRadius: BorderRadius.circular(2.0),
                      child: Image.asset("assets/qaqf4.jpg",fit: BoxFit.fill,),
                        ), 
                    ),
                  ),
                 
                ],

               ),
             ),

             SizedBox(
               height:15,
             ),
             Container(
               margin: EdgeInsets.only(top:15,left:15),
               child:Text('Quick Access',style:TextStyle(fontSize: 23,fontWeight: FontWeight.bold))
             ),
            Container(
              width:MediaQuery.of(context).size.width,
              height:350,
              child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3 ,
                
                ),
                
                children: [

                  GestureDetector(
                    child:Container(
                    width:150,
                    height:150,
                    child: Card(
                      
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/home_assignment.png'),
                          SizedBox(height: 5,),
                          Text('Assignments',style:TextStyle(color:Colors.black), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAssignment())),
                  ),
                  GestureDetector(
                  child:Container(
                    width:150,
                    height:150,
                    child: Card(
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment,color:Colors.black,size: 70,),
                          SizedBox(height: 5,),
                          Text('Courses',style:TextStyle(color:Colors.black), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentCourse())),
                  ),
                 GestureDetector( 
                   child:Container(
                    width:150,
                    height:150,
                    child: Card(
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_camera_front_outlined,color:Colors.black,size: 70,),
                          SizedBox(height: 5,),
                          Text('Rooms',style:TextStyle(color:Colors.black), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentRooms())),
                 ),
                GestureDetector(
                  child: Container(
                    width:150,
                    height:150,
                    child: Card(
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.book,color:Colors.black,size: 70,),
                          SizedBox(height: 5,),
                          Text('Lessons',style:TextStyle(color:Colors.black), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                ),
                 GestureDetector(
                   child:Container(
                    width:150,
                    height:150,
                    child: Card(
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.support,color:Colors.black,size: 70,),
                          SizedBox(height: 5,),
                          Text('Support',style:TextStyle(color:Colors.black), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                  onTap: ()=>null,
                 ),
                  

                ],

               
              ),
            ),
          
          ],
        )
      ),
        ),
      ),
    );
  }
}


