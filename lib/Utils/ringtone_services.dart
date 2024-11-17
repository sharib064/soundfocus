import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class RingtoneService {
  static Future<String> copyAssetToFile(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/${assetPath.split('/').last}';

    File tempFile = File(tempPath);
    await tempFile.writeAsBytes(bytes, flush: true);

    return tempFile.path;
  }

  static Future<bool> changeRingtone(String ringtonePath) async {
    try {
      String filePath = await copyAssetToFile(ringtonePath);
      const platform = MethodChannel('com.example.soundfocus/ringtone');
      await platform.invokeMethod('changeRingtone', {'ringtonePath': filePath});
      return true;
    } on PlatformException catch (e) {
      print("Failed to change ringtone: '${e.message}'.");
      return false;
    }
  }
}
