
import 'dart:convert';

import 'package:alphacue_vet_doc/education/education_add_item.dart';
import 'package:alphacue_vet_doc/education/education_item_new.dart';
import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class EducationAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EducationAddState();
  }

}
class EducationAddState extends State<EducationAdd>{

  List item=[];
  var d;
  bool AddnewV=true;
  bool SubnewV=false;
  bool savePress=false;
  final sharedpreff = GetStorage();
  @override
  void initState() {


    print(sharedpreff.read("access")+"sdddddddddddddddddd");

   try{
     getStudy(sharedpreff.read("access"))
         .then((value) {
       setState(() {
         d=jsonDecode(value);
         print(d.length);
       });
     });
   }catch(er){
     sharedpreff.erase();
     errorShow(context, "something went wrong");

   }
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
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
          ),
        ),
      );
    }
    else{
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                  width: width,
                  height: height/12,
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,size: 30,color: Theme.of(context).highlightColor,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      Text("Education".tr,style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).highlightColor,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic


                      ),),
                    ],
                  )
                //Icon(Icons.arrow_back,size: 30,color: Theme.of(context).highlightColor,),
              ),
              Expanded(
                  child: Container(
                    color: Theme.of(context).highlightColor,
                    width: width,
                    // height: height-height/10,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Flex(
                          direction: Axis.vertical,
                          children:[
                            //const SizedBox(height: 20,),



                            //const SizedBox(height: 20,),
                            // EducationAddItem(),
                            // const SizedBox(height: 20,),
                            // EducationAddItem(),
                            // const SizedBox(height: 20,),
                            Column(
                              children: List.generate(d.length, (index) {

                                return Column(
                                  children: [
                                    const SizedBox(height: 20,),
                                    EducationAddItem(d[index]["id"],d[index]["institution_name"],d[index]["subject"],d[index]["pass_year"]),
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
                                              item.elementAt(index).subject.text.toString().length!=0 &&
                                              item.elementAt(index).passYear.text.toString().length!=0){


                                            var connectivityResult = await (Connectivity().checkConnectivity());
                                            if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

                                              setState(() {
                                                savePress=true;
                                              });

                                              try{
                                                studyItemUpAdd(sharedpreff.read("access"),sharedpreff.read("id"),
                                                    item.elementAt(index).institution.text,item.elementAt(index).subject.text
                                                    ,item.elementAt(index).passYear.text
                                                ).then((value) {
                                                  var d=jsonDecode(value);
                                                  if(d["msg"]=="Study Added"){
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => EducationAdd()),
                                                    );
                                                  }
                                                });
                                              }catch(er){
                                                setState(() {
                                                  savePress=false;
                                                });
                                                sharedpreff.erase();
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
                                          item.add(new EducationItemNew());
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
              )

            ],
          ),
        ),
      );
    }

  }

}