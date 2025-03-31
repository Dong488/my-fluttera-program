import 'package:flutter/material.dart';
import 'package:flutter_account/bases/BaseState.dart';
import 'package:flutter_account/pages/home/MainPage.dart';
import 'package:flutter_account/pages/login/ForgetPswPage.dart';
import 'package:flutter_account/network/ApiService.dart';
import 'package:flutter_account/utils/ToastUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/ColorsUtil.dart';
import '../../utils/MyFontConstant.dart';
import '../../utils/NavigateUtil.dart';
import '../../views/CustomButton.dart';
import 'RegistPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends BaseState<LoginPage> {
  @override
  void localAInit() {}

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
            SizedBox(height: 78.h),
            Text(
              MyFontConstant.font_welcome,
              style: TextStyle(fontSize: 30.sp, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 65.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsUtil.color_F1FFF3,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(44.r),
                    topRight: Radius.circular(44.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTextField(emailController, MyFontConstant.font_u_e, "example@example.com"),
                      _buildTextField(pswController, MyFontConstant.font_psw, "password", isPassword: true),
                      SizedBox(height: 90.h),
                      CustomButton(
                        buttonWidth: 207.w,
                        buttonHeight: 45.h,
                        buttonRadius: 30.r,
                        buttonFont: MyFontConstant.font_log_in,
                        buttonBackgroundColor: ColorsUtil.primaryColor,
                        buttonFontColor: ColorsUtil.publicFontColor,
                        onTab: () async {
                          if (await ApiService.login(emailController.text, pswController.text)) {
                            NavigateUtil.offAll(MainPage());
                          }
                        },
                      ),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        onTap: () => NavigateUtil.to(ForgetPswPage()),
                        child: Text(
                          MyFontConstant.font_forPws,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomButton(
                        buttonWidth: 207.w,
                        buttonHeight: 45.h,
                        buttonRadius: 30.r,
                        buttonFont: MyFontConstant.font_sign_up,
                        buttonBackgroundColor: ColorsUtil.color_DFF7E2,
                        buttonFontColor: Colors.black,
                        onTab: () => NavigateUtil.to(RegistPage()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 60.w, top: 30.h, bottom: 14.h),
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: ColorsUtil.publicFontColor)),
        ),
        SizedBox(
          height: 41.h,
          width: 356.w,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            style: TextStyle(color: ColorsUtil.publicFontColor, fontSize: 16.sp),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 16.w, top: 0, bottom: 0),
              filled: true,
              fillColor: ColorsUtil.color_DFF7E2,
              hintText: hint,
              hintStyle: TextStyle(color: ColorsUtil.hintColor, fontSize: 16.sp),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.r)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.r)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void localCClose() {}
}
