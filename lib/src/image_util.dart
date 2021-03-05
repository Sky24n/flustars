import 'dart:async';

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
  late ImageStreamListener _listener;
  late ImageStream _imageStream;

  /// get image width height，load error throw exception.（unit px）
  /// 获取图片宽高，加载错误会抛出异常.（单位 px）
  /// image
  /// url network
  /// local url , package
  Future<Rect> getImageWH({
    Image? image,
    String? url,
    String? localUrl,
    String? package,
    ImageConfiguration? configuration,
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
      onError: (dynamic exception, StackTrace? stackTrace) {
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
    Image? img = image;
    if (img == null) {
      img = (url != null && url.isNotEmpty)
          ? Image.network(url)
          : Image.asset(localUrl!, package: package);
    }
    _imageStream = img.image.resolve(configuration ?? ImageConfiguration());
    _imageStream.addListener(_listener);
    return completer.future;
  }
}
