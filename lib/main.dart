import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:emojieme/chars.dart';
import 'package:emojieme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
      title: 'EmojiMe',
      debugShowCheckedModeBanner: false,
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
  Computer computer = Computer();

  void setStatus() async {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }

  @override
  void initState() {
    setStatus();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SlidingUpPanel(
          maxHeight: 550,
          controller: controller,
          body: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Align(
              alignment: Alignment.topCenter,
              child: buildImage(),
            ),
          ),
          panel: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, //Center Row contents horizontally,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getSaveOrSpacer(),
                  Container(
                    width: 50,
                    height: 7,
                    decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  FlatButton(
                    onPressed: () async {
                      if (computer.orgImage != null) {
                        alerts.showLoading(context, "Generating Image...");
                        await controller.close();
                        img.Image tmpImg = await computer.computeImage();
                        setState(() {
                          computer.generatedImage = tmpImg;
                        });
                        tmpImg = null;
                        alerts.dismissContext();
                      } else {
                        alerts.showAlert(context, "Import an Image");
                      }
                    },
                    child: Text(
                      'Generate',
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                ]),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [Styles.topShadow, Styles.bottomShadow],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Text(
                        'Resolution Percentage',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
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
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.grey[300]))),
                        hatchMark: FlutterSliderHatchMark(
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
              padding: EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Container(
                constraints: BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [Styles.topShadow, Styles.bottomShadow],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Text(
                        'Count Per Pixel',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
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
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.grey[300]))),
                        hatchMark: FlutterSliderHatchMark(
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
                                  '15',
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                )),
                            FlutterSliderHatchMarkLabel(
                                percent: 66,
                                label: Text(
                                  '25',
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                )),
                            FlutterSliderHatchMarkLabel(
                                percent: 100,
                                label: Text(
                                  '35',
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                )),
                          ], // means 50 lines, from 0 to 100 percent
                        ),
                        values: [computer.countPerPixel.toDouble()],
                        onDragCompleted: (int handlerIndex, dynamic lowerValue, dynamic upperValue) {
                          computer.countPerPixel = lowerValue.toInt();
                        },
                        min: 5,
                        max: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30,
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [Styles.topShadow, Styles.bottomShadow],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Text(
                        'Emoji Scale',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 15, left: 28, right: 28),
                      child: ToggleSwitch(
                        initialLabelIndex: computer.selectedFontIndex,
                        cornerRadius: 12.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        labels: ['14', '18', '22', '26'],
                        activeBgColors: [
                          Colors.blue,
                          Colors.blue,
                          Colors.blue,
                          Colors.blue,
                        ],
                        onToggle: (index) {
                          computer.selectedFont = computer.fontRange[index];
                          computer.selectedFontIndex = index;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SelectEmojiWidget(),
          ]),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget getSaveOrSpacer() {
    if (computer.generatedImage != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 35.0),
        child: IconButton(
          icon: Icon(Icons.save_alt_outlined),
          color: Colors.black,
          onPressed: () async {
            await [Permission.storage, Permission.mediaLibrary].request();
            String time = DateTime.now().toIso8601String();
            try {
              await ImageGallerySaver.saveImage(Uint8List.fromList(img.encodeJpg(computer.generatedImage)), quality: 100, name: "emojime_$time");
              alerts.showAlert(context, "File saved!");
            } catch (PlatformException) {
              alerts.showAlert(context, "Failed to save. :(");
            }
          },
        ),
      );
    } else {
      return Container(
        width: 105,
      );
    }
  }

  Widget buildImage() {
    if (computer.orgImage != null && computer.generatedImage != null) {
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
                //width: 600,
                //height: 600,
                //cacheWidth: 600,
                //cacheHeight: 600,
                filterQuality: FilterQuality.medium,
                gaplessPlayback: true,
              ),
            ),
          ),
        ),
        Positioned(
          left: 7, top: -10, //bottom: -15,
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
                    gaplessPlayback: true,
                    //width: 600,
                    //height: 600,
                    //cacheWidth: 600,
                    //cacheHeight: 600,
                    filterQuality: FilterQuality.medium,
                  ),
                )),
          ),
          Positioned(
            left: 7, top: -10, //bottom: -15,
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
                          alerts.showLoading(context, "Reading Image...");
                          try {
                            final _picker = ImagePicker();
                            PickedFile imagePick = await _picker.getImage(source: ImageSource.camera, maxHeight: 1024, maxWidth: 1024, imageQuality: 75);
                            Uint8List imageBytes = await imagePick.readAsBytes();
                            computer.orgImage = img.bakeOrientation(img.decodeImage(imageBytes));
                            setStatus();
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
                        onPressed: () async {
                          await [Permission.photos].request();
                          alerts.showLoading(context, "Reading Image...");
                          try {
                            final _picker = ImagePicker();
                            PickedFile imagePick = await _picker.getImage(source: ImageSource.gallery, maxHeight: 1024, maxWidth: 1024, imageQuality: 75);
                            Uint8List imageBytes = await imagePick.readAsBytes();
                            computer.orgImage = img.bakeOrientation(img.decodeImage(imageBytes));
                            setStatus();
                            alerts.dismissContext();
                            setState(() {});
                            await controller.open();
                          } catch (PlatformException) {
                            alerts.dismissContext();
                          }
                        },
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
