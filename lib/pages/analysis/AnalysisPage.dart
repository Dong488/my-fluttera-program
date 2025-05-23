import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_account/bases/BaseState.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mrx_charts/mrx_charts.dart';

import '../../utils/CacheUtil.dart';
import '../../utils/ColorsUtil.dart';
import '../../utils/MyFontConstant.dart';
import '../../utils/NavigateUtil.dart';
import '../../utils/UIUtil.dart';
import '../transaction/AddExpensesPage.dart';

class AnalysisPage extends StatefulWidget {
  String allAmount = CacheUtil.allExpense();
  String allIncome = CacheUtil.allIncome();
  List<String> dataList=UIUtil.getLastSevenDate();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnalysisPageState();
  }
  void refresh() {
     allAmount = CacheUtil.allExpense();
     allIncome = CacheUtil.allIncome();
  }
}

class AnalysisPageState extends BaseState<AnalysisPage> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 64.h,
          ),
          Center(
            child: Text(
              MyFontConstant.font_analysis,
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
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorsUtil.color_F1FFF3,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(44.r),
                    topRight: Radius.circular(44.r))),
            child: Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  width: 357.w,
                  height: 287.h,
                  padding: EdgeInsets.all(21.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(31.r)),
                      color: ColorsUtil.color_DFF7E2),
                  child: Column(
                    children: [
                      Text(MyFontConstant.font_in_ex,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.h,),
                      Expanded(child: Chart(
                        layers: layers(),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12.0).copyWith(
                          bottom: 12.0,
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "images/icon_income.png",
                          width: 25.w,
                          height: 25.w,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(MyFontConstant.font_income,
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.black)),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text("\$${CacheUtil.getLastSevenMoneyCount(1)}",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsUtil.primaryColor))
                      ],
                    ),
                    SizedBox(width: 94.w,),
                    Column(
                      children: [
                        Image.asset(
                          "images/icon_expenses.png",
                          width: 25.w,
                          height: 25.w,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(MyFontConstant.font_expense,
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.black)),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text("\$${CacheUtil.getLastSevenMoneyCount(2)}",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsUtil.color_0068FF))
                      ],
                    )

                  ],
                )
              ],
            ),
          ))
        ],
      ),
    ));
  }

  List<ChartLayer> layers() {
    List<int> timeList = [];
    CacheUtil.expenseMap.keys.forEach((element) {
      timeList.add(int.parse(element));
    });
    timeList.sort((a, b) => a.compareTo(b));

    return [
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: 1.0,
            max: 6.0,
            min: 0,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency: 1000.0,
            max: 5000.0,
            min: 0.0,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 10.0,
            ),
          ),
        ),
        labelX: (value) {

          return UIUtil.getOnlyDay(widget.dataList[value.toInt()]);
        } ,
        labelY: (value) => value.toInt().toString(),
      ),
      ChartGroupBarLayer(
        items: List.generate(
          7,
          (index) => [
            ChartGroupBarDataItem(
              color: const Color(0xFF00D09E),
              x: index +0,
              value: CacheUtil.getDateMoney(widget.dataList[index], 1),
            ),
            ChartGroupBarDataItem(
              color: const Color(0xFF0068FF),
              x: index +0,
              value: CacheUtil.getDateMoney(widget.dataList[index], 2),
            ),
          ],
        ),
        settings: const ChartGroupBarSettings(
          thickness: 8.0,
          radius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      ChartTooltipLayer(
        shape: () => ChartTooltipBarShape<ChartGroupBarDataItem>(
          backgroundColor: Colors.white,
          currentPos: (item) => item.currentValuePos,
          currentSize: (item) => item.currentValueSize,
          onTextValue: (item) => '€${item.value.toString()}',
          marginBottom: 6.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          radius: 6.0,
          textStyle: const TextStyle(
            color: Color(0xFF8043F9),
            letterSpacing: 0.2,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];
  }

  @override
  void localCClose() {
    // TODO: implement localCClose
  }
}
