import 'package:flutter/material.dart';
import 'startPage.dart';

// firebase initialization
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // app 실행 전에 firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Start page',
      home: startPage(),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffffffff),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  //primary: Colors.white,

                  ))),
    );
  }
}
