
import 'dart:convert';

import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/login_page.dart';
import 'package:alphacue_vet_doc/prescription/precriptionview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity/connectivity.dart';
class Presscription extends StatefulWidget{
  String appointmentId;

  Presscription(this.appointmentId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PresscriptionState();
  }

}
class PresscriptionState extends State<Presscription>{
  final sharedpreff = GetStorage();
  List<bool> clinichistory=[false,false,false,false,false,false,false,false,false];
  List<String> clinichistoryData=[
    "Anaemia",
    "Alopecia",
    "Anorexia",
    "Common Cold",
    "Constipation",
    "Diarrhea",
    "Fever",
    "Pneumonia",
    "Vomiting"
  ];

  List<bool> vaccinations=[false,false,false,false];
  List<String> vaccinationsData= [
    "Deworming",
    "C.D.",
    "Rabies",
    "Flu"
  ];

  List<bool> tests=[false,false,false,false,false];
  List<String> testsData= [
    "Blood Test",
    "Urine Test",
    "FIP Test",
    "Skin Test",
    "Ear Mites Test"
  ];

  List medicines=[new Medicine()];

  TextEditingController weight=TextEditingController();
  TextEditingController temp=TextEditingController();
  TextEditingController consult=TextEditingController();
  TextEditingController advice=TextEditingController();
  bool savepress=false;

  var d;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.appointmentId);
    getPrescriptionData(sharedpreff.read("access")).then((value){
      try{
        d=jsonDecode(value);
        print(d.toString());
      }catch(er){
       // sharedpreff.erase();
        errorShow(context, "something went wrong");

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).highlightColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
                width: width,
                height: height/12,
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
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  width: width,

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: weight,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[

                            FilteringTextInputFormatter.digitsOnly

                          ],
                          decoration:  InputDecoration(




                              labelText: "weight ex 10kg".tr,
                              hintText: "weight ex 10kg".tr,
                              labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              border:OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: temp,
                          keyboardType: TextInputType.number,

                          decoration:  InputDecoration(




                              labelText: "Temperature in ferenheit".tr,
                              hintText: "Temperature in ferenheit".tr,
                              labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              border:OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),
                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:  Text("Clinical History".tr,style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic


                          ),),
                        ),
                        Column(
                          children: List.generate(clinichistoryData.length, (index) {

                            return CheckboxListTile(
                              checkColor: Theme.of(context).highlightColor,
                              activeColor: Theme.of(context).canvasColor,
                              title: Text(clinichistoryData[index],style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic


                              ),),
                              value: clinichistory[index],
                              onChanged: (val){
                                setState(() {
                                  if(val==true){
                                    clinichistory[index]=true;
                                  }
                                  else{
                                    clinichistory[index]=false;
                                  }
                                });
                              },

                            );
                          }),
                        ),
                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:  Text("Vaccinations".tr,style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic


                          ),),
                        ),
                        Column(
                          children: List.generate(vaccinationsData.length, (index) {

                            return CheckboxListTile(
                              checkColor: Theme.of(context).highlightColor,
                              activeColor: Theme.of(context).canvasColor,
                              title: Text(vaccinationsData[index],style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic


                              ),),
                              value: vaccinations[index],
                              onChanged: (val){
                                setState(() {
                                  if(val==true){
                                    vaccinations[index]=true;
                                  }
                                  else{
                                    vaccinations[index]=false;
                                  }
                                });
                              },

                            );
                          }),
                        ),
                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:  Text("Tests".tr,style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic


                          ),),
                        ),
                        Column(
                          children: List.generate(testsData.length, (index) {

                            return CheckboxListTile(
                              checkColor: Theme.of(context).highlightColor,
                              activeColor: Theme.of(context).canvasColor,
                              title: Text(testsData[index],style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic


                              ),),
                              value: tests[index],
                              onChanged: (val){
                                setState(() {
                                  if(val==true){
                                    tests[index]=true;
                                  }
                                  else{
                                    tests[index]=false;
                                  }
                                });
                              },

                            );
                          }),
                        ),
                        Column(
                          children: List.generate(medicines.length, (index) {
                            return Column(
                              children: [
                                SizedBox(height: 20,),
                                medicines[index]
                              ],
                            );
                          }),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline,size: 30,color: Theme.of(context).primaryColor,),
                          onPressed: (){
                            setState(() {
                              medicines.add(new Medicine());
                            });
                          },
                        ),
                        medicines.length>1?
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline,size: 30,color: Theme.of(context).primaryColor,),
                          onPressed: (){
                            setState(() {
                              medicines.removeLast();
                            });
                          },
                        )
                            :Container()  ,
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: consult,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[

                            FilteringTextInputFormatter.digitsOnly

                          ],
                          decoration:  InputDecoration(




                              labelText: "Consult After".tr,
                              hintText: "Consult After".tr,
                              labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              border:OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: advice,
                          // keyboardType: TextInputType.number,
                          decoration:  InputDecoration(




                              labelText: "Advice".tr,
                              hintText: "Advice".tr,
                              labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              border:OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),
                        SizedBox(height: 5,),


                        SizedBox(height: 20,),
                        savepress?
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
                              String finalclinichistoryData="";
                              String finalvaccinationsData="";
                              String finaltestData='';
                              int numOfVaccination=0;
                              int numOfClinicalHistory=0;
                              int numOfTest=0;

                              for(int i=0;i<vaccinations.length;i++){
                                if(vaccinations[i]==true){
                                  numOfVaccination++;

                                }
                              }
                              for(int i=0;i<clinichistory.length;i++){
                                if(clinichistory[i]==true){
                                  numOfClinicalHistory++;

                                }
                              }
                              for(int i=0;i<tests.length;i++){
                                if(tests[i]==true){
                                  numOfTest++;
                                }
                              }
                              print(numOfClinicalHistory);
                              for(int i=0;i<vaccinations.length;i++){
                                if(vaccinations[i]==true){
                                  finalvaccinationsData+='"';
                                  finalvaccinationsData+=vaccinationsData[i];
                                  finalvaccinationsData+='"';
                                  numOfVaccination--;
                                  if(numOfVaccination!=0){
                                    finalvaccinationsData+=',';
                                  }


                                }
                              }
                              finalvaccinationsData="["+finalvaccinationsData+"]";
                              print(finalvaccinationsData);
                              for(int i=0;i<clinichistory.length;i++){
                                if(clinichistory[i]==true){
                                  finalclinichistoryData+='"';
                                  finalclinichistoryData+=clinichistoryData[i];
                                  finalclinichistoryData+='"';
                                  numOfClinicalHistory--;
                                  if(numOfClinicalHistory!=0){
                                    finalclinichistoryData+=',';
                                  }

                                }
                              }
                              finalclinichistoryData="["+finalclinichistoryData+"]";
                              for(int i=0;i<tests.length;i++){
                                if(tests[i]==true){
                                  finaltestData+='"';
                                  finaltestData+=testsData[i];
                                  finaltestData+='"';
                                  numOfTest--;
                                  if(numOfTest!=0){
                                    finaltestData+=',';
                                  }
                                }
                              }
                              finaltestData="["+finaltestData+"]";
                              // print(clinichistoryData);
                              String s="";



                              if(weight.text.toString().length>0 && temp.text.toString().length>0
                                  && consult.text.toString().length>0 && advice.text.toString().length>0){


                                for(int i=0;i<medicines.length;i++){
                                  if(medicines.elementAt(i).name.text.length<1 ||
                                      medicines.elementAt(i).dose.text.length<1 ||
                                      medicines.elementAt(i).time.text.length<1 ||
                                      medicines.elementAt(i).note.text.length<1
                                  ){

                                    errorShow(context, "Check Your medicine $i information");
                                  }
                                  else{
                                    s=s+'{"medicine_name":"'+medicines.elementAt(i).name.text+'","dose":"'+medicines.elementAt(i).dose.text+'", "time":"'+ medicines.elementAt(i).time.text +'","note":"'+ medicines.elementAt(i).note.text +'"}';
                                    if(i<medicines.length-1 ){
                                      s=s+',';

                                    }
                                    s=' "medicines" :['+s+']';


                                    String parse='{"appointment": '+widget.appointmentId.toString()+',"weight" : '+
                                        weight.text+',"temperature" : '+temp.text+',"clinical_history" : '+finalclinichistoryData.toString()+',"vaccinations" : '+finalvaccinationsData.toString()+''
                                        ',"tests" : '+finaltestData.toString()+','+s+',"consult_after_days" : '+consult.text+',"advice" : "'+advice.text+'"}';
                                    print(parse);
                                    var connectivityResult = await (Connectivity().checkConnectivity());
                                    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                      setState(() {
                                        savepress=true;
                                      });
                                      try{
                                        makePrescription(sharedpreff.read("access"),parse).then((value) {
                                          print(jsonDecode(value));
                                          var d=jsonDecode(value);
                                         // print(d["appointment"]["prescription_id"]);
                                          setState(() {
                                            savepress=false;
                                          });
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => PrescriptionView(d["id"].toString())),
                                          );
                                        });
                                      }
                                      catch(er){
                                        setState(() {
                                          savepress=false;
                                        });
                                        //  sharedpreff.erase();
                                        // // errorShow(context, "something went wrong");
                                        //  Navigator.of(context).pop();
                                        //  Navigator.push(
                                        //    context,
                                        //    MaterialPageRoute(builder: (context) => LoginPage()),
                                        //  );
                                        errorShow(context, "something went wrong");
                                      }
                                    }
                                    else{
                                      errorShow(context, "No network");
                                    }



                                  }

                                }


                              }
                              else{
                                errorShow(context, "all the fields are required");
                              }


                              //

                            },
                            child: Text("save".tr,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),)
                        ),
                        SizedBox(height: 300,)
                      ],
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
class Medicine extends StatelessWidget{
  TextEditingController name=TextEditingController();
  TextEditingController dose=TextEditingController();
  TextEditingController time=TextEditingController();
  TextEditingController note=TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: Column(
        children: [
          SizedBox(height: 20,),
          TextFormField(
             controller: name,

            decoration:  InputDecoration(




                labelText: "Name",
                hintText: "Name",
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                border:OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                filled: true,
                fillColor: Colors.white
            ),
          ),
          SizedBox(height: 5,),
          TextFormField(
             controller: dose,

            decoration:  InputDecoration(




                labelText: "dose",
                hintText: "dose",
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                border:OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                filled: true,
                fillColor: Colors.white
            ),
          ),
          SizedBox(height: 5,),
          TextFormField(
             controller: time,

            decoration:  InputDecoration(




                labelText: "time",
                hintText: "time",
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                border:OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                filled: true,
                fillColor: Colors.white
            ),
          ),
          SizedBox(height: 5,),
          TextFormField(
             controller: note,

            decoration:  InputDecoration(




                labelText: "note",
                hintText: "note",
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                border:OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                filled: true,
                fillColor: Colors.white
            ),
          ),
          SizedBox(height: 10,)
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