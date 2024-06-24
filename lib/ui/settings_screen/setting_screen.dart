import 'dart:convert';

import 'package:driver/constant/constant.dart';
import 'package:driver/constant/show_toast_dialog.dart';
import 'package:driver/services/localization_service.dart';
import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/responsive.dart';
import 'package:driver/ui/auth_screen/login_screen.dart';
import 'package:driver/utils/DarkThemeProvider.dart';
import 'package:driver/utils/Preferences.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/setting_controller.dart';
import '../profile_screen/profile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder<SettingController>(
        init: SettingController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: controller.isLoading.value
                ? Constant.loader(context)
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //     children: [
                                    //       SvgPicture.asset(
                                    //           'assets/icons/ic_language copy.svg',
                                    //           color: const Color(0xFF1C1B1F),
                                    //           width: 18),
                                    //       const SizedBox(
                                    //         width: 20,
                                    //       ),
                                    //       Expanded(
                                    //         child: Text(
                                    //           "Language".tr,
                                    //           style: const TextStyle(
                                    //             color: Colors.black,
                                    //             fontSize: 16,
                                    //             fontFamily: 'Instrument Sans',
                                    //             fontWeight: FontWeight.w600,
                                    //             letterSpacing: -0.20,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       SizedBox(
                                    //         width:
                                    //             Responsive.width(26, context),
                                    //         child: DropdownButtonFormField(
                                    //             isExpanded: true,
                                    //             decoration:
                                    //                 const InputDecoration(
                                    //               contentPadding:
                                    //                   EdgeInsets.symmetric(
                                    //                       vertical: 1),
                                    //               disabledBorder:
                                    //                   InputBorder.none,
                                    //               focusedBorder:
                                    //                   InputBorder.none,
                                    //               enabledBorder:
                                    //                   InputBorder.none,
                                    //               errorBorder: InputBorder.none,
                                    //               border: InputBorder.none,
                                    //               isDense: true,
                                    //             ),
                                    //             value: controller
                                    //                         .selectedLanguage
                                    //                         .value
                                    //                         .id ==
                                    //                     null
                                    //                 ? null
                                    //                 : controller
                                    //                     .selectedLanguage.value,
                                    //             onChanged: (value) {
                                    //               controller.selectedLanguage
                                    //                   .value = value!;
                                    //
                                    //               LocalizationService()
                                    //                   .changeLocale(value.code
                                    //                       .toString());
                                    //               Preferences.setString(
                                    //                   Preferences
                                    //                       .languageCodeKey,
                                    //                   jsonEncode(controller
                                    //                       .selectedLanguage
                                    //                       .value));
                                    //             },
                                    //             hint: Text("select".tr),
                                    //             items: controller.languageList
                                    //                 .map((item) {
                                    //               print(item.toJson());
                                    //               return DropdownMenuItem(
                                    //                 value: item,
                                    //                 child: Text(
                                    //                     item.name.toString(),
                                    //                     style:
                                    //                         GoogleFonts.manrope(
                                    //                             fontWeight:
                                    //                                 FontWeight
                                    //                                     .w500)),
                                    //               );
                                    //             }).toList()),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // const Divider(),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //     children: [
                                    //       SvgPicture.asset(
                                    //           'assets/icons/ic_light_drak copy.svg',
                                    //           color: const Color(0xFF1C1B1F),
                                    //           width: 18),
                                    //       const SizedBox(
                                    //         width: 20,
                                    //       ),
                                    //       Expanded(
                                    //           child: Text(
                                    //         "Light/dark mod".tr,
                                    //         style: const TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 16,
                                    //           fontFamily: 'Instrument Sans',
                                    //           fontWeight: FontWeight.w600,
                                    //           letterSpacing: -0.20,
                                    //         ),
                                    //       )),
                                    //       SizedBox(
                                    //         width:
                                    //             Responsive.width(26, context),
                                    //         child: DropdownButtonFormField<
                                    //                 String>(
                                    //             isExpanded: true,
                                    //             decoration:
                                    //                 const InputDecoration(
                                    //               contentPadding:
                                    //                   EdgeInsets.symmetric(
                                    //                       vertical: 1),
                                    //               disabledBorder:
                                    //                   InputBorder.none,
                                    //               focusedBorder:
                                    //                   InputBorder.none,
                                    //               enabledBorder:
                                    //                   InputBorder.none,
                                    //               errorBorder: InputBorder.none,
                                    //               border: InputBorder.none,
                                    //               isDense: true,
                                    //             ),
                                    //             validator: (value) =>
                                    //                 value == null
                                    //                     ? 'field required'
                                    //                     : null,
                                    //             value: controller
                                    //                     .selectedMode.isEmpty
                                    //                 ? null
                                    //                 : controller
                                    //                     .selectedMode.value,
                                    //             onChanged: (value) {
                                    //               controller.selectedMode
                                    //                   .value = value!;
                                    //               Preferences.setString(
                                    //                   Preferences.themKey,
                                    //                   value.toString());
                                    //               if (controller
                                    //                       .selectedMode.value ==
                                    //                   "Dark mode") {
                                    //                 themeChange.darkTheme = 0;
                                    //               } else if (controller
                                    //                       .selectedMode.value ==
                                    //                   "Light mode") {
                                    //                 themeChange.darkTheme = 1;
                                    //               } else {
                                    //                 themeChange.darkTheme = 2;
                                    //               }
                                    //             },
                                    //             hint: Text("select".tr),
                                    //             items: controller.modeList
                                    //                 .map((item) {
                                    //               return DropdownMenuItem(
                                    //                 value: item,
                                    //                 child: Text(item.toString(),
                                    //                     style:
                                    //                         GoogleFonts.manrope(
                                    //                             fontWeight:
                                    //                                 FontWeight
                                    //                                     .w500)),
                                    //               );
                                    //             }).toList()),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          final Uri url = Uri.parse(
                                              Constant.supportURL.toString());
                                          if (!await launchUrl(url)) {
                                            throw Exception(
                                                'Could not launch ${Constant.supportURL.toString()}'
                                                    .tr);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/ic_support copy.svg',
                                                color: const Color(0xFF1C1B1F),
                                                width: 18),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Support".tr,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Instrument Sans',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          Get.to(() => const ProfileScreen());
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/ic_person.svg',
                                                color: const Color(0xFF1C1B1F),
                                                width: 18),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Account Settings'.tr,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Instrument Sans',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/ic_delete copy.svg',
                                              color: const Color(0xFF1C1B1F),
                                              width: 18,
                                              height: 18,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Delete Account".tr,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Instrument Sans',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 120),
                                      child:
                                          Text("V ${Constant.appVersion}".tr),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK".tr),
      onPressed: () async {
        ShowToastDialog.showLoader("Please wait".tr);
        await FireStoreUtils.deleteUser().then((value) {
          ShowToastDialog.closeLoader();
          if (value == true) {
            ShowToastDialog.showToast("Account delete".tr);
            Get.offAll(const LoginScreen());
          } else {
            ShowToastDialog.showToast("Please contact to administrator".tr);
          }
        });
      },
    );
    Widget cancel = TextButton(
      child: Text("Cancel".tr),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Account delete".tr),
      content: Text("Are you sure want to delete Account.".tr),
      actions: [
        okButton,
        cancel,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK".tr),
    onPressed: () async {
      ShowToastDialog.showLoader("Please wait".tr);
      await FireStoreUtils.deleteUser().then((value) {
        ShowToastDialog.closeLoader();
        if (value == true) {
          ShowToastDialog.showToast("Account delete".tr);
          Get.offAll(const LoginScreen());
        } else {
          ShowToastDialog.showToast("Please contact to administrator".tr);
        }
      });
    },
  );
  Widget cancel = TextButton(
    child: Text("Cancel".tr),
    onPressed: () {
      Get.back();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Account delete".tr),
    content: Text("Are you sure want to delete Account.".tr),
    actions: [
      okButton,
      cancel,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
