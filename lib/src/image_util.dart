import 'dart:async';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;
import 'package:flutter/widgets.dart';

/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Email: sky24no@gmail.com
 * @Description: Image Util.
 * @Date: 2020/03/10
 */

/// Image Util.
class ImageUtil {
  ImageStreamListener _listener;
  ImageStream _imageStream;

  /// get image width height，load error throw exception.（unit px）
  /// 获取图片宽高，加载错误会抛出异常.（单位 px）
  /// image
  /// url network
  /// local url , package
  Future<Rect> getImageWH({
    Image image,
    String url,
    String localUrl,
    String package,
    ImageConfiguration configuration,
  }) {
    Completer<Rect> completer = Completer<Rect>();
    _listener = ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        _imageStream.removeListener(_listener);
        if (!completer.isCompleted) {
          completer.complete(Rect.fromLTWH(
              0, 0, info.image.width.toDouble(), info.image.height.toDouble()));
        }
      },
      onError: (dynamic exception, StackTrace stackTrace) {
        _imageStream.removeListener(_listener);
        if (!completer.isCompleted) {
          completer.completeError(exception, stackTrace);
        }
      },
    );

    if (image == null &&
        (url == null || url.isEmpty) &&
        (localUrl == null || localUrl.isEmpty)) {
      return Future.value(Rect.zero);
    }
    Image img = image != null
        ? image
        : ((url != null && url.isNotEmpty)
            ? Image.network(url)
            : Image.asset(localUrl, package: package));
    _imageStream = img.image.resolve(configuration ?? ImageConfiguration());
    _imageStream.addListener(_listener);
    return completer.future;
  }

  /// CameraImage yuv420 convert to Jpg bytes
  /// Android摄像头图片对象 yuv420 转换至 jpg 数据
  /// https://github.com/flutter/flutter/issues/26348
  ///
  /// image
  Future<List<int>> convertYUV420ToImageByte(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel;

      print("uvRowStride: " + uvRowStride.toString());
      print("uvPixelStride: " + uvPixelStride.toString());

      // imgLib -> Image package from https://pub.dartlang.org/packages/image
      var img = imglib.Image(width, height); // Create Image buffer

      // Fill image buffer with plane[0] from YUV420_888
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex =
              uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
        }
      }

      // imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
      imglib.JpegEncoder jpgEncoder = new imglib.JpegEncoder(quality: 100);

      List<int> png = jpgEncoder.encodeImage(img);
      // muteYUVProcessing = false;
      return png;
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

  /// CameraImage yuv420 convert to Image widget
  /// 摄像头图片对象 YUV420 转换至 Image Widget
  /// image
  Future<Image> convertYUV420ToImage(CameraImage image) async {
    List<int> bin = await convertYUV420ToImageByte(image);
    return Image.memory(bin);
  }
}
