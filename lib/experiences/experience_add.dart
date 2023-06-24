
import 'dart:convert';

import 'package:alphacue_vet_doc/education/education_item_new.dart';
import 'package:alphacue_vet_doc/experiences/experience_add_item.dart';
import 'package:alphacue_vet_doc/experiences/experience_item_new.dart';
import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class ExperienceAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExperienceAddState();
  }

}
class ExperienceAddState extends  State<ExperienceAdd>{

  List item=[];
  var d;

  bool AddnewV=true;
  bool SubnewV=false;
  bool savePress=false;
  final sharedpreff = GetStorage();
  @override
  void initState() {
    getExperience(sharedpreff.read("access"))
        .then((value) {
       try{
         setState(() {
           d=jsonDecode(value);

         });
       }catch(er){
         sharedpreff.erase();
         errorShow(context, "something went wrong");
         Navigator.of(context).pop();
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => LoginPage()),
         );
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    if(d==null){
      return Scaffold(
        body:Container(
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
    return Scaffold(
      backgroundColor: Theme.of(context).highlightColor,
      resizeToAvoidBottomInset: false,
      body: Flex(
        direction: Axis.vertical,
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
            height: height-height/10,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Flex(
                  direction: Axis.vertical,
                  children:[
                  //  const SizedBox(height: 20,),


                    // EducationAddItem(),
                    // const SizedBox(height: 20,),
                    // EducationAddItem(),
                    // const SizedBox(height: 20,),
                    Column(
                      children: List.generate(d.length, (index) {

                        return Column(
                          children: [
                            const SizedBox(height: 20,),
                            ExperienceAddItem(d[index]["id"],d[index]["institution_name"]
                                ,d[index]["job_title"],d[index]["job_from"],d[index]["job_to"]),
                            const SizedBox(height: 20,),
                          ],
                        );
                      }),
                    ),
                    Column(
                      children: List.generate(item.length, (index) {

                        return  Column(
                          children: [
                            const SizedBox(height: 10,),
                            item.elementAt(index),
                            const SizedBox(height: 10,),
                            savePress?
                            LoadingAnimationWidget.staggeredDotsWave(
                              color: Theme.of(context).primaryColor,
                              size: 50,
                            )
                            :ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  shape: StadiumBorder(),
                                  shadowColor: Colors.black,


                                ),
                                onPressed: () async{



                                  if(item.elementAt(index).institution.text.toString().length!=0 &&
                                      item.elementAt(index).jobTitle.text.toString().length!=0 &&
                                      item.elementAt(index).jobFrom.toString().length!=0 &&
                                      item.elementAt(index).jobTo.toString().length!=0 ){


                                    var connectivityResult = await (Connectivity().checkConnectivity());
                                    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                      setState(() {
                                        savePress=true;
                                      });
                                      try{
                                        ExperienceItemAdd(sharedpreff.read("access"),
                                            item.elementAt(index).institution.text,item.elementAt(index).jobTitle.text
                                        ,item.elementAt(index).jobFrom,item.elementAt(index).jobTo
                                        ).then((value) {
                                          var d=jsonDecode(value);
                                          if(d["msg"]=="Experience Added"){

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
                                        sharedpreff.erase();
                                        errorShow(context, "something went wrong");
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginPage()),
                                        );
                                        errorShow(context, "something went wrong");
                                      }
                                    }else{
                                      errorShow(context, "No Network");
                                    }
                                  }
                                  else{
                                    errorShow(context, "Fillup the field");
                                  }


                                },
                                child: Text("save".tr,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),)
                            )

                          ],
                        );
                      }),

                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: AddnewV,
                          child:  IconButton(

                              onPressed: (){

                                setState(() {
                                  item.add(new ExperienceItemNew());
                                  AddnewV=false;
                                  SubnewV=true;
                                  //widget.text.add(new PetRegistrationPage(widget.pets));
                                });
                              }, icon: Icon(Icons.add_circle_outline_sharp,color:Theme.of(context).primaryColor ,)
                          ),
                        ),

                        Visibility(
                          visible: SubnewV,
                          child:IconButton(

                              onPressed: (){

                                setState(() {
                                  if(!item.isEmpty){
                                    item.removeLast();
                                    SubnewV=false;
                                    AddnewV=true;
                                  }

                                  //widget.text.add(new PetRegistrationPage(widget.pets));
                                });
                              }, icon: Icon(Icons.remove,color:Theme.of(context).primaryColor ,)
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const SizedBox(height: 20,),
                    const SizedBox(height: 20,),
                    const SizedBox(height: 300,),



                  ]
              ),
            ),
          )
        ],
      ),
    );
  }

}