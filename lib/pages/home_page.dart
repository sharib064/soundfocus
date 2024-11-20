import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfocus/Utils/sleep_slider.dart';
import 'package:soundfocus/pages/background_sound.dart';
import 'package:soundfocus/pages/sleep_statistics.dart';
import 'package:soundfocus/pages/sound_environment.dart';
import 'package:soundfocus/pages/timer_schedule.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List modes = [
      [
        'Sound environment modes',
        'You can select different sound environment presets for different situation',
        const SoundEnvironment(),
      ],
      [
        'Background sound environment for sleep',
        'In sleep mode the app can play calm sound such as white noise, rain or ocean noise',
        const BackgroundSound(),
      ],
      [
        'Timer and schedule mode',
        'You can set the sound mode to switch automatically depending on the time of the day.',
        const TimerSchedule(),
      ],
      [
        'Sleep Statistics',
        'In sleep mode the app can play calm sound such as white noise, rain or ocean noise',
        const SleepStatistics(),
      ],
    ];
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(
              "lib/images/banner.png",
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Sound Focus",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.32,
              child: const SleepDurationSlider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    "Modes",
                    style:
                        GoogleFonts.oswald(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: modes.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      color: const Color(0xff2e0c0c),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => modes[index][2],
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff2e0c0c),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            autofocus: false,
                            title: Text(
                              modes[index][0],
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              modes[index][1],
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: const Color(0xff161616),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: MediaQuery.of(context).size.height * 0.4,
    //         width: double.infinity,
    //         child: Stack(
    //           children: [
    //             Positioned.fill(
    //               child: Image.asset(
    //                 'lib/images/banner.png',
    //                 fit: BoxFit.cover,
    //                 errorBuilder: (context, error, stackTrace) => const Center(
    //                     child: Icon(Icons.broken_image, color: Colors.white)),
    //               ),
    //             ),
    //             Positioned(
    //                 top: 30,
    //                 child: Center(
    //                   child:
    //                       SizedBox(height: 300, child: SleepDurationSlider()),
    //                 )),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(height: 20),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //         child: Text(
    //           "Modes",
    //           style: GoogleFonts.oswald(color: Colors.white, fontSize: 15),
    //         ),
    //       ),
    //       const SizedBox(height: 20),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: modes.length,
    //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //           itemBuilder: (context, index) {
    //             return Padding(
    //               padding: const EdgeInsets.only(bottom: 10),
    //               child: ListTile(
    //                 tileColor: const Color(0xff2e0c0c),
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(10)),
    //                 title: Text(
    //                   modes[index][0],
    //                   style: const TextStyle(color: Colors.white),
    //                 ),
    //                 subtitle: Text(
    //                   modes[index][1],
    //                   style: const TextStyle(color: Colors.grey),
    //                 ),
    //                 trailing: const Icon(
    //                   Icons.arrow_forward_ios,
    //                   color: Colors.grey,
    //                 ),
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => modes[index][2],
    //                     ),
    //                   );
    //                 },
    //               ),
    //             );
    //           },
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
