import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/send_notification.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controller/home_controller.dart';
import 'package:customer/model/banner_model.dart';
import 'package:customer/model/order/location_lat_lng.dart';
import 'package:customer/model/order/positions.dart';
import 'package:customer/model/order_model.dart';
import 'package:customer/model/service_model.dart';
import 'package:customer/model/user_model.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/themes/text_field_them.dart';
import 'package:customer/utils/DarkThemeProvider.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetX<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: controller.isLoading.value
                ? Constant.loader()
                : Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            // borderRadius: const BorderRadius.only(
                            //     topLeft: Radius.circular(25),
                            //     topRight: Radius.circular(25))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // controller.sourceLocationLAtLng.value
                                  //             .latitude ==
                                  //         null
                                  //     ? InkWell(
                                  //         onTap: () async {
                                  //           LocationResult? result =
                                  //               await Utils.showPlacePicker(
                                  //                   context);
                                  //           if (result != null) {
                                  //             controller
                                  //                     .sourceLocationController
                                  //                     .value
                                  //                     .text =
                                  //                 result.formattedAddress
                                  //                     .toString();
                                  //             controller.sourceLocationLAtLng
                                  //                     .value =
                                  //                 LocationLatLng(
                                  //                     latitude: result
                                  //                         .latLng!.latitude,
                                  //                     longitude: result
                                  //                         .latLng!.longitude);
                                  //             controller.calculateAmount();
                                  //           }
                                  //         },
                                  //         child: TextFieldThem.buildTextFiled(
                                  //             context,
                                  //             hintText: 'Enter Location'.tr,
                                  //             controller: controller
                                  //                 .sourceLocationController
                                  //                 .value,
                                  //             enable: false))
                                  //     :
                                  Row(
                                    children: [
                                      // Column(
                                      //   children: [
                                      //     SvgPicture.asset(
                                      //         'assets/icons/ic_source.svg',
                                      //         width: 18),
                                      //     Dash(
                                      //         direction: Axis.vertical,
                                      //         length:
                                      //             Responsive.height(6, context),
                                      //         dashLength: 12,
                                      //         dashColor:
                                      //             AppColors.dottedDivider),
                                      //     SvgPicture.asset(
                                      //       'assets/icons/ic_destination.svg',
                                      //         width: 20),
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   width: 18,
                                      // ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                onTap: () async {
                                                  LocationResult? result =
                                                      await Utils
                                                          .showPlacePicker(
                                                              context);
                                                  if (result != null) {
                                                    controller
                                                            .sourceLocationController
                                                            .value
                                                            .text =
                                                        result.formattedAddress
                                                            .toString();
                                                    controller
                                                            .sourceLocationLAtLng
                                                            .value =
                                                        LocationLatLng(
                                                            latitude: result
                                                                .latLng!
                                                                .latitude,
                                                            longitude: result
                                                                .latLng!
                                                                .longitude);
                                                    controller
                                                        .calculateAmount();
                                                  }
                                                },
                                                child: TextFieldThem.buildTextFiledWithPrefixIcon(
                                                    context,
                                                    prefix: SvgPicture.asset(
                                                        "assets/icons/near_me.svg"),
                                                    hintText:
                                                        'Select pickup location'
                                                            .tr,
                                                    controller: controller
                                                        .sourceLocationController
                                                        .value,
                                                    enable: false)),
                                            SizedBox(
                                                height: Responsive.height(
                                                    1, context)),
                                            InkWell(
                                                onTap: () async {
                                                  LocationResult? result =
                                                      await Utils
                                                          .showPlacePicker(
                                                              context);
                                                  if (result != null) {
                                                    controller
                                                            .destinationLocationController
                                                            .value
                                                            .text =
                                                        result.formattedAddress
                                                            .toString();
                                                    controller
                                                            .destinationLocationLAtLng
                                                            .value =
                                                        LocationLatLng(
                                                            latitude: result
                                                                .latLng!
                                                                .latitude,
                                                            longitude: result
                                                                .latLng!
                                                                .longitude);
                                                    controller
                                                        .calculateAmount();
                                                  }
                                                },
                                                child: TextFieldThem
                                                    .buildTextFiledWithPrefixIcon(
                                                        context,
                                                        prefix: SvgPicture
                                                            .asset(
                                                                "assets/icons/pin_drop.svg"),
                                                        hintText:
                                                            'Select destination'
                                                                .tr,
                                                        controller: controller
                                                            .destinationLocationController
                                                            .value,
                                                        enable: false)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 36),

                                  Visibility(
                                    visible: controller.bannerList.isNotEmpty,
                                    child: SizedBox(
                                        width: Get.width,
                                        height: 158,
                                        child:
                                            // PageView.builder(
                                            //     padEnds: true,
                                            //     itemCount:
                                            //         controller.bannerList.length,
                                            //     scrollDirection: Axis.horizontal,
                                            //     controller:
                                            //         controller.pageController,
                                            //     itemBuilder: (context, index) {
                                            //       BannerModel bannerModel =
                                            //           controller.bannerList[index];
                                            //       return

                                            CachedNetworkImage(
                                          imageUrl:
                                              controller.bannerList.first.image,
                                          // .toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                image: imageProvider,
                                              ),
                                            ),
                                          ),
                                          color: Colors.black.withOpacity(0.5),
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                        )
                                        // })
                                        ),
                                  ),
                                  const SizedBox(height: 36),
                                  controller.destinationLocationLAtLng.value
                                              .latitude !=
                                          null
                                      ? Obx(() => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Choose a ride',
                                                style: TextStyle(
                                                  color: Color(0xFF1D2939),
                                                  fontSize: 14,
                                                  fontFamily: 'Instrument Sans',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: -0.20,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              SizedBox(
                                                height: Responsive.height(
                                                    18, context),
                                                child: ListView.builder(
                                                  itemCount: controller
                                                      .serviceList.length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    ServiceModel serviceModel =
                                                        controller
                                                            .serviceList[index];

                                                    return Obx(
                                                      () => InkWell(
                                                        onTap: () {
                                                          controller
                                                                  .selectedType
                                                                  .value =
                                                              serviceModel;
                                                          controller
                                                              .calculateAmount();
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: Container(
                                                            width: Responsive
                                                                .width(28,
                                                                    context),
                                                            height: 70,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: controller.selectedType.value ==
                                                                            serviceModel
                                                                        ? const Color(
                                                                            0x33F8E71D)
                                                                        : Colors
                                                                            .white,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius
                                                                          .circular(
                                                                              3),
                                                                    )),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      8),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CachedNetworkImage(
                                                                    imageUrl: serviceModel
                                                                        .image
                                                                        .toString(),
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    width: 112,
                                                                    height:
                                                                        40.77,
                                                                    placeholder: (context,
                                                                            url) =>
                                                                        Constant
                                                                            .loader(),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Image.network(
                                                                            Constant.userPlaceHolder),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          12),
                                                                  Expanded(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(serviceModel.title.toString(),
                                                                                style: const TextStyle(
                                                                                  color: Color(0xFF1D2939),
                                                                                  fontSize: 14,
                                                                                  fontFamily: 'Instrument Sans',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  letterSpacing: -0.20,
                                                                                )),
                                                                            const SizedBox(height: 6),
                                                                            Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    "${controller.duration}",
                                                                                    style: const TextStyle(
                                                                                      color: Color(0xFF64748B),
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'Manrope',
                                                                                      fontWeight: FontWeight.w500,
                                                                                      letterSpacing: -0.20,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(width: 6),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      SvgPicture.asset("assets/icons/supervised_user_circle.svg"),
                                                                                      const SizedBox(width: 4),
                                                                                      Text(
                                                                                        serviceModel.title == 'Mile Premium' ? '2 seats' : '4 seats',
                                                                                        style: const TextStyle(
                                                                                          color: Color(0xFF64748B),
                                                                                          fontSize: 10,
                                                                                          fontFamily: 'Manrope',
                                                                                          fontWeight: FontWeight.w500,
                                                                                          letterSpacing: -0.20,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ])
                                                                          ],
                                                                        ),
                                                                        controller.selectedType.value ==
                                                                                serviceModel
                                                                            ? Text(Constant.amountShow(amount: controller.amount.value),
                                                                                textAlign: TextAlign.center,
                                                                                style: const TextStyle(
                                                                                  color: Color(0xFF1D2939),
                                                                                  fontSize: 16,
                                                                                  fontFamily: 'Manrope',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  height: 0.08,
                                                                                ))
                                                                            : const SizedBox()
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              // Obx(
                                              //   () => controller
                                              //                   .sourceLocationLAtLng
                                              //                   .value
                                              //                   .latitude !=
                                              //               null &&
                                              //           controller
                                              //                   .destinationLocationLAtLng
                                              //                   .value
                                              //                   .latitude !=
                                              //               null &&
                                              //           controller.amount.value
                                              //               .isNotEmpty
                                              //       ? Column(
                                              //           children: [
                                              //             const SizedBox(
                                              //               height: 10,
                                              //             ),
                                              //             Padding(
                                              //               padding:
                                              //                   const EdgeInsets
                                              //                           .symmetric(
                                              //                       horizontal:
                                              //                           10,
                                              //                       vertical:
                                              //                           5),
                                              //               child: Container(
                                              //                 width: Responsive
                                              //                     .width(100,
                                              //                         context),
                                              //                 decoration: const BoxDecoration(
                                              //                     color:
                                              //                         AppColors
                                              //                             .gray,
                                              //                     borderRadius:
                                              //                         BorderRadius.all(
                                              //                             Radius.circular(
                                              //                                 10))),
                                              //                 child: Padding(
                                              //                     padding: const EdgeInsets
                                              //                             .symmetric(
                                              //                         horizontal:
                                              //                             10,
                                              //                         vertical:
                                              //                             10),
                                              //                     child: Center(
                                              //                       child: controller.selectedType.value.offerRate ==
                                              //                               true
                                              //                           ? RichText(
                                              //                               text:
                                              //                                   TextSpan(
                                              //                                 text: 'Recommended Price is ${Constant.amountShow(amount: controller.amount.value)}. Approx time ${controller.duration}. Approx distance ${double.parse(controller.distance.value).toStringAsFixed(Constant.currencyModel!.decimalDigits!)} ${Constant.distanceType}'.tr,
                                              //                                 style: GoogleFonts.poppins(color: Colors.black),
                                              //                               ),
                                              //                             )
                                              //                           : RichText(
                                              //                               text:
                                              //                                   TextSpan(text: 'Your Price is ${Constant.amountShow(amount: controller.amount.value)}. Approx time ${controller.duration}. Approx distance ${double.parse(controller.distance.value).toStringAsFixed(Constant.currencyModel!.decimalDigits!)} ${Constant.distanceType}'.tr, style: GoogleFonts.poppins(color: Colors.black)),
                                              //                             ),
                                              //                     )),
                                              //               ),
                                              //             ),
                                              //           ],
                                              //         )
                                              //       : Container(),
                                              // ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              // Visibility(
                                              //   visible: controller.selectedType
                                              //           .value.offerRate ==
                                              //       true,
                                              //   child: TextFieldThem
                                              //       .buildTextFiledWithPrefixIcon(
                                              //     context,
                                              //     hintText:
                                              //         "Enter your offer rate"
                                              //             .tr,
                                              //     controller: controller
                                              //         .offerYourRateController
                                              //         .value,
                                              //     prefix: Padding(
                                              //       padding:
                                              //           const EdgeInsets.only(
                                              //               right: 10),
                                              //       child: Text(Constant
                                              //           .currencyModel!.symbol
                                              //           .toString()),
                                              //     ),
                                              //   ),
                                              // ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ))
                                      : SizedBox(
                                          height:
                                              Responsive.height(25, context),
                                        ),
                                  InkWell(
                                    onTap: () {
                                      paymentMethodDialog(context, controller);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x66CBD5E1),
                                            blurRadius: 0,
                                            offset: Offset(0, -1),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 12),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/ic_payment.svg',
                                              width: 26,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Text(
                                              controller.selectedPaymentMethod
                                                      .value.isNotEmpty
                                                  ? controller
                                                      .selectedPaymentMethod
                                                      .value
                                                  : "Select Payment type".tr,
                                              style: const TextStyle(
                                                color: Color(0xFF64748B),
                                                fontSize: 14,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: -0.20,
                                              ),
                                            )),
                                            const Icon(
                                                Icons.arrow_drop_down_outlined)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ButtonThem.buildButton(
                                    context,
                                    title: "Book Ride".tr,
                                    btnWidthRatio:
                                        Responsive.width(100, context),
                                    onPress: () async {
                                      if (controller.selectedPaymentMethod.value
                                          .isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please select Payment Method".tr);
                                      } else if (controller
                                          .sourceLocationController
                                          .value
                                          .text
                                          .isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please select source location".tr);
                                      } else if (controller
                                          .destinationLocationController
                                          .value
                                          .text
                                          .isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please select destination location"
                                                .tr);
                                      } else if (double.parse(
                                              controller.distance.value) <=
                                          2) {
                                        ShowToastDialog.showToast(
                                            "Please select more than two ${Constant.distanceType} location"
                                                .tr);
                                        // } else if (controller.selectedType.value
                                        //             .offerRate ==
                                        //         true &&
                                        //     controller.offerYourRateController
                                        //         .value.text.isEmpty) {
                                        //   ShowToastDialog.showToast(
                                        //       "Please Enter offer rate".tr);
                                      } else {
                                        ShowToastDialog.showToast("Start".tr);
                                        // ShowToastDialog.showLoader("Please wait");
                                        OrderModel orderModel = OrderModel();
                                        orderModel.id = Constant.getUuid();
                                        orderModel.userId =
                                            FireStoreUtils.getCurrentUid();
                                        orderModel.sourceLocationName =
                                            controller.sourceLocationController
                                                .value.text;
                                        orderModel.destinationLocationName =
                                            controller
                                                .destinationLocationController
                                                .value
                                                .text;
                                        orderModel.sourceLocationLAtLng =
                                            controller
                                                .sourceLocationLAtLng.value;
                                        orderModel.destinationLocationLAtLng =
                                            controller.destinationLocationLAtLng
                                                .value;
                                        orderModel.distance =
                                            controller.distance.value;
                                        orderModel.distanceType =
                                            Constant.distanceType;
                                        print(
                                            "----->${controller.amount.value}");
                                        orderModel.offerRate =
                                            // controller
                                            //             .selectedType
                                            //             .value
                                            //             .offerRate ==
                                            //         true
                                            //     ? controller.offerYourRateController
                                            //         .value.text
                                            //     :
                                            // ShowToastDialog.showToast(
                                            //     "Ride Placed ".tr);
                                            controller.amount.value;
                                        orderModel.serviceId =
                                            controller.selectedType.value.id;
                                        GeoFirePoint position = GeoFlutterFire()
                                            .point(
                                                latitude: controller
                                                    .sourceLocationLAtLng
                                                    .value
                                                    .latitude!,
                                                longitude: controller
                                                    .sourceLocationLAtLng
                                                    .value
                                                    .longitude!);

                                        orderModel.position = Positions(
                                            geoPoint: position.geoPoint,
                                            geohash: position.hash);
                                        orderModel.createdDate =
                                            Timestamp.now();
                                        orderModel.status = Constant.ridePlaced;
                                        orderModel.paymentType = controller
                                            .selectedPaymentMethod.value;
                                        orderModel.paymentStatus = false;
                                        orderModel.service =
                                            controller.selectedType.value;
                                        orderModel.adminCommission =
                                            Constant.adminCommission;
                                        orderModel.otp =
                                            Constant.getReferralCode();
                                        orderModel.taxList = Constant.taxList;

                                        // FireStoreUtils().startStream();
                                        FireStoreUtils()
                                            .sendOrderData(orderModel)
                                            .listen((event) {
                                          event.forEach((element) async {
                                            if (element.fcmToken != null) {
                                              Map<String, dynamic> playLoad =
                                                  <String, dynamic>{
                                                "type": "city_order",
                                                "orderId": orderModel.id
                                              };
                                              await SendNotification
                                                  .sendOneNotification(
                                                      token: element
                                                          .fcmToken
                                                          .toString(),
                                                      title:
                                                          'New Ride Available'
                                                              .tr,
                                                      body:
                                                          'A customer has placed an ride near your location.'
                                                              .tr,
                                                      payload: playLoad);
                                            }
                                          });
                                          FireStoreUtils().closeStream();
                                        });
                                        await FireStoreUtils.setOrder(
                                                orderModel)
                                            .then((value) {
                                          ShowToastDialog.showToast(
                                              "Ride Placed successfully".tr);
                                          controller.dashboardController
                                              .selectedDrawerIndex(1);
                                          ShowToastDialog.closeLoader();
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }

  paymentMethodDialog(BuildContext context, HomeController controller) {
    return showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context1) {
          final themeChange = Provider.of<DarkThemeProvider>(context1);

          return FractionallySizedBox(
            heightFactor: 0.9,
            child: StatefulBuilder(builder: (context1, setState) {
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(Icons.arrow_back_ios)),
                            const Expanded(
                                child: Center(
                                    child: Text(
                              "Payment",
                              style: TextStyle(
                                color: Color(0xFF1D2939),
                                fontSize: 20,
                                fontFamily: 'Instrument Sans',
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.20,
                              ),
                            ))),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Payment methods',
                          style: TextStyle(
                            color: Color(0xFF1D2939),
                            fontSize: 14,
                            fontFamily: 'Instrument Sans',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.20,
                          ),
                        ).paddingOnly(left: 16),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Visibility(
                                visible: controller
                                        .paymentModel.value.cash!.enable ==
                                    true,
                                child: Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.selectedPaymentMethod.value =
                                          controller
                                              .paymentModel.value.cash!.name
                                              .toString();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/ic_cash.svg',
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              controller
                                                  .paymentModel.value.cash!.name
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color(0xFF64748B),
                                                fontSize: 14,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: -0.20,
                                              ),
                                            ),
                                          ),
                                          Radio(
                                            value: controller
                                                .paymentModel.value.cash!.name
                                                .toString(),
                                            groupValue: controller
                                                .selectedPaymentMethod.value,
                                            activeColor:
                                                const Color(0xFF0A0A0A),
                                            onChanged: (value) {
                                              controller.selectedPaymentMethod
                                                      .value =
                                                  controller.paymentModel.value
                                                      .cash!.name
                                                      .toString();
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                  thickness: 1, color: Color(0xFFD9D9D9)),
                              Visibility(
                                visible: controller
                                        .paymentModel.value.wallet!.enable ==
                                    true,
                                child: Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.selectedPaymentMethod.value =
                                          controller
                                              .paymentModel.value.wallet!.name
                                              .toString();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/ic_wallet.svg',
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              controller.paymentModel.value
                                                  .wallet!.name
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color(0xFF64748B),
                                                fontSize: 14,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: -0.20,
                                              ),
                                            ),
                                          ),
                                          Radio(
                                            value: controller
                                                .paymentModel.value.wallet!.name
                                                .toString(),
                                            groupValue: controller
                                                .selectedPaymentMethod.value,
                                            activeColor:
                                                const Color(0xFF0A0A0A),
                                            onChanged: (value) {
                                              controller.selectedPaymentMethod
                                                      .value =
                                                  controller.paymentModel.value
                                                      .wallet!.name
                                                      .toString();
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                  thickness: 1, color: Color(0xFFD9D9D9)),
                              Visibility(
                                visible: controller
                                        .paymentModel.value.payStack!.enable ==
                                    true,
                                child: InkWell(
                                  onTap: () {
                                    controller.selectedPaymentMethod.value =
                                        controller
                                            .paymentModel.value.payStack!.name
                                            .toString();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              'assets/images/paystack.png'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            controller.paymentModel.value
                                                .payStack!.name
                                                .toString(),
                                            style: const TextStyle(
                                              color: Color(0xFF64748B),
                                              fontSize: 14,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.20,
                                            ),
                                          ),
                                        ),
                                        Radio(
                                          value: controller
                                              .paymentModel.value.payStack!.name
                                              .toString(),
                                          groupValue: controller
                                              .selectedPaymentMethod.value,
                                          activeColor: const Color(0xFF0A0A0A),
                                          onChanged: (value) {
                                            controller.selectedPaymentMethod
                                                    .value =
                                                controller.paymentModel.value
                                                    .payStack!.name
                                                    .toString();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                  thickness: 1, color: Color(0xFFD9D9D9)),
                              Visibility(
                                visible: controller.paymentModel.value
                                        .flutterWave!.enable ==
                                    true,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.selectedPaymentMethod.value =
                                            controller.paymentModel.value
                                                .flutterWave!.name
                                                .toString();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
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
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                controller.paymentModel.value
                                                    .flutterWave!.name
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Color(0xFF64748B),
                                                  fontSize: 14,
                                                  fontFamily: 'Manrope',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: -0.20,
                                                ),
                                              ),
                                            ),
                                            Radio(
                                              value: controller.paymentModel
                                                  .value.flutterWave!.name
                                                  .toString(),
                                              groupValue: controller
                                                  .selectedPaymentMethod.value,
                                              activeColor:
                                                  const Color(0xFF0A0A0A),
                                              onChanged: (value) {
                                                controller.selectedPaymentMethod
                                                        .value =
                                                    controller.paymentModel
                                                        .value.flutterWave!.name
                                                        .toString();
                                              },
                                            )
                                          ],
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
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonThem.buildButton(
                        context,
                        title: "Pay",
                        onPress: () async {
                          Get.back();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}
