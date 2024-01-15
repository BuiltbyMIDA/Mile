import 'package:driver/constant/constant.dart';
import 'package:driver/constant/show_toast_dialog.dart';
import 'package:driver/controller/bank_details_controller.dart';
import 'package:driver/model/bank_details_model.dart';
import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/button_them.dart';
import 'package:driver/themes/responsive.dart';
import 'package:driver/themes/text_field_them.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<BankDetailsController>(
        init: BankDetailsController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                  child: controller.isLoading.value
                      ? Constant.loader(context)
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  'Please fill in your bank account information',
                                  style: TextStyle(
                                    color: Color(0xFF1D2939),
                                    fontSize: 14,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 0.09,
                                    letterSpacing: -0.20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Bank Name".tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFieldThem.buildTextFiled(context,
                                    hintText: 'Bank Name'.tr,
                                    controller:
                                        controller.bankNameController.value),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Account Number".tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFieldThem.buildTextFiled(context,
                                    hintText: 'Account Number'.tr,
                                    controller: controller
                                        .accountNumberController.value),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Account Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFieldThem.buildTextFiled(context,
                                    hintText: 'Enter account name'.tr,
                                    controller:
                                        controller.holderNameController.value),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(28),
              child: ButtonThem.buildButton(
                context,
                title: "Save".tr,
                onPress: () async {
                  if (controller.bankNameController.value.text.isEmpty) {
                    ShowToastDialog.showToast("Please enter bank name".tr);
                  } else if (controller
                      .holderNameController.value.text.isEmpty) {
                    ShowToastDialog.showToast("Please enter holder name".tr);
                  } else if (controller
                      .accountNumberController.value.text.isEmpty) {
                    ShowToastDialog.showToast("Please enter account number".tr);
                  } else {
                    ShowToastDialog.showLoader("Please wait".tr);
                    BankDetailsModel bankDetailsModel =
                        controller.bankDetailsModel.value;

                    bankDetailsModel.userId = FireStoreUtils.getCurrentUid();
                    bankDetailsModel.bankName =
                        controller.bankNameController.value.text;
                    bankDetailsModel.branchName =
                        controller.branchNameController.value.text;
                    bankDetailsModel.holderName =
                        controller.holderNameController.value.text;
                    bankDetailsModel.accountNumber =
                        controller.accountNumberController.value.text;
                    bankDetailsModel.otherInformation =
                        controller.otherInformationController.value.text;

                    await FireStoreUtils.updateBankDetails(bankDetailsModel)
                        .then((value) {
                      ShowToastDialog.closeLoader();
                      ShowToastDialog.showToast(
                          "Bank details update successfully".tr);
                    });
                  }
                },
              ),
            ),
          );
        });
  }
}
