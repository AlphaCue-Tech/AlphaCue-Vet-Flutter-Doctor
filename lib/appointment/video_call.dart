
import 'package:alphacue_vet_doc/function.dart';
import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:firebase_database/firebase_database.dart';
class VC extends StatefulWidget{
  String cName;
  String tok;
  String chatId;
  String id;


  VC(this.cName, this.tok,this.chatId,this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VideoCall();
  }

}


class VideoCall extends State<VC>{

  late String a;
  late String b;
  var client ;










  @override
  initState()  {

    //super.initState();

    a=widget.cName;
    b=widget.tok;
    print("hurrah");
    print(a);
    print(b);
    client= AgoraClient(
      agoraChannelData: AgoraChannelData(

          enableDualStreamMode: true

      ),
      agoraConnectionData: AgoraConnectionData(

        appId: "124db1da18c0476584103e1bf9fc6351",
        channelName: a,
        tempToken:b,
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );
    setState(() {
      initAgora();
    });


  }






  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                showNumberOfUsers: true,
              ),
              AgoraVideoButtons(
                  client: client,
                  onDisconnect: (){
                    String chatID=widget.chatId;
                    String id=widget.id;
                    var  commentsRef = FirebaseDatabase.instance.ref("CHATS/$id/$chatID");
                    commentsRef.update({
                      "active": "no",

                    });
                    Navigator.pop(context);
                  },

              ),
            ],
          ),
        ),

    );
  }

}


