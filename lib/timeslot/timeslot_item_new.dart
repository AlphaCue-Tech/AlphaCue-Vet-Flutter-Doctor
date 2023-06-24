
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TimeSlotItemNew extends StatefulWidget{

  String time="";
  String weekday="SUNDAY";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TimeSlotItemNewState();
  }

}
class TimeSlotItemNewState extends State<TimeSlotItemNew>{

 // String time="HH:mm:ss";
  List<String> weekdaylist=["SUNDAY","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY"];

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  Container(
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
                      Text(widget.time,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),),
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
                                widget.time=value!.hour.toString()+":"+value!.minute.toString()+":00";
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
                      icon: Icon(Icons.arrow_downward,color:Theme.of(context).highlightColor,),
                      isExpanded: true,
                      value: widget.weekday,
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
                          widget.weekday=val!;
                        });
                      }
                  ),
              )
            ],
          ),

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
    );
  }

}