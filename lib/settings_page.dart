
import 'package:flutter/material.dart';

class Settings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Settings_State();
  }

}
class Settings_State extends State<Settings>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).highlightColor,
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 60,),
                // Container(
                //   margin: EdgeInsets.only(left: 10,right: 10),
                //   width: width,
                //   padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("Background notification",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                //       LiteRollingSwitch(
                //         value: false,
                //         width: width/5,
                //         textOn: 'Yes',
                //         textOff: 'No',
                //         colorOn: Theme.of(context).hintColor,
                //         colorOff: Colors.red,
                //         iconOn: Icons.lightbulb_outline,
                //         iconOff: Icons.lightbulb_outline,
                //         animationDuration: const Duration(milliseconds: 100),
                //         onChanged: (bool state) {
                //           // print('turned ${(state) ? 'BN' : 'ENG'}');
                //
                //         },
                //         onDoubleTap: () {},
                //         onSwipe: () {},
                //         onTap: () {},
                //       ),
                //     ],
                //   ),
                //   decoration:  BoxDecoration(
                //
                //       color:Theme.of(context).primaryColor,
                //
                //       borderRadius: BorderRadius.all(Radius.circular(15))
                //   ),
                // ),
                const SizedBox(height: 60,),
                GestureDetector(
                  onTap: (){
                    // sharedpreff.write("user_name","");
                    // sharedpreff.write('user_id',"");
                    // sharedpreff.write('user_phn', "");
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.logout,color: Theme.of(context).primaryColor,
                        size: width/5,
                      ),
                      Text("Logout",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
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