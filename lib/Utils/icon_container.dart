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

  const IconContainer({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.ringtone,
    required this.isSelected,
    required this.onTap,
  });

  void setRingtone() async {
    await RingtoneService.changeRingtone(ringtone);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
            setRingtone();
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
