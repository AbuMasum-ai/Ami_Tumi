import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gari_chai_app/golbalvariable.dart';
import 'package:gari_chai_app/screen/login_page.dart';
import 'package:gari_chai_app/screen/mainpage.dart';
import 'package:gari_chai_app/screen/registration_page.dart';
import 'package:gari_chai_app/screen/vehicalinfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
      googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
      gcmSenderID: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : const FirebaseOptions(
      googleAppID: '1:812965745384:android:f03a5b8fa61d1f2586ef5d',//mobilesdk_app_id
      apiKey: 'AIzaSyCcyaETaAT4kZtos4pzXRsRzD1NZ5HebGE', // google json line 24
      databaseURL: 'https://transportapp-14f73.firebaseio.com', // google json line 4
    ),
  );
  currentFirebaseUser = await FirebaseAuth.instance.currentUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialRoute:(currentFirebaseUser == null) ? LoginPage.id:MainPage.id,
      routes: {
        MainPage.id:(context)=>MainPage(),
        RegistrationPage.id:(context)=>RegistrationPage(),
        VehicalInfoPage.id:(context)=>VehicalInfoPage(),
        LoginPage.id:(context)=>LoginPage(),
      },
    );
  }
}
