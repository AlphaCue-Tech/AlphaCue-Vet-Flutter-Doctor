import 'dart:convert';

import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class PrescriptionView extends StatefulWidget{
  String id;

  PrescriptionView(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PrescriptionViewState();
  }

}
class PrescriptionViewState extends State<PrescriptionView>{

  final sharedpreff = GetStorage();

  List<dynamic>? med=[];
  var d;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrescriptionView(sharedpreff.read("access"),widget.id).then((value) {
     try{
       setState(() {
         d=jsonDecode(value);
         med = d != null ? List.from(d["medicines"]) : null;
       });
     }
     catch(er){
       sharedpreff.erase();
       errorShow(context, "something went wrong");
       Navigator.of(context).pop();
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => LoginPage()),
       );
     }

      print(d.toString());
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
            Container(
                padding: EdgeInsets.all(20),
                width: width,
                height: height-height/10,
                color: Theme.of(context).highlightColor,

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:  Text("Alphacue Animal Care".tr,style: TextStyle(
                          fontSize: width/18,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,



                        ),),
                      ),
                      Text("Doctor".tr+": "+d["appointment"]["doc"]["user"]["name"],style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),
                      Text("Phone".tr+": "+d["appointment"]["doc"]["user"]["phone"],style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),
                      SizedBox(height: 30,),
                      Text("Weight".tr+": "+d["weight"].toString(),style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),

                      Text("Temperature".tr+": "+d["temperature"].toString(),style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),
                      SizedBox(height: 30,),
                      Text("Clinical History".tr+": ",style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(d["clinical_history"].length, (index) {

                          return Text(d["clinical_history"][index],style: TextStyle(
                            fontSize: width/20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900,



                          ),);
                        }),
                      ),
                      SizedBox(height: 30,),

                      Text("Vaccinations".tr+": ",style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(d["vaccinations"].length, (index) {

                          return Text(d["vaccinations"][index],style: TextStyle(
                            fontSize: width/20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900,



                          ),);
                        }),
                      ),
                      SizedBox(height: 30,),
                      Text("Tests".tr+": ",style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(d["tests"].length, (index) {

                          return Text(d["tests"][index],style: TextStyle(
                            fontSize: width/20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900,



                          ),);
                        }),
                      ),

                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.center,
                        child:  Text("Medicines".tr,style: TextStyle(
                          fontSize: width/18,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,



                        ),),
                      ),
                      Column(
                        children: List.generate(med!.length, (index) {
                          return Column(
                            children: [
                              SizedBox(height: 5,),
                              Medicine(med![index]["medicine_name"], med![index]["dose"]
                                  ,med![index]["time"], med![index]["note"]),
                              SizedBox(height: 5,),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: 30,),
                      Text("Advice".tr+": "+d["advice"].toString(),style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),

                      Text("Consult after".tr+": "+d["consult_after_days"].toString()+" days",style: TextStyle(
                        fontSize: width/20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,



                      ),),
                      SizedBox(height: 30,),
                    ],
                  ),
                )
              //Icon(Icons.arrow_back,size: 30,color: Theme.of(context).highlightColor,),
            ),
          ],
        ),
      );
    }

  }


}

class Medicine extends StatelessWidget{
  String name;
  String dose;
  String time;
  String note;


  Medicine(this.name, this.dose, this.time, this.note);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(10),

      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name".tr+": "+name,style: TextStyle(
            fontSize: width/20,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.w900,



          ),),
          Text("Dose".tr+": "+dose,style: TextStyle(
            fontSize: width/20,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.w900,



          ),),
          Text("Feeding Time".tr+": "+time,style: TextStyle(
            fontSize: width/20,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.w900,



          ),),
          Text("Note".tr+": "+note,style: TextStyle(
            fontSize: width/20,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.w900,



          ),),
        ],
      ),
      decoration:  BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],

      ),
    );
  }

}