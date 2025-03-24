import 'package:flutter/material.dart';
import 'package:flutter_account/bases/BaseState.dart';
import 'package:flutter_account/pages/mine/PrivacyPage.dart';
import 'package:flutter_account/utils/MyFontConstant.dart';
import 'package:flutter_account/utils/NavigateUtil.dart';
import 'package:flutter_account/utils/UIUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/ColorsUtil.dart';

class SecurityPage extends StatefulWidget {
  int index = 0;
  int type; //1消费 2收入

  SecurityPage({super.key, this.index = 0, this.type = 1});

  @override
  State<StatefulWidget> createState() {
    return SecurityPageState();
  }
}

class SecurityPageState extends BaseState<SecurityPage> {
  final List<DateTime?> _singleDatePickerValueWithDefaultValue = [];
  String choiceTime = UIUtil.getLocalTime();
  String choiceType = "";
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void localAInit() {
    choiceType = UIUtil.nameList[widget.index];
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  NavigateUtil.back();
                },
                child: Image.asset(
                  "images/icon_back_white.png",
                  width: 24.w,
                  height: 19.h,
                ),
              ),
              Text(
                MyFontConstant.font_security,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "  ",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 130.h,
          ),
          Expanded(
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 50.w, right: 50.w),
                  decoration: BoxDecoration(
                      color: ColorsUtil.color_F1FFF3,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(44.r),
                          topRight: Radius.circular(44.r))),
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          NavigateUtil.to(PrivacyPage());
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: 160.h,
                            ),
                            Text(
                              MyFontConstant.font_pri_ager,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                            const Expanded(child: SizedBox()),
                            Image.asset(
                              "images/icon_point_right.png",
                              width: 10.w,
                              height: 21.h,
                            )
                          ],
                        ),
                      )
                    ],
                  )))
        ],
      ),
    ));
  }

  @override
  void localCClose() {}
}
