import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //TODO: Personalize according to the preferences of your project
  static showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(50),
        ),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 75),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 100,
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }

}
