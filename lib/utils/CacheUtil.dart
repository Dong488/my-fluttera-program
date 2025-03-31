import 'dart:developer';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_account/utils/ConstantUtil.dart';
import 'package:flutter_account/utils/SPManager.dart';
import 'package:flutter_account/utils/ToastUtil.dart';
import 'package:flutter_account/utils/UIUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheUtil {
  static Map<String, String> accountMap = Map();
  static Map<String, String> userMap = Map();
  static Map<String, String> expenseMap = Map();
  static Map<String, String> incomeMap = Map();
  static String budgetAmount="";

  ///初始化缓存内容
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

  ///更改预算设定值
  static void changeBudgetAmount(String newBud){
    SPManager.instance.put(ConstantUtil.BudgetAmount,newBud);
  }
  ///获取预算设定值
  static String getBudgetAmount(){
    dynamic budgetAmount=SPManager.instance.get(ConstantUtil.BudgetAmount);
    if(budgetAmount!=null &&budgetAmount!=""){
      return "$budgetAmount";
    }else{
      return "";
    }
  }

  ///更改存款设定值
  static void changeMoneyAmount(String newBud){
    SPManager.instance.put(ConstantUtil.MoneyAmount,newBud);
  }
  ///获取存钱设定值
  static String getMoneyAmount(){
    dynamic moneyAmount=SPManager.instance.get(ConstantUtil.MoneyAmount);
    if(moneyAmount!=null &&moneyAmount!=""){
      return "$moneyAmount";
    }else{
      return "";
    }
  }

  ///存储花费
  static void addExpense(
      String date, String category, String amount, String title, String index) {
    int time = DateTime.now().millisecondsSinceEpoch;
    String newData = "$date%$category%$amount%$title%${index}";
    // expenseMap["$time"] = newData;
    // SPManager.instance
    //     .put(ConstantUtil.ExpenseMap, UIUtil.mapToString(expenseMap));
    if ("Income" == category) {
      incomeMap["$time"] = newData;
      SPManager.instance
          .put(ConstantUtil.IncomeMap, UIUtil.mapToString(incomeMap));
    } else {
      expenseMap["$time"] = newData;
      SPManager.instance
          .put(ConstantUtil.ExpenseMap, UIUtil.mapToString(expenseMap));
    }
  }

  ///总支出
  static String allExpense() {
    if (expenseMap.keys.isNotEmpty) {
      double allAmount = 0;
      expenseMap.keys.forEach((element) {
        List<String> datas = expenseMap[element]!.split("%");
        String date = datas[0];
        String category = datas[1];
        String amount = datas[2];
        String title = datas[3];
        double newAmount = double.parse(amount);
        allAmount += newAmount;
        // if (type == 1) {
        //   if (category != "Income") {
        //     double newAmount = double.parse(amount);
        //     allAmount += newAmount;
        //   }
        // } else {
        //   if (category == "Income") {
        //     double newAmount = double.parse(amount);
        //     allAmount += newAmount;
        //   }
        // }
      });
      return "$allAmount";
    } else {
      return "0";
    }
  }
  ///总收入
  static String allIncome() {
    if (incomeMap.keys.isNotEmpty) {
      double allAmount = 0;
      incomeMap.keys.forEach((element) {
        List<String> datas = incomeMap[element]!.split("%");
        String date = datas[0];
        String category = datas[1];
        String amount = datas[2];
        String title = datas[3];
        double newAmount = double.parse(amount);
        allAmount += newAmount;
      });
      return "$allAmount";
    } else {
      return "0";
    }
  }
  ///某项目总钱数
  static String oneExpense(String paramCategory) {
    if("Income"==paramCategory){
      if (incomeMap.keys.isNotEmpty) {
        double allAmount = 0;
        incomeMap.keys.forEach((element) {
          List<String> datas = incomeMap[element]!.split("%");
          String date = datas[0];
          String category = datas[1];
          String amount = datas[2];
          String title = datas[3];
          double newAmount = double.parse(amount);
          allAmount += newAmount;
        });
        return "$allAmount";
      } else {
        return "0";
      }
    }else{
      if (expenseMap.keys.isNotEmpty) {
        double allAmount = 0;
        expenseMap.keys.forEach((element) {
          List<String> datas = expenseMap[element]!.split("%");
          String date = datas[0];
          String category = datas[1];
          String amount = datas[2];
          String title = datas[3];
          if (category == paramCategory) {
            double newAmount = double.parse(amount);
            allAmount += newAmount;
          }
        });
        return "$allAmount";
      } else {
        return "0";
      }
    }

  }

  ///获取预算百分比
  static double getBudgetPer(){
    String allExStr=allExpense();
    if(allExStr!=""){
      String baStr=getBudgetAmount();
      if(baStr!=""){
        double expenseDouble=double.parse(allExStr);
        double baDouble=double.parse(baStr);
        double per=expenseDouble/baDouble*100;
        String formattedNumber = per.toStringAsFixed(1);
        return double.parse(formattedNumber);
      }
    }
    return 0;
  }
  ///获取存钱百分比
  static double getSavingMoneyPer(){
    String allIncomeStr=allIncome();
    String allExStr=allExpense();
    double localMoney=0;//当前钱数
    if(allIncomeStr!=""){
      //收入
      double incomeDouble=double.parse(allIncomeStr);
      if(allExStr!=""){
        //支出
        double expenseDouble=double.parse(allExStr);
        localMoney=incomeDouble-expenseDouble;
        if(localMoney<0){
          localMoney=0;
        }
      }else{
        localMoney=incomeDouble;
      }
    }
    if(localMoney>=0){
      String baStr=getMoneyAmount();
      if(baStr!=""){
        double baDouble=double.parse(baStr);
        double per=localMoney/baDouble;
        String formattedNumber = per.toStringAsFixed(1);
        return double.parse(formattedNumber);
      }
    }
    return 0;
  }

  /// 获取某一天的总收入/支出
  /// @dateFormat yyyy-MM-dd
  /// @type 1收入 2支出
  static double getDateMoney(String dateFormat, int type) {
    double totalAmount = 0;
    // 根据 type 选择对应的 Map
    Map<String, String> targetMap = type == 1 ? incomeMap : expenseMap;

    // 遍历目标 Map
    for (String key in targetMap.keys) {
      String value = targetMap[key]!;
      // 分割存储的数据
      List<String> parts = value.split("%");
      String date = parts[0];
      String amountStr = parts[2];

      // 检查日期是否匹配
      if (date == dateFormat) {
        try {
          // 解析金额并累加到总数中
          double amount = double.parse(amountStr);
          totalAmount += amount;
        } catch (e) {
          // 处理解析错误
          log('Error parsing amount: $e');
        }
      }
    }

    return totalAmount;
  }

  /// 获取近7天的总收入/支出
  /// @type 1收入 2支出
  static double getLastSevenMoneyCount(int type) {
    double totalAmount = 0;
    // 获取近7天的日期
    List<String> lastSevenDates = UIUtil.getLastSevenDate();
    // 遍历近7天的日期
    for (String date in lastSevenDates) {
      // 调用 getDateMoney 函数获取每一天的收入或支出
      double dailyAmount = getDateMoney(date, type);
      // 累加每一天的收入或支出
      totalAmount += dailyAmount;
    }
    return totalAmount;
  }
}
