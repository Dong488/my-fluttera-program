
import 'package:flutter_account/utils/ConstantUtil.dart';
import 'package:flutter_account/utils/SPManager.dart';
import 'package:flutter_account/utils/UIUtil.dart';

class CacheUtil {
  static Map<String, String> accountMap = {};
  static Map<String, String> userMap = {};
  static Map<String, String> expenseMap = {};
  static Map<String, String> incomeMap = {};

  static void initCache() {
    dynamic cacheAccountStr =
        SPManager.instance.get(ConstantUtil.AccountMap); //账户
    dynamic userInfoStr = SPManager.instance.get(ConstantUtil.UserMap); //用户信息
    dynamic expenseStr = SPManager.instance.get(ConstantUtil.ExpenseMap); //花费存储
    dynamic incomeStr = SPManager.instance.get(ConstantUtil.IncomeMap); //花费存储

    if (cacheAccountStr != null && cacheAccountStr != "") {
      accountMap = UIUtil.stringToMap(cacheAccountStr.toString());
    }
    if (userInfoStr != null && userInfoStr != "") {
      userMap = UIUtil.stringToMap(userInfoStr.toString());
    }
    if (expenseStr != null && expenseStr != "") {
      expenseMap = UIUtil.stringToMap(expenseStr.toString());
    }
    if (incomeStr != null && incomeStr != "") {
      incomeMap = UIUtil.stringToMap(incomeStr.toString());
    }
  }

  ///存储用户注册信息
  static void saveAccountMap() {
    SPManager.instance
        .put(ConstantUtil.AccountMap, UIUtil.mapToString(accountMap));
  }

  ///存储用户登录信息
  static void saveUserInfo() {
    SPManager.instance.put(ConstantUtil.UserMap, UIUtil.mapToString(userMap));
  }

  ///退出登录
  static void logout() {
    userMap.clear();
    SPManager.instance.put(ConstantUtil.UserMap, "");
  }

  ///存储花费
  static void addExpense(
      String date, String category, String amount, String title, String index) {
    int time = DateTime.now().millisecondsSinceEpoch;
    String newData = "$date%$category%$amount%$title%$index";
    expenseMap["$time"] = newData;
    SPManager.instance
        .put(ConstantUtil.ExpenseMap, UIUtil.mapToString(expenseMap));
    // if ("Income" == category) {
    //   incomeMap["$time"] = newData;
    //   SPManager.instance
    //       .put(ConstantUtil.IncomeMap, UIUtil.mapToString(incomeMap));
    // } else {
    //   expenseMap["$time"] = newData;
    //   SPManager.instance
    //       .put(ConstantUtil.ExpenseMap, UIUtil.mapToString(expenseMap));
    // }
  }

  /// @type 1花费 2收入
  static String allExpense(int type) {
    if (expenseMap.keys.isNotEmpty) {
      double allAmount = 0;
      for (var element in expenseMap.keys) {
        List<String> datas = expenseMap[element]!.split("%");
        String date = datas[0];
        String category = datas[1];
        String amount = datas[2];
        String title = datas[3];
        if (type == 1) {
          if (category != "Income") {
            double newAmount = double.parse(amount);
            allAmount += newAmount;
          }
        } else {
          if (category == "Income") {
            double newAmount = double.parse(amount);
            allAmount += newAmount;
          }
        }
      }
      return "$allAmount";
    } else {
      return "0";
    }
  }

  static String allIncome() {
    if (incomeMap.keys.isNotEmpty) {
      double allAmount = 0;
      for (var element in incomeMap.keys) {
        List<String> datas = incomeMap[element]!.split("%");
        String date = datas[0];
        String category = datas[1];
        String amount = datas[2];
        String title = datas[3];
        double newAmount = double.parse(amount);
        allAmount += newAmount;
      }
      return "$allAmount";
    } else {
      return "0";
    }
  }

  static String oneExpense(String paramCategory) {
    if (expenseMap.keys.isNotEmpty) {
      double allAmount = 0;
      for (var element in expenseMap.keys) {
        List<String> datas = expenseMap[element]!.split("%");
        String date = datas[0];
        String category = datas[1];
        String amount = datas[2];
        String title = datas[3];
        if (category == paramCategory) {
          double newAmount = double.parse(amount);
          allAmount += newAmount;
        }
      }
      return "$allAmount";
    } else {
      return "0";
    }
  }
}
