
import 'dart:convert';


import 'package:alphacue_vet_doc/function.dart';
import 'package:alphacue_vet_doc/home_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class OtpPage extends StatefulWidget{

  late String phonenumber;


  OtpPage(this.phonenumber);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OtpPageState();
  }

}

class _OtpPageState extends State<OtpPage>{
  TextEditingController phoneNumberOtp = TextEditingController();
 // final controller=Get.put(AuthenticationRepository());
  final sharedpreff = GetStorage();

  bool otpEnterButtonPress=false;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height:height,
            color: Color.fromRGBO(255,255,255, 1),
            padding:  EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children:  [

                Form(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical:  10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TextFormField(
                        //   controller: phoneNumberOtp,
                        //   decoration:  InputDecoration(
                        //
                        //       labelText: "OTP Number",
                        //       hintText: "OTP Number",
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                        //         borderRadius: BorderRadius.all(Radius.circular(20)),
                        //       ),
                        //       border: const OutlineInputBorder(),
                        //       filled: true,
                        //       fillColor: Colors.white
                        //   ),
                        // ),
                        Center(
                            child: PinCodeTextField(
                              keyboardType: TextInputType.number,
                              appContext: context,
                              length: 6,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  inactiveFillColor: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  selectedFillColor: Colors.white,
                                  selectedColor: Theme.of(context).primaryColor,
                                  activeColor: Theme.of(context).primaryColor,
                                  inactiveColor: Theme.of(context).primaryColor,
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeFillColor: Colors.white,
                                  borderWidth: 2
                              ),
                              animationDuration: Duration(milliseconds: 300),
                              backgroundColor: Colors.white,
                              enableActiveFill: true,
                              // errorAnimationController: errorController,
                              controller: phoneNumberOtp,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                setState(() {

                                });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            )
                        ),
                        const SizedBox(height:  20),

                        const SizedBox(height:  20),

                        Visibility(
                          visible: !otpEnterButtonPress,
                          child: SizedBox(
                              width: double.infinity,
                              child:  ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    shape: StadiumBorder(),
                                    shadowColor: Colors.black,


                                  ),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      otpEnterButtonPress=true;
                                    });

                                    var connectivityResult = await (Connectivity().checkConnectivity());
                                     if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
                                      verifyPhnOtp(widget.phonenumber,phoneNumberOtp.text ).then((value1) {
                                        var d=jsonDecode(value1);
                                        print(d.toString());
                                        if(d["msg"]!=null){
                                          print("objectddddddddddddddddddd");
                                          sharedpreff.write("access", d["access"]);
                                          sharedpreff.write("id", d["user"]["id"]);

                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => HomePage()),
                                          );

                                        }
                                        else{
                                          setState(() {
                                            otpEnterButtonPress=false;
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                              duration: const Duration(seconds: 2),

                                              backgroundColor: Theme.of(context).primaryColor,
                                              content: Container(
                                                //height: height/3,
                                                //margin: EdgeInsets.only(left: 10,right: 10),
                                                width: width,
                                                padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                                                decoration:  BoxDecoration(

                                                    color:Theme.of(context).primaryColor,

                                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text("validation failed",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                                    const SizedBox(height: 10,),

                                                  ],
                                                ),
                                              )
                                          ));
                                        }
                                      });
                                    }
                                    else{

                                      setState(() {
                                        otpEnterButtonPress=false;
                                      });

                                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                          duration: const Duration(seconds: 2),

                                          backgroundColor: Theme.of(context).primaryColor,
                                          content: Container(
                                            //height: height/3,
                                            //margin: EdgeInsets.only(left: 10,right: 10),
                                            width: width,
                                            padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                                            decoration:  BoxDecoration(

                                                color:Theme.of(context).primaryColor,

                                                borderRadius: BorderRadius.all(Radius.circular(15))
                                            ),
                                            child: Column(
                                              children: [
                                                Text("No Net",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                                const SizedBox(height: 10,),

                                              ],
                                            ),
                                          )
                                      ));

                                    }





                                  },
                                  child: Text("ok".tr,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),)
                              )
                          ),
                        ),
                        Visibility(
                            visible: otpEnterButtonPress,
                            child:  Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Theme.of(context).primaryColor,
                                size: 50,
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'dart:convert';
//
// import 'package:alphacue_vet_doc/auth/authentication_repository.dart';
// import 'package:alphacue_vet_doc/dash_page.dart';
// import 'package:alphacue_vet_doc/function.dart';
// import 'package:alphacue_vet_doc/home_page.dart';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:get_storage/get_storage.dart';
// class OtpPage extends StatefulWidget{
//
//   late String phonenumber;
//
//
//   OtpPage(this.phonenumber);
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _OtpPageState();
//   }
//
// }
//
// class _OtpPageState extends State<OtpPage>{
//   TextEditingController phoneNumberOtp = TextEditingController();
//
//   final controller=Get.put(AuthenticationRepository());
//   final sharedpreff = GetStorage();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     double width = MediaQuery
//         .of(context)
//         .size
//         .width;
//     double height = MediaQuery
//         .of(context)
//         .size
//         .height;
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             width: width,
//             height:height,
//             color: Color.fromRGBO(255,255,255, 1),
//             padding:  EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//
//               children:  [
//
//                 Form(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical:  10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // TextFormField(
//                         //   controller: phoneNumberOtp,
//                         //   decoration:  InputDecoration(
//                         //
//                         //     // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(100, 97, 255, 1),),
//                         //
//                         //
//                         //       labelText: "OTP Number",
//                         //       hintText: "OTP Number",
//                         //
//                         //       enabledBorder: OutlineInputBorder(
//                         //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
//                         //         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         //
//                         //       ),
//                         //       border: OutlineInputBorder(
//                         //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
//                         //         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         //
//                         //       ),
//                         //       filled: true,
//                         //       fillColor: Colors.white
//                         //   ),
//                         // ),
//                     Center(
//                     child: PinCodeTextField(
//
//                       appContext: context,
//                       length: 6,
//                       obscureText: false,
//                       animationType: AnimationType.fade,
//                       pinTheme: PinTheme(
//                         shape: PinCodeFieldShape.box,
//                         inactiveFillColor: Colors.white,
//                         borderRadius: BorderRadius.circular(5),
//                         selectedFillColor: Colors.white,
//                         selectedColor: Theme.of(context).primaryColor,
//                         activeColor: Theme.of(context).primaryColor,
//                         inactiveColor: Theme.of(context).primaryColor,
//                         fieldHeight: 50,
//                         fieldWidth: 40,
//                         activeFillColor: Colors.white,
//                         borderWidth: 2
//                       ),
//                       animationDuration: Duration(milliseconds: 300),
//                       backgroundColor: Colors.white,
//                       enableActiveFill: true,
//                      // errorAnimationController: errorController,
//                       controller: phoneNumberOtp,
//                       onCompleted: (v) {
//                         print("Completed");
//                       },
//                       onChanged: (value) {
//                         print(value);
//                         setState(() {
//
//                         });
//                       },
//                       beforeTextPaste: (text) {
//                         print("Allowing to paste $text");
//                         //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                         //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                         return true;
//                       },
//                     )
//           ),
//
//                         const SizedBox(height:  20),
//
//                         const SizedBox(height:  20),
//
//                         SizedBox(
//                             width: double.infinity,
//                             child:  ElevatedButton(
//
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Theme.of(context).primaryColor,
//                                   shape: StadiumBorder(),
//                                   shadowColor: Colors.black,
//
//
//                                 ),
//                                 onPressed: () async {
//
//
//
//                                       var value1=widget.phonenumber+"doc";
//
//
//                                       CollectionReference user = FirebaseFirestore.instance.collection('user');
//                                       user.doc(value1).set({
//                                         'otp': phoneNumberOtp.text,
//
//                                       }).then((value) {
//                                         var d;
//                                         // sharedpreff.write("access", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwMzg1NzQzLCJpYXQiOjE2ODUyMDE3NDMsImp0aSI6ImM0Y2NlZjg5MzIzODQ0ODY4M2QxZDdiNzgwMzJiMzZlIiwidXNlcl9pZCI6Nn0.aMnqxULGOtJJiFEyNiFKWzB_mGyXQvXZgM880jyfqCM");
//                                         // sharedpreff.write("id", "01534561707");
//                                         //   Navigator.pop(context);
//                                         //   Navigator.push(
//                                         //     context,
//                                         //     MaterialPageRoute(builder: (context) => Dash()),
//                                         //   );
//                                         makeLogin(widget.phonenumber,value1,phoneNumberOtp.text).then((data) {
//                                           d=jsonDecode(data);
//                                           print(d);
//                                           sharedpreff.write("access", d["access"]);
//                                           sharedpreff.write("id", d["user"]["id"]);
//                                           Navigator.pop(context);
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(builder: (context) => Dash()),
//                                           );
//                                         });
//                                       });
//
//
//                                     },
//
//
//                                 child: Text("app_next".tr,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20),)
//                             )
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }