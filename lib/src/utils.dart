/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @Email: 863764940@qq.com
 * @Email: sky24no@gmail.com
 * @Description: Widget Util.
 * @Date: 2019/03/07
 */

/// Utils.
class Utils {
  /// isEmpty.
  static bool isEmpty(Object value) {
    if (value == null) return true;
    if (value is String && value.isEmpty) {
      return true;
    }
    return false;
  }
}
