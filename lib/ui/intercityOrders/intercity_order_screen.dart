import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/constant/collection_name.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/model/driver_user_model.dart';
import 'package:customer/model/intercity_order_model.dart';
import 'package:customer/model/sos_model.dart';
import 'package:customer/model/user_model.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/ui/chat_screen/chat_screen.dart';
import 'package:customer/ui/intercityOrders/intercity_accept_order_screen.dart';
import 'package:customer/ui/intercityOrders/intercity_complete_order_screen.dart';
import 'package:customer/ui/intercityOrders/intercity_payment_order_screen.dart';
import 'package:customer/ui/orders/live_tracking_screen.dart';
import 'package:customer/ui/review/review_screen.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/utils/utils.dart';
import 'package:customer/widget/driver_view.dart';
import 'package:customer/widget/location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InterCityOrderScreen extends StatelessWidget {
  const InterCityOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor:  AppColors.primary,
      body: Column(
        children: [
          Container(
            height: Responsive.width(8, context),
            width: Responsive.width(100, context),
            color: AppColors.primary,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          indicatorColor:AppColors.darkModePrimary ,
                          tabs: [
                            Tab(
                                child: Text(
                              "Active Rides".tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(),
                            )),
                            Tab(
                                child: Text(
                              "Completed Rides".tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(),
                            )),
                            Tab(
                                child: Text(
                              "Canceled Rides".tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(),
                            )),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection(CollectionName.ordersIntercity)
                                    .where("userId", isEqualTo: FireStoreUtils.getCurrentUid())
                                    .where("status", whereIn: [Constant.ridePlaced, Constant.rideInProgress, Constant.rideComplete, Constant.rideActive])
                                    .where("paymentStatus", isEqualTo: false)
                                    .orderBy("createdDate", descending: true)
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return  Center(child: Text('Something went wrong'.tr));
                                  }
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Constant.loader();
                                  }
                                  return snapshot.data!.docs.isEmpty
                                      ?  Center(
                                          child: Text("No active rides Found".tr),
                                        )
                                      : ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            InterCityOrderModel orderModel = InterCityOrderModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                                            return InkWell(
                                              onTap: () {

                                                if (Constant.mapType == "inappmap") {
                                                  if (orderModel.status == Constant.rideActive || orderModel.status == Constant.rideInProgress) {
                                                    Get.to(const LiveTrackingScreen(), arguments: {
                                                      "interCityOrderModel": orderModel,
                                                      "type": "interCityOrderModel",
                                                    });
                                                  }
                                                } else {
                                                  Utils.redirectMap(
                                                      latitude: orderModel.destinationLocationLAtLng!.latitude!,
                                                      longLatitude: orderModel.destinationLocationLAtLng!.longitude!,
                                                      name: orderModel.destinationLocationName.toString());
                                                }


                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.containerBackground,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                    border: Border.all(color:  AppColors.containerBorder, width: 0.5),
                                                    boxShadow:  [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.10),
                                                              blurRadius: 5,
                                                              offset: const Offset(0, 4), // changes position of shadow
                                                            ),
                                                          ],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        orderModel.status == Constant.rideComplete || orderModel.status == Constant.rideActive
                                                            ? const SizedBox()
                                                            : Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      orderModel.status.toString(),
                                                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        Constant.currencyModel!.symbol.toString(),
                                                                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 5.0,
                                                                      ),
                                                                      Text(
                                                                        orderModel.status == Constant.ridePlaced
                                                                            ? double.parse(orderModel.offerRate.toString()).toStringAsFixed(Constant.currencyModel!.decimalDigits!)
                                                                            : double.parse(orderModel.finalRate.toString()).toStringAsFixed(Constant.currencyModel!.decimalDigits!),
                                                                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                        orderModel.status == Constant.rideComplete || orderModel.status == Constant.rideActive
                                                            ? Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 10),
                                                                child: DriverView(
                                                                    driverId: orderModel.driverId.toString(),
                                                                    amount: orderModel.status == Constant.ridePlaced
                                                                        ? double.parse(orderModel.offerRate.toString()).toStringAsFixed(Constant.currencyModel!.decimalDigits!)
                                                                        : double.parse(orderModel.finalRate.toString()).toStringAsFixed(Constant.currencyModel!.decimalDigits!)),
                                                              )
                                                            : Container(),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        LocationView(
                                                          sourceLocation: orderModel.sourceLocationName.toString(),
                                                          destinationLocation: orderModel.destinationLocationName.toString(),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 14),
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                                color:  AppColors.gray, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                            child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Expanded(
                                                                      child: orderModel.status == Constant.rideInProgress ||
                                                                              orderModel.status == Constant.ridePlaced ||
                                                                              orderModel.status == Constant.rideComplete
                                                                          ? Text(orderModel.status.toString())
                                                                          : Row(
                                                                              children: [
                                                                                Text("OTP".tr, style: GoogleFonts.poppins()),
                                                                                Text(" : ${orderModel.otp}", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
                                                                              ],
                                                                            ),
                                                                    ),
                                                                    Text(Constant().formatTimestamp(orderModel.createdDate), style: GoogleFonts.poppins(fontSize: 12)),
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: orderModel.status == Constant.ridePlaced,
                                                          child: ButtonThem.buildButton(
                                                            context,
                                                            title: "View bids (${orderModel.acceptedDriverId != null ? orderModel.acceptedDriverId!.length.toString() : "0"})".tr,
                                                            btnHeight: 44,
                                                            onPress: () async {
                                                              Get.to(const InterCityAcceptOrderScreen(), arguments: {
                                                                "orderModel": orderModel,
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        Visibility(
                                                            visible: orderModel.status != Constant.ridePlaced,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: InkWell(
                                                                    onTap: () async {
                                                                      UserModel? customer = await FireStoreUtils.getUserProfile(orderModel.userId.toString());
                                                                      DriverUserModel? driver = await FireStoreUtils.getDriver(orderModel.driverId.toString());

                                                                      Get.to(ChatScreens(
                                                                        driverId: driver!.id,
                                                                        customerId: customer!.id,
                                                                        customerName: customer.fullName,
                                                                        customerProfileImage: customer.profilePic,
                                                                        driverName: driver.fullName,
                                                                        driverProfileImage: driver.profilePic,
                                                                        orderId: orderModel.id,
                                                                        token: driver.fcmToken,
                                                                      ));
                                                                    },
                                                                    child: Container(
                                                                      height: 44,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors.primary, borderRadius: BorderRadius.circular(5)),
                                                                      child: const Icon(Icons.chat, color:  Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: InkWell(
                                                                    onTap: () async {
                                                                      DriverUserModel? driver = await FireStoreUtils.getDriver(orderModel.driverId.toString());
                                                                      Constant.makePhoneCall("${driver!.countryCode}${driver.phoneNumber}");
                                                                    },
                                                                    child: Container(
                                                                      height: 44,
                                                                      decoration: BoxDecoration(
                                                                          color:  AppColors.primary, borderRadius: BorderRadius.circular(5)),
                                                                      child: const Icon(Icons.call, color: Colors.white),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Visibility(
                                                            visible: orderModel.status == Constant.rideInProgress,
                                                            child: ButtonThem.buildButton(
                                                              context,
                                                              title: "SOS".tr,
                                                              btnHeight: 44,
                                                              onPress: () async {
                                                                await FireStoreUtils.getSOS(orderModel.id.toString()).then((value) {
                                                                  if (value != null) {
                                                                    ShowToastDialog.showToast("Your request is ${value.status}", position: EasyLoadingToastPosition.bottom);
                                                                  } else {
                                                                    SosModel sosModel = SosModel();
                                                                    sosModel.id = Constant.getUuid();
                                                                    sosModel.orderId = orderModel.id;
                                                                    sosModel.status = "Initiated";
                                                                    sosModel.orderType = "intercity";
                                                                    FireStoreUtils.setSOS(sosModel);
                                                                  }
                                                                });
                                                              },
                                                            )),
                                                        Visibility(
                                                          visible: orderModel.status == Constant.rideComplete && (orderModel.paymentStatus == null || orderModel.paymentStatus == false),
                                                          child: ButtonThem.buildButton(
                                                            context,
                                                            title: "Pay".tr,
                                                            btnHeight: 44,
                                                            onPress: () async {
                                                              Get.to(const InterCityPaymentOrderScreen(), arguments: {
                                                                "orderModel": orderModel,
                                                              });
                                                              // paymentMethodDialog(context, controller, orderModel);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                },
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection(CollectionName.ordersIntercity)
                                    .where("userId", isEqualTo: FireStoreUtils.getCurrentUid())
                                    .where("status", isEqualTo: Constant.rideComplete)
                                    .where("paymentStatus", isEqualTo: true)
                                    .orderBy("createdDate", descending: true)
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return  Center(child: Text('Something went wrong'.tr));
                                  }
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Constant.loader();
                                  }
                                  return snapshot.data!.docs.isEmpty
                                      ?  Center(
                                          child: Text("No completed rides Found".tr),
                                        )
                                      : ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            InterCityOrderModel orderModel = InterCityOrderModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                                            return Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.containerBackground,
                                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                  border: Border.all(color:  AppColors.containerBorder, width: 0.5),
                                                  boxShadow:  [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.10),
                                                            blurRadius: 5,
                                                            offset: const Offset(0, 4), // changes position of shadow
                                                          ),
                                                        ],
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      if (orderModel.status == Constant.rideComplete && orderModel.paymentStatus == true) {
                                                        Get.to(const IntercityCompleteOrderScreen(), arguments: {
                                                          "orderModel": orderModel,
                                                        });
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          DriverView(
                                                              driverId: orderModel.driverId.toString(),
                                                              amount: orderModel.status == Constant.ridePlaced
                                                                  ? double.parse(orderModel.offerRate.toString()).toStringAsFixed(Constant.currencyModel!.decimalDigits!)
                                                                  : double.parse(orderModel.finalRate.toString()).toStringAsFixed(Constant.currencyModel!.decimalDigits!)),
                                                          const Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 4),
                                                            child: Divider(
                                                              thickness: 1,
                                                            ),
                                                          ),
                                                          LocationView(
                                                            sourceLocation: orderModel.sourceLocationName.toString(),
                                                            destinationLocation: orderModel.destinationLocationName.toString(),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            decoration: const BoxDecoration(
                                                                color:AppColors.gray, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                            child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                child: Center(
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(child: Text(orderModel.status.toString(), style: GoogleFonts.poppins(fontWeight: FontWeight.w600))),
                                                                      Text(Constant().formatTimestamp(orderModel.createdDate), style: GoogleFonts.poppins()),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Visibility(
                                                            visible: orderModel.status == Constant.rideComplete,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: ButtonThem.buildButton(
                                                                    context,
                                                                    title: "Review".tr,
                                                                    btnHeight: 44,
                                                                    onPress: () async {
                                                                      Get.to(const ReviewScreen(), arguments: {
                                                                        "type": "interCityOrderModel",
                                                                        "interCityOrderModel": orderModel,
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            );
                                          });
                                },
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection(CollectionName.ordersIntercity)
                                    .where("userId", isEqualTo: FireStoreUtils.getCurrentUid())
                                    .where("status", isEqualTo: Constant.rideCanceled)
                                    .orderBy("createdDate", descending: true)
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return  Center(child: Text('Something went wrong'.tr));
                                  }
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Constant.loader();
                                  }
                                  return snapshot.data!.docs.isEmpty
                                      ?  Center(
                                    child: Text("No completed rides Found".tr),
                                  )
                                      : ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        InterCityOrderModel orderModel = InterCityOrderModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:  AppColors.containerBackground,
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              border: Border.all(color: AppColors.containerBorder, width: 0.5),
                                              boxShadow:  [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.10),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 4), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  orderModel.status == Constant.rideComplete || orderModel.status == Constant.rideActive
                                                      ? const SizedBox()
                                                      : Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          orderModel.status.toString(),
                                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            Constant.currencyModel!.symbol.toString(),
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text( double.parse(orderModel.offerRate.toString()).toStringAsFixed(Constant.currencyModel!.decimalDigits!),
                                                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  LocationView(
                                                    sourceLocation: orderModel.sourceLocationName.toString(),
                                                    destinationLocation: orderModel.destinationLocationName.toString(),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color:  AppColors.gray, borderRadius: BorderRadius.all(Radius.circular(10))),
                                                      child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Expanded(
                                                                  child:  Text(orderModel.status.toString())
                                                              ),
                                                              Text(Constant().formatTimestamp(orderModel.createdDate), style: GoogleFonts.poppins(fontSize: 12)),
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
