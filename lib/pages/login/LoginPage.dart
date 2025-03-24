import 'package:flutter/material.dart';
import 'package:flutter_account/bases/BaseState.dart';
import 'package:flutter_account/pages/home/MainPage.dart';
import 'package:flutter_account/pages/login/ForgetPswPage.dart';
import 'package:flutter_account/utils/CacheUtil.dart';
import 'package:flutter_account/utils/ToastUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_account/utils/SPManager.dart';
import '../../network/ApiService.dart';
import '../../utils/ColorsUtil.dart';
import '../../utils/MyFontConstant.dart';
import '../../utils/NavigateUtil.dart';
import '../../views/CustomButton.dart';
import 'RegistPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends BaseState<LoginPage> {
  @override
  void localAInit() {
    // TODO: implement localAInit
  }

  @override
  Widget localBuild(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pswController = TextEditingController();

    return Scaffold(
      body: Container(
        color: ColorsUtil.primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 78.h,
            ),
            Text(
              MyFontConstant.font_welcome,
              style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 65.h,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorsUtil.color_F1FFF3,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(44.r),
                      topRight: Radius.circular(44.r))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(left: 60.w, top: 95.h, bottom: 14.h),
                      child: const Text(
                        MyFontConstant.font_u_e,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtil.publicFontColor),
                      ),
                    ),
                    SizedBox(
                      height: 41.h,
                      width: 356.w,
                      child: TextField(
                        controller: emailController,
                        onChanged: (value) {
                          bool state = value.isNotEmpty;
                        },
                        style: TextStyle(
                            color: ColorsUtil.publicFontColor, fontSize: 16.sp),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 16.w, top: 0, bottom: 0),
                            filled: true,
                            fillColor: ColorsUtil.color_DFF7E2,
                            hintText: "example@example.com",
                            hintStyle: TextStyle(
                                color: ColorsUtil.hintColor, fontSize: 16.sp),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.r)),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.r)),
                                borderSide: const BorderSide(
                                    color: Colors.transparent))),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(left: 60.w, top: 30.h, bottom: 14.h),
                      child: const Text(
                        MyFontConstant.font_psw,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtil.publicFontColor),
                      ),
                    ),
                    SizedBox(
                      height: 41.h,
                      width: 356.w,
                      child: TextField(
                        obscureText: true,
                        controller: pswController,
                        onChanged: (value) {
                          bool state = value.isNotEmpty;
                        },
                        style: TextStyle(
                            color: ColorsUtil.publicFontColor, fontSize: 16.sp),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 16.w, top: 0, bottom: 0),
                            filled: true,
                            fillColor: ColorsUtil.color_DFF7E2,
                            hintText: "password",
                            hintStyle: TextStyle(
                                color: ColorsUtil.hintColor, fontSize: 16.sp),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.r)),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.r)),
                                borderSide: const BorderSide(
                                    color: Colors.transparent))),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    CustomButton(
                        buttonWidth: 207.w,
                        buttonHeight: 45.h,
                        buttonRadius: 30.r,
                        buttonFont: MyFontConstant.font_log_in,
                        buttonBackgroundColor: ColorsUtil.primaryColor,
                        buttonFontColor: ColorsUtil.publicFontColor,
                        onTab: () async {
                          String emailStr = emailController.text;
                          String pswStr = pswController.text;

                          if (emailStr.isEmpty || pswStr.isEmpty) {
                            ToastUtil.toast("plase entry email and password.");
                            return;
                          }

                          try {
                            var result =
                                await ApiService.login(emailStr, pswStr);
                            String token = result["token"];
                            String accountName = result["accountName"];
                            String userId = result["userId"];

                            SPManager.instance.saveToken(token);
                            SPManager.instance.saveUserId(userId);
                            CacheUtil.userMap["accountName"] = accountName;
                            CacheUtil.saveUserInfo();

                            ToastUtil.toast("login successfully.");
                            NavigateUtil.offAll(const MainPage());
                          } catch (e) {
                            ToastUtil.toast(e.toString());
                          }
                        }),
                    SizedBox(
                      height: 12.h,
                    ),
                    GestureDetector(
                        onTap: () => {NavigateUtil.to(const ForgetPswPage())},
                        child: const Text(
                          MyFontConstant.font_forPws,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomButton(
                      buttonWidth: 207.w,
                      buttonHeight: 45.h,
                      buttonRadius: 30.r,
                      buttonFont: MyFontConstant.font_sign_up,
                      buttonBackgroundColor: ColorsUtil.color_DFF7E2,
                      buttonFontColor: Colors.black,
                      onTab: () => {NavigateUtil.to(const RegistPage())},
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  void localCClose() {
    // TODO: implement localCClose
  }
}
