
import 'package:alphacue_vet_doc/auth/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();


  //TextField Controllers to get data from TextFields



  /// This func will be used to register user with [EMAIL] & [Password]



  //Get phoneNo from user (Screen) and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneauth(phoneNo);
  }
}