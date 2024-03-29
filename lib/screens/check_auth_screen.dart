import 'package:fl_productos_app/screens/screens.dart';
import 'package:fl_productos_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthServices>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authProvider.readToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if(!snapshot.hasData) return const Text('');

            if(snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoginScreen(),
                    transitionDuration: const Duration(seconds: 0)
                ));
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const HomeScreen(),
                    transitionDuration: const Duration(seconds: 0)
                ));
              });
            }



            return Container();
          },
        ),
      ),
    );
  }
}
