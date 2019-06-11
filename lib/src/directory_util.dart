import 'dart:async';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

/// getTemporaryDirectory
/// 指向设备上临时目录的路径，该目录没有备份，适合存储下载文件的缓存。
/// 此目录中的文件可以随时清除。这不会返回一个新的临时目录。相反，调用者负责在这个目录中创建(和清理)文件或目录。这个目录的作用域是调用应用程序。
/// 在iOS上，它使用“NSCachesDirectory”API。
/// 在Android上，它在上下文中使用“getCacheDir”API。

/// getApplicationSupportDirectory
/// 应用程序可以放置应用程序支持文件的目录的路径。
/// 对不希望向用户公开的文件使用此选项。您的应用程序不应将此目录用于用户数据文件。
/// 在iOS上，它使用“NSApplicationSupportDirectory”API。如果此目录不存在，则自动创建。
/// 在Android上，此函数抛出一个[UnsupportedError]。

/// getApplicationDocumentsDirectory
/// 指向应用程序可以放置用户生成的数据或应用程序无法重新创建的数据的目录的路径。
/// 在iOS上，它使用“NSDocumentDirectory”API。如果数据不是用户生成的，请考虑使用[GetApplicationSupportDirectory]。
/// 在Android上，这在上下文中使用了“getDataDirectory”API。如果数据对用户可见，请考虑改用getExternalStorageDirectory。

/// getExternalStorageDirectory
/// 应用程序可以访问顶层存储的目录的路径。在发出这个函数调用之前，应该确定当前操作系统，因为这个功能只在Android上可用。
/// 在iOS上，这个函数抛出一个[UnsupportedError]，因为它不可能访问应用程序的沙箱之外。
/// 在Android上，它使用“getExternalStorageDirectory”API。

bool _initTempDir = true;
bool _initAppDocDir = true;
bool _initStorageDir = true;

/// 配置初始化Directory。
void setInitDir({bool initTempDir, bool initAppDocDir, bool initStorageDir}) {
  _initTempDir = initTempDir ?? _initTempDir;
  _initAppDocDir = initAppDocDir ?? _initAppDocDir;
  _initStorageDir = initStorageDir ?? _initStorageDir;
}

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @JianShu: https://www.jianshu.com/u/cbf2ad25d33a
 * @Email: 863764940@qq.com
 * @Description: Directory Util.
 * @Date: 2019/05/09
 */

/// DirectoryUtil。
class DirectoryUtil {
  static DirectoryUtil _singleton;

  static Lock _lock = Lock();

  static Directory _tempDir;
  static Directory _appDocDir;
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
    if (_initTempDir) {
      await initTempDir();
    }
    if (_initAppDocDir) {
      await initAppDocDir();
    }
    if (_initStorageDir) {
      await initStorageDir();
    }
  }

  static Future initTempDir() async {
    if (_tempDir == null) {
      _tempDir = await getTemporaryDirectory();
    }
  }

  static Future initAppDocDir() async {
    if (_appDocDir == null) {
      _appDocDir = await getApplicationDocumentsDirectory();
    }
  }

  static Future initStorageDir() async {
    if (_storageDir == null) {
      if (Platform.isAndroid) {
        _storageDir = await getExternalStorageDirectory();
      }
// 考虑旧版兼容问题，暂时屏蔽。该方法在v1.1.0才有。
//      if (Platform.isIOS) {
//        _storageDir = await getApplicationSupportDirectory();
//      }
    }
  }

  /// 同步创建文件夹
  static Directory createDirSync(String path) {
    if (ObjectUtil.isEmpty(path)) return null;
    Directory dir = new Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  /// 异步创建文件夹
  static Future<Directory> createDir(String path) async {
    if (ObjectUtil.isEmpty(path)) return null;
    Directory dir = new Directory(path);
    bool exist = await dir.exists();
    if (!exist) {
      dir = await dir.create(recursive: true);
    }
    return dir;
  }

  /// fileName 文件名
  /// format 文件格式，如果文件名包含格式，则不需要
  /// package 顶层文件夹名，默认doc
  /// category 分类，例如：video，image等等
  /// String path = DirectoryUtil.getTempPath(fileName: 'demo.png', category: 'image');
  /// String path = DirectoryUtil.getTempPath(fileName: 'demo', format: 'png', category: 'image');
  /// Android: /data/user/0/com.thl.flustars_example/cache/doc/image/demo.png
  /// iOS: xxx;
  static String getTempPath({
    String fileName,
    String format,
    String package = 'doc',
    String category,
  }) {
    if (_tempDir == null) return null;
    StringBuffer sb = new StringBuffer("${_tempDir.path}");
    if (!ObjectUtil.isEmpty(package)) sb.write("/$package");
    if (!ObjectUtil.isEmpty(category)) sb.write("/$category");
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    if (!ObjectUtil.isEmpty(format)) sb.write(".$format");
    return sb.toString();
  }

  /// fileName 文件名
  /// format 文件格式，如果文件名包含格式，则不需要
  /// package 顶层文件夹名，默认doc
  /// category 分类，例如：video，image等等
  /// String path = DirectoryUtil.getAppDocPath(fileName: 'demo.mp4', category: 'video');
  /// String path = DirectoryUtil.getAppDocPath(fileName: 'demo', format: 'mp4', category: 'video');
  /// Android: /data/user/0/com.thl.flustars_example/app_flutter/doc/video/demo.mp4
  /// iOS: xxx;
  static String getAppDocPath({
    String fileName,
    String format,
    String package = 'doc',
    String category,
  }) {
    if (_appDocDir == null) return null;
    StringBuffer sb = new StringBuffer("${_appDocDir.path}");
    if (!ObjectUtil.isEmpty(package)) sb.write("/$package");
    if (!ObjectUtil.isEmpty(category)) sb.write("/$category");
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    if (!ObjectUtil.isEmpty(format)) sb.write(".$format");
    return sb.toString();
  }

  /// fileName 文件名
  /// format 文件格式，如果文件名包含格式，则不需要
  /// package 顶层文件夹名，建议使用包名
  /// category 分类，例如：video，image等等
  /// String path = DirectoryUtil.getStoragePath(fileName: 'flutterwanandroid.apk', package: 'com.thl.flutterwanandroid');
  /// String path = DirectoryUtil.getStoragePath(fileName: 'flutterwanandroid', format: 'apk', package: 'com.thl.flutterwanandroid');
  /// Android: /storage/emulated/0/com.thl.flutterwanandroid/flutterwanandroid.apk
  /// iOS: xxx;
  static String getStoragePath({
    String fileName,
    String format,
    String package,
    String category,
  }) {
    if (_storageDir == null) return null;
    StringBuffer sb = new StringBuffer("${_storageDir.path}");
    if (!ObjectUtil.isEmpty(package)) sb.write("/$package");
    if (!ObjectUtil.isEmpty(category)) sb.write("/$category");
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    if (!ObjectUtil.isEmpty(format)) sb.write(".$format");
    return sb.toString();
  }

  static Directory createTempDirSync({String package, String category}) {
    String path = getTempPath(package: package, category: category);
    return createDirSync(path);
  }

  static Directory createAppDocDirSync({String package, String category}) {
    String path = getAppDocPath(package: package, category: category);
    return createDirSync(path);
  }

  static Directory createStorageDirSync({String package, String category}) {
    String path = getStoragePath(package: package, category: category);
    return createDirSync(path);
  }

  static Future<Directory> createTempDir(
      {String package, String category}) async {
    await initTempDir();
    String path = getTempPath(package: package, category: category);
    return createDir(path);
  }

  static Future<Directory> createAppDocDir(
      {String package, String category}) async {
    await initAppDocDir();
    String path = getAppDocPath(package: package, category: category);
    return createDir(path);
  }

  static Future<Directory> createStorageDir(
      {String package, String category}) async {
    await initStorageDir();
    String path = getStoragePath(package: package, category: category);
    return createDir(path);
  }
}
