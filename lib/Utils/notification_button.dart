import 'package:flutter/material.dart';

class NotificationButton extends StatefulWidget {
  final String text;
  const NotificationButton({super.key, required this.text});

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xfffb3e3e),
            Color(0xff8f0909),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      child: Center(
        child: Text(
          widget.text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
