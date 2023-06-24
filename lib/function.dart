import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
//String s='http://10.0.2.2:8000';
String s='https://app.alphacueanimalcare.com';

Future<String> verifyPhnToken(String serial,String device, String name) async {
  String url = s+'/user/otp/token';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"serial": "'+serial+'","device":"'+device+'","name": "'+name+'"}';
  print(json);
  var response = await http.post(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  print(body);
  return body;

}

Future<String> sendPhnToken(String phn,String serial, String token) async {
  String url = s+'/user/otp';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"phone": "'+phn+'","serial":"'+serial+'","token": "'+token+'"}';
  print(json);
  var response = await http.post(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  print(body);
  return body;

}

Future<String> verifyPhnOtp(String phn,String otp ) async {
  String url = s+'/user/login';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"phone": "'+phn+'","otp":"'+otp+'"}';
  print(json);
  var response = await http.post(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  return body;

}


Future<String> getVideoToken(String token,  String name,String uid,String role,String ts) async {
  String url = s+'/communication/agora/token';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};

  String json = '{"channelName":"'+name+'", "uid":"'+ uid +'","role":"'+ role +'","privilegeExpiredTs":"'+ ts +'"}';

  print(json);
  var response = await http.post(Uri.parse(url), headers: headers, body: json);
  print(response);
  String body = response.body.toString();
  print(body);
  return body;



}

Future<String> makeLogin(String phnno,String fid,String otp) async {
  String url = s+'/user/login';
  Map<String, String> headers = {"Content-type": "application/json"};
  //String phn=phnno.substring(3);
  String json = '{"phone":"'+phnno+'", "firebase_id":"'+ fid +'","otp":"'+ otp +'"}';
  print(json);
  var response = await http.post(Uri.parse(url), headers: headers, body: json);
  print(response);
  String body = response.body.toString();
  return body;

  var data = jsonDecode(body);


  return data;

}
Future<String> getAppointmentList(String token) async {
  String url = s+'/clinic/vet/appointments';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> getAppointment(String token,int id) async {
  String url = s+'/clinic/vet/appointment/'+id.toString();
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}

Future<String> getStudy(String token) async {
  String url = s+'/doctor/study';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> getStudyItem(String token,int id) async {
  String url = s+'/doctor/study/'+id.toString();
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}

Future<String> studyItemDelete(String token,int id) async {
  String url = s+'/doctor/study/'+id.toString();
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.delete(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> studyItemUpdate(String token,int id,String insti,String sub,String py) async {
  String url = s+'/doctor/study/'+id.toString();

  String json = '{"id":'+id.toString()+', "institution_name":"'+ insti+'","pass_year":"'+ py +'","subject":"'+ sub +'"}';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.put(Uri.parse(url), headers: headers,body: json);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> studyItemUpAdd(String token,int id,String insti,String sub,String py) async {
  String url = s+'/doctor/study/'+id.toString();

  String json = '{"institution_name":"'+ insti+'","pass_year":"'+ py +'","subject":"'+ sub +'"}';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.post(Uri.parse(url), headers: headers,body: json);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> getTimeSlot(String token) async {
  String url = s+'/doctor/time-slot';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> getTimeSlotItem(String token,int id) async {
  String url = s+'/doctor/time-slot/'+id.toString();
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> TimeSlotItemDelete(String token,int id) async {
  String url = s+'/doctor/time-slot/'+id.toString();
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.delete(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> TimeSlotItemUpdate(String token,int id,String slot,String weekday) async {
  String url = s+'/doctor/time-slot/'+id.toString();
  String json = '{"id":'+id.toString()+', "slot":"'+ slot+'","week_day":"'+ weekday +'"}';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.put(Uri.parse(url), headers: headers,body: json);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> TimeSlotItemAdd(String token,String slot,String weekday) async {
  String url = s+'/doctor/time-slot';
  String json = '{"slot":"'+ slot+'","week_day":"'+ weekday +'"}';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.post(Uri.parse(url), headers: headers,body: json);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> getExperience(String token) async {
  String url = s+'/doctor/experience';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> getExperienceItem(String token,int id) async {
  String url = s+'/doctor/experience/'+id.toString();
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> ExperienceItemDelete(String token,int id) async {
  String url = s+'/doctor/experience/'+id.toString();
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};



  var response = await http.delete(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> ExperienceItemUpdate(String token,int id,String insti,String title,String from,String to) async {
  String url = s+'/doctor/experience/'+id.toString();
  String json = '{"id":'+id.toString()+', "institution_name":"'+ insti+'","job_title":"'+ title +'", "job_from":"'+ from+'","job_to":"'+ to +'"}';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.put(Uri.parse(url), headers: headers,body: json);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> ExperienceItemAdd(String token,String insti,String title,String from,String to) async {
  String url = s+'/doctor/experience';
  String json = '{"institution_name":"'+ insti+'","job_title":"'+ title +'", "job_from":"'+ from+'","job_to":"'+ to +'"}';
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(json);
  var response = await http.post(Uri.parse(url), headers: headers,body: json);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}

Future<String> makePrescription(String token,String parse) async {
  String url = s+'/clinic/prescription/create';
  Map<String, String> headers = {"Content-type": "application/json",'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  //String phn=phnno.substring(3);
  //String json = '{"phone":"'+phnno+'", "firebase_id":"'+ fid +'","otp":"'+ otp +'"}';
  //print(json);
  var response = await http.post(Uri.parse(url), headers: headers, body: parse);
  print(response);
  String body = response.body.toString();
  return body;

  var data = jsonDecode(body);


  return data;

}

Future<String> getPrescriptionView(String token,String id) async {
  String url = s+'/clinic/prescription/view/'+id;
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json', 'Authorization': 'Bearer $token'};


  print(url);
  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> getPrescriptionData(String token) async {
  String url = s+'/clinic/prescription/create';
  Map<String, String> headers = {"Content-type": "application/json",'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  //String phn=phnno.substring(3);
  //String json = '{"phone":"'+phnno+'", "firebase_id":"'+ fid +'","otp":"'+ otp +'"}';
  //print(json);
  var response = await http.get(Uri.parse(url), headers: headers);
  print(response);
  String body = response.body.toString();
  return body;

  var data = jsonDecode(body);


  return data;

}

void errorShow(BuildContext context, String msg){
  // ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
  //     duration: const Duration(seconds: 4),
  //
  //     backgroundColor: Theme.of(context).primaryColor,
  //     content: Container(
  //       //height: height/3,
  //       //margin: EdgeInsets.only(left: 10,right: 10),
  //       width: double.infinity,
  //       padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
  //       decoration:  BoxDecoration(
  //
  //           color:Theme.of(context).primaryColor,
  //
  //           borderRadius: BorderRadius.all(Radius.circular(15))
  //       ),
  //       child: Column(
  //         children: [
  //           Text(msg,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).highlightColor,),),
  //           const SizedBox(height: 10,),
  //
  //         ],
  //       ),
  //     )
  // ));
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}