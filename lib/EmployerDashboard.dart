import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'Login.dart';
import 'StudentList.dart';

class EmployerDashboard extends StatefulWidget {
 

  @override
  _EmployerDashboardState createState() => _EmployerDashboardState();
}

class _EmployerDashboardState extends State<EmployerDashboard> {

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

 setState(() {
   
   email = temp_email;
   userid = temp_userid;
   first_name = temp_first_name;
   last_name = temp_last_name;


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
          child: Text('View Candidates'),
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
          child: Text('Candidate Videos'),
        )
      ],
    ),
    onTap: ()=>null,
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
                  onTap: ()=>null,
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
                  onTap: ()=>null,
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
                  onTap: ()=>null,
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