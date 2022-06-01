import 'dart:async';
import 'package:flutter/widgets.dart';

/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Email: sky24no@gmail.com
 * @Description: Widget Util.
 * @Date: 2018/9/10
 */

/// Widget Util.
class WidgetUtil {
  bool _hasMeasured = false;
  double _width = 0;
  double _height = 0;

  /// Widget rendering listener.
  /// Widget渲染监听.
  /// context: Widget context.
  /// isOnce: true,Continuous monitoring  false,Listen only once.
  /// onCallBack: Widget Rect CallBack.
  void asyncPrepare(
      BuildContext context, bool isOnce, ValueChanged<Rect>? onCallBack) {
    if (_hasMeasured) return;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      RenderBox? box = getRenderBox(context);
      if (box != null) {
        if (isOnce) _hasMeasured = true;
        double width = box.semanticBounds.width;
        double height = box.semanticBounds.height;
        if (_width != width || _height != height) {
          _width = width;
          _height = height;
          if (onCallBack != null) onCallBack(box.semanticBounds);
        }
      }
    });
  }

  /// Widget渲染监听.
  void asyncPrepares(bool isOnce, ValueChanged<Rect>? onCallBack) {
    if (_hasMeasured) return;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (isOnce) _hasMeasured = true;
      if (onCallBack != null) onCallBack(Rect.zero);
    });
  }

  ///get Widget Bounds (width, height, left, top, right, bottom and so on).Widgets must be rendered completely.
  ///获取widget Rect
  static Rect getWidgetBounds(BuildContext context) {
    RenderBox? box = getRenderBox(context);
    return box?.semanticBounds ?? Rect.zero;
  }

  static RenderBox? getRenderBox(BuildContext context) {
    RenderObject? renderObject = context.findRenderObject();
    RenderBox? box;
    if (renderObject != null) {
      box = renderObject as RenderBox;
    }
    return box;
  }

  ///Get the coordinates of the widget on the screen.Widgets must be rendered completely.
  ///获取widget在屏幕上的坐标,widget必须渲染完成
  static Offset getWidgetLocalToGlobal(BuildContext context) {
    RenderBox? box = getRenderBox(context);
    return box == null ? Offset.zero : box.localToGlobal(Offset.zero);
  }

  /// Suggest use ImageUtil instead.
  ///
  /// get image width height，load error return Rect.zero.（unit px）
  /// Gif is not supported.
  /// 获取图片宽高，加载错误情况返回 Rect.zero.（单位 px）
  /// image
  /// url network
  /// local url , package
  static Future<Rect> getImageWH({
    Image? image,
    String? url,
    String? localUrl,
    String? package,
    ImageConfiguration? configuration,
  }) {
    if (image == null &&
        (url == null || url.isEmpty) &&
        (localUrl == null || localUrl.isEmpty)) {
      return Future.value(Rect.zero);
    }
    Completer<Rect> completer = Completer<Rect>();
    Image? img = image;
    if (img == null) {
      img = (url != null && url.isNotEmpty)
          ? Image.network(url)
          : Image.asset(localUrl!, package: package);
    }
    img.image
        .resolve(configuration ?? ImageConfiguration())
        .addListener(ImageStreamListener(
          (ImageInfo info, bool synchronousCall) {
            if (!completer.isCompleted) {
              completer.complete(Rect.fromLTWH(0, 0,
                  info.image.width.toDouble(), info.image.height.toDouble()));
            }
          },
          onError: (dynamic exception, StackTrace? stackTrace) {
            if (!completer.isCompleted) {
              completer.complete(Rect.zero);
            }
          },
        ));
    return completer.future;
  }

  /// Suggest use ImageUtil instead.
  ///
  /// get image width height, load error throw exception.（unit px）
  /// Gif is not supported.
  /// 获取图片宽高，加载错误会抛出异常.（单位 px）
  /// image
  /// url network
  /// local url (full path/全路径，example："assets/images/ali_connors.png"，""assets/images/3.0x/ali_connors.png"" );
  /// package
  static Future<Rect> getImageWHE({
    Image? image,
    String? url,
    String? localUrl,
    String? package,
    ImageConfiguration? configuration,
  }) {
    if (image == null &&
        (url == null || url.isEmpty) &&
        (localUrl == null || localUrl.isEmpty)) {
      return Future.error("image is null.");
    }
    Completer<Rect> completer = Completer<Rect>();
    Image? img = image;
    if (img == null) {
      img = (url != null && url.isNotEmpty)
          ? Image.network(url)
          : Image.asset(localUrl!, package: package);
    }
    img.image
        .resolve(configuration ?? ImageConfiguration())
        .addListener(ImageStreamListener(
          (ImageInfo info, bool synchronousCall) {
            if (!completer.isCompleted) {
              completer.complete(Rect.fromLTWH(0, 0,
                  info.image.width.toDouble(), info.image.height.toDouble()));
            }
          },
          onError: (dynamic exception, StackTrace? stackTrace) {
            if (!completer.isCompleted) {
              completer.completeError(exception, stackTrace);
            }
          },
        ));
    return completer.future;
  }
}
