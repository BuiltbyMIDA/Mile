import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/ui/terms_and_condition/terms_and_condition_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
     return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/app_logo.png",
                        width: Responsive.width(100, context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/login_car_1.png",
                          width: Get.width / 2.2,
                        ),
                        Image.asset(
                          "assets/images/login_car_2.png",
                          width: Get.width / 2.2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("Login".tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 24)),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'A journey of a thousand MILE, begins with one click.'
                                    .tr,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.14,
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              validator: (value) =>
                                  value != null && value.isNotEmpty
                                      ? null
                                      : 'Required',
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.sentences,
                              controller:
                                 TextEditingController(),
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(color: Colors.black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: AppColors.textField,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  prefixIcon: CountryCodePicker(
                                    enabled: false,
                                    onChanged: (value) {
                                      
                                    },
                                    dialogBackgroundColor: AppColors.background,
                                    // initialSelection:
                                    //     'NGN',
                                    comparator: (a, b) =>
                                        b.name!.compareTo(a.name.toString()),
                                    flagDecoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2)),
                                    ),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: AppColors.darkTextFieldBorder,
                                        width: 1),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.darkTextFieldBorder,
                                        width: 1),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.darkTextFieldBorder,
                                        width: 1),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.darkTextFieldBorder,
                                        width: 1),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.darkTextFieldBorder,
                                        width: 1),
                                  ),
                                  hintText: "Phone number".tr)),
                          const SizedBox(
                            height: 24,
                          ),
                          ButtonThem.buildButton(
                            context,
                            title: "Next".tr,
                            txtSize: 14,
                            onPress: () {
                             
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 32),
                            child: Row(
                              children: [
                                const Expanded(
                                    child: Divider(
                                  height: 1,
                                )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    "OR".tr,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Expanded(
                                    child: Divider(
                                  height: 1,
                                )),
                              ],
                            ),
                          ),
                          ButtonThem.buildBorderButton(
                            context,
                            title: "Login with google".tr,
                            txtSize: 16,
                            iconVisibility: true,
                            iconAssetImage: 'assets/icons/ic_google.png',
                            borderRadius: 100,
                            onPress: () async {
                             
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Visibility(
                              visible: Platform.isIOS,
                              child: ButtonThem.buildBorderButton(
                                context,
                                title: "Login with apple".tr,
                                iconVisibility: true,
                                txtSize: 16,
                                iconAssetImage: 'assets/icons/applelogo.png',
                                onPress: () async {
                                
                                },
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'By tapping "Next" you agree to '.tr,
                      style: GoogleFonts.poppins(),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(const TermsAndConditionScreen(
                                  type: "terms",
                                ));
                              },
                            text: 'Terms and conditions'.tr,
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.underline)),
                        TextSpan(text: ' and ', style: GoogleFonts.poppins()),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(const TermsAndConditionScreen(
                                  type: "privacy",
                                ));
                              },
                            text: 'privacy policy'.tr,
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.underline)),
                        // can add more TextSpans here...
                      ],
                    ),
                  )),
            ),
          );
        
  }
}
