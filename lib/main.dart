import 'package:flutter/material.dart';

import 'package:soundfocus/pages/login_page.dart';
import 'package:soundfocus/services/sleep_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SleepService().init();
  await SleepService().saveFirstLaunch();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sound Focus',
      home: LoginPage(),
    );
  }
}
