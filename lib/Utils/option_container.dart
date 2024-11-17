import 'package:flutter/material.dart';

class OptionContainer extends StatelessWidget {
  final String option;
  final bool isSelected; // New parameter to check if selected
  const OptionContainer(
      {super.key, required this.option, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: [
                  Color(0xff8f0909),
                  Color(0xfffb3e3e),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? null : Border.all(color: const Color(0xff161b36)),
      ),
      child: Center(
        child: Text(
          option,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
