import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/constant/show_toast_dialog.dart';
import 'package:driver/controller/information_controller.dart';
import 'package:driver/model/driver_user_model.dart';
import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/button_them.dart';
import 'package:driver/themes/text_field_them.dart';
import 'package:driver/ui/dashboard_screen.dart';
import 'package:driver/utils/DarkThemeProvider.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../themes/responsive.dart';

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
                            hintText: 'Full name'.tr,
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
                            controller: controller.phoneNumberController.value,
                            textAlign: TextAlign.start,
                            enabled: controller.loginType.value ==
                                    Constant.phoneLoginType
                                ? false
                                : true,
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: AppColors.textField,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                prefixIcon: CountryCodePicker(
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
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldBorder,
                                      width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldBorder,
                                      width: 1),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldBorder,
                                      width: 1),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldBorder,
                                      width: 1),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldBorder,
                                      width: 1),
                                ),
                                hintText: "Phone number".tr)),
                        const SizedBox(
                          height: 12,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        ButtonThem.buildButton(context, title: "Signup".tr,
                            onPress: () async {
                          if (controller
                              .fullNameController.value.text.isEmpty) {
                            ShowToastDialog.showToast(
                                "Please enter full name".tr);
                          } else if (controller
                              .emailController.value.text.isEmpty) {
                            ShowToastDialog.showToast("Please enter email".tr);
                          } else if (controller
                              .phoneNumberController.value.text.isEmpty) {
                            ShowToastDialog.showToast(
                                "Please enter phone number".tr);
                          } else if (Constant.validateEmail(
                                  controller.emailController.value.text) ==
                              false) {
                            ShowToastDialog.showToast(
                                "Please enter valid email".tr);
                          } else {
                            ShowToastDialog.showLoader("Please wait".tr);
                            DriverUserModel userModel =
                                controller.userModel.value;
                            userModel.fullName =
                                controller.fullNameController.value.text;
                            userModel.email =
                                controller.emailController.value.text;
                            userModel.countryCode =
                                controller.countryCode.value;
                            userModel.phoneNumber =
                                controller.phoneNumberController.value.text;
                            userModel.documentVerification = false;
                            userModel.isOnline = false;
                            userModel.createdAt = Timestamp.now();

                            await FireStoreUtils.updateDriverUser(userModel)
                                .then((value) {
                              ShowToastDialog.closeLoader();
                              print("------>$value");
                              if (value == true) {
                                Get.offAll(const DashBoardScreen());
                              }
                            });
                          }
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
        });
  }
}
