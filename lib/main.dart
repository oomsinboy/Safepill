import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Navigation/naviga_medpill.dart';
import 'package:flutter_application_1/Welcome/welcome.dart';
import 'package:flutter_application_1/controller/db_helper.dart';
import 'package:flutter_application_1/function/ui/theme.dart';
import 'package:flutter_application_1/function/ui/themeService.dart';
import 'package:flutter_application_1/home.dart';
//import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login/unknowhn.dart';
import 'package:flutter_application_1/page/graph/graphpage.dart';
import 'package:flutter_application_1/page/guidepill.dart';
import 'package:flutter_application_1/page/detailpressure.dart';
import 'package:flutter_application_1/page/more.dart';
import 'package:flutter_application_1/page/screen_main/pageuser.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'function/addtemp.dart';
import 'function/ui/notification_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().iniNotification();
  await Firebase.initializeApp();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // ignore: unused_field
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  // late User? user;
  // // var flag = 0;

  // Future<void> getUser() async {
  //   user = auth.currentUser;
  // }

  @override
  Widget build(BuildContext context) {
    // getUser();
    User? user = FirebaseAuth.instance.currentUser;
    //if (snapshot.connectionState == ConnectionState.done) {}
    return GetMaterialApp(
      debugShowMaterialGrid: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().Theme,
    
      //home: new Home(),
      initialRoute: '/',
      routes: {
        '/': (context) => user == null ? Welcome() : Home(),
        '/forgot HN': (BuildContext context) => UnknowHN(),
        '/guide pill': (BuildContext context) => GuidePill(),
        '/detail pressure': (BuildContext context) => DetailPressure(),
        '/addtemp': (context) => AddTemp(),
        '/graphpage': (context) => PageGraphtest(),
        '/pagemore': (context) => More(),
        '/page datauser': (context) => PageDataUser(),
        //'/medpill': (context) => Medpill(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
