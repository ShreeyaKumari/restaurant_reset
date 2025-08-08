import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer that increases progress gradually
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 1 / 30; // Progress takes 3 seconds (30 * 100ms)
        if (_progress >= 1.0) {
          _progress = 1.0;
          _timer.cancel();
          // Navigate to home screen when progress is full
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App Logo
          Center(child: Image.asset('assets/images/logo2.png', width: 300)),
          SizedBox(height: 30),
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[300],
              color: AppColors.green,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
