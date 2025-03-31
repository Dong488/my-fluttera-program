import 'package:common_utils/common_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPManager{

  SharedPreferences? sp ;

  static SPManager _instance = SPManager._();
  static SPManager get instance => _instance;

  factory SPManager (){
    return _getInstance();
  }

  static SPManager _getInstance() {
    return _instance;
  }

  SPManager._();

  initSp() async {
    if(sp == null){
      sp = await SharedPreferences.getInstance();
    }
    LogUtil.v("SharedPreferences initialized");
  }

  void put(String key, dynamic value) {
    if (value is String) {
      sp!.setString(key, value);
    } else if (value is int) {
      sp!.setInt(key, value);
    } else if (value is bool) {
      sp!.setBool(key, value);
    } else if (value is double) {
      sp!.setDouble(key, value);
    }
  }

  T? get<T>(String key) {
    var value = sp!.get(key);
    return value as T?;
  }

  String? getToken() {
    return sp!.getString("token");
  }

  void saveToken(String token) {
    put("token", token);
  }

  dynamic getUserId() {
    return sp!.getString("userId");
  }

  void saveUserId(String userId) {
    put("userId", userId);
  }

  void clear() {
    sp!.clear();
  }

  void remove(String key) {
    sp!.remove(key);
  }

  bool containsKey(String key) {
    return sp!.containsKey(key);
  }

  bool isLogin() {
    return getToken() != null;
  }
}
