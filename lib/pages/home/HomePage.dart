import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_account/bases/BaseState.dart';
import 'package:flutter_account/utils/CacheUtil.dart';
import 'package:flutter_account/utils/MyFontConstant.dart';
import 'package:flutter_account/utils/ToastUtil.dart';
import 'package:flutter_account/utils/UIUtil.dart';
import 'package:flutter_account/views/CustomButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/MainController.dart';
import '../../utils/ColorsUtil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../views/BudgetProgressBar.dart';

class HomePage extends StatefulWidget {
  String allAmount = CacheUtil.allExpense();
  String allIncome = CacheUtil.allIncome();
  Map<String, String> newMap = Map();
  String budgetAmount = CacheUtil.getBudgetAmount(); //预算值
  String savingMoneyAmount = CacheUtil.getMoneyAmount(); //存钱值

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

  void refresh() {
    allAmount = CacheUtil.allExpense();
    allIncome = CacheUtil.allIncome();
  }
}

class HomePageState extends BaseState<HomePage> {
  @override
  void localAInit() {
    // TODO: implement localAInit
  }

  @override
  Widget localBuild(BuildContext context) {
    return Scaffold(
        body: Container(
      color: ColorsUtil.primaryColor,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 38.w, top: 60.h),
            child: Text(
              MyFontConstant.font_hi,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 42.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      MyFontConstant.font_t_i,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "\$${widget.allIncome}",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  width: 36.w,
                ),
                Container(
                  color: Colors.white,
                  width: 1.w,
                  height: 42.h,
                ),
                SizedBox(
                  width: 36.w,
                ),
                Column(
                  children: [
                    Text(
                      MyFontConstant.font_t_e,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "-\$${widget.allAmount}",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsUtil.color_0068FF),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              _showBudgetDialog(context);
            },
            child: BudgetProgressBar(
              height: 27.h,
              width: 330.w,
              progress: CacheUtil.getBudgetPer(),
              budgetAmount: widget.budgetAmount,
              progressColor: Color(0xFF052224),
              backgroundColor: Color(0xFFF1FFF3),
              showTextInside: true,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorsUtil.color_F1FFF3,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(44.r),
                    topRight: Radius.circular(44.r))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 357.w,
                  height: 152.h,
                  margin: EdgeInsets.only(top: 33.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: ColorsUtil.color_00D09E),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showGetMoneyDialog(context);
                            },
                            child: Container(
                              width: 68.w,
                              height: 68.w,
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // 环形进度条
                                    SizedBox(
                                      width: 68.w,
                                      height: 68.w,
                                      child: CircularProgressIndicator(
                                        // 这里假设从 CacheUtil 获取存钱进度，你可以根据实际情况修改
                                        value: CacheUtil.getSavingMoneyPer(),
                                        strokeWidth: 3.0,
                                        backgroundColor: Colors.white,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                ColorsUtil.color_0068FF),
                                      ),
                                    ),
                                    // 中间的图片
                                    Image.asset(
                                      'images/icon_salary.png',
                                      width: 65.w,
                                      height: 42.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            MyFontConstant.font_s_o_g,
                            style: TextStyle(fontSize: 12.sp),
                          )
                        ],
                      ),
                      Container(
                        width: 2.w,
                        height: 108.h,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 33.w, right: 20.w),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "images/icon_salary.png",
                                width: 31.w,
                                height: 28.h,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyFontConstant.font_r_l_w,
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  Text(
                                    "\$${CacheUtil.oneExpense("Income")}",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            height: 2.h,
                            width: 161.w,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "images/icon_food.png",
                                width: 31.w,
                                height: 34.h,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyFontConstant.font_f_l_w,
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  Text(
                                    "-\$${CacheUtil.oneExpense("Food")}",
                                    style: TextStyle(
                                        color: ColorsUtil.color_0068FF,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Expanded(
                    child: Container(
                  child: _getExpenseList(),
                )),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ))
        ],
      ),
    ));
  }

  /// 列表展示
  Widget _getExpenseList() {
    List<int> timeList = [];
    widget.newMap.clear();
    widget.newMap.addAll(CacheUtil.expenseMap);
    widget.newMap.addAll(CacheUtil.incomeMap);

    widget.newMap.keys.forEach((element) {
      timeList.add(int.parse(element));
    });
    timeList.sort((a, b) => b.compareTo(a));

    return ListView.builder(
        itemCount: timeList.length,
        itemBuilder: (context, index) {
          return Slidable(
            // 配置左滑操作
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    String localCate =
                        _getValue("${timeList[index]}", "category");
                    if ("Income" == localCate) {
                      //收入
                      CacheUtil.incomeMap.remove("${timeList[index]}");
                    } else {
                      CacheUtil.expenseMap.remove("${timeList[index]}");
                    }
                    widget.refresh();
                    setState(() {});

                    // 删除对应的数据
                    // widget.newMap.remove(timeList[index].toString());
                    // // 移除列表中的数据
                    // timeList.removeAt(index);
                    // // 更新界面
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: MyFontConstant.splash_delete,
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.only(top: 24.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 37.w,
                  ),
                  Image.asset(
                    UIUtil.imgList[
                        int.parse(_getValue("${timeList[index]}", "index"))],
                    width: 53.w,
                    height: 53.w,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Column(
                    children: [
                      Text(
                        UIUtil.nameList[int.parse(
                            _getValue("${timeList[index]}", "index"))],
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        _getValue("${timeList[index]}", "date"),
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsUtil.color_0068FF),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                      child: Text(
                    _getValue("${timeList[index]}", "title"),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(
                    "Income" == _getValue("${timeList[index]}", "category")
                        ? "\$${_getValue("${timeList[index]}", "amount")}"
                        : "-\$${_getValue("${timeList[index]}", "amount")}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: "Income" ==
                                _getValue("${timeList[index]}", "category")
                            ? Colors.black
                            : ColorsUtil.color_0068FF),
                  ),
                  SizedBox(
                    width: 37.w,
                  ),
                ],
              ),
            ),
          );
        });
  }

  String _getValue(String key, String detail) {
    String? oldJson = widget.newMap[key];
    LogUtil.v("oldJson：$oldJson");

    List<String> ss = oldJson!.split("%");
    // "$date%$category%$amount%$title%index";
    if (detail == "date") {
      return ss[0];
    } else if (detail == "category") {
      return ss[1];
    } else if (detail == "amount") {
      return ss[2];
    } else if (detail == "title") {
      return ss[3];
    } else if (detail == "index") {
      return ss[4];
    } else {
      return "0";
    }
  }

  ///预算设置弹窗
  void _showBudgetDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = widget.budgetAmount;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(MyFontConstant.font_s_b_a),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: MyFontConstant.font_p_s_b_a,
            ),
          ),
          actions: [
            CustomButton(
                buttonWidth: 90.w,
                buttonHeight: 30.h,
                buttonFont: MyFontConstant.font_cancel,
                buttonBackgroundColor: ColorsUtil.color_F1FFF3,
                buttonRadius: 10.r,
                buttonFontColor: Colors.black,
                buttonFontSize: 15.sp,
                onTab: () {
                  Navigator.of(context).pop();
                }),
            CustomButton(
                buttonWidth: 90.w,
                buttonHeight: 30.h,
                buttonFont: MyFontConstant.font_sure,
                buttonBackgroundColor: ColorsUtil.color_00D09E,
                buttonRadius: 10.r,
                buttonFontColor: Colors.black,
                buttonFontSize: 15.sp,
                onTab: () {
                  if (_controller.text.isEmpty) {
                    ToastUtil.toast(MyFontConstant.font_p_s_b_a);
                    return;
                  }
                  setState(() {
                    widget.budgetAmount = _controller.text;
                    CacheUtil.changeBudgetAmount(_controller.text);
                  });
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  ///存钱设置弹窗
  void _showGetMoneyDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = widget.savingMoneyAmount;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(MyFontConstant.font_s_s_a),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: MyFontConstant.font_p_s_s_a,
            ),
          ),
          actions: [
            CustomButton(
                buttonWidth: 90.w,
                buttonHeight: 30.h,
                buttonFont: MyFontConstant.font_cancel,
                buttonBackgroundColor: ColorsUtil.color_F1FFF3,
                buttonRadius: 10.r,
                buttonFontColor: Colors.black,
                buttonFontSize: 15.sp,
                onTab: () {
                  Navigator.of(context).pop();
                }),
            CustomButton(
                buttonWidth: 90.w,
                buttonHeight: 30.h,
                buttonFont: MyFontConstant.font_sure,
                buttonBackgroundColor: ColorsUtil.color_00D09E,
                buttonRadius: 10.r,
                buttonFontColor: Colors.black,
                buttonFontSize: 15.sp,
                onTab: () {
                  if (_controller.text.isEmpty) {
                    ToastUtil.toast(MyFontConstant.font_p_s_s_a);
                    return;
                  }
                  setState(() {
                    widget.savingMoneyAmount = _controller.text;
                    CacheUtil.changeMoneyAmount(_controller.text);
                  });
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  @override
  void localCClose() {
    // TODO: implement localCClose
  }
}
