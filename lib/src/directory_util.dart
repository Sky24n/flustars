import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

/// getTemporaryDirectory
/// 设备上未备份的临时目录的路径，适用于存储下载文件的缓存。
/// 此目录中的文件可以随时清除。 *不会*返回新的临时目录。 相反，调用者负责在此目录中创建（和清理）文件或目录。 此目录的作用域是调用应用程序。
/// 在iOS上，它使用“NSCachesDirectory”API。
/// 在Android上，它在上下文中使用“getCacheDir”API。

/// getApplicationSupportDirectory
/// 应用程序可以在其中放置应用程序支持文件的目录的路径。
/// 将此文件用于您不想向用户公开的文件。 您的应用不应将此目录用于用户数据文件。
/// 在iOS上，它使用`NSApplicationSupportDirectory` API。 如果此目录不存在，则会自动创建。
/// 在Android上，此函数在上下文中使用`getFilesDir` API。

/// getApplicationDocumentsDirectory
/// 应用程序可能在其中放置用户生成的数据或应用程序无法重新创建的数据的目录路径。
/// 在iOS上，它使用`NSDocumentDirectory` API。 如果不是用户生成的数据，请考虑使用[getApplicationSupportDirectory]。
/// 在Android上，它在上下文上使用`getDataDirectory` API。 如果要让用户看到数据，请考虑改用[getExternalStorageDirectory]。

/// getExternalStorageDirectory
/// 应用程序可以访问顶级存储的目录的路径。在发出此函数调用之前，应确定当前操作系统，因为此功能仅在Android上可用。
/// 在iOS上，这个函数抛出一个[UnsupportedError]，因为它不可能访问应用程序的沙箱之外。
/// 在Android上，它使用`getExternalFilesDir（null）`。

bool _initTempDir = false;
bool _initAppDocDir = false;
bool _initAppSupportDir = false;
bool _initStorageDir = false;

/// 配置初始化Directory。
void setInitDir({
  bool initTempDir,
  bool initAppDocDir,
  bool initAppSupportDir,
  bool initStorageDir,
}) {
  _initTempDir = initTempDir ?? _initTempDir;
  _initAppDocDir = initAppDocDir ?? _initAppDocDir;
  _initAppSupportDir = initAppSupportDir ?? _initAppSupportDir;
  _initStorageDir = initStorageDir ?? _initStorageDir;
}

/**
 * @Author: Sky24n
 * @GitHub: https://github.com/Sky24n
 * @Email: sky24no@gmail.com
 * @Description: Directory Util.
 * @Date: 2019/05/09
 */

/// DirectoryUtil。
class DirectoryUtil {
  static DirectoryUtil _singleton;

  static Lock _lock = Lock();

  static Directory _tempDir;
  static Directory _appDocDir;
  static Directory _appSupportDir;
  static Directory _storageDir;

  static Future<DirectoryUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = DirectoryUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  DirectoryUtil._();

  Future _init() async {
    int old = DateTime.now().millisecondsSinceEpoch;
    if (_initTempDir) {
      await initTempDir();
    }
    if (_initAppDocDir) {
      await initAppDocDir();
    }
    if (_initAppSupportDir) {
      await initAppSupportDir();
    }
    if (_initStorageDir) {
      await initStorageDir();
    }
    print(
        "thll DirectoryUtil init : ${DateTime.now().millisecondsSinceEpoch - old}");
  }

  static Future<Directory> initTempDir() async {
    if (_tempDir == null) {
      _tempDir = await getTemporaryDirectory();
    }
    return _tempDir;
  }

  static Future<Directory> initAppDocDir() async {
    if (_appDocDir == null) {
      _appDocDir = await getApplicationDocumentsDirectory();
    }
    return _appDocDir;
  }

  static Future<Directory> initAppSupportDir() async {
    if (_appSupportDir == null) {
      _appSupportDir = await getApplicationSupportDirectory();
    }
    return _appSupportDir;
  }

  static Future<Directory> initStorageDir() async {
    if (_storageDir == null) {
      if (Platform.isAndroid) {
        _storageDir = await getExternalStorageDirectory();
      }
    }
    return _storageDir;
  }

  /// 同步创建文件夹
  static Directory createDirSync(String path) {
    if (path == null) return null;
    Directory dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  /// 异步创建文件夹
  static Future<Directory> createDir(String path) async {
    if (path == null) return null;
    Directory dir = Directory(path);
    bool exist = await dir.exists();
    if (!exist) {
      dir = await dir.create(recursive: true);
    }
    return dir;
  }

  /// get path.
  /// dir
  /// category 分类，例如：Download，Pictures, Music等等
  /// fileName 文件名
  /// format 文件格式，如果文件名包含格式，则不需要
  static String getPath(
    Directory dir, {
    String category,
    String fileName,
    String format,
  }) {
    if (dir == null) return null;
    StringBuffer sb = StringBuffer("${dir.path}");
    if (category != null) sb.write("/$category");
    if (fileName != null) sb.write("/$fileName");
    if (format != null) sb.write(".$format");
    return sb.toString();
  }

  /// get Temporary Directory file path.
  /// category 分类，例如：Download，Pictures, Music等等
  /// fileName 文件名
  /// format 文件格式，如果文件名包含格式，则不需要
  /// String path = DirectoryUtil.getTempPath(category: 'Pictures',fileName: 'demo.png');
  /// String path = DirectoryUtil.getTempPath(category: 'Pictures', fileName: 'demo', format: 'png');
  /// Android: /data/user/0/com.thl.flustars_example/cache/Pictures/demo.png
  /// iOS: xxx;
  static String getTempPath({
    String category,
    String fileName,
    String format,
  }) {
    return getPath(_tempDir,
        category: category, fileName: fileName, format: format);
  }

  /// get Application Documents Directory file path.
  /// fileName 文件名
  /// format 文件格式，如果文件名包含格式，则不需要
  /// category 分类，例如：Download，Pictures, Music等等
  /// String path = DirectoryUtil.getAppDocPath(category: 'Pictures', fileName: 'demo.png');
  /// String path = DirectoryUtil.getAppDocPath(category: 'Pictures', fileName: 'demo', format: 'png');
  /// Android: /data/user/0/com.thl.flustars_example/app_flutter/Pictures/demo.png
  /// iOS: xxx;
  static String getAppDocPath({
    String category,
    String fileName,
    String format,
  }) {
    return getPath(_appDocDir,
        category: category, fileName: fileName, format: format);
  }

  /// get Application Support Directory file path.
  /// fileName 文件名
  /// format 文件格式，如果文件名包含格式，则不需要
  /// category 分类，例如：video，image等等
  /// String path = DirectoryUtil.getAppSupportPath(category: 'Pictures', fileName: 'demo.png');
  /// String path = DirectoryUtil.getAppSupportPath(category: 'Pictures', fileName: 'demo', format: 'png');
  /// Android: /data/user/0/com.thl.flustars_example/files/Pictures/demo.png
  /// iOS: xxx;
  static String getAppSupportPath({
    String category,
    String fileName,
    String format,
  }) {
    return getPath(_appSupportDir,
        category: category, fileName: fileName, format: format);
  }

  /// get External Storage Directory file path.
  /// category 分类，例如：video，image等等
  /// fileName 文件名
  /// format 文件格式，如果文件名包含格式，则不需要
  /// String path = DirectoryUtil.getStoragePath(category: 'Download', fileName: 'demo.apk';
  /// String path = DirectoryUtil.getStoragePath(category: 'Download', fileName: 'demo', format: 'apk');
  /// Android: /storage/emulated/0/Android/data/com.thl.flustars_example/files/Download/demo.apk
  /// iOS: xxx;
  static String getStoragePath(
      {String category, String fileName, String format}) {
    return getPath(
      _storageDir,
      category: category,
      fileName: fileName,
      format: format,
    );
  }

  static Directory createTempDirSync({String category}) {
    String path = getTempPath(category: category);
    return createDirSync(path);
  }

  static Directory createAppDocDirSync({String category}) {
    String path = getAppDocPath(category: category);
    return createDirSync(path);
  }

  static Directory createAppSupportDirSync({String category}) {
    String path = getAppSupportPath(category: category);
    return createDirSync(path);
  }

  static Directory createStorageDirSync({String category}) {
    String path = getStoragePath(category: category);
    return createDirSync(path);
  }

  static Future<Directory> createTempDir({String category}) async {
    await initTempDir();
    String path = getTempPath(category: category);
    return createDir(path);
  }

  static Future<Directory> createAppDocDir({String category}) async {
    await initAppDocDir();
    String path = getAppDocPath(category: category);
    return createDir(path);
  }

  static Future<Directory> createAppSupportDir({String category}) async {
    await initAppSupportDir();
    String path = getAppSupportPath(category: category);
    return createDir(path);
  }

  static Future<Directory> createStorageDir({String category}) async {
    await initStorageDir();
    String path = getStoragePath(category: category);
    return createDir(path);
  }
}
