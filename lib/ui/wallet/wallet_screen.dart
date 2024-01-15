import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controller/wallet_controller.dart';
import 'package:customer/model/intercity_order_model.dart';
import 'package:customer/model/order_model.dart';
import 'package:customer/model/wallet_transaction_model.dart';
import 'package:customer/payment/createRazorPayOrderModel.dart';
import 'package:customer/payment/rozorpayConroller.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/themes/text_field_them.dart';
import 'package:customer/ui/intercityOrders/intercity_complete_order_screen.dart';
import 'package:customer/ui/orders/complete_order_screen.dart';
import 'package:customer/utils/DarkThemeProvider.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX<WalletController>(
        init: WalletController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: controller.isLoading.value
                ? Constant.loader()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'Current balance',
                              style: TextStyle(
                                color: Color(0xFF1D2939),
                                fontSize: 14,
                                fontFamily: 'Instrument Sans',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.20,
                              ),
                            ),
                          ),
                          controller.userModel.value.walletAmount != null
                              ? Text(
                                  "\$MILE ${double.parse(controller.userModel.value.walletAmount.toString()).toStringAsFixed(Constant.currencyModel!.decimalDigits!)}",
                                  style: const TextStyle(
                                    color: Color(0xFF1D2939),
                                    fontSize: 32,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : const Text(
                                  '\$MILE 0',
                                  style: TextStyle(
                                    color: Color(0xFF1D2939),
                                    fontSize: 32,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          const SizedBox(
                            height: 16,
                          ),
                          ButtonThem.roundButton(
                            context,
                            title: "Topup".tr,
                            btnColor: AppColors.primary,
                            txtColor: Colors.black,
                            btnWidthRatio: 0.70,
                            btnHeight: 50,
                            icon: const Icon(
                              Icons.add,
                              size: 16,
                            ),
                            iconVisibility: true,
                            onPress: () async {
                              paymentMethodDialog(context, controller);
                            },
                          ),
                        ],
                      ),
                      // Container(
                      //   height: Responsive.width(28, context),
                      //   width: Responsive.width(100, context),
                      //   color: AppColors.primary,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 10),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Expanded(
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 "Total Balance".tr,
                      //                 style: GoogleFonts.poppins(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w600,
                      //                     fontSize: 16),
                      //               ),
                      //               controller.userModel.value.walletAmount !=
                      //                       null
                      //                   ? Text(
                      //                       Constant.amountShow(
                      //                           amount: controller.userModel
                      //                               .value.walletAmount
                      //                               .toString()),
                      //                       style: GoogleFonts.poppins(
                      //                           color: Colors.white,
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: 24),
                      //                     )
                      //                   : Text(
                      //                       '0',
                      //                       style: GoogleFonts.poppins(
                      //                           color: Colors.white,
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: 24),
                      //                     ),
                      //             ],
                      //           ),
                      //         ),
                      // Transform.translate(
                      //           offset: const Offset(0, -22),
                      //           child: ButtonThem.roundButton(
                      //             context,
                      //             title: "Topup Wallet".tr,
                      //             btnColor: Colors.white,
                      //             txtColor: AppColors.primary,
                      //             btnWidthRatio: 0.40,
                      //             btnHeight: 40,
                      //             onPress: () async {
                      //               paymentMethodDialog(context, controller);
                      //             },
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: controller.transactionList.isEmpty
                              ? Center(child: Text("No transaction found".tr))
                              : ListView.builder(
                                  itemCount: controller.transactionList.length,
                                  itemBuilder: (context, index) {
                                    WalletTransactionModel
                                        walletTransactionModel =
                                        controller.transactionList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          if (walletTransactionModel
                                                  .orderType ==
                                              "city") {
                                            await FireStoreUtils.getOrder(
                                                    walletTransactionModel
                                                        .transactionId
                                                        .toString())
                                                .then((value) {
                                              if (value != null) {
                                                OrderModel orderModel = value;
                                                Get.to(
                                                    const CompleteOrderScreen(),
                                                    arguments: {
                                                      "orderModel": orderModel,
                                                    });
                                              }
                                            });
                                          } else if (walletTransactionModel
                                                  .orderType ==
                                              "intercity") {
                                            await FireStoreUtils
                                                    .getInterCityOrder(
                                                        walletTransactionModel
                                                            .transactionId
                                                            .toString())
                                                .then((value) {
                                              if (value != null) {
                                                InterCityOrderModel orderModel =
                                                    value;
                                                Get.to(
                                                    const IntercityCompleteOrderScreen(),
                                                    arguments: {
                                                      "orderModel": orderModel,
                                                    });
                                              }
                                            });
                                          } else {
                                            showTransactionDetails(
                                                context: context,
                                                walletTransactionModel:
                                                    walletTransactionModel);
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors
                                                      .containerBackground,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color:  AppColors
                                                          .containerBorder,
                                                  width: 0.5),
                                              boxShadow:  [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.10),
                                                        blurRadius: 5,
                                                        offset: const Offset(0,
                                                            4), // changes position of shadow
                                                      ),
                                                    ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .lightGray,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/ic_wallet.svg',
                                                          width: 24,
                                                          color: Colors.black,
                                                        ),
                                                      )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                Constant.dateFormatTimestamp(
                                                                    walletTransactionModel
                                                                        .createdDate),
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            Text(
                                                              "${Constant.IsNegative(double.parse(walletTransactionModel.amount.toString())) ? "(-" : "+"}${Constant.amountShow(amount: walletTransactionModel.amount.toString().replaceAll("-", ""))}${Constant.IsNegative(double.parse(walletTransactionModel.amount.toString())) ? ")" : ""}",
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Constant.IsNegative(double.parse(walletTransactionModel
                                                                          .amount
                                                                          .toString()))
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .green),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                walletTransactionModel
                                                                    .note
                                                                    .toString(),
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                            Text(walletTransactionModel
                                                                .paymentType
                                                                .toString()
                                                                .toUpperCase())
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }

  paymentMethodDialog(BuildContext context, WalletController controller) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context1) {
          final themeChange = Provider.of<DarkThemeProvider>(context1);

          return FractionallySizedBox(
            heightFactor: 0.65,
            child: StatefulBuilder(builder: (context1, setState) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 28,
                                ),
                                const SizedBox(
                                  width: 358,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'Transfer Naira to the account below  to get credited \$MILE tokens. ',
                                          style: TextStyle(
                                            color: Color(0xFF222222),
                                            fontSize: 14,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.20,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\$MILE = 1.25 NGN',
                                          style: TextStyle(
                                            color: Color(0xFF222222),
                                            fontSize: 14,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                const Text(
                                  'Enter top-up amount',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFieldThem.buildTextFiled(context,
                                    hintText: 'Enter Amount'.tr,
                                    controller:
                                        controller.amountController.value,
                                    keyBoardType: TextInputType.number),
                                const SizedBox(
                                  height: 28,
                                ),
                                Text(
                                  'Select payment method'.tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value
                                          .payStack!.enable ==
                                      true,
                                  child: Column(
                                    children: [
                                      // const SizedBox(
                                      //   height: 12,
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          controller
                                                  .selectedPaymentMethod.value =
                                              controller.paymentModel.value
                                                  .payStack!.name
                                                  .toString();
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                            bottom: BorderSide(
                                                width: 0.50,
                                                color: Color(0xFFEAEAEC)),
                                          )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                      'assets/images/paystack.png'),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    controller.paymentModel
                                                        .value.payStack!.name
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                ),
                                                Radio(
                                                  value: controller.paymentModel
                                                      .value.payStack!.name
                                                      .toString(),
                                                  groupValue: controller
                                                      .selectedPaymentMethod
                                                      .value,
                                                  activeColor: Colors.black,
                                                  onChanged: (value) {
                                                    controller
                                                            .selectedPaymentMethod
                                                            .value =
                                                        controller
                                                            .paymentModel
                                                            .value
                                                            .payStack!
                                                            .name
                                                            .toString();
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: controller.paymentModel.value
                                          .flutterWave!.enable ==
                                      true,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller
                                                  .selectedPaymentMethod.value =
                                              controller.paymentModel.value
                                                  .flutterWave!.name
                                                  .toString();
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                            bottom: BorderSide(
                                                width: 0.50,
                                                color: Color(0xFFEAEAEC)),
                                          )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                    'assets/images/flutterwave.png',
                                                    scale: 2,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    controller.paymentModel
                                                        .value.flutterWave!.name
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                ),
                                                Radio(
                                                  value: controller.paymentModel
                                                      .value.flutterWave!.name
                                                      .toString(),
                                                  groupValue: controller
                                                      .selectedPaymentMethod
                                                      .value,
                                                  activeColor: Colors.black,
                                                  onChanged: (value) {
                                                    controller
                                                            .selectedPaymentMethod
                                                            .value =
                                                        controller
                                                            .paymentModel
                                                            .value
                                                            .flutterWave!
                                                            .name
                                                            .toString();
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      ButtonThem.buildButton(context,
                          title: "Continue".tr,
                          btnHeight: 50,
                          color: AppColors.primary, onPress: () {
                        if (controller.amountController.value.text.isNotEmpty) {
                          Get.back();
                          if (controller.selectedPaymentMethod.value ==
                              controller.paymentModel.value.payStack!.name) {
                            controller.payStackPayment(
                                controller.amountController.value.text);
                          } else if (controller.selectedPaymentMethod.value ==
                              controller.paymentModel.value.flutterWave!.name) {
                            controller.flutterWaveInitiatePayment(
                                context: context,
                                amount: controller.amountController.value.text);
                          } else {
                            ShowToastDialog.showToast(
                                "Please select payment method".tr);
                          }
                        } else {
                          ShowToastDialog.showToast("Please enter amount".tr);
                        }
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonThem.buildBorderButton(context,
                          title: "Cancel".tr, btnHeight: 50, onPress: () {
                        Get.back();
                      }),
                      const SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  showTransactionDetails(
      {required BuildContext context,
      required WalletTransactionModel walletTransactionModel}) {
    return showModalBottomSheet(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            final themeChange = Provider.of<DarkThemeProvider>(context);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Transaction Details".tr,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  AppColors.containerBackground,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: AppColors.containerBorder,
                            width: 0.5),
                        boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Transaction ID".tr,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "#${walletTransactionModel.transactionId!.toUpperCase()}",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  AppColors.containerBackground,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color:  AppColors.containerBorder,
                            width: 0.5),
                        boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payment Details".tr,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Opacity(
                                          opacity: 0.7,
                                          child: Text(
                                            "Pay Via".tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " ${walletTransactionModel.paymentType}",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date in UTC Format".tr,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Opacity(
                                        opacity: 0.7,
                                        child: Text(
                                          DateFormat('KK:mm:ss a, dd MMM yyyy')
                                              .format(walletTransactionModel
                                                  .createdDate!
                                                  .toDate())
                                              .toUpperCase(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
