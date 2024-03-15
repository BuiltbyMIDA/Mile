import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/constant/collection_name.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/model/driver_user_model.dart';
import 'package:customer/model/order_model.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/ui/orders/payment_dailog.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/widget/driver_view.dart';
import 'package:customer/widget/location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/button_them.dart';

class PaymentOrderScreen extends StatelessWidget {
  const PaymentOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text("Ride Details".tr),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
              )),
        ),
        body: Column(
          children: [
            Container(
              height: Responsive.width(10, context),
              width: Responsive.width(100, context),
              color: AppColors.primary,
            ),
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -22),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(CollectionName.orders)
                            .doc('')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Something went wrong'.tr));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Constant.loader();
                          }
                          OrderModel orderModel =
                              OrderModel.fromJson(snapshot.data!.data()!);

                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const DriverView(driverId: '', amount: ''),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Divider(thickness: 1),
                                  ),
                                  Text(
                                    "Vehicle Details".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FutureBuilder<DriverUserModel?>(
                                      future: FireStoreUtils.getDriver(''),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Constant.loader();
                                          case ConnectionState.done:
                                            if (snapshot.hasError) {
                                              return Text(
                                                  snapshot.error.toString());
                                            } else {
                                              DriverUserModel driverModel =
                                                  snapshot.data!;
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .containerBackground,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .containerBorder,
                                                      width: 0.5),
                                                  boxShadow: [
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12,
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/ic_car.svg',
                                                            width: 18,
                                                            color: Colors.black,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            driverModel
                                                                .vehicleInformation!
                                                                .vehicleType
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/ic_color.svg',
                                                            width: 18,
                                                            color: Colors.black,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            driverModel
                                                                .vehicleInformation!
                                                                .vehicleColor
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/icons/ic_number.png',
                                                            width: 18,
                                                            color: Colors.black,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            driverModel
                                                                .vehicleInformation!
                                                                .vehicleNumber
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          default:
                                            return Text('Error'.tr);
                                        }
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Pickup and drop-off locations".tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.containerBackground,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: AppColors.containerBorder,
                                          width: 0.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: LocationView(
                                        sourceLocation: '',
                                        destinationLocation: '',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.gray,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 12),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        orderModel.status
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))),
                                                Text(
                                                    Constant().formatTimestamp(
                                                        orderModel.createdDate),
                                                    style:
                                                        GoogleFonts.poppins()),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.containerBackground,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: AppColors.containerBorder,
                                          width: 0.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/icons/ic_offer.png',
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Redeem Coupon".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    "Add coupon code".tr,
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SvgPicture.asset(
                                              "assets/icons/ic_add_offer.svg",
                                              width: 40,
                                              height: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.containerBackground,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: AppColors.containerBorder,
                                          width: 0.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Booking summary".tr,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Ride Amount".tr,
                                                  style: GoogleFonts.poppins(
                                                      color: AppColors
                                                          .subTitleColor),
                                                ),
                                              ),
                                              Text(
                                                Constant.amountShow(
                                                  amount: 'amount',
                                                ),
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                          ListView.builder(
                                            itemCount: 1,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "--",
                                                          style: GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .subTitleColor),
                                                        ),
                                                      ),
                                                      Text(
                                                        "text",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Discount".tr,
                                                  style: GoogleFonts.poppins(
                                                      color: AppColors
                                                          .subTitleColor),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "copon",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Payable amount".tr,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                'amount',
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ButtonThem.buildButton(
                                    context,
                                    title: "Pay".tr,
                                    onPress: () {
                                      paymentMethodDialog(
                                        context,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
