
import 'package:alphacue_vet_doc/timeslot/timeslot_item_update_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TimeSlotAddItem extends StatefulWidget{
  int id;

  String slot;
  String weekday;


  TimeSlotAddItem(this.id,this.slot, this.weekday);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TimeSlotAddItemState();
  }

}
class TimeSlotAddItemState extends State<TimeSlotAddItem>{
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  GestureDetector(
      onTap: (){
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TimeSlotItemUpdateDelete(widget.id)),
        );
      },
      child: Container(
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
                Text(widget.slot,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: 20),),
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
                Text("week day".tr+" : "+widget.weekday,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: 20),),
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
      ),
    );
  }

}