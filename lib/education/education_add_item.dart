
import 'package:alphacue_vet_doc/education/education_item_update_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EducationAddItem extends StatefulWidget{

  int id;
  String institution;
  String subject;
  String passYear;


  EducationAddItem(this.id,this.institution, this.subject, this.passYear);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EducationAddItemState();
  }

}
class EducationAddItemState extends State<EducationAddItem>{
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
          MaterialPageRoute(builder: (context) => EducationItemUpdateDelete(widget.id)),
        );
      },
      child: Container(
        width: width,

        //height: height/6,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10,right: 10),
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              width: width/8,
              height: height/10,
              child:  Image(
                  image: AssetImage('assets/images/education_institution.png')
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Text(widget.institution,style:TextStyle(color: Theme.of(context).highlightColor,fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Flexible(
                    child: Column(
                      children: [
                        Container(
                          width: width/8,
                          height: height/10,
                          child:  Image(
                              image: AssetImage('assets/images/education_subject.png')
                          ),
                        ),
                        Text("Subject".tr,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                ),
                Flexible(
                    child: Text(" : "+widget.subject,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: 20,fontWeight: FontWeight.bold),),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        width: width/8,
                        height: height/10,
                        child:  Image(
                            image: AssetImage('assets/images/education_passyear.png')
                        ),
                      ),
                      Text("Pass Year".tr,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: 16,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Flexible(
                  child: Text(" : "+widget.passYear,style: TextStyle(color: Theme.of(context).highlightColor,fontSize: 20,fontWeight: FontWeight.bold),),
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
      ),

    );
  }

}