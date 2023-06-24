import 'dart:io';

import 'package:alphacue_vet_doc/language/language_selection.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:get_storage/get_storage.dart';
class SettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsPageState();
  }
}
class SettingsPageState extends State<SettingsPage>{

  final sharedpreff = GetStorage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  width: width,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                  child: Center(
                    child: LiteRollingSwitch(
                      value: sharedpreff.read("lng")=="BD"?true:false,
                      width: 150,
                      textOn: 'BN',
                      textOff: 'ENG',
                      colorOn: Colors.green,
                      colorOff: Colors.red,
                      iconOn: Icons.lightbulb_outline,
                      iconOff: Icons.lightbulb_outline,
                      animationDuration: const Duration(milliseconds: 300),
                      onChanged: (bool state) {
                        print('turned ${(state) ? 'BN' : 'ENG'}');
                        if(state==true){
                          Get.updateLocale( Locale('bn','BD'));
                          setState(() {
                            sharedpreff.write("lng", "BD");
                          });
                          print("BAN");
                        }
                        else{
                          Get.updateLocale( Locale('en','US'));
                          setState(() {
                            sharedpreff.write("lng", "US");
                          });
                          print("ENG");
                        }
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                    ),
                  ),
                  decoration:  BoxDecoration(

                      color:Theme.of(context).primaryColor,

                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                ),
                const SizedBox(height: 60,),
                GestureDetector(
                  onTap: (){
                    // sharedpreff.write("user_name",null);
                    // sharedpreff.write('user_id',null);
                    // sharedpreff.write('user_phn', null);
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed:(){
                            print(sharedpreff.read("id").toString());
                            sharedpreff.erase();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            print(sharedpreff.read("id").toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
                            );
                          },
                          icon:  Icon(
                            Icons.logout,color: Theme.of(context).primaryColor,
                            size: width/5,
                          ),
                      ),

                      //Text("Logout",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }


}