
import 'dart:convert';

import 'package:alphacue_vet_doc/education/education_add.dart';
import 'package:alphacue_vet_doc/function.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
class EducationItemUpdateDelete extends StatefulWidget{

  int id;

  EducationItemUpdateDelete(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EducationItemUpdateDeleteState();
  }

}
class EducationItemUpdateDeleteState extends State<EducationItemUpdateDelete>{

  var d;
  TextEditingController institution = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController passYear = TextEditingController();
  final sharedpreff = GetStorage();
  bool savePress=false;
  @override
  void initState() {
    getStudyItem(sharedpreff.read("access"),
    widget.id)
        .then((value) {
      setState(() {
        d=jsonDecode(value);
        institution.text=d["institution_name"];
        subject.text=d["subject"];
        passYear.text=d["pass_year"];
       // print(d.length);
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
    else{
      return Scaffold(
        body:Container(
          color: Theme.of(context).highlightColor,
          child: Column(
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
              const SizedBox(height: 15,),
              Container(
                width: width,
                //color: Theme.of(context).primaryColor,
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
                            controller: institution,
                            decoration:  InputDecoration(

                              // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                              //   labelText: "Institute",
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
                          width: width/10,
                          height: height/12,
                          child:  Image(
                              image: AssetImage('assets/images/education_subject.png')
                          ),
                        ),
                        Flexible(

                          child:  TextFormField(
                            controller: subject,
                            decoration:  InputDecoration(

                              // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                              //  labelText: "Subject(ex: Botani)",
                                hintText: "Subject",

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
                          width: width/8,
                          height: height/10,
                          child:  Image(
                              image: AssetImage('assets/images/education_passyear.png')
                          ),
                        ),
                        Flexible(

                          child:  TextFormField(
                            controller: passYear,
                            decoration:  InputDecoration(

                              // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                              //   labelText: "Passing Year",
                                hintText: "Passing Year",

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
                              // studyItemUpdate(sharedpreff.read("access")
                              //     , widget.id,institution.text,subject.text,passYear.text).then((value) {
                              //   Navigator.pop(context);
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => EducationItemUpdateDelete(widget.id)),
                              //   );
                              // });
                              var connectivityResult = await (Connectivity().checkConnectivity());
                              if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi)
                              {
                                setState(() {
                                  savePress=true;
                                });
                                try{
                                  studyItemUpdate(sharedpreff.read("access")
                                      , widget.id,institution.text,subject.text,passYear.text).then((value) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EducationItemUpdateDelete(widget.id)),
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
                                  studyItemDelete(sharedpreff.read("access")
                                      , widget.id).then((value){
                                    var tmp=jsonDecode(value);
                                    if(tmp["msg"]=="deleted"){
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
        ) ,
      );
    }

  }


}