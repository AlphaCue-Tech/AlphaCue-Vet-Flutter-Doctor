
import 'package:alphacue_vet_doc/experiences/experience_item_update_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ExperienceAddItem extends StatefulWidget{
  int id;
  String institution;
  String jobTitle;
  String dateFrom;
  String dateTo;


  ExperienceAddItem(
      this.id,this.institution, this.jobTitle, this.dateFrom, this.dateTo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExperienceAddItemState();
  }

}
class ExperienceAddItemState extends State<ExperienceAddItem>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  GestureDetector(
      onTap: (){
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExperienceItemUpdateDelete(widget.id)),
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
                      image: AssetImage('assets/images/education_institution.png')
                  ),
                ),
                Text(widget.institution,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor,fontSize: 20),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Container(
                  width: width/12,
                  height: height/14,
                  child:  Image(
                      image: AssetImage('assets/images/title.png')
                  ),
                ),
                Text(widget.jobTitle,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor,fontSize: 20),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                // Container(
                //   width: width/12,
                //   height: height/14,
                //   child:  Image(
                //       image: AssetImage('assets/images/date_from.png')
                //   ),
                // ),
                Text("From".tr+" : "+widget.dateFrom,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor,fontSize: 20),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                // Container(
                //   width: width/12,
                //   height: height/14,
                //   child:  Image(
                //       image: AssetImage('assets/images/date_to.png')
                //   ),
                // ),
                Text("end".tr+" : "+widget.dateTo,style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor,fontSize: 20),),
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
      ),
    );
  }

}