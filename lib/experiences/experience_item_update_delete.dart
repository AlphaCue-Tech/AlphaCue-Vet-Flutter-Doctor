
import 'dart:convert';

import 'package:alphacue_vet_doc/experiences/experience_add.dart';
import 'package:alphacue_vet_doc/function.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
class ExperienceItemUpdateDelete extends StatefulWidget{
  int id;


  ExperienceItemUpdateDelete(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExperienceItemUpdateDeleteState();
  }

}

class ExperienceItemUpdateDeleteState extends State<ExperienceItemUpdateDelete>{

  String jobTo="";
  String jobFrom="";
  var d;
  TextEditingController institution = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  final sharedpreff = GetStorage();
  bool savePress=false;
  @override
  void initState() {
    getExperienceItem(sharedpreff.read("access")
    ,widget.id)
        .then((value) {
      setState(() {
        d=jsonDecode(value);

        jobTo=d["job_to"];
        jobFrom=d["job_from"];
        institution.text=d["institution_name"];
        jobTitle.text=d["job_title"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
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
      const SizedBox(height: 10,),
      Container(
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
                      controller: institution,
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
                      controller: jobTitle,
                    decoration:  InputDecoration(

                      // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                       // labelText: "Job Title",
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
                        Text(jobFrom,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 16),),
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
                                  jobFrom=value!.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
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
                        Text(jobTo,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 16),),
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
                                  jobTo=value!.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
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
                          ExperienceItemUpdate(sharedpreff.read("access")
                              , widget.id,institution.text,jobTitle.text,jobFrom,jobTo).then((value) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExperienceItemUpdateDelete(widget.id)),
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
                          ExperienceItemDelete(sharedpreff.read("access")
                              , widget.id).then((value){
                            var tmp=jsonDecode(value);
                            if(tmp["msg"]=="deleted"){
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ExperienceAdd()),
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