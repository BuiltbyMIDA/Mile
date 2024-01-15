import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controller/information_controller.dart';
import 'package:customer/model/referral_model.dart';
import 'package:customer/model/user_model.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/themes/text_field_them.dart';
import 'package:customer/ui/dashboard_screen.dart';
import 'package:customer/utils/DarkThemeProvider.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetX<InformationController>(
        init: InformationController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset("assets/images/login_image.png", width: Responsive.width(100, context)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 53),
                            child: Text(
                              "Sign up".tr,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Instrument Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
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
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Full name'.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Instrument Sans',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.20,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFieldThem.buildTextFiled(context,
                              hintText: 'Enter full name'.tr,
                              controller: controller.fullNameController.value),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Email '.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Instrument Sans',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.20,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFieldThem.buildTextFiled(context,
                              hintText: 'Enter email address'.tr,
                              controller: controller.emailController.value,
                              enable: controller.loginType.value ==
                                      Constant.googleLoginType
                                  ? false
                                  : true),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Phone number'.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Instrument Sans',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.20,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
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
                              enabled: controller.loginType.value ==
                                      Constant.phoneLoginType
                                  ? false
                                  : true,
                              decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor:AppColors.textField,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  prefixIcon: CountryCodePicker(
                                    onChanged: (value) {
                                      controller.countryCode.value =
                                          value.dialCode.toString();
                                    },
                                    dialogBackgroundColor:AppColors.background,
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.textFieldBorder,
                                        width: 1),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.textFieldBorder,
                                        width: 1),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color:  AppColors.textFieldBorder,
                                        width: 1),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color:  AppColors.textFieldBorder,
                                        width: 1),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),
                                    borderSide: BorderSide(
                                        color: AppColors.textFieldBorder,
                                        width: 1),
                                  ),
                                  hintText: "Phone number".tr)),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Referral code (optional)'.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Instrument Sans',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.20,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFieldThem.buildTextFiled(context,
                              hintText: 'Enter referral code'.tr,
                              controller:
                                  controller.referralCodeController.value,
                              enable: controller.loginType.value ==
                                      Constant.googleLoginType
                                  ? false
                                  : true),
                          const SizedBox(
                            height: 60,
                          ),
                          ButtonThem.buildButton(
                            context,
                            title: 'Signup'.tr,
                            onPress: () async {
                              if (controller
                                  .fullNameController.value.text.isEmpty) {
                                ShowToastDialog.showToast(
                                    "Please enter full name".tr);
                              } else if (controller
                                  .emailController.value.text.isEmpty) {
                                ShowToastDialog.showToast(
                                    "Please enter email".tr);
                              } else if (controller
                                  .phoneNumberController.value.text.isEmpty) {
                                ShowToastDialog.showToast(
                                    "Please enter phone".tr);
                              } else if (Constant.validateEmail(
                                      controller.emailController.value.text) ==
                                  false) {
                                ShowToastDialog.showToast(
                                    "Please enter valid email".tr);
                              } else {
                                if (controller.referralCodeController.value.text
                                    .isNotEmpty) {
                                  FireStoreUtils.checkReferralCodeValidOrNot(
                                          controller.referralCodeController
                                              .value.text)
                                      .then((value) async {
                                    if (value == true) {
                                      ShowToastDialog.showLoader(
                                          "Please wait".tr);
                                      UserModel userModel =
                                          controller.userModel.value;
                                      userModel.fullName = controller
                                          .fullNameController.value.text;
                                      userModel.email =
                                          controller.emailController.value.text;
                                      userModel.countryCode =
                                          controller.countryCode.value;
                                      userModel.phoneNumber = controller
                                          .phoneNumberController.value.text;
                                      userModel.isActive = true;
                                      userModel.createdAt = Timestamp.now();

                                      await FireStoreUtils
                                              .getReferralUserByCode(controller
                                                  .referralCodeController
                                                  .value
                                                  .text)
                                          .then((value) async {
                                        if (value != null) {
                                          ReferralModel ownReferralModel =
                                              ReferralModel(
                                                  id: FireStoreUtils
                                                      .getCurrentUid(),
                                                  referralBy: value.id,
                                                  referralCode: Constant
                                                      .getReferralCode());
                                          await FireStoreUtils.referralAdd(
                                              ownReferralModel);
                                        } else {
                                          ReferralModel referralModel =
                                              ReferralModel(
                                                  id: FireStoreUtils
                                                      .getCurrentUid(),
                                                  referralBy: "",
                                                  referralCode: Constant
                                                      .getReferralCode());
                                          await FireStoreUtils.referralAdd(
                                              referralModel);
                                        }
                                      });

                                      await FireStoreUtils.updateUser(userModel)
                                          .then((value) {
                                        ShowToastDialog.closeLoader();
                                        print("------>$value");
                                        if (value == true) {
                                          Get.offAll(const DashBoardScreen());
                                        }
                                      });
                                    } else {
                                      ShowToastDialog.showToast(
                                          "Referral code Invalid".tr);
                                    }
                                  });
                                } else {
                                  ShowToastDialog.showLoader("Please wait".tr);
                                  UserModel userModel =
                                      controller.userModel.value;
                                  userModel.fullName =
                                      controller.fullNameController.value.text;
                                  userModel.email =
                                      controller.emailController.value.text;
                                  userModel.countryCode =
                                      controller.countryCode.value;
                                  userModel.phoneNumber = controller
                                      .phoneNumberController.value.text;
                                  userModel.isActive = true;
                                  userModel.createdAt = Timestamp.now();

                                  ReferralModel referralModel = ReferralModel(
                                      id: FireStoreUtils.getCurrentUid(),
                                      referralBy: "",
                                      referralCode: Constant.getReferralCode());
                                  await FireStoreUtils.referralAdd(
                                      referralModel);

                                  await FireStoreUtils.updateUser(userModel)
                                      .then((value) {
                                    ShowToastDialog.closeLoader();
                                    print("------>$value");
                                    if (value == true) {
                                      Get.offAll(const DashBoardScreen());
                                    }
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
