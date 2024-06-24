import 'dart:convert';

import 'package:driver/model/bank_details_model.dart';
import 'package:driver/model/bank_model.dart';
import 'package:driver/model/lookup_bank_model.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constant/show_toast_dialog.dart';
import '../model/payment_model.dart';
import '../payment/paystack/paystack_url_genrater.dart';

class BankDetailsController extends GetxController {
  Rx<TextEditingController> bankNameController = TextEditingController().obs;
  Rx<TextEditingController> branchNameController = TextEditingController().obs;
  Rx<TextEditingController> holderNameController = TextEditingController().obs;
  Rx<TextEditingController> accountNumberController = TextEditingController().obs;
  Rx<TextEditingController> otherInformationController = TextEditingController().obs;

  List<BankModelData> bankList = <BankModelData>[].obs;
  Rx<BankModelData> selectedBank = BankModelData().obs;

  Rx<PaymentModel> paymentModel = PaymentModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getBankDetails();
    fetchBanks();
    getPaymentData();
    super.onInit();
  }

  RxBool isLoading = true.obs;
  Rx<BankDetailsModel> bankDetailsModel = BankDetailsModel().obs;

  getBankDetails() async {
    await FireStoreUtils.getBankDetails().then((value) {
      if (value != null) {
        bankDetailsModel.value = value;
        bankNameController.value.text = bankDetailsModel.value.bankName.toString();
        branchNameController.value.text = bankDetailsModel.value.bankName.toString();
        holderNameController.value.text = bankDetailsModel.value.holderName.toString();
        accountNumberController.value.text = bankDetailsModel.value.accountNumber.toString();
        otherInformationController.value.text = bankDetailsModel.value.otherInformation.toString();
      }
    });
    isLoading.value = false;
    update();
  }

  getPaymentData() async {

    await FireStoreUtils().getPayment().then((value) {
      if (value != null) {
        paymentModel.value = value;

      }
    });

    isLoading.value = false;
    update();
  }

  fetchBanks() async {

    String jsonString = await rootBundle.loadString('assets/json/bank_list.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    BankModel bankModel = BankModel.fromJson(jsonMap);

    bankList = bankModel.data!;
    if (bankDetailsModel.value.bankName != null) {
      for (var element in bankList) {
        if (element.name == bankDetailsModel.value.bankName) {
          selectedBank.value = element;
        }
      }
    }
    isLoading.value = false;
    update();
  }

  payStackLookup() async {
    await PayStackURLGen.payStackLookup(
        account_number: accountNumberController.value.text,
        bank_code: selectedBank.value.code!,
        secretKey: paymentModel.value.payStack!.secretKey.toString(),
      )
        .then((value) async {
      if (value != null) {
        print(value);
        LookupBankModel lookupBankModel = value;
        holderNameController.value.text = lookupBankModel.data!.accountName!;
      } else {
        ShowToastDialog.showToast(
            "Something went wrong, unable to validate account.");
      }
    });

    isLoading.value = false;
    update();
  }
}
