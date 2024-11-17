import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundfocus/Utils/ringtone_services.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool change = false;
  Cron cron = Cron();
  bool isCronScheduled = false;

  @override
  void initState() {
    super.initState();
    _loadCronState();
  }

  Future<void> _loadCronState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isCronScheduled = prefs.getBool('isCronScheduled') ?? false;
      change = isCronScheduled;
    });

    if (isCronScheduled) {
      _scheduleCronJob();
    }
  }

  Future<void> _saveCronState(bool scheduled) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCronScheduled', scheduled);
  }

  void toggle(bool value) {
    if (value) {
      if (!isCronScheduled) {
        _scheduleCronJob();
        _saveCronState(true);
        setState(() {
          isCronScheduled = true;
        });
      }
    } else {
      cron.close().then(
        (value) {
          cron = Cron();
          _saveCronState(false);
          setState(() {
            isCronScheduled = false;
          });
        },
      );
    }

    setState(() {
      change = value;
    });
  }

  void _scheduleCronJob() {
    final hour = DateTime.now().hour;
    cron.schedule(
        Schedule.parse('0 */1 * * * *'),
        () async => {
              if (hour >= 6 && hour < 12)
                {
                  await RingtoneService.changeRingtone(
                      "assets/audio/forest.ogg"),
                }
              else
                {
                  await RingtoneService.changeRingtone("assets/audio/rain.ogg"),
                },
            });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: change,
      onChanged: (value) {
        HapticFeedback.lightImpact();
        toggle(value);
      },
    );
  }
}
