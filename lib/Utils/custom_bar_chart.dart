import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:soundfocus/services/sleep_service.dart';
import 'package:soundfocus/models/sleep_model.dart';

class CustomBarChart extends StatefulWidget {
  const CustomBarChart({super.key});

  @override
  _CustomBarChartState createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  final SleepService _sleepService = SleepService();
  List<SleepModel> _sleepStatistics = [];
  double _maxY = 10;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    double max = await _sleepService.max();
    setState(() {
      _maxY = max > 0 ? max : 10;
      _sleepStatistics = _sleepService.sleepStatistics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _maxY + 1,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      maxIncluded: false,
                      showTitles: true,
                      getTitlesWidget: (value, _) => Text(
                        '${value.toInt()}h',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      interval: (_maxY / 12).floorToDouble() + 1,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        return Text(
                          _sleepStatistics[value.toInt()].day!,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: _buildBarGroups(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to build Bar Groups
  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(_sleepStatistics.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: _sleepStatistics[index].hours ?? 0,
            color: _getBarColor(index),
            width: 16,
            borderRadius: BorderRadius.circular(10),
          )
        ],
      );
    });
  }

  // Method to get color based on index
  Color _getBarColor(int index) {
    const colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.cyan,
      Colors.blue,
      Colors.purple
    ];
    return colors[index % colors.length];
  }
}
