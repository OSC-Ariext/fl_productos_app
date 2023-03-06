import 'package:fl_productos_app/screens/screens.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}
