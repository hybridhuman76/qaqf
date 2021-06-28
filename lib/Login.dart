import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import 'EmployerDashboard.dart';
import 'InstructorDashboard.dart';
import 'StudentDashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
	
  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

 

  bool visible = false;

  var session = FlutterSession();

  Future userLogin(pr) async{
 
 pr.show();
 
  // Getting value from Controller
  String email = emailController.text;
  String password = passwordController.text;
 
  // SERVER LOGIN API URL
  var url = 'https://learning.qaqf.co.uk/auth.php';
 
  // Store all data with Param Name.
  var data = {'email': email, 'password' : password};
 
  // Starting Web API Call.
  var response = await http.post(Uri.parse(url), 
  
  body: json.encode(data));
 
  // Getting Server response into variable.
  List<dynamic> message = jsonDecode(response.body);
 
  // If the Response Message is Matched.
  if(message[0] == 'Student Login Matched')
  {


    if(message[6] == '0'){

       pr.hide();
    setState(() {
      visible = false; 
      });
 
    // Showing Alert Dialog with Response JSON Message.
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text('Please Complete the QAQF Form from Web Portal'),
        actions: <Widget>[
          FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
    );

    }

    if(message[6] == '1'){
        pr.hide();
    setState(() {
      visible = false; 
      });
 
    // Showing Alert Dialog with Response JSON Message.
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text('Please Complete the Video Profiling from Web Portal'),
        actions: <Widget>[
          FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
    );
    }


    if(message[6] == '2'){
        pr.hide();
    setState(() {
      visible = false; 
      });
 
    // Showing Alert Dialog with Response JSON Message.
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text('Your Application is Pending for Approval'),
        actions: <Widget>[
          FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
    );
    }
    if(message[6] == '3'){
         session.set("email", message[5]);

      session.set("userid",message[1]);

      session.set("profile_image", message[2]);

      session.set("first_name",message[3]);
      session.set("last_name", message[4]);

      pr.hide();
      setState(() {
      visible = false; 
      });

 
    // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentDashboard()),
      );
    }

     if(message[6] == '4'){
        pr.hide();
    setState(() {
      visible = false; 
      });
 
    // Showing Alert Dialog with Response JSON Message.
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text('Your Application is Rejected'),
        actions: <Widget>[
          FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
    );
    }
      

     
  }

    if(message[0] == 'Employer Login Matched')
  {
      

      session.set("email", message[5]);

      session.set("userid",message[1]);

      session.set("first_name",message[3]);
      session.set("last_name", message[4]);

      pr.hide();
      setState(() {
      visible = false; 
      });

 
    // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmployerDashboard()),
      );
  }

   if(message[0] == 'Instructor Login Matched')
  {
      

      

      session.set("userid",message[1]);

      session.set("first_name",message[2]);

      pr.hide();
      setState(() {
      visible = false; 
      });

 
    // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InstructorDashboard()),
      );
  }

  if(message[0] == "Invalid Username or Password Please Try Again"){



      pr.hide();
    setState(() {
      visible = false; 
      });
 
    // Showing Alert Dialog with Response JSON Message.
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text('Invalid Login Credentials'),
        actions: <Widget>[
          FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
    );

  }
 
}

  @override
  Widget build(BuildContext context) {

   ProgressDialog pr = new ProgressDialog(context);
        double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height*0.45,
                child: Image.asset('assets/logo.png',fit: BoxFit.fill,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
             Container(
               margin: EdgeInsets.only(left:10,right:10),
               child: TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: emailController,
              ),
             ),
              SizedBox(height: 20.0,),
              Container(
                margin: EdgeInsets.only(left:10,right:10),
                child:TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: passwordController,
              ),
              ),
              SizedBox(height: 30.0,),
              Container(
                margin: EdgeInsets.only(left:10,right:10),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text('Login'),
                   color: Color(0xffEE7B23),
                   onPressed: ()=>userLogin(pr),
                ),
              ),
              SizedBox(height:20.0),
             
              


            ],
          ),
        ),
      ),
    );
  }
}