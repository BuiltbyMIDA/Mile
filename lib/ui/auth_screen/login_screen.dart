import 'dart:developer';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controller/login_controller.dart';
import 'package:customer/model/user_model.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/ui/auth_screen/information_screen.dart';
import 'package:customer/ui/dashboard_screen.dart';
import 'package:customer/ui/terms_and_condition/terms_and_condition_screen.dart';
import 'package:customer/utils/DarkThemeProvider.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX<LoginController>(
        init: LoginController(),
        builder: (controller) {
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
                                  controller.phoneNumberController.value,
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
                                      controller.countryCode.value =
                                          value.dialCode.toString();
                                    },
                                    dialogBackgroundColor: AppColors.background,
                                    initialSelection:
                                        controller.countryCode.value,
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
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.darkTextFieldBorder,
                                        width: 1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
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
                              controller.sendCode();
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
                              ShowToastDialog.showLoader("Please wait".tr);
                              await controller.signInWithGoogle().then((value) {
                                ShowToastDialog.closeLoader();
                                if (value != null) {
                                  if (value.additionalUserInfo!.isNewUser) {
                                    print("----->new user");
                                    UserModel userModel = UserModel();
                                    userModel.id = value.user!.uid;
                                    userModel.email = value.user!.email;
                                    userModel.fullName =
                                        value.user!.displayName;
                                    userModel.profilePic = value.user!.photoURL;
                                    userModel.loginType =
                                        Constant.googleLoginType;

                                    ShowToastDialog.closeLoader();
                                    Get.to(const InformationScreen(),
                                        arguments: {
                                          "userModel": userModel,
                                        });
                                  } else {
                                    print("----->old user");
                                    FireStoreUtils.userExitOrNot(
                                            value.user!.uid)
                                        .then((userExit) async {
                                      ShowToastDialog.closeLoader();
                                      if (userExit == true) {
                                        UserModel? userModel =
                                            await FireStoreUtils.getUserProfile(
                                                value.user!.uid);
                                        if (userModel != null) {
                                          if (userModel.isActive == true) {
                                            Get.offAll(const DashBoardScreen());
                                          } else {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            ShowToastDialog.showToast(
                                                "This user is disable please contact administrator"
                                                    .tr);
                                          }
                                        }
                                      } else {
                                        UserModel userModel = UserModel();
                                        userModel.id = value.user!.uid;
                                        userModel.email = value.user!.email;
                                        userModel.fullName =
                                            value.user!.displayName;
                                        userModel.profilePic =
                                            value.user!.photoURL;
                                        userModel.loginType =
                                            Constant.googleLoginType;

                                        Get.to(const InformationScreen(),
                                            arguments: {
                                              "userModel": userModel,
                                            });
                                      }
                                    });
                                  }
                                }
                              });
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
                                  ShowToastDialog.showLoader("Please wait".tr);
                                  await controller
                                      .signInWithApple()
                                      .then((value) {
                                    ShowToastDialog.closeLoader();
                                    if (value != null) {
                                      if (value.additionalUserInfo!.isNewUser) {
                                        log("----->new user");
                                        UserModel userModel = UserModel();
                                        userModel.id = value.user!.uid;
                                        userModel.email = value.user!.email;
                                        userModel.profilePic =
                                            value.user!.photoURL;
                                        userModel.loginType =
                                            Constant.appleLoginType;

                                        ShowToastDialog.closeLoader();
                                        Get.to(const InformationScreen(),
                                            arguments: {
                                              "userModel": userModel,
                                            });
                                      } else {
                                        print("----->old user");
                                        FireStoreUtils.userExitOrNot(
                                                value.user!.uid)
                                            .then((userExit) async {
                                          ShowToastDialog.closeLoader();

                                          if (userExit == true) {
                                            UserModel? userModel =
                                                await FireStoreUtils
                                                    .getUserProfile(
                                                        value.user!.uid);
                                            if (userModel != null) {
                                              if (userModel.isActive == true) {
                                                Get.offAll(
                                                    const DashBoardScreen());
                                              } else {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                ShowToastDialog.showToast(
                                                    "This user is disable please contact administrator"
                                                        .tr);
                                              }
                                            }
                                          } else {
                                            UserModel userModel = UserModel();
                                            userModel.id = value.user!.uid;
                                            userModel.email = value.user!.email;
                                            userModel.profilePic =
                                                value.user!.photoURL;
                                            userModel.loginType =
                                                Constant.googleLoginType;

                                            Get.to(const InformationScreen(),
                                                arguments: {
                                                  "userModel": userModel,
                                                });
                                          }
                                        });
                                      }
                                    }
                                  });
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
        });
  }
}
