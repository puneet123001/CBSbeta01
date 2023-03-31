import 'package:cbsbeta01/auth/supplier_login.dart';
import 'package:cbsbeta01/auth/supplier_signup.dart';
import 'package:cbsbeta01/main_screens/supplier_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cbsbeta01/main_screens/customer_home.dart';
import 'package:cbsbeta01/main_screens/welcome_screen.dart';
import 'package:cbsbeta01/auth/customer_signup.dart';
import 'package:cbsbeta01/auth/customer_login.dart';


import 'main_screens/customer_home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //       apiKey: "AIzaSyDxx2Tcwv0aWVeYPnmNrONtJTSkx5rQ7WI",
  //       authDomain: "cbsbeta01.firebaseapp.com",
  //       projectId: "cbsbeta01",
  //       storageBucket: "cbsbeta01.appspot.com",
  //       messagingSenderId: "107866540864",
  //       appId: "1:107866540864:web:4f4de0f3a2c975bd9788a5",
  //       measurementId: "G-GB9ZYJ6W48"
  //   )
  // );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen':(context)=>const WelcomeScreen(),
    '/customer_home':(context)=>const CustomerHomeScreen(),
    '/supplier_home':(context)=>const SupplierHomeScreen(),
      '/customer_signup':(context)=>const CustomerRegister(),
        '/customer_login':(context)=> const CustomerLogin(),
        '/supplier_signup':(context)=> const SupplierRegister(),
        '/supplier_login':(context)=> const SupplierLogin(),

      },
    );
  }
}
