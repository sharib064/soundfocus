import 'package:flutter/material.dart';
import 'package:soundfocus/services/sleep_service.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SleepDurationSlider extends StatefulWidget {
  const SleepDurationSlider({super.key});

  @override
  State<SleepDurationSlider> createState() => _SleepDurationSliderState();
}

class _SleepDurationSliderState extends State<SleepDurationSlider> {
  String weekday(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thr';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return 'Sun';
    }
  }

  void updateStats() {
    final day = weekday(DateTime.now().weekday);
    SleepService().updateSleepStats(day, _sleepHours);
    print(day);
    print(_sleepHours);
  }

  double _sleepHours = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      margin: const EdgeInsets.all(20),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            startAngle: 270,
            endAngle: 270,
            minimum: 0,
            maximum: 24,
            interval: 6,
            majorTickStyle:
                const MajorTickStyle(color: Colors.redAccent, length: 10),
            minorTickStyle: const MinorTickStyle(
              color: Colors.redAccent,
            ),
            minorTicksPerInterval: 50,
            axisLineStyle: const AxisLineStyle(
              color: Color(0xFF1A1A2E),
            ),
            axisLabelStyle: const GaugeTextStyle(
              color: Colors.white,
            ),
            ranges: <GaugeRange>[
              GaugeRange(
                  endValue: _sleepHours, // We declared this in state class.
                  sizeUnit: GaugeSizeUnit.factor,
                  startValue: 0,
                  startWidth: 0.075,
                  gradient: const SweepGradient(
                      stops: [0.25, 0.75],
                      colors: [Color(0xffa81515), Color(0xfff53b3b)]),
                  endWidth: 0.075)
            ],
            pointers: <GaugePointer>[
              // RangePointer(
              //   value: _sleepHours,
              //   cornerStyle: CornerStyle.bothCurve,
              //   width: 15,
              //   color: Colors.redAccent,
              //   onValueChanged: (double newValue) {
              //     setState(() {
              //       _sleepHours = newValue;
              //     });
              //   },
              // ),
              MarkerPointer(
                value: _sleepHours,
                markerType: MarkerType.circle,
                color: const Color(0xfff53b3b),
                markerHeight: 17,
                markerWidth: 17,
                enableDragging: true,
                onValueChanged: (double newValue) {
                  setState(() {
                    _sleepHours = newValue;
                    updateStats();
                  });
                },
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_sleepHours.toStringAsFixed(1)} hours',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Sleep Duration',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
                positionFactor: 0.1,
                angle: 90,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
