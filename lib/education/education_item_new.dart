
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class EducationItemNew extends StatefulWidget{

  TextEditingController institution = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController passYear = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EducationItemNewState();
  }

}
class EducationItemNewState extends State<EducationItemNew>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Container(
      width: width,

      //height: height/6,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10,right: 10),
      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                width: width/10,
                height: height/12,
                child:  Image(
                    image: AssetImage('assets/images/education_institution.png')
                ),
              ),
              Flexible(

                child:  TextFormField(
                    controller: widget.institution,
                  decoration:  InputDecoration(

                    // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                     // labelText: "Institute",
                      hintText: "Institute",

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
                      filled: true,
                      fillColor: Colors.white
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                width: width/10,
                height: height/12,
                child:  Image(
                    image: AssetImage('assets/images/education_subject.png')
                ),
              ),
              Flexible(

                child:  TextFormField(
                    controller: widget.subject,
                  decoration:  InputDecoration(

                    // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                      //labelText: "Subject(ex: Botani)",
                      hintText: "Subject",

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
                      filled: true,
                      fillColor: Colors.white
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                width: width/10,
                height: height/12,
                child:  Image(
                    image: AssetImage('assets/images/education_passyear.png')
                ),
              ),
              Flexible(

                child:  TextFormField(
                    controller: widget.passYear,
                  decoration:  InputDecoration(

                    // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                      //labelText: "Passing Year",
                      hintText: "Passing Year",

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
                      filled: true,
                      fillColor: Colors.white
                  ),
                ),
              ),
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
    );
  }

}