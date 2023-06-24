
import 'dart:convert';

import 'package:alphacue_vet_doc/appointment/video_call.dart';
import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/models.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';
class ChatDetails extends StatefulWidget{

  String id;


  ChatDetails(this.id);

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
  final sharedpreff=GetStorage();
  var commentsRef;
  @override
  void initState() {
    // TODO: implement initState

   //  getVideoToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwNzI0ODY5LCJpYXQiOjE2ODU1NDA4NjksImp0aSI6ImVkMWQ1NWEyZmY1ZTRmMDk5OGNiMzFjMzFjNTMwYWU0IiwidXNlcl9pZCI6MX0.fNchXc09V9T8lDSkMSuxXAvpapWSyKrvQtzOkkWPmcw");
    id=widget.id.toString();
    print(id+"sdddddddddddddddddddddddddd");

   try{
     commentsRef = FirebaseDatabase.instance.ref("CHATS/$id");
     chats.clear();
     commentsRef.onChildAdded.listen((event) {
       var status=event.snapshot.value;

       Communicate communicate=Communicate.fromJson(status as Map) ;
       if(communicate.type!="video"){
         setState(() {
           chats.add(communicate);
         });
       }
       else{

       }

     });
   }catch(er){

   }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 2,right: 10),
            width: width,
            height: height/10,
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
                Text(widget.id.toString(),style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'money'


                ),),
                IconButton(
                    onPressed: () async {
                     // Navigator.pop(context);

                      setState(() {
                        msg.text="";
                      });
                      //Navigator.pop(context);

                      getVideoToken(sharedpreff.read("access"),
                          sharedpreff.read("id").toString(),"2","doc","200").then((value) async {
                        var d=jsonDecode(value);
                        print(d.toString());
                        var dt = DateTime.now();
                        String time=dt.hour.toString()+":"+dt.minute.toString();
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
                )

              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                 reverse: true,
                child: Column(
                  children:  List.generate(chats.length, (index) {

                    return Column(
                      children: [
                        const SizedBox(height: 10,),
                          Align(
                            alignment: chats[index].from=="user"? Alignment.centerLeft : Alignment.centerRight,
                            child: ChatBox(chats[index].msg,chats[index].time),
                          ),
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
                          String time=dt.hour.toString()+":"+dt.minute.toString();
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
    );
  }

}
class ChatBox extends StatelessWidget{


  //String specialized;
  //int rating;
  String txt;
  String time;


  ChatBox(this.txt, this.time);

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
            )

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