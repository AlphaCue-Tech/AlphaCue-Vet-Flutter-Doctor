
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ExperienceItemNew extends StatefulWidget{

  String jobFrom="";
  String jobTo="";
  TextEditingController institution = TextEditingController();
  TextEditingController jobTitle = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExperienceItemNewState();
  }

}
class ExperienceItemNewState extends State<ExperienceItemNew>{





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
                width: width/12,
                height: height/14,
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
                      border: const OutlineInputBorder(),
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
                width: width/12,
                height: height/14,
                child:  Image(
                    image: AssetImage('assets/images/title.png')
                ),
              ),
              Flexible(

                child:  TextFormField(
                    controller:widget.jobTitle,
                  decoration:  InputDecoration(

                    // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                   //   labelText: "Job Title",
                      hintText: "Job Title",

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
                      border: const OutlineInputBorder(),
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
              // Container(
              //   width: width/12,
              //   height: height/14,
              //   child:  Image(
              //       image: AssetImage('assets/images/date_from.png')
              //   ),
              // ),
              Flexible(

                child:  Row(
                  children: [
                    Text("From".tr+" : ",style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 16),),
                    Text(widget.jobFrom,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 16),),
                    GestureDetector(
                        onTap: () async {
                          await showDatePicker(

                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2025),
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
                              widget.jobFrom=value!.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
                            });
                          });
                        },
                        child: Icon(Icons.calendar_month,
                          size: 40,
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
              //       image: AssetImage('assets/images/date_to.png')
              //   ),
              // ),
              Flexible(

                  child:  Row(
                    children: [
                      Text("end".tr+" : ",style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 16),),
                      Text(widget.jobTo,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 16),),
                      GestureDetector(
                          onTap: () async {
                            await showDatePicker(

                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:DateTime.now(),
                              lastDate: DateTime(2025),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).primaryColor, // <-- SEE HERE
                                      onPrimary:Theme.of(context).highlightColor, // <-- SEE HERE
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
                                widget.jobTo=value!.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
                              });
                            });
                          },
                          child: Icon(Icons.calendar_month,
                            size: 40,
                            color: Theme.of(context).highlightColor,
                          )

                      ),
                    ],

                  )
              ),
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