
import 'dart:io';
import 'dart:ui';

import 'package:alphacue_vet_doc/home_page.dart';
import 'package:alphacue_vet_doc/language/language_selection.dart';
import 'package:alphacue_vet_doc/language/languages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  //await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(Home());
}
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }

}

class _HomeState extends State<Home>{

  final sharedpreff = GetStorage();

 @override
   initState()  {
    // TODO: implement initState
    super.initState();
    if(sharedpreff.read("lng")=="BD"){
      Get.updateLocale( Locale('bn','BD'));
    }
    else{
      Get.updateLocale( Locale('en','US'));
    }
   // initPlatform();
 }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      title: "",
      translations: Languages(),
    //  locale: Locale('bn','BD'),
     // fallbackLocale:Locale('bn','BD'),
      theme: ThemeData(
         // fontFamily: GoogleFonts.tinos().fontFamily,
          primarySwatch: Colors.cyan,
          primaryColor:Color.fromRGBO(76,84,76,1) ,
          //primaryColor:Color.fromRGBO(227,173,44,1) ,
          canvasColor:Color.fromRGBO(227,173,44,1)  ,
          hintColor: Color.fromRGBO(74,76,108, 1),
          highlightColor: Colors.white,
          backgroundColor: Color.fromRGBO(255,255,255, 1)

      ),
      home:

      sharedpreff.read("access")==null?LanguageSelectionPage():HomePage(),

    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       translations: Languages(),
//       locale: Locale('bn','BD'),
//       fallbackLocale:Locale('bn','BD'),
//       title: 'app_name'.tr,
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: "app_name"),
//
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//
//       _counter++;
//     });
//   }
//   void _dec(){
//     setState(() {
//
//       _counter--;
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text("app_name".tr),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         children: <Widget>[
//           FloatingActionButton(
//             onPressed: _incrementCounter,
//             tooltip: 'Increment',
//             child: const Icon(Icons.add),
//           ),
//           FloatingActionButton(
//             onPressed: _dec,
//             tooltip: 'Increment',
//             child: const Icon(Icons.remove),
//           ),
//         ],
//       ) // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
