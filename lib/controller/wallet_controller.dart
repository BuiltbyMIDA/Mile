import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as maths;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/model/payment_model.dart';
import 'package:customer/model/user_model.dart';
import 'package:customer/model/wallet_transaction_model.dart';
import 'package:customer/payment/paystack/pay_stack_screen.dart';
import 'package:customer/payment/paystack/pay_stack_url_model.dart';
import 'package:customer/payment/paystack/paystack_url_genrater.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';

import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WalletController extends GetxController {
  Rx<TextEditingController> amountController = TextEditingController().obs;
  Rx<PaymentModel> paymentModel = PaymentModel().obs;
  Rx<UserModel> userModel = UserModel().obs;
  RxString selectedPaymentMethod = "".obs;

  RxBool isLoading = true.obs;
  RxList transactionList = <WalletTransactionModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getPaymentData();
    super.onInit();
  }

  getPaymentData() async {
    getTraction();
    getUser();
    try {
      await FireStoreUtils().getPayment().then((value) {
        if (value != null) {
          print(value.payStack!.enable);
          paymentModel.value = value;

          setRef();
        } else {
          print("not null");
          print(value);
        }
      });
    } catch (e) {
      print("ERRO ${e.toString()}");
    }

    isLoading.value = false;
    update();
  }

  getUser() async {
    await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid())
        .then((value) {
      if (value != null) {
        userModel.value = value;
      }
    });
  }

  getTraction() async {
    await FireStoreUtils.getWalletTransaction().then((value) {
      if (value != null) {
        transactionList.value = value;
      }
    });
  }

  walletTopUp() async {
    WalletTransactionModel transactionModel = WalletTransactionModel(
        id: Constant.getUuid(),
        amount: amountController.value.text,
        createdDate: Timestamp.now(),
        paymentType: selectedPaymentMethod.value,
        transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: FireStoreUtils.getCurrentUid(),
        userType: "customer",
        note: "Wallet Topup");

    await FireStoreUtils.setWalletTransaction(transactionModel)
        .then((value) async {
      if (value == true) {
        await FireStoreUtils.updateUserWallet(
                amount: amountController.value.text)
            .then((value) {
          getUser();
          getTraction();
        });
      }
    });

    ShowToastDialog.showToast("Amount added in your wallet.");
  }

  ///PayStack Payment Method
  payStackPayment(String totalAmount) async {
    await PayStackURLGen.payStackURLGen(
            amount: (double.parse(totalAmount) * 100).toString(),
            currency: "NGN",
            secretKey: paymentModel.value.payStack!.secretKey.toString(),
            userModel: userModel.value)
        .then((value) async {
          print("value is");
          print(value);
      if (value != null) {
        PayStackUrlModel payStackModel = value;
        print(payStackModel.status);
        Get.to(PayStackScreen(
          secretKey: paymentModel.value.payStack!.secretKey.toString(),
          callBackUrl: paymentModel.value.payStack!.callbackURL.toString(),
          initialURl: payStackModel.data.authorizationUrl,
          amount: totalAmount,
          reference: payStackModel.data.reference,
        ))!
            .then((value) {
          if (payStackModel.status) {
            print("got here Successful");
            ShowToastDialog.showToast("Payment Successful!!");
            walletTopUp();
          } else {
            print("got here UnSuccessful");
            ShowToastDialog.showToast("Payment UnSuccessful!!");
          }
        });
      } else {
        ShowToastDialog.showToast(
            "Something went wrong, please contact admin.");
      }
    });
  }

  //flutter wave Payment Method
  flutterWaveInitiatePayment(
      {required BuildContext context, required String amount}) async {
    final flutterWave = Flutterwave(
      amount: amount.trim(),
      currency: "NGN",
      customer: Customer(
          name: userModel.value.fullName,
          phoneNumber: userModel.value.phoneNumber,
          email: userModel.value.email.toString()),
      context: context,
      publicKey: paymentModel.value.flutterWave!.publicKey.toString().trim(),
      paymentOptions: "ussd, card, barter, payattitude",
      customization: Customization(title: "Mile"),
      txRef: _ref!,
      isTestMode: paymentModel.value.flutterWave!.isSandbox!,
      redirectUrl: '${Constant.globalUrl}success',
      paymentPlanId: _ref!,
    );
    final ChargeResponse response = await flutterWave.charge();

    if (response.success!) {
      ShowToastDialog.showToast("Payment Successful!!");
      walletTopUp();
    } else {
      ShowToastDialog.showToast(response.status!);
    }
  }

  String? _ref;

  setRef() {
    maths.Random numRef = maths.Random();
    int year = DateTime.now().year;
    int refNumber = numRef.nextInt(20000);
    if (Platform.isAndroid) {
      _ref = "AndroidRef$year$refNumber";
    } else if (Platform.isIOS) {
      _ref = "IOSRef$year$refNumber";
    }
  }
}
