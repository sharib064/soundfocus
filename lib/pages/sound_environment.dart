import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:soundfocus/Utils/icon_container.dart';
import 'package:soundfocus/Utils/option_container.dart';

class SoundEnvironment extends StatefulWidget {
  const SoundEnvironment({super.key});

  @override
  _SoundEnvironmentState createState() => _SoundEnvironmentState();
}

class _SoundEnvironmentState extends State<SoundEnvironment> {
  final List<String> options = [
    'All',
    'Job',
    'Meditation',
    'Vacation',
    'Reading'
  ];

  final List<Map<String, dynamic>> iconData = [
    {
      'icon': 'lib/images/icon-typoon.png',
      'label': 'Typhoon',
      'category': 'All',
      'selected': 'lib/images/typoon-selected.png',
      'ringtone': 'assets/audio/typoon.ogg',
      'ringtone-mp3': 'audio/typoon.mp3',
    },
    {
      'icon': 'lib/images/icon-sleet.png',
      'label': 'Sleet',
      'category': 'All',
      'selected': 'lib/images/sleet-selected.png',
      'ringtone': 'assets/audio/sleet.ogg',
      'ringtone-mp3': 'audio/sleet.mp3',
    },
    {
      'icon': 'lib/images/icon-snow.png',
      'label': 'Snow',
      'category': 'Job',
      'selected': 'lib/images/snow-selected.png',
      'ringtone': 'assets/audio/snow.ogg',
      'ringtone-mp3': 'audio/snow.mp3',
    },
    {
      'icon': 'lib/images/icon-tribal-drums.png',
      'label': 'Tribal Drums',
      'category': 'Meditation',
      'selected': 'lib/images/tribal-drums-selected.png',
      'ringtone': 'assets/audio/tribal-drums.ogg',
      'ringtone-mp3': 'audio/tribal-drums.mp3',
    },
    {
      'icon': 'lib/images/icon-wind.png',
      'label': 'Wind',
      'category': 'Vacation',
      'selected': 'lib/images/wind-selected.png',
      'ringtone': 'assets/audio/wind.ogg',
      'ringtone-mp3': 'audio/wind.mp3',
    },
    {
      'icon': 'lib/images/icon-rain.png',
      'label': 'Rain',
      'category': 'All',
      'selected': 'lib/images/rain-selected.png',
      'ringtone': 'assets/audio/rain.ogg',
      'ringtone-mp3': 'audio/rain.mp3',
    },
    {
      'icon': 'lib/images/icon-animal.png',
      'label': 'Animals',
      'category': 'Reading',
      'selected': 'lib/images/animal-selected.png',
      'ringtone': 'assets/audio/animal.ogg',
      'ringtone-mp3': 'audio/animal.mp3',
    },
    {
      'icon': 'lib/images/icon-bird.png',
      'label': 'Bird',
      'category': 'Vacation',
      'selected': 'lib/images/bird-selected.png',
      'ringtone': 'assets/audio/bird.ogg',
      'ringtone-mp3': 'audio/bird.mp3',
    },
    {
      'icon': 'lib/images/icon-nature.png',
      'label': 'Nature',
      'category': 'Meditation',
      'selected': 'lib/images/nature-selected.png',
      'ringtone': 'assets/audio/nature.ogg',
      'ringtone-mp3': 'audio/nature.mp3',
    },
    {
      'icon': 'lib/images/icon-city.png',
      'label': 'City',
      'category': 'Job',
      'selected': 'lib/images/city-selected.png',
      'ringtone': 'assets/audio/city.ogg',
      'ringtone-mp3': 'audio/city.mp3',
    },
  ];

  int selectedIndex = -1;
  String selectedOption = 'All';

  final screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  List<Map<String, dynamic>> getFilteredIcons() {
    if (selectedOption == 'All') {
      return iconData;
    } else {
      return iconData
          .where((icon) => icon['category'] == selectedOption)
          .toList();
    }
  }

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
              "lib/images/banner.png",
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
                        "Sound environment",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.23),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(
                            () {
                              selectedOption = options[index];
                              selectedIndex = -1;
                            },
                          );
                        },
                        child: OptionContainer(
                          option: options[index],
                          isSelected: options[index] == selectedOption,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (screenWidth / 100).floor(),
                    mainAxisSpacing: 10,
                  ),
                  itemCount: getFilteredIcons().length,
                  itemBuilder: (context, index) {
                    final filteredIcons = getFilteredIcons();
                    return IconContainer(
                      icon: filteredIcons[index]['icon'],
                      label: filteredIcons[index]['label'],
                      selected: filteredIcons[index]['selected'],
                      ringtone: filteredIcons[index]['ringtone'],
                      isSelected: index == selectedIndex,
                      ringtoneMp3: filteredIcons[index]['ringtone-mp3'],
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(
                          () {
                            selectedIndex = index;
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//     Scaffold(
//       backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Stack(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   width: double.infinity,
//                   child: Image.asset(
//                     'lib/images/banner.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   left: 16,
//                   child: GestureDetector(
//                     onTap: () {
//                       HapticFeedback.lightImpact();
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.only(
//                           top: 10, left: 20, bottom: 10, right: 10),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white, width: 1),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 40,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: options.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         HapticFeedback.lightImpact();
//                         setState(() {
//                           selectedOption = options[index];
//                           selectedIndex = -1;
//                         });
//                       },
//                       child: OptionContainer(
//                         option: options[index],
//                         isSelected: options[index] == selectedOption,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: (screenWidth / 100).floor(),
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: getFilteredIcons().length,
//                 itemBuilder: (context, index) {
//                   final filteredIcons = getFilteredIcons();
//                   return IconContainer(
//                     icon: filteredIcons[index]['icon'],
//                     label: filteredIcons[index]['label'],
//                     selected: filteredIcons[index]['selected'],
//                     ringtone: filteredIcons[index]['ringtone'],
//                     isSelected: index == selectedIndex,
//                     onTap: () {
//                       HapticFeedback.lightImpact();
//                       setState(() {
//                         selectedIndex = index;
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // 