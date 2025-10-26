import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tugas_praktikum/widget/takepicture_screen.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device. Wrap in try/catch
  // so that a plugin error doesn't crash the whole app on startup.
  List<CameraDescription> cameras = <CameraDescription>[];
  try {
    cameras = await availableCameras();
  } catch (e) {
    // Log the error and continue — we'll show a friendly message if no camera
    // is available or the plugin failed to initialize.
    debugPrint('availableCameras() failed: $e');
  }

  // Get a specific camera from the list of available cameras if any.
  final CameraDescription? firstCamera = cameras.isNotEmpty
      ? cameras.first
      : null;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: firstCamera != null
          ? TakePictureScreen(
              // Pass the appropriate camera to the TakePictureScreen widget.
              camera: firstCamera,
            )
          : const Scaffold(
              body: Center(
                child: Text(
                  'No camera available or camera initialization failed.',
                ),
              ),
            ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
