import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmojieMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  img.Image imagePath;
  String dir;
  PanelController controller = PanelController();
  static BoxShadow shadow2 = BoxShadow(spreadRadius: -20, color: Colors.black45, blurRadius: 20, offset: Offset(0, 14));

  @override
  Widget build(BuildContext context) {
    //double width =
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SlidingUpPanel(
          controller: controller,
          body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Align(
              alignment: Alignment.topCenter,
              child: DottedBorder(
                color: Colors.black45,
                borderType: BorderType.RRect,
                radius: Radius.circular(20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 475,
                  width: 350,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10),
                          child: Text(
                            'Import Media',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 75.0),
                        child: Container(
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_a_photo_outlined),
                                onPressed: null,
                                iconSize: 96,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 25),
                                child: Text(
                                  'Or',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.photo_library_outlined),
                                onPressed: null,
                                iconSize: 96,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Text('Import Media', style: TextStyle(color: Colors.black, fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          panel: Align(
            alignment: Alignment.topRight,
            child: FlatButton(
              minWidth: 25,
              onPressed: null,
              //color: Colors.blue,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 54,
                        ),
                        Container(
                          //color: Colors.black45,
                          width: 50,
                          height: 7,
                          decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                        Spacer(
                          flex: 30,
                        ),
                        Text(
                          'Generate',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [shadow2],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Res Usage',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: FlutterSlider(
                            trackBar: FlutterSliderTrackBar(
                              inactiveTrackBar: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.black12,
                                border: Border.all(width: 3, color: Colors.black87),
                              ),
                              activeTrackBar: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.blue),
                            ),
                            //jump: true,
                            tooltip: FlutterSliderTooltip(
                                textStyle: TextStyle(fontSize: 16, color: Colors.black87),
                                boxStyle: FlutterSliderTooltipBox(
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.grey[300]))),
                            hatchMark: FlutterSliderHatchMark(
                              //linesDistanceFromTrackBar: 50,
                              //density: .09,
                              labels: [
                                FlutterSliderHatchMarkLabel(
                                    percent: 0,
                                    label: Text(
                                      '25',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 33,
                                    label: Text(
                                      '50',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 66,
                                    label: Text(
                                      '75',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 100,
                                    label: Text(
                                      '100',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                              ], // means 50 lines, from 0 to 100 percent
                            ),
                            values: [25, 50, 75, 100],
                            onDragCompleted: (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
                              //setState(() {
                              //  pointsToWin = lowerValue.toInt();
                              //  data.setPointsToWin(pointsToWin);
                              //});
                            },
                            min: 25,
                            max: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [shadow2],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Scale Count',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: FlutterSlider(
                            trackBar: FlutterSliderTrackBar(
                              inactiveTrackBar: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.black12,
                                border: Border.all(width: 3, color: Colors.black87),
                              ),
                              activeTrackBar: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.blue),
                            ),
                            //jump: true,
                            tooltip: FlutterSliderTooltip(
                                textStyle: TextStyle(fontSize: 16, color: Colors.black87),
                                boxStyle: FlutterSliderTooltipBox(
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.grey[300]))),
                            hatchMark: FlutterSliderHatchMark(
                              //linesDistanceFromTrackBar: 50,
                              //density: .09,
                              labels: [
                                FlutterSliderHatchMarkLabel(
                                    percent: 0,
                                    label: Text(
                                      '5',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 33,
                                    label: Text(
                                      '20',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 66,
                                    label: Text(
                                      '30',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 100,
                                    label: Text(
                                      '40',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                              ], // means 50 lines, from 0 to 100 percent
                            ),
                            values: [5, 20, 40, 60],
                            onDragCompleted: (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
                              //setState(() {
                              //  pointsToWin = lowerValue.toInt();
                              //  data.setPointsToWin(pointsToWin);
                              //});
                            },
                            min: 5,
                            max: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget getImage() {
    if (imagePath != null) {
      //File('$dir/tmp.png').writeAsBytesSync(img.encodePng(imagePath));
      return Container(
        height: 500,
        child: PinchZoom(
          image: Image.memory(img.encodePng(imagePath)),
          zoomedBackgroundColor: Colors.transparent,
          resetDuration: const Duration(milliseconds: 100),
          //maxScale: 15.0,
        ),
      );
    } else {
      return Text('');
    }
  }

  void perm() async {
    await [Permission.mediaLibrary, Permission.photos].request();
  }

  void run() async {
    final directory = await getApplicationDocumentsDirectory();
    dir = directory.path;
    perm();
    int indexVar = 16;
    File imagePick = await ImagePicker.pickImage(source: ImageSource.camera);
    img.Image image = img.decodeImage(imagePick.readAsBytesSync());
    ByteData test = await rootBundle.load("assets/font14.zip");
    var font = img.BitmapFont.fromZip(test.buffer.asUint8List());

    img.Image image3 = img.copyResize(image, width: (image.width / 2).floor());
    img.Image image2 = img.Image(image3.width, image3.height);
    image2.fill(Colors.black.value);
    int width = image3.width;
    int height = image3.height;
    for (int w = 0; w <= width; w += 5) {
      for (int h = 0; h <= height; h += 5) {
        //AABBGGRR
        int output = image3.getPixel(w, h);
        //print(output);
        //String yes = output.toRadixString(16);
        img.drawString(image2, font, w, h, "⛄", color: output);
      }
    }

    setState(() {
      imagePath = image2;
    });
    print('Done');
  }
}
