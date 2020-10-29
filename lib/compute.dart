import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'chars.dart';

class Computer {
  img.BitmapFont font;
  int resPercentage = 50;
  int countPerPixel = 12;
  int selectedFont = 18;
  int selectedFontIndex = 1;
  img.Image orgImage;
  img.Image generatedImage;
  List<int> fontRange = [14, 18, 22, 26];

  Future<void> loadFont() async {
    String fontStr = "assets/font$selectedFont.zip";
    ByteData fontData = await rootBundle.load(fontStr);
    font = img.BitmapFont.fromZip(fontData.buffer.asUint8List());
  }

  Future<img.Image> computeImage() async {
    await loadFont();
    double scaleValue = resPercentage / 100;
    int scaleWidth = (orgImage.width * scaleValue).floor();
    img.Image imgCopy = img.copyResize(orgImage, width: scaleWidth);
    img.Image retImage = img.Image(imgCopy.width, imgCopy.height);
    retImage.fill(Colors.black.value);
    int width = retImage.width;
    int height = retImage.height;
    for (int w = 0; w <= width; w += countPerPixel) {
      for (int h = 0; h <= height; h += countPerPixel) {
        int output = imgCopy.getPixelSafe(w, h);
        img.drawString(retImage, font, w, h, Char.selectedChar, color: output);
      }
    }
    imgCopy = null;
    return retImage;
  }
}
