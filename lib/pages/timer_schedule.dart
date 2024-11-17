import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundfocus/Utils/switch_button.dart';

class TimerSchedule extends StatefulWidget {
  const TimerSchedule({super.key});

  @override
  State<TimerSchedule> createState() => _TimerScheduleState();
}

class _TimerScheduleState extends State<TimerSchedule> {
  bool isAutomaticSwitchingEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  void toggleSwitch(bool value) {
    setState(() {
      isAutomaticSwitchingEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: Image.asset(
                    'lib/images/banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20, bottom: 10, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  "Automatically switch sound mode depending on the time of the day",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(
                  color: Color(0xff2e0c0c),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Enable automatic switching",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SwitchButton(),
                    // CupertinoSwitch(
                    //   value: isAutomaticSwitchingEnabled,
                    //   onChanged: toggleSwitch,
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
