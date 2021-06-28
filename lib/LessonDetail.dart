import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetail extends StatefulWidget {
  
  String video_url;
  LessonDetail({required this.video_url});

  @override
  _LessonDetailState createState() => _LessonDetailState();
}


class _LessonDetailState extends State<LessonDetail> {


late String video_url = '';
void initState(){

 getVideoID(); 
}
  getVideoID(){
    try {
  String? videoID= YoutubePlayer.convertUrlToId(widget.video_url);
  
  setState(() {
    video_url = videoID!;
  });
} on Exception catch (exception) {
  print(exception);
  return "";
} catch (error) {
  print(error);
  return "";
}
  }


  lessonVideo(){

    return Container(
    child: Align(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.fill,
        child:YoutubePlayer(
  controller: YoutubePlayerController(
    initialVideoId: '$video_url', //Add videoID.
    flags: YoutubePlayerFlags(
      hideControls: false,
      controlsVisibleAtStart: true,
      autoPlay: false,
      mute: false,
    ),
  ),
  showVideoProgressIndicator: true,
  progressIndicatorColor: Colors.black,
),
      ),
    ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child:OrientationBuilder(builder: (BuildContext context , Orientation orientation){
         if(orientation == Orientation.landscape){
            return Scaffold(
              body: lessonVideo(),
            );

         }else{

            return Scaffold(
       backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        
        title: Text('Lesson Details', style: TextStyle(color: Colors.black)),
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
      ),
      
      
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Lessons'.toUpperCase(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),

            YoutubePlayer(
  controller: YoutubePlayerController(
    initialVideoId: '$video_url', //Add videoID.
    flags: YoutubePlayerFlags(
      hideControls: false,
      controlsVisibleAtStart: true,
      autoPlay: false,
      mute: false,
    ),
  ),
  showVideoProgressIndicator: true,
  progressIndicatorColor: Colors.black,
),
Padding(
              padding: EdgeInsets.only(top: 15),
            ),
             Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
             Text(
              '',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                
              ),
            ),
          ],
        ),
      ),
    );

         }
      

      }),
      
     
    );
  }
}