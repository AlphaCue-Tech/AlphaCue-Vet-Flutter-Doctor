

import 'dart:io';

import 'package:alphacue_vet_doc/home_page.dart';
import 'package:alphacue_vet_doc/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:get_storage/get_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LanguageSelectionPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LanguageSelectionPageState();
  }

}

class _LanguageSelectionPageState extends State<LanguageSelectionPage>{
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  final sharedpreff = GetStorage();

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
      ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
  initPlatform() async {
    if (Platform.isAndroid) {
      deviceData =
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      // print("dssssssssssssss"+deviceData["id"]);
      //print("dssssssssssssss"+deviceData["serialNumber"]);
      //  print("dssssssssssssss"+deviceData["device"]);
      // print("dssssssssssssss"+deviceData["model"]);
      //print("dssssssssssssss"+deviceData["id"]);
      sharedpreff.write("serial",deviceData["id"]);
      sharedpreff.write("device",deviceData["device"]);
      sharedpreff.write("name",deviceData["model"]);


    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      sharedpreff.write("serial",deviceData["utsname.machine:"]);
      sharedpreff.write("device",deviceData["model"]);
      sharedpreff.write("name",deviceData["name"]);
    }
  }

  initState()  {
    // TODO: implement initState
    super.initState();
    initPlatform();
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Theme.of(context).primaryColor,
        child: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LiteRollingSwitch(
                  value: false,
                  width: 150,
                  textOn: 'BN',
                  textOff: 'ENG',
                  colorOn: Colors.green,
                  colorOff: Colors.red,
                  iconOn: Icons.lightbulb_outline,
                  iconOff: Icons.lightbulb_outline,
                  animationDuration: const Duration(milliseconds: 300),
                  onChanged: (bool state) {
                    // print('turned ${(state) ? 'BN' : 'ENG'}');
                    if(state==true){
                      Get.updateLocale( Locale('bn','BD'));
                      sharedpreff.write("lng", "BD");
                      print("BAN");
                    }
                    else{
                      Get.updateLocale( Locale('en','US'));
                      sharedpreff.write("lng", "US");
                      print("ENG");
                    }
                  },
                  onDoubleTap: () {},
                  onSwipe: () {},
                  onTap: () {},
                ),
                SizedBox(
                  height: height/20,
                ),
                SizedBox(
                    width: width/2, // <-- match_parent
                    height: height/15, // <-- match-parent
                    child:  ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).canvasColor,
                          shape: StadiumBorder(),

                        ),
                        onPressed: (){
                          //  Navigator.pop(context);
                          //  Navigator.push(
                          //    context,
                          //    MaterialPageRoute(builder: (context) => HomePage()),
                          //
                          //
                          // );
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                           // MaterialPageRoute(builder: (context) => LoginPage()),
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text("ok".tr,style: TextStyle(color:Theme.of(context).highlightColor, fontSize: 20,fontWeight: FontWeight.bold),)
                    )
                )

              ],
            )

        ),
      ),

    );
  }
}