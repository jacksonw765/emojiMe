import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class Computer {
  img.BitmapFont font;

  Computer() {
    init();
  }

  Future<void> init() async {
    ByteData fontData = await rootBundle.load("assets/font14.zip");
    font = img.BitmapFont.fromZip(fontData.buffer.asUint8List());
  }

  Future<img.Image> generateImage(File imagePick) async {
    img.Image image = img.decodeImage(imagePick.readAsBytesSync());
    img.Image image3 = img.copyResize(image, width: (image.width / 2).floor());
    img.Image image2 = img.Image(image3.width, image3.height);
    image2.fill(Colors.black.value);
    int width = image3.width;
    int height = image3.height;
    for (int w = 0; w <= width; w += 5) {
      for (int h = 0; h <= height; h += 5) {
        int output = image3.getPixel(w, h);
        img.drawString(image2, font, w, h, "⛄", color: output);
      }
    }
  }
}