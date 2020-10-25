import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex/hex.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  String dir;

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
      //File('$dir/tmp.png').writeAsBytesSync(img.encodePng(imagePath));
      return Image.memory(img.encodePng(imagePath));
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
    ByteData test =  await rootBundle.load("assets/font.zip");
    var font = img.BitmapFont.fromZip(test.buffer.asUint8List());

    //List<String> colorVales = [];
    img.Image image2 = img.copyResize(image, width: 2048);
    int width = image2.width;
    int height = image2.height;
    for (int w = 0; w <= width; w += 15) {
      for (int h = 0; h <= height; h += 15) {
        //AABBGGRR
        int output = image2.getPixelSafe(w, h);
        //String yes = output.toRadixString(16);
        img.drawString(image2, font, w, h, "A", color: output);
      }
    }

    setState(() {
      imagePath = image2;
    });
    print('Done');
  }

  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  int abgrToArgb2(Color color) {
    Color color2 = Color.fromARGB(0, color.red, color.green, color.blue);
    print(color2.value);
    return color2.value;
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Color getAverageColor(int color1, int color2) {
    //var hex1 = int.
    //var color = sqrt((R1^2+R2^2)/2),sqrt((G1^2+G2^2)/2),sqrt((B1^2+B2^2)/2)
  }
}
