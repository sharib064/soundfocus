import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundfocus/Utils/custom_bar_chart.dart';

class SleepStatistics extends StatelessWidget {
  const SleepStatistics({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(
              "lib/images/banner-sleep.png",
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, bottom: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Sleep statistics",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Text(
                    "This is where your sleep statistics are located, you can see how much sleep you get on each day of the week. Keep track of your statistics and align your sleep",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Expanded(child: CustomBarChart()),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
    //   body: SafeArea(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Stack(
    //           children: [
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height * 0.2,
    //               width: double.infinity,
    //               child: Image.asset(
    //                 'lib/images/banner-sleep.png',
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             Positioned(
    //               top: 10,
    //               left: 16,
    //               child: GestureDetector(
    //                 onTap: () {
    //                   HapticFeedback.lightImpact();
    //                   Navigator.pop(context);
    //                 },
    //                 child: Container(
    //                   padding: const EdgeInsets.only(
    //                       top: 10, left: 20, bottom: 10, right: 10),
    //                   decoration: BoxDecoration(
    //                     border: Border.all(color: Colors.white, width: 1),
    //                     borderRadius:
    //                         const BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: const Icon(
    //                     Icons.arrow_back_ios,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         const Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 20.0),
    //           child: Center(
    //             child: Text(
    //               "This is where your sleep statistics are located, you can see how much sleep you get on each day of the week. Keep track of your statistics and align your sleep",
    //               maxLines: 3,
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 color: Colors.grey,
    //                 fontSize: 16,
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.65,
    //             child: const CustomBarChart()),
    //       ],
    //     ),
    //   ),
    // );
  }
}
