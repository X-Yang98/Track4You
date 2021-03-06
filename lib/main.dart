import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:track_4_you/screens/add_finance_screen.dart';
import 'package:track_4_you/screens/add_health_screen.dart';
import 'package:track_4_you/screens/add_leetcode_screen.dart';
import 'package:track_4_you/screens/finance_screen.dart';
import 'package:track_4_you/screens/health_screen.dart';
import 'package:track_4_you/screens/home_screen.dart';
import 'package:track_4_you/screens/leetcode_screen.dart';
import 'package:track_4_you/screens/login_screen.dart';
import 'package:track_4_you/screens/register_screen.dart';
import 'package:track_4_you/screens/studies_screen.dart';
import 'package:track_4_you/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        MyHomePage.id: (context) => MyHomePage(),
        FinanceScreen.id: (context) => FinanceScreen(),
        LeetcodeScreen.id: (context) => LeetcodeScreen(),
        HealthScreen.id: (context) => HealthScreen(),
        AddHealthScreen.id: (context) => AddHealthScreen(),
        StudiesScreen.id: (context) => StudiesScreen(),
        AddFinanceScreen.id: (context) => AddFinanceScreen(),
        AddLeetcodeScreen.id: (context) => AddLeetcodeScreen(),
      },
    );
  }
}
