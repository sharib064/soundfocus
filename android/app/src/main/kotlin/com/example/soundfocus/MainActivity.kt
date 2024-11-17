package com.example.soundfocus

import android.content.ContentValues
import android.content.Intent
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.provider.Settings
import android.util.Log // Import Log for debugging
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.io.OutputStream
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.soundfocus/ringtone"
    private val REQUEST_WRITE_SETTINGS = 2001
    private var pendingRingtonePath: String? = null // To store the pending ringtone path if permission is needed

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "changeRingtone") {
                val ringtonePath = call.argument<String>("ringtonePath")
                if (ringtonePath != null) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && !Settings.System.canWrite(this)) {
                        // Request permission if not granted
                        pendingRingtonePath = ringtonePath // Save the ringtone path to retry after permission
                        val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)
                        intent.data = Uri.parse("package:$packageName")
                        startActivityForResult(intent, REQUEST_WRITE_SETTINGS)
                        result.error("PERMISSION_REQUIRED", "Permission to change settings is required", null)
                    } else {
                        // Permission is already granted, set ringtone directly
                        val success = setRingtone(ringtonePath)
                        if (success) {
                            result.success("Ringtone set successfully")
                            showToast("Ringtone set successfully!")
                        } else {
                            result.error("UNAVAILABLE", "Ringtone not set", null)
                            showToast("Failed to set ringtone.")
                        }
                    }
                } else {
                    result.error("INVALID_ARGUMENT", "Ringtone path is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_WRITE_SETTINGS) {
            if (Settings.System.canWrite(this)) {
                showToast("Permission granted! You can now change the ringtone.")
                // Retry setting the ringtone if there was a pending request
                pendingRingtonePath?.let { path ->
                    val success = setRingtone(path)
                    if (success) {
                        showToast("Ringtone set successfully!")
                    } else {
                        showToast("Failed to set ringtone.")
                    }
                    // Clear the pending path after attempting
                    pendingRingtonePath = null
                }
            } else {
                showToast("Permission denied! You need to grant permission to change ringtone.")
                // Clear the pending path since permission was denied
                pendingRingtonePath = null
            }
        }
    }

    private fun setRingtone(filePath: String): Boolean {
        try {
            val file = File(filePath)
            if (!file.exists()) {
                showToast( "File does not exist: $filePath")
                return false
            }

            // Use timestamp to create a unique file name
            val timeStamp = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.getDefault()).format(Date())
            val fileName = "CustomRingtone_$timeStamp.ogg"

            val values = ContentValues().apply {
                put(MediaStore.MediaColumns.DISPLAY_NAME, fileName)
                put(MediaStore.MediaColumns.MIME_TYPE, "audio/ogg") // Use "audio/ogg" if needed
                put(MediaStore.Audio.Media.IS_RINGTONE, true)
            }

            val ringtoneUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
            val newUri = contentResolver.insert(ringtoneUri, values)

            if (newUri != null) {
                contentResolver.openOutputStream(newUri)?.use { outputStream ->
                    FileInputStream(file).use { inputStream ->
                        inputStream.copyTo(outputStream)
                    }
                }

                // Set the new URI as the default ringtone
                RingtoneManager.setActualDefaultRingtoneUri(this, RingtoneManager.TYPE_RINGTONE, newUri)
                return true
            } else {
                showToast("Failed to create a new Uri in MediaStore")
            }
        } catch (e: Exception) {
            showToast( "Error setting ringtone: ${e.message}")
            e.printStackTrace()
        }
        return false
    }

    private fun showToast(message: String) {
        Toast.makeText(applicationContext, message, Toast.LENGTH_SHORT).show()
    }
}
