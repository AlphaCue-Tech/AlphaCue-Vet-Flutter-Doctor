
import 'dart:convert';

import 'package:alphacue_vet_doc/appointment/video_call.dart';
import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/models.dart';
import 'package:alphacue_vet_doc/prescription/precriptionview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';
class ChatDetails extends StatefulWidget{

  String id;
  String Prescription_id;

  ChatDetails(this.id,this.Prescription_id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatDetailsState();
  }


}
class ChatDetailsState extends State<ChatDetails>{
  TextEditingController msg = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List chats=[];
  String id="";
  int chatseen=0;
  final sharedpreff=GetStorage();
  var commentsRef,commentsRef1,commentsRef2;
  bool vidCallButtonPress=false;
  @override
  void initState() {
    // TODO: implement initState

   //  getVideoToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwNzI0ODY5LCJpYXQiOjE2ODU1NDA4NjksImp0aSI6ImVkMWQ1NWEyZmY1ZTRmMDk5OGNiMzFjMzFjNTMwYWU0IiwidXNlcl9pZCI6MX0.fNchXc09V9T8lDSkMSuxXAvpapWSyKrvQtzOkkWPmcw");
    id=widget.id.toString();
    print(id+"sdddddddddddddddddddddddddd");
    commentsRef2 = FirebaseDatabase.instance.ref("CHATSEEN/$id");
   try{
     commentsRef = FirebaseDatabase.instance.ref("CHATS/$id");
     chats.clear();
     commentsRef.onChildAdded.listen((event) {
       var status=event.snapshot.value;
       Communicate communicate=Communicate.fromJson(status as Map) ;
      // if(communicate.type!="video"){
         setState(() {
           chats.add(communicate);
         });

       commentsRef2.update({
         "DoctorSeen": chats.length,
       });
      // }


     }).then((){
       print("hurre");


     });
   }catch(er){

   }

    commentsRef1 = FirebaseDatabase.instance.ref("CHATSEEN/$id");
    commentsRef1.onValue.listen((DatabaseEvent event) {
      var data = event.snapshot.value;
      try{
        setState(() {
          chatseen=(data as Map)["UserSeen"];
        });
      }catch(er){

      }
    });



  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 2,right: 10),
              width: width,
              height: height/12,
              color: Theme.of(context).primaryColor,
              child:Row(
                children: [
                  IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  vidCallButtonPress==false?
                  IconButton(
                      onPressed: () async {
                        // Navigator.pop(context);

                        setState(() {
                          msg.text="";
                          vidCallButtonPress=true;
                        });
                        //Navigator.pop(context);

                        getVideoToken(sharedpreff.read("access"),
                            sharedpreff.read("id").toString(),"2","doc","200").then((value) async {
                          var d=jsonDecode(value);
                          print(d.toString());
                          var dt = DateTime.now();

                          String h=dt.hour.toString().length==1? "0"+dt.hour.toString(): dt.hour.toString();
                          String m=dt.minute.toString().length==1? "0"+dt.minute.toString(): dt.minute.toString();

                          String time=h+":"+m;
                          String date=dt.day.toString()+"/"+dt.month.toString()+"/"+dt.year.toString();
                          print(time);
                          commentsRef = FirebaseDatabase.instance.ref("CHATS/$id");
                          var chatID=commentsRef.push().key;
                          commentsRef = FirebaseDatabase.instance.ref("CHATS/$id/$chatID");
                          await commentsRef.set({
                            "msgId":chatID,
                            "type":"video",
                            "active":"yes",
                            "from":"doc",
                            "msg":"Video Calling",
                            "channel":d["channel_name"].toString(),
                            "token":d["token"].toString(),
                            "time":time,
                            "date":date


                          });
                          commentsRef2.update({
                            "DoctorSeen": chats.length,
                          });
                          setState(() {
                            vidCallButtonPress=false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VC(d["channel_name"],d["token"],chatID,id)),
                          );
                        });
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => VC()),
                        // );
                      },
                      icon: Icon(Icons.video_call,size: 30,color: Colors.white)
                  ):
                  Container(),
                  widget.Prescription_id!=0?
                  IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(Icons.list_alt,size: 30,color: Colors.white,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrescriptionView(widget.Prescription_id.toString())),
                      );
                    },
                  ):
                  Container()

                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                    controller: _scrollController,
                    reverse: true,
                    child: Column(
                      children: [
                        Column(
                          children:  List.generate(chats.length, (index) {

                            return Column(
                              children: [
                                const SizedBox(height: 10,),
                                chats[index].from=="user"?
                                Align(
                                    alignment:  Alignment.centerLeft ,
                                    child: ChatBox(chats[index].msg,chats[index].time,0)
                                ):
                                Align(
                                  alignment:  Alignment.centerRight,
                                  child: index<chatseen?ChatBox(chats[index].msg,chats[index].time,2):ChatBox(chats[index].msg,chats[index].time,1),
                                  //ChatBox(chats[index].msg,chats[index].time,0),
                                )
                                ,
                                const SizedBox(height: 10,),
                                index<chats.length-1?
                                chats[index].date!=chats![index+1].date?
                                Container(
                                    width: double.infinity,
                                    // height: 5,
                                    child: Center(
                                      child: Text(chats[index+1].date,style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w900,
                                          // fontStyle: FontStyle.italic,
                                          fontFamily: 'money'


                                      ),),
                                    )

                                ):
                                Container():Container(),
                                // Align(
                                //   alignment:  Alignment.centerRight,
                                //   child: Text("ds"),
                                // ),

                              ],
                            );
                          }),
                          // [
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerRight,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerRight,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerRight,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerRight,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerRight,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: ChatBox(),
                          //   ),
                          //   SizedBox(height: 10,),
                          //   Align(
                          //     alignment: Alignment.centerRight,
                          //     child: ChatBox(),
                          //   ),
                          //
                          //
                          // ],
                        ),
                        Align(
                          alignment:  Alignment.centerRight,
                          child: Text("ds"),
                        ),
                      ],
                    )
                )
            ),
            Container(
                padding: EdgeInsets.only(left: 2,right: 10),
                width: width,
                height: height/12,
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: [
                    Flexible(
                      flex:8,
                      child: TextFormField(
                        controller: msg,

                        keyboardType: TextInputType.multiline,
                        decoration:  InputDecoration(




                          // labelText: "Phone Number",
                            hintText: "Type Here",
                            labelStyle: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontFamily: 'money'

                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(20)),

                            ),
                            hintStyle: TextStyle(
                                color: Theme.of(context).hintColor
                            ),
                            border:  OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            filled: true,
                            fillColor: Colors.white
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.send,color: Colors.white,size: 28,),
                          onPressed: () async{
                            var dt = DateTime.now();
                            String h=dt.hour.toString().length==1? "0"+dt.hour.toString(): dt.hour.toString();
                            String m=dt.minute.toString().length==1? "0"+dt.minute.toString(): dt.minute.toString();

                            String time=h+":"+m;
                            String date=dt.day.toString()+"/"+dt.month.toString()+"/"+dt.year.toString();
                            print(time);
                            commentsRef = FirebaseDatabase.instance.ref("CHATS/$id");
                            var chatID=commentsRef.push().key;
                            commentsRef = FirebaseDatabase.instance.ref("CHATS/$id/$chatID");
                            await commentsRef.set({
                              "msgId":chatID,
                              "type":"chat",
                              "active":"yes",
                              "from":"doc",
                              "msg":msg.text.toString(),
                              "channel":"",
                              "token":"",
                              "time":time,
                              "date":date


                            });

                            setState(() {
                              msg.text="";
                            });
                          },
                        )
                    )
                  ],
                )
            )

          ],
        ),
      ),
    );
  }

}
class ChatBox extends StatelessWidget{


  //String specialized;
  //int rating;
  String txt;
  String time;
  int tick;


  ChatBox(this.txt, this.time,this.tick);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    // TODO: implement build
    return  GestureDetector(
      onTap: (){

        // Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DogDoctorPageDetails(id)),
        //
        // );
      },
      child:  Container(
        width: width/2,
        //height: height/6,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 10,right: 10),
        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
        child:
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child:  Text(txt,style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w900,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'money'


              ),),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child:
              Text(time,style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w900,
                  // fontStyle: FontStyle.italic,
                  fontFamily: 'money'


              ),),
            ),
            tick!=0?
            Align(
              alignment: Alignment.bottomRight,
              child:tick==2?Icon(Icons.check_circle,size: 15,color: Theme.of(context).primaryColor,):Icon(Icons.check_circle_outline,size: 15,color: Theme.of(context).primaryColor,),

            ):Container()

          ],
        ),
        decoration:  BoxDecoration(
          color: Color.fromRGBO(235, 240, 240, 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],

        ),
      ),
    );
  }

}