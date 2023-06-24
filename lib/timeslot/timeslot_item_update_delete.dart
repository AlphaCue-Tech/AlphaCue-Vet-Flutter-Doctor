
import 'dart:convert';

import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/timeslot/timeslots_add.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
class TimeSlotItemUpdateDelete extends StatefulWidget{

  int id;

  TimeSlotItemUpdateDelete(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TimeSlotItemUpdateDeleteState();
  }


}
class TimeSlotItemUpdateDeleteState extends State<TimeSlotItemUpdateDelete>{
  String time="HH:mm:ss";
  List<String> weekdaylist=["SUNDAY","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY"];
  String weekday="SUNDAY";

  var d;
  final sharedpreff = GetStorage();
  bool savePress=false;
  @override
  void initState() {
    getTimeSlotItem(sharedpreff.read("access")
    ,widget.id).then((value) {
      setState(() {
        d=jsonDecode(value);
        print(d.length);
        weekday=d["week_day"];
        time=d["slot"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    if(d==null){
      return Scaffold(
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      );
    }
    else{
      return Scaffold(
        backgroundColor: Theme.of(context).highlightColor,
        body: Column(
          children: [
            Container(
                width: width,
                height: height/10,
                color: Theme.of(context).primaryColor,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back,size: 30,color: Theme.of(context).highlightColor,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              //Icon(Icons.arrow_back,size: 30,color: Theme.of(context).highlightColor,),
            ),
            Container(
              width: width,

              //height: height/6,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10,right: 10),
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Container(
                        width: width/12,
                        height: height/14,
                        child:  Image(
                            image: AssetImage('assets/images/timeslots.png')
                        ),
                      ),
                      Flexible(

                          child:  Row(
                            children: [
                              Text("Time Slot".tr+" : ",style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),),
                              Text(time,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),),
                              GestureDetector(
                                  onTap: () async {
                                    await showTimePicker(

                                      context: context,
                                      initialTime: TimeOfDay.now(),

                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(

                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context).primaryColor, // <-- SEE HERE
                                              onPrimary: Theme.of(context).highlightColor, // <-- SEE HERE
                                              onSurface:Theme.of(context).primaryColor, // <-- SEE HERE
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors.red, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    ).then((value) {
                                      print(value.toString());
                                      setState(() {
                                        time=value!.hour.toString()+":"+value!.minute.toString()+":00";
                                      });
                                    });
                                  },
                                  child: Icon(Icons.access_time_rounded,
                                    size: 35,
                                    color: Theme.of(context).highlightColor,
                                  )

                              ),
                            ],

                          )
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      // Container(
                      //   width: width/12,
                      //   height: height/14,
                      //   child:  Image(
                      //       image: AssetImage('assets/images/weekslot.png')
                      //   ),
                      // ),
                      Text("week day".tr+" : ",style: TextStyle(color: Theme.of(context).highlightColor,fontSize: 20),),

                      Flexible(
                        child:DropdownButton(
                            icon: Icon(Icons.arrow_downward,color: Theme.of(context).highlightColor,),
                            isExpanded: true,
                            value: weekday,
                            items: weekdaylist
                                .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child:  Text(value,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: 20),),
                                ))
                                .toList()

                            ,
                            onChanged: (val){
                              setState(() {
                                weekday=val!;
                              });
                            }
                        ),
                      )
                    ],
                  ),
                  savePress?
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  )
                      :Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).highlightColor,
                            shape: StadiumBorder(),
                            shadowColor: Colors.black,


                          ),
                          onPressed: () async{

                            var connectivityResult = await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi)
                            {
                              setState(() {
                                savePress=true;
                              });
                              try{
                                TimeSlotItemUpdate(sharedpreff.read("access")
                                    , widget.id,time,weekday).then((value) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TimeSlotItemUpdateDelete(widget.id)),
                                  );
                                });
                              }catch(er){
                                setState(() {
                                  savePress=false;
                                });
                                errorShow(context, "something went wrong");
                              }
                            }else{
                              errorShow(context, "No Network");
                            }

                          },
                          child: Text("update".tr,style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 20),)
                      ),
                      ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).highlightColor,
                            shape: StadiumBorder(),
                            shadowColor: Colors.black,


                          ),
                          onPressed: () async{

                            var connectivityResult = await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi)
                            {
                              setState(() {
                                savePress=true;
                              });
                              try{
                                TimeSlotItemDelete(sharedpreff.read("access")
                                    , widget.id).then((value){
                                  var tmp=jsonDecode(value);
                                  if(tmp["msg"]=="deleted"){
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TimeSlotAdd()),
                                    );
                                  }
                                });
                              }catch(er){
                                setState(() {
                                  savePress=false;
                                });
                                errorShow(context, "something went wrong");
                              }
                            }else{
                              errorShow(context, "No Network");
                            }

                          },
                          child: Text("delete".tr,style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 20),)
                      )
                    ],
                  )

                ],

              ),

              decoration:  BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],

              ),
            )
          ],
        ),
      );
    }

  }

}