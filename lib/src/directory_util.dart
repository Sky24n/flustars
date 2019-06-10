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

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @JianShu: https://www.jianshu.com/u/cbf2ad25d33a
 * @Email: 863764940@qq.com
 * @Description: Directory Util.
 * @Date: 2019/05/09
 */

///
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
    _tempDir = await getTemporaryDirectory();
    _appDocDir = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      _storageDir = await getExternalStorageDirectory();
    }
    if (Platform.isIOS) {
      _storageDir = await getApplicationSupportDirectory();
    }
  }

  static String getTempPath(
      {String fileName,
      String format,
      String package = 'doc',
      String category}) {
    if (_tempDir == null) return null;
    StringBuffer sb = new StringBuffer("${_tempDir.path}");
    if (!ObjectUtil.isEmpty(package)) sb.write("/$package");
    if (!ObjectUtil.isEmpty(category)) sb.write("/$category");
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    if (!ObjectUtil.isEmpty(format)) sb.write(".$format");
    return sb.toString();
  }

  static String getAppDocPath(
      {String fileName,
      String format,
      String package = 'doc',
      String category}) {
    if (_appDocDir == null) return null;
    StringBuffer sb = new StringBuffer("${_appDocDir.path}");
    if (!ObjectUtil.isEmpty(package)) sb.write("/$package");
    if (!ObjectUtil.isEmpty(category)) sb.write("/$category");
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    if (!ObjectUtil.isEmpty(format)) sb.write(".$format");
    return sb.toString();
  }

  static String getStoragePath(
      {String fileName, String format, String package, String category}) {
    if (_storageDir == null) return null;
    StringBuffer sb = new StringBuffer("${_storageDir.path}");
    if (!ObjectUtil.isEmpty(package)) sb.write("/$package");
    if (!ObjectUtil.isEmpty(category)) sb.write("/$category");
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    if (!ObjectUtil.isEmpty(format)) sb.write(".$format");
    return sb.toString();
  }

  static Directory createDirSync(String path) {
    Directory dir = new Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  static Future<Directory> createDir(String path) async {
    Directory dir = new Directory(path);
    bool exist = await dir.exists();
    if (!exist) {
      dir = await dir.create(recursive: true);
    }
    return dir;
  }
}
