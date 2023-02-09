import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kulika/users/user_model.dart';
import '../pages/splash_screen.dart';

class LoginUiApp extends StatelessWidget {
  // Color _primaryColor = HexColor('#DC54FE');
  // Color _primaryColor = HexColor('#FFD700');
  Color _primaryColor = Colors.orange;
  // Color _accentColor = HexColor('#BAD2AE');
  Color _accentColor = HexColor('#1c3c9d');
  // Color _accentColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kulika login',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(title: 'kulika app'),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
