import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_student_list/screens/Update.dart';
import 'package:new_student_list/screens/addStudent.dart';
import 'package:new_student_list/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCAHtXaO5VIFLGVRtPTtOUCj-5iY2LFx7w",
          authDomain: "new-one-f3bd2.firebaseapp.com",
          projectId: "new-one-f3bd2",
          storageBucket: "new-one-f3bd2.appspot.com",
          messagingSenderId: "177740114668",
          appId: "1:177740114668:web:15fcc2af4a7ebfb76213c9",
          measurementId: "G-P2N8C1DRJY"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/add': (context) => const AddStudent(),
        '/update': (context) => const UpdateStudent(),
      },
      initialRoute: '/',
    );
  }
}
