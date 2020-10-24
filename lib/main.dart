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
  img.Image imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: MaterialButton(
                minWidth: 250,
                onPressed: run,
                color: Colors.blue,
              ),
            ),
            getImage(),
          ]),
        ),
      ),
    );
  }

  Widget getImage() {
    if (imagePath != null) {
      Uint8List _image = imagePath.data.buffer.asUint8List();
      print(_image);
      //Uint8List.fromList()
      //ByteData.view(Uint8List.fromList(a).buffer).getUint32(0);
      return Image.memory(_image);
    } else {
      return Text('');
    }
  }

  void run() async {
    int indexVar = 16;
    File imagePick = await ImagePicker.pickImage(source: ImageSource.camera);
    //imagePick.readAsBytesSync();
    img.Image image = img.decodeImage(imagePick.readAsBytesSync());
    int width = image.width;
    int height = image.height;
    print(width);
    print(height);
    List<String> colorVales = [];
    for (int w = 0; w <= width; ++w) {
      for (int h = 0; h <= height; ++h) {
        var output = image.getPixelSafe(w, h);
        var yes = output.toRadixString(16);
        colorVales.add(yes);
      }
    }
    //img.Image image2 = img.Image(width, height);
    //img.drawString(image2, img.BitmapFont.fromFnt("Ariel", image2), 0, 0, '🤣', color: Colors.blue[500].value);
    //img.drawChar(image, img.arial_14, (width / 2).floor(), (height / 2).floor(), '🤣');
    setState(() {
      imagePath = image;
    });
    //return image2;
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
