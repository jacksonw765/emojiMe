import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'chars.dart';

class Computer {
  img.BitmapFont font;
  int resPercentage = 50;
  int scaleCount = 12;
  img.Image orgImage;
  img.Image generatedImage;

  Computer() {
    init();
  }

  Future<void> init() async {
    ByteData fontData = await rootBundle.load("assets/font14.zip");
    font = img.BitmapFont.fromZip(fontData.buffer.asUint8List());
  }

  Future<img.Image> computeImage() async {
    double scaleValue = resPercentage / 100;
    int scaleWidth = (orgImage.width * scaleValue).floor();
    img.Image image2 = img.copyResize(orgImage, width: scaleWidth, interpolation: img.Interpolation.linear);
    //img.Image image3 = img.Image(image2.width, image2.height);
    image2.fill(Colors.black.value);
    int width = image2.width;
    int height = image2.height;
    for (int w = 0; w <= width; w += scaleCount) {
      for (int h = 0; h <= height; h += scaleCount) {
        int output = orgImage.getPixelSafe(w, h);
        img.drawString(image2, font, w, h, Char.selectedChar, color: output);
      }
    }
    return image2;
  }
}
