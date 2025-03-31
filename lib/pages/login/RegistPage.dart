import 'package:flutter/material.dart';
import 'package:flutter_account/bases/BaseState.dart';
import 'package:flutter_account/network/ApiService.dart';
import 'package:flutter_account/utils/ToastUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/ColorsUtil.dart';
import '../../utils/MyFontConstant.dart';
import '../../utils/NavigateUtil.dart';
import '../../views/CustomButton.dart';

class RegistPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistPageState();
  }
}

class RegistPageState extends BaseState<RegistPage> {
  @override
  void localAInit() {}

  @override
  Widget localBuild(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pswController = TextEditingController();
    TextEditingController confirmPswController = TextEditingController();

    return Scaffold(
      body: Container(
        color: ColorsUtil.primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 78.h),
            Text(
              MyFontConstant.font_create_acc,
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
                      _buildTextField(confirmPswController, MyFontConstant.font_con_psw, MyFontConstant.font_con_psw, isPassword: true),
                      SizedBox(height: 90.h),
                      CustomButton(
                        buttonWidth: 207.w,
                        buttonHeight: 45.h,
                        buttonRadius: 30.r,
                        buttonFont: MyFontConstant.font_sign_up,
                        buttonBackgroundColor: ColorsUtil.primaryColor,
                        buttonFontColor: ColorsUtil.publicFontColor,
                        onTab: () async {
                          if (pswController.text != confirmPswController.text) {
                            ToastUtil.toast(MyFontConstant.font_two_passwords);
                            return;
                          }
                          if (await ApiService.register(emailController.text, pswController.text)) {
                            NavigateUtil.back();
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(MyFontConstant.font_alr_have_acc, style: TextStyle(fontSize: 13.sp, color: ColorsUtil.publicFontColor)),
                          GestureDetector(
                            onTap: () => NavigateUtil.back(),
                            child: Text(MyFontConstant.font_log_in, style: TextStyle(fontSize: 13.sp, color: ColorsUtil.color_3299FF)),
                          ),
                        ],
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
