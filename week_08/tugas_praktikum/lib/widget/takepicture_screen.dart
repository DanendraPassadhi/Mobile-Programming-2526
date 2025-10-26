import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tugas_praktikum/widget/displaypicture_screen.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late final CameraController _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the controller and save the Future for a FutureBuilder.
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    // Wrap initialization in try/catch to avoid unhandled exceptions
    // bubbling to JNI; failures will be surfaced to the UI instead.
    _initializeControllerFuture = _controller.initialize().catchError((error) {
      // Log and rethrow to let FutureBuilder show an error state.
      // Do not let exceptions escape synchronously from initState.
      debugPrint('Camera initialization error: $error');
      return Future<void>.value();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture - 2341720144')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the CameraController is initialized, show the preview.
            return CameraPreview(_controller);
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 8),
                  Text('Camera failed to initialize: ${snapshot.error}'),
                ],
              ),
            );
          }
          // Otherwise, show a loading indicator.
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Ensure controller is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and navigate to the display screen.
            final XFile image = await _controller.takePicture();
            if (!mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: image.path),
              ),
            );
          } catch (e) {
            debugPrint('Error taking picture: $e');
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to take picture: $e')),
              );
            }
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
