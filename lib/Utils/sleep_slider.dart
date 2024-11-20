import 'dart:async';
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
  }

  double _sleepHours = 0.0;
  Timer? _timer;
  bool _isRunning = false;
  DateTime? _startTime;
  Duration _currentDuration = Duration.zero;

  void toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _isRunning = true;
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentDuration = DateTime.now().difference(_startTime!);
        _sleepHours = _currentDuration.inSeconds / 3600;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();

    updateStats();
    setState(() {
      _isRunning = false;
      _sleepHours = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String getFormattedTime() {
    final int hours = _currentDuration.inHours;
    final int minutes = _currentDuration.inMinutes % 60;
    final int seconds = _currentDuration.inSeconds % 60;
    return '${hours}h ${minutes}m ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleTimer,
      child: Container(
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
                  endValue: _sleepHours,
                  sizeUnit: GaugeSizeUnit.factor,
                  startValue: 0,
                  startWidth: 0.075,
                  gradient: const SweepGradient(
                    stops: [0.25, 0.75],
                    colors: [Color(0xffa81515), Color(0xfff53b3b)],
                  ),
                  endWidth: 0.075,
                ),
              ],
              pointers: <GaugePointer>[
                MarkerPointer(
                  value: _sleepHours,
                  markerType: MarkerType.circle,
                  color: const Color(0xfff53b3b),
                  markerHeight: 17,
                  markerWidth: 17,
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getFormattedTime(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _isRunning
                            ? 'Tracking Sleep..\nClick to stop'
                            : 'Start tracking',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
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
      ),
    );
  }
}
