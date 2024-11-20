import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundfocus/Utils/ringtone_services.dart';

class IconContainer extends StatelessWidget {
  final String icon;
  final String label;
  final String selected;
  final String ringtone;
  final bool isSelected;
  final VoidCallback onTap;
  final String ringtoneMp3;

  const IconContainer(
      {super.key,
      required this.icon,
      required this.label,
      required this.selected,
      required this.ringtone,
      required this.isSelected,
      required this.onTap,
      required this.ringtoneMp3});

  void setRingtone() async {
    await RingtoneService.changeRingtone(ringtone);
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayer _audioPlayer = AudioPlayer();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            HapticFeedback.lightImpact();
            await _audioPlayer.play(AssetSource(ringtoneMp3));
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Color(0xff161616),
                  title: Text(
                    label,
                    style: const TextStyle(color: Colors.white),
                  ),
                  content: Image.asset(
                    'lib/images/music-3.gif',
                    //height: 60,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _audioPlayer.stop();
                        setRingtone();
                        Navigator.pop(context);
                        onTap();
                      },
                      child: const Text(
                        "Set",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _audioPlayer.stop();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Image.asset(
            isSelected ? selected : icon,
            width: 72, // Adjust size as needed
            height: 72,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
