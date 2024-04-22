// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:travel_sau_project/views/login_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {

@override
  void initState() {
    Future.delayed(
      Duration(
        seconds: 3
      ),
      ()=> Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> LoginUI())),

    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Text(
              'บันทึกการเดินทาง',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.045,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            CircularProgressIndicator(
              color: Colors.grey[800],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Text(
              'Created By 6552410001',
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
            Text(
              'Adisorn Nangnoi',
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
