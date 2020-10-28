import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:emojieme/chars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'alerts.dart';
import 'compute.dart';

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
  PanelController controller = PanelController();
  Alerts alerts = Alerts();
  BoxShadow shadow2 = BoxShadow(spreadRadius: -20, color: Colors.black45, blurRadius: 20, offset: Offset(0, 14));
  Computer computer = Computer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SlidingUpPanel(
          //minHeight: 600,
          //parallaxEnabled: true,
          //parallaxOffset: 25.0,
          maxHeight: 550,
          controller: controller,
          body: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Align(
              alignment: Alignment.topCenter,
              child: buildImage(),
            ),
          ),
          panel: Align(
            alignment: Alignment.topRight,
            child: FlatButton(
              minWidth: 25,
              onPressed: null,
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 54,
                      ),
                      Container(
                        width: 50,
                        height: 7,
                        decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      Spacer(
                        flex: 20,
                      ),
                      FlatButton(
                        onPressed: () async {
                          if (computer.orgImage != null) {
                            alerts.showLoading(context);
                            await controller.close();
                            final tmpImg = await computer.computeImage();
                            setState(() {
                              computer.generatedImage = tmpImg;
                            });
                            alerts.dismissContext();
                          }
                        },
                        child: Text(
                          'Generate',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ),
                    ]),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [shadow2],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Resolution Percentage',
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
                            values: [computer.resPercentage.toDouble()],
                            onDragCompleted: (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
                              computer.resPercentage = lowerValue.toInt();
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
                          'Count Per Pixel',
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
                            values: [computer.countPerPixel.toDouble()],
                            onDragCompleted: (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
                              computer.countPerPixel = lowerValue.toInt();
                            },
                            min: 5,
                            max: 60,
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
                          'Emoji Scale',
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: FlutterSlider(
                            jump: true,
                            trackBar: FlutterSliderTrackBar(
                              inactiveTrackBar: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.black12,
                                border: Border.all(width: 3, color: Colors.black87),
                              ),
                              activeTrackBar: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.blue),
                            ),
                            //values: [ 10, 50 ],
                            fixedValues: [
                              FlutterSliderFixedValue(percent: 0, value: "14"),
                              FlutterSliderFixedValue(percent: 33, value: "18"),
                              FlutterSliderFixedValue(percent: 66, value: "22"),
                              FlutterSliderFixedValue(percent: 100, value: "26"),
                            ],
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
                                      '14',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 33,
                                    label: Text(
                                      '18',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 66,
                                    label: Text(
                                      '22',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                                FlutterSliderHatchMarkLabel(
                                    percent: 100,
                                    label: Text(
                                      '26',
                                      style: TextStyle(color: Colors.black, fontSize: 12),
                                    )),
                              ], // means 50 lines, from 0 to 100 percent
                            ),

                            values: [computer.selectedFont.toDouble()],
                            onDragCompleted: (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
                              computer.selectedFont = int.parse(lowerValue);
                            },
                            min: 14,
                            max: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SelectEmojiWidget(),
              ]),
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget buildImage() {
    if (computer.orgImage != null && computer.generatedImage != null) {
      // display generated image
      return Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.all(10),
            height: 475,
            child: PinchZoom(
              zoomedBackgroundColor: Colors.transparent,
              resetDuration: const Duration(milliseconds: 100),
              image: Image.memory(
                img.encodePng(computer.generatedImage),
              ),
            ),
          ),
        ),
        Positioned(
          left: 7,
          top: -10,
          //bottom: -15,
          child: IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
              onPressed: () {
                computer.orgImage = null;
                computer.generatedImage = null;
                setState(() {});
              }),
        ),
      ]);
    } else if (computer.orgImage != null) {
      // display captured image
      return Container(
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.all(10),
                height: 475,
                child: PinchZoom(
                  zoomedBackgroundColor: Colors.transparent,
                  resetDuration: const Duration(milliseconds: 100),
                  image: Image.memory(
                    img.encodePng(computer.orgImage),
                  ),
                )),
          ),
          Positioned(
            left: 7,
            top: -10,
            //bottom: -15,
            child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    computer.orgImage = null;
                  });
                }),
          ),
        ]),
      );
    } else {
      return DottedBorder(
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
                  padding: const EdgeInsets.only(top: 10.0, left: 15),
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
                        onPressed: () async {
                          await [Permission.camera].request();
                          alerts.showLoading(context);
                          try {
                            PickedFile imagePick = await ImagePicker.platform.pickImage(source: ImageSource.camera);
                            Uint8List imageBytes = await imagePick.readAsBytes();
                            computer.orgImage = img.bakeOrientation(img.decodeImage(imageBytes));
                            alerts.dismissContext();
                            setState(() {});
                            await controller.open();
                          } catch (PlatformException) {
                            alerts.dismissContext();
                          }
                        },
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
            ],
          ),
        ),
      );
    }
  }
}
