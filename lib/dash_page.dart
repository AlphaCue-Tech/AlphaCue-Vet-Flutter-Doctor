

import 'dart:async';
import 'dart:convert';


import 'package:alphacue_vet_doc/home_page.dart';
import 'package:alphacue_vet_doc/profile_page.dart';
import 'package:alphacue_vet_doc/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:get_storage/get_storage.dart';

class Dash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DashState();
  }

}

class _DashState extends State<Dash>{
  int index=0;

  var status ;

  final sharedpreff = GetStorage();
  var d;
  @override
  initState()  {
     print(sharedpreff.read("access"));
     print(sharedpreff.read("id"));

  }

  List<Widget> listItems = [
    HomePage(),

    Settings(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;




    return Scaffold(
      // body: listItems.elementAt(index),
      body: listItems.elementAt(index),


      bottomNavigationBar: Container(
        height: 30,
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Home",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor)),
            Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor),),

            //Text("Doctor",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),

            //Text("Message",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),
            Text("Profile",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).highlightColor),),
          ],
        ),
      ),
      bottomSheet:
      //Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      CurvedNavigationBar(

        onTap: (index1) {
          setState(() {
            index = index1;
            print(index);
          });
        },

        index: index,
        height: height/16,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).primaryColor,
        items: [

          Image.asset(

            "assets/images/home.png",
            width: 40,
            height: 40,
          ),


          Image.asset(
            "assets/images/settings.png",
            width: 40,
            height: 40,
          ),


          Image.asset(
            "assets/images/profile.png",
            width: 40,
            height: 40,
          ),






        ],

      ),

    );


  }
}
//     Container(
//       height: 20,
//       color: Color.fromRGBO(100, 97, 255, 1),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text("Settings",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),
//
//           Text("Doctor",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),
//           Text("Home",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),
//           Text("Message",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),
//           Text("Profile",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),
//         ],
//       ),
//     ),
//     Container(
//       height: 10,
//       color: Color.fromRGBO(100, 97, 255, 1),
//     )
//   ]
//   rgba(39,34,100,255) beguni
//   rgba(248,236,52,255)  ye
//   rgba(237,27,36,255) red,