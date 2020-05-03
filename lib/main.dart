import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
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
    File imagePick = await ImagePicker.pickImage(source: ImageSource.camera);
    img.Image image = img.decodeImage(imagePick.readAsBytesSync());
    img.Channels chan = image.channels;
    var test = image.data;
    print(chan.toString());
    print(test);
  }
}
