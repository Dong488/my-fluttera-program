import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_account/bases/BaseState.dart';
import 'package:flutter_account/pages/login/LoginPage.dart';
import 'package:flutter_account/utils/CacheUtil.dart';
import 'package:flutter_account/utils/NavigateUtil.dart';
import 'package:flutter_account/utils/ToastUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/ColorsUtil.dart';
import '../../utils/MyFontConstant.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InfoPageState();
  }
}

class InfoPageState extends BaseState<InfoPage> {
  @override
  void localAInit() {
    // TODO: implement localAInit
  }
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
                  MyFontConstant.font_e_m_p,
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorsUtil.color_F1FFF3,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(44.r),
                                topRight: Radius.circular(44.r))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 38.w),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150.h,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  ToastUtil.toast(MyFontConstant.font_edit_profile);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/icon_mine_info.png",
                                      width: 57.w,
                                      height: 53.w,
                                    ),
                                    SizedBox(
                                      width: 13.w,
                                    ),
                                    const Text(MyFontConstant.font_edit_profile)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  ToastUtil.toast(MyFontConstant.font_security);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/icon_mine_safe.png",
                                      width: 57.w,
                                      height: 53.w,
                                    ),
                                    SizedBox(
                                      width: 13.w,
                                    ),
                                    const Text(MyFontConstant.font_security)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  ToastUtil.toast(MyFontConstant.font_setting);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/icon_mine_setting.png",
                                      width: 57.w,
                                      height: 53.w,
                                    ),
                                    SizedBox(
                                      width: 13.w,
                                    ),
                                    const Text(MyFontConstant.font_setting)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  ToastUtil.toast(MyFontConstant.font_help);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/icon_mine_help.png",
                                      width: 57.w,
                                      height: 53.w,
                                    ),
                                    SizedBox(
                                      width: 13.w,
                                    ),
                                    const Text(MyFontConstant.font_help)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  CacheUtil.logout();
                                  NavigateUtil.offAll(const LoginPage());
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/icon_mine_logout.png",
                                      width: 57.w,
                                      height: 53.w,
                                    ),
                                    SizedBox(
                                      width: 13.w,
                                    ),
                                    const Text(MyFontConstant.font_logout)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  _openImagePicker();
                                },
                                child: ClipOval(
                                  child: Image.asset(
                                    "images/icon_defalut_head.jpg",
                                    fit: BoxFit.cover,
                                    width: 117.w,
                                    height: 117.w,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                              Text(
                                "Blues",
                                style: TextStyle(
                                    fontSize: 20.sp, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  @override
  void localCClose() {
    // TODO: implement localCClose
  }
}
