import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
     return SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset("assets/images/login_image.png"),

                      SizedBox(
                        height: Get.height * 0.3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "Verify Phone Number".tr,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Instrument Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                "We just send a verification code to "
                                    .tr,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 36),
                              child: PinCodeTextField(
                                length: 6,
                                appContext: context,
                                keyboardType: TextInputType.phone,
                                pinTheme: PinTheme(
                                  fieldHeight: 50,
                                  fieldWidth: 50,
                                  activeColor: AppColors.textFieldBorder,
                                  selectedColor:AppColors.textFieldBorder,
                                  inactiveColor:  AppColors.textFieldBorder,
                                  activeFillColor:  AppColors.textField,
                                  inactiveFillColor: AppColors.textField,
                                  selectedFillColor:  AppColors.textField,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enableActiveFill: true,
                                cursorColor: AppColors.primary,
                                controller: TextEditingController(),
                                onCompleted: (v) async {},
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: ButtonThem.buildButton(
                    context,
                    title: "Verify".tr,
                    onPress: () async {
                    
                    },
                  ),
                )),
          );
        
  }
}
