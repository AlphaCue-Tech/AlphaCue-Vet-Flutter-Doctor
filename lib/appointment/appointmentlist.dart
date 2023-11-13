
import 'dart:convert';

import 'package:alphacue_vet_doc/appointment/appointment_details.dart';
import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';
class AppointmentList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppointmentListState();
  }
}
class AppointmentListState extends State<AppointmentList>{


var d;
List<dynamic>? appointments;
@override
  void initState() {
  final sharedpreff = GetStorage();
 try{
   getAppointmentList(sharedpreff.read("access"))
       .then((value) {

     print(value);
     setState(() {
       d=jsonDecode(value);
       appointments= d != null ? List.from(d) : null;
       print(d.toString());
     });
    // appointments= d != null ? List.from(d) : null;

   });
 }catch(er){
   errorShow(context, "Something went Wrong");
 }
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    // TODO: implement build
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
   else{
      return Scaffold(
        body:SafeArea(
          child:  Column(
            children: [
              Container(
                  width: width,
                  height: height/12,
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,size: 30,color: Theme.of(context).highlightColor,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      Text("Appointments".tr,style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic


                      ),),

                    ],
                  )
                //Icon(Icons.arrow_back,size: 30,color: Theme.of(context).highlightColor,),
              ),
              Expanded(
                  child:  Container(
                    color: Theme.of(context).highlightColor,
                    width: width,
                    // height: height-height/12,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(appointments!.length, (index) {

                          return Column(
                            children: [
                              const SizedBox(height:  20),

                              ListItem(appointments![index]["id"],appointments![index]["patient_type"]
                                  ,appointments![index]["date"],appointments![index]["time"]
                              ),
                              const SizedBox(height:  20),
                            ],
                          );
                        }),
                      ),
                    ),
                  )
              )

            ],
          ),
        )
      );
    }
  }

}
class ListItem extends StatelessWidget{
  int id;
  String type;
  String date ;
  String time;


  ListItem(this.id, this.type, this.date, this.time);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    // TODO: implement build
    return  GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppointmentDetails(id)),
        );
      },
      child: Container(
        width: width,

        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 10,right: 10),
        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            // Text("Name".tr+" : "+name,style: TextStyle(
            //     fontSize: 18,
            //     color: Theme.of(context).highlightColor,
            //     fontWeight: FontWeight.w900,
            //     fontStyle: FontStyle.italic
            //
            //
            // ),),
            // Text("Gender".tr+" : "+gender,style: TextStyle(
            //     fontSize: 18,
            //     color: Theme.of(context).highlightColor,
            //     fontWeight: FontWeight.w900,
            //     fontStyle: FontStyle.italic
            //
            //
            // ),),
            // Text("Breed".tr+" : "+breed,style: TextStyle(
            //     fontSize: 18,
            //     color: Theme.of(context).highlightColor,
            //     fontWeight: FontWeight.w900,
            //     fontStyle: FontStyle.italic
            //
            //
            // ),),
            SizedBox(
              height: 5,
            ),
            // Text("Date of birth".tr+" : "+dob,style: TextStyle(
            //     fontSize: 15,
            //     color: Theme.of(context).highlightColor,
            //     fontWeight: FontWeight.w900,
            //     fontStyle: FontStyle.italic
            //
            //
            // ),),
            // SizedBox(
            //   height: 5,
            // ),
            Text("Appointment Date".tr+" : "+date,style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).highlightColor,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic


            ),),
            SizedBox(
              height: 5,
            ),
            Text("Appointment Time".tr+" : "+time,style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).highlightColor,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic


            ),),
            SizedBox(
              height: 5,
            ),
            Text("Appointment Type".tr+" : "+type,style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).highlightColor,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic


            ),),
            SizedBox(
              height: 5,
            ),

          ],

        ),
        decoration:  BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),


        ),
      ),
    );
  }

}