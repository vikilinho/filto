import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;
  bool isRecording = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            CameraDeepAr(
                onCameraReady: (isReady) {
                  print("Camera status $isReady");
                },
                onImageCaptured: (path) {
                  print("Image Taken $path");
                },
                onVideoRecorded: (path) {
                  print("Video Recorded @ $path");
                },
                androidLicenceKey:
                    '9e099bd5a5867a3e4679a4b9c757a248f5dc79a40064251c2fc03f7b2703e560278cdc30610b5311',
                iosLicenceKey:
                    'c3323d1f776efdeb6c4f88e86c087e4fa03b82605d5f83d6fd28b8ae0d35c9318cd3003734eca8d5',
                cameraDeepArCallback: (c) async {
                  cameraDeepArController = c;
                  setState(() {});
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(Masks.values.length, (p) {
                          bool active = currentPage == p;
                          return GestureDetector(
                            onTap: () {
                              currentPage = p;
                              cameraDeepArController.changeMask(p);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              width: active ? 40 : 30,
                              height: active ? 50 : 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: active ? Colors.green : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "$p",
                                style: TextStyle(
                                    fontSize: active ? 16 : 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
