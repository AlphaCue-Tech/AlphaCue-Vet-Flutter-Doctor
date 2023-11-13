
import 'package:alphacue_vet_doc/appointment/appointmentlist.dart';
import 'package:alphacue_vet_doc/education/education_add.dart';
import 'package:alphacue_vet_doc/experiences/experience_add.dart';
import 'package:alphacue_vet_doc/prescription/prescript.dart';
import 'package:alphacue_vet_doc/settings.dart';
import 'package:alphacue_vet_doc/timeslot/timeslots_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }

}

class HomePageState extends State<HomePage>{

  final sharedpreff = GetStorage();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // setState(() {


  //  });
  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: width,
      height: height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            child:  Container(
              width: width/6,
              height: height/15,

              decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.rectangle,
                  image:  DecorationImage(
                    alignment: Alignment.center,
                    matchTextDirection: true,
                    repeat: ImageRepeat.noRepeat,
                    image: AssetImage('assets/images/logo.jpg'),
                  )
              ),

            ),
          ),
          // GridView.count(crossAxisCount: 3,
          //
          // children: [
          //  Container(
          //    width: width/4,
          //    height: height/12,
          //    color:Colors.black
          //  ),
          //   Container(
          //       width: width/4,
          //       height: height/12,
          //       color:Colors.black
          //   ),
          //   Container(
          //       width: width/4,
          //       height: height/12,
          //       color:Colors.black
          //   ),
          // ],
          //
          //
          // )
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentList()),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Presscription()),
                  // );
                },
                child: Container(
                  
                  width: width/2.5,
                  height: height/5,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        width: width/5,
                        height: height/10,
                        decoration: BoxDecoration(
                            color: Colors.transparent,

                            image:  DecorationImage(
                              alignment: Alignment.center,
                              matchTextDirection: true,
                              repeat: ImageRepeat.noRepeat,
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/appointment.png'),
                            )
                        ),

                      ),

                      Text("Appointments".tr,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: width/24,decoration: TextDecoration.none),),
                    ],
                  ),
                  decoration:  BoxDecoration(
                      color:Theme.of(context).primaryColor,

                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                ),
              ),
             GestureDetector(
               onTap: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => EducationAdd()),
                 );
               },
               child: Container(

                 width: width/2.5,
                 height: height/5,
                 padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(

                       width: width/5,
                       height: height/10,
                       decoration: BoxDecoration(
                           color: Colors.transparent,

                           image:  DecorationImage(
                             alignment: Alignment.center,
                             matchTextDirection: true,
                             repeat: ImageRepeat.noRepeat,
                             fit: BoxFit.contain,
                             image: AssetImage('assets/images/education.png'),
                           )
                       ),

                     ),

                     Text("Education".tr,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: width/24,decoration: TextDecoration.none),),
                   ],
                 ),
                 decoration:  BoxDecoration(
                     color:Theme.of(context).primaryColor,

                     borderRadius: BorderRadius.all(Radius.circular(15))
                 ),
               ),
             ),

            ],
          ),
          SizedBox(
            height: 20,
          )
          ,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeSlotAdd()),
                  );
                },
                child: Container(

                  width: width/2.5,
                  height: height/5,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        width: width/5,
                        height: height/10,
                        decoration: BoxDecoration(
                            color: Colors.transparent,

                            image:  DecorationImage(
                              alignment: Alignment.center,
                              matchTextDirection: true,
                              repeat: ImageRepeat.noRepeat,
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/timeslots.png'),
                            )
                        ),

                      ),

                      Text("Time Slot".tr,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: width/24,decoration: TextDecoration.none),),
                    ],
                  ),
                  decoration:  BoxDecoration(
                      color:Theme.of(context).primaryColor,

                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExperienceAdd()),
                  );
                },
                child: Container(

                  width: width/2.5,
                  height: height/5,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        width: width/5,
                        height: height/10,
                        decoration: BoxDecoration(
                            color: Colors.transparent,

                            image:  DecorationImage(
                              alignment: Alignment.center,
                              matchTextDirection: true,
                              repeat: ImageRepeat.noRepeat,
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/experiences.png'),
                            )
                        ),

                      ),

                      Text("Experience".tr,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: width/24,decoration: TextDecoration.none),),
                    ],
                  ),
                  decoration:  BoxDecoration(
                      color:Theme.of(context).primaryColor,

                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20,
          )



        ],
      ),
    );
  }


}