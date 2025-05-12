import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_shop/controllers/category_controller.dart';
import 'package:firebase_shop/views/screens/authentication_screens/login_screen.dart';
//import 'package:firebase_shop/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid? await 
  Firebase.initializeApp(options: FirebaseOptions(apiKey:  "AIzaSyCWmCi-yy756RGM-2wJexfeCDHiWSdI8yA", appId: "1:387488316116:android:2ad06184f8614bdbbe9941",
   messagingSenderId: "387488316116", projectId: "my-shop-e7b87",storageBucket: 'gs://my-shop-e7b87.firebasestorage.app')):await Firebase.initializeApp();
  runApp( const ProviderScope(child:   MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:LoginScreen(),
    initialBinding: BindingsBuilder(() {
  Get.put(CategoryController());
}),
    );
  }
}

