import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/model/bank_details_model.dart';
import 'package:driver/model/payment_model.dart';
import 'package:driver/model/wallet_transaction_model.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:driver/model/driver_user_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:math' as maths;

import 'package:driver/constant/constant.dart';
import 'package:driver/constant/show_toast_dialog.dart';
import 'package:driver/payment/paystack/pay_stack_screen.dart';
import 'package:driver/payment/paystack/pay_stack_url_model.dart';
import 'package:driver/payment/paystack/paystack_url_genrater.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class WalletController extends GetxController {
  Rx<TextEditingController> withdrawalAmountController =
      TextEditingController().obs;
  Rx<TextEditingController> noteController = TextEditingController().obs;

  Rx<TextEditingController> amountController = TextEditingController().obs;
  Rx<PaymentModel> paymentModel = PaymentModel().obs;
  Rx<DriverUserModel> driverUserModel = DriverUserModel().obs;
  Rx<BankDetailsModel> bankDetailsModel = BankDetailsModel().obs;
  RxString selectedPaymentMethod = "".obs;

  RxBool isLoading = true.obs;
  RxList transactionList = <WalletTransactionModel>[].obs;

  @override
  void onInit() {
    getPaymentData();
    super.onInit();
  }

  getPaymentData() async {
    getTraction();
    getUser();
    await FireStoreUtils().getPayment().then((value) {
      if (value != null) {
        paymentModel.value = value;

        setRef();
      }
    });

    isLoading.value = false;
    update();
  }

  getUser() async {
    await FireStoreUtils.getDriverProfile(FireStoreUtils.getCurrentUid())
        .then((value) {
      if (value != null) {
        driverUserModel.value = value;
      }
    });

    await FireStoreUtils.getBankDetails().then((value) {
      if (value != null) {
        bankDetailsModel.value = value;
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
        userType: "driver",
        note: "Wallet Topup");

    await FireStoreUtils.setWalletTransaction(transactionModel)
        .then((value) async {
      if (value == true) {
        await FireStoreUtils.updatedDriverWallet(
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
            userModel: driverUserModel.value)
        .then((value) async {
      if (value != null) {
        PayStackUrlModel payStackModel = value;
        Get.to(PayStackScreen(
          secretKey: paymentModel.value.payStack!.secretKey.toString(),
          callBackUrl: paymentModel.value.payStack!.callbackURL.toString(),
          initialURl: payStackModel.data.authorizationUrl,
          amount: totalAmount,
          reference: payStackModel.data.reference,
        ))!
            .then((value) {
          if (value) {
            ShowToastDialog.showToast("Payment Successful!!");
            walletTopUp();
          } else {
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
          name: driverUserModel.value.fullName,
          phoneNumber: driverUserModel.value.phoneNumber,
          email: driverUserModel.value.email.toString()),
      context: context,
      publicKey: paymentModel.value.flutterWave!.publicKey.toString().trim(),
      paymentOptions: "ussd, card, barter, payattitude",
      customization: Customization(title: "MILE"),
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

  // void handlePaymentSuccess(PaymentSuccessResponse response) {
  //   Get.back();
  //   ShowToastDialog.showToast("Payment Successful!!");
  //   walletTopUp();
  // }

  // void handleExternalWaller(ExternalWalletResponse response) {
  //   Get.back();
  //   ShowToastDialog.showToast("Payment Processing!! via");
  // }

  // void handlePaymentError(PaymentFailureResponse response) {
  //   Get.back();
  //   RazorPayFailedModel lom = RazorPayFailedModel.fromJson(jsonDecode(response.message!.toString()));
  //   ShowToastDialog.showToast("Payment Failed!!");
  // }
}
