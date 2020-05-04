
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmojieMe',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

  @override
  Widget build(BuildContext context) {
    //var image = AssetImage('assets/img/spongebob.png');

    //ByteData imageBytes = Services.load(imagePath);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: MaterialButton(
            onPressed: run,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  void run() async {
    int indexVar = 16;
    File imagePick = await ImagePicker.pickImage(source: ImageSource.camera);
    img.Image image = img.decodeImage(imagePick.readAsBytesSync());
    //var two = abgrToArgb(image.getPixelSafe(50, 200));
    int width = image.width;
    int height = image.height;
    print(width);
    print(height);
    List<String> colorVales = [];
    for(int w = 0; w <= width; ++w) {
      for(int h = 0; h <= height; ++h) {
        var output = image.getPixelSafe(w, h);
        var yes = output.toRadixString(16);
        colorVales.add(yes);
      }
    }
    //img.drawString(image, img.BitmapFont.fromFnt(fnt, page), 0, 0, '🤣');
    //img.draw
    print('Done');
  }

  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  Color getAverageColor(int color1, int color2) {

    //var hex1 = int.
    //var color = sqrt((R1^2+R2^2)/2),sqrt((G1^2+G2^2)/2),sqrt((B1^2+B2^2)/2)
  }
}
