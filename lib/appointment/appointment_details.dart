import 'dart:convert';

import 'package:alphacue_vet_doc/appointment/communicate.dart';
import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/login_page.dart';
import 'package:alphacue_vet_doc/prescription/precriptionview.dart';
import 'package:alphacue_vet_doc/prescription/prescript.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';
class AppointmentDetails extends StatefulWidget{
  int id;

  AppointmentDetails(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppointmentDetailsState();
  }

}
class AppointmentDetailsState extends State<AppointmentDetails>{
  var d;
  final sharedpreff = GetStorage();
  @override
  void initState() {

   try{
     getAppointment(sharedpreff.read("access"),widget.id)
         .then((value) {

       setState(() {
         d=jsonDecode(value);
         print(d);
       });

     });
   }
   catch(er){
       print(er.toString());

     sharedpreff.erase();
     errorShow(context, "something went wrong");
     Navigator.of(context).pop();
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => LoginPage()),
     );
   }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    if(d==null){
      return Scaffold(
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Column(

        children: [
          Container(
            width: width,
            height: height/10,
            color: Theme.of(context).primaryColor,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
              ),
            )
          ),
          Container(
            width:width,
            height: height-height/10,
            color: Theme.of(context).highlightColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: width,

                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    child: Flex(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      direction: Axis.vertical,
                      children: [
                        Text("Name".tr+" : "+d["pet"]["name"],style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic


                        ),),
                        Text("Gender".tr+" : "+d["pet"]["gender"],style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic


                        ),),
                        Text("Breed".tr+" : "+d["pet"]["breed"],style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic


                        ),),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Date of birth".tr+" : "+d["pet"]["dob"],style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic


                        ),),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Appointment Date".tr+" : "+d["date"],style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic


                        ),),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child:  Text("Problems".tr,style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).highlightColor,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic


                          ),),
                        ),
                        Text(d["problem"],style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).highlightColor,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic


                        ),),

                      ],

                    ),
                    decoration:  BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),


                    ),
                  ),
                  d["prescription_id"].toString()!="0"?
                  ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: StadiumBorder(),
                        shadowColor: Colors.black,


                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrescriptionView(d["prescription_id"].toString())),
                        );
                      },
                      child: Text("View Prescription".tr,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),)
                  )
                  :ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: StadiumBorder(),
                        shadowColor: Colors.black,


                      ),
                      onPressed: () async {
                         Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Presscription(d["id"].toString())),
                        );
                      },


                      child: Text("Write Prescription".tr,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),)
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: StadiumBorder(),
                        shadowColor: Colors.black,


                      ),
                      onPressed: () async {
                       // Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatDetails(widget.id.toString())),
                        );
                      },


                      child: Text("Start Chat".tr,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),)
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }


}