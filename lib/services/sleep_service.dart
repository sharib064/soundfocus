import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soundfocus/models/sleep_model.dart';

class SleepService {
  // Create a singleton instance
  static final SleepService _instance = SleepService._internal();

  // Constructor
  factory SleepService() {
    return _instance;
  }

  // Internal constructor
  SleepService._internal();

  static late Isar isar;
  final List<SleepModel> sleepStatistics = [];
  final List<SleepModel> dummy = [
    SleepModel(day: 'Mon', hours: 0),
    SleepModel(day: 'Tues', hours: 0),
    SleepModel(day: 'Wed', hours: 0),
    SleepModel(day: 'Thr', hours: 0),
    SleepModel(day: 'Fri', hours: 0),
    SleepModel(day: 'Sat', hours: 0),
    SleepModel(day: 'Sun', hours: 0),
  ];

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [SleepModelSchema],
      directory: dir.path,
    );
  }

  Future<void> saveFirstLaunch() async {
    final existingSettings = await isar.sleepModels.where().findFirst();
    if (existingSettings == null) {
      await isar.writeTxn(() async {
        for (var sleepModel in dummy) {
          await isar.sleepModels.put(sleepModel);
        }
      });
    }
    getSleepStats();
  }

  Future<void> getSleepStats() async {
    final fetchedHabits = await isar.sleepModels.where().findAll();
    sleepStatistics.clear();
    sleepStatistics.addAll(fetchedHabits);
  }

  Future<void> updateSleepStats(String day, double hours) async {
    final stats = await isar.sleepModels.filter().dayEqualTo(day).findFirst();
    if (stats != null) {
      await isar.writeTxn(() async {
        stats.hours = hours;
        await isar.sleepModels.put(stats);
      });
      await getSleepStats(); // Fetch the updated stats
    }
  }

  Future<double> max() async {
    final stats = await isar.sleepModels.where().findAll();
    double maximum = stats[0].hours!;
    for (int i = 0; i < stats.length; i++) {
      if (maximum < stats[i].hours!) {
        maximum = stats[i].hours!;
      }
    }
    return maximum;
  }
}
