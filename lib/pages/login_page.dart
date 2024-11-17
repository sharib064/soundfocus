import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:soundfocus/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startProgress();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        _progress += 0.3;
        if (_progress >= 0.9) {
          _progress = 1.0;
          timer.cancel();
          _navigateToHome();
        }
      });
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/images/login.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            bottom: 0,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'lib/images/pillow.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 20,
                      )
                    ]),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sound Focus",
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Get ready for incredible relaxation\nin the Sound Focus app",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oswald(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 30),
                        LinearPercentIndicator(
                          percent: _progress,
                          animation: false,
                          lineHeight: 10.0,
                          progressColor: Colors.red,
                          backgroundColor: Colors.red.shade200,
                          barRadius: const Radius.circular(5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
