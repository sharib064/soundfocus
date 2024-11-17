import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    },
    {
      'icon': 'lib/images/icon-sleet.png',
      'label': 'Sleet',
      'category': 'All',
      'selected': 'lib/images/sleet-selected.png',
      'ringtone': 'assets/audio/sleet.ogg',
    },
    {
      'icon': 'lib/images/icon-snow.png',
      'label': 'Snow',
      'category': 'Job',
      'selected': 'lib/images/snow-selected.png',
      'ringtone': 'assets/audio/snow.ogg',
    },
    {
      'icon': 'lib/images/icon-tribal-drums.png',
      'label': 'Tribal Drums',
      'category': 'Meditation',
      'selected': 'lib/images/tribal-drums-selected.png',
      'ringtone': 'assets/audio/tribal-drums.ogg',
    },
    {
      'icon': 'lib/images/icon-wind.png',
      'label': 'Wind',
      'category': 'Vacation',
      'selected': 'lib/images/wind-selected.png',
      'ringtone': 'assets/audio/wind.ogg',
    },
    {
      'icon': 'lib/images/icon-rain.png',
      'label': 'Rain',
      'category': 'All',
      'selected': 'lib/images/rain-selected.png',
      'ringtone': 'assets/audio/rain.ogg',
    },
    {
      'icon': 'lib/images/icon-animal.png',
      'label': 'Animals',
      'category': 'Reading',
      'selected': 'lib/images/animal-selected.png',
      'ringtone': 'assets/audio/animal.ogg',
    },
    {
      'icon': 'lib/images/icon-bird.png',
      'label': 'Bird',
      'category': 'Vacation',
      'selected': 'lib/images/bird-selected.png',
      'ringtone': 'assets/audio/bird.ogg',
    },
    {
      'icon': 'lib/images/icon-nature.png',
      'label': 'Nature',
      'category': 'Meditation',
      'selected': 'lib/images/nature-selected.png',
      'ringtone': 'assets/audio/nature.ogg',
    },
    {
      'icon': 'lib/images/icon-city.png',
      'label': 'City',
      'category': 'Job',
      'selected': 'lib/images/city-selected.png',
      'ringtone': 'assets/audio/city.ogg',
    },
  ];

  int selectedIndex = -1;
  String selectedOption = 'All';

  final screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
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
      backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
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
            const SizedBox(height: 10),
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
                        setState(() {
                          selectedOption = options[index];
                          selectedIndex = -1;
                        });
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
                    onTap: () {
                      HapticFeedback.lightImpact();
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
