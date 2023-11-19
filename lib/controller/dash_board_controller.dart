import 'dart:developer';

import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/model/user_model.dart';
import 'package:customer/ui/auth_screen/login_screen.dart';
import 'package:customer/ui/chat_screen/inbox_screen.dart';
import 'package:customer/ui/contact_us/contact_us_screen.dart';
import 'package:customer/ui/faq/faq_screen.dart';
import 'package:customer/ui/home_screens/home_screen.dart';
import 'package:customer/ui/interCity/interCity_screen.dart';
import 'package:customer/ui/intercityOrders/intercity_order_screen.dart';
import 'package:customer/ui/orders/order_screen.dart';
import 'package:customer/ui/profile_screen/profile_screen.dart';
import 'package:customer/ui/referral_screen/referral_screen.dart';
import 'package:customer/ui/settings_screen/setting_screen.dart';
import 'package:customer/ui/wallet/wallet_screen.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/utils/notification_service.dart';
import 'package:customer/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import '../model/banner_model.dart';
import '../model/service_model.dart';

class DashBoardController extends GetxController {
  final drawerItems = [
    DrawerItem('Book a ride'.tr, "assets/icons/ic_city.svg"),
    // DrawerItem('OutStation'.tr, "assets/icons/ic_intercity.svg"),
    DrawerItem('Rides'.tr, "assets/icons/ic_order.svg"),
    // DrawerItem('OutStation Rides'.tr, "assets/icons/ic_order.svg"),
    DrawerItem('Wallet'.tr, "assets/icons/ic_wallet.svg"),

    DrawerItem('Inbox'.tr, "assets/icons/ic_inbox.svg"),
    DrawerItem('Emergency / SOS'.tr, "assets/icons/ic_sos.svg"),
    DrawerItem('Refer a friend'.tr, "assets/icons/ic_referral.svg"),
    // DrawerItem('Profile'.tr, "assets/icons/ic_profile.svg"),
    //
    DrawerItem('FAQs'.tr, "assets/icons/ic_faq.svg"),
    DrawerItem('Settings'.tr, "assets/icons/ic_settings.svg"),
    DrawerItem('Log out'.tr, "assets/icons/ic_logout.svg"),
  ];

  RxString currentLocation = "".obs;
  RxList serviceList = <ServiceModel>[].obs;
  RxList bannerList = <BannerModel>[].obs;
  Rx<ServiceModel> selectedType = ServiceModel().obs;

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const HomeScreen();

      case 1:
        return const OrderScreen();
      case 2:
        return const WalletScreen();
      case 3:
        return const InboxScreen();
      case 4:
        return const ContactUsScreen();
      case 5:
        return const ReferralScreen();
      case 6:
        return const FaqScreen();
      case 7:
        return const SettingScreen();
      case 8:
        return const FaqScreen();
      default:
        return const Text("Error");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getServiceType();
    getLocation();
    super.onInit();
  }

  RxBool isLoading = true.obs;

  getServiceType() async {
    await FireStoreUtils.getService().then((value) {
      serviceList.value = value;
      if (serviceList.isNotEmpty) {
        selectedType.value = serviceList.first;
      }
    });

    await FireStoreUtils.getBanner().then((value) {
      bannerList.value = value;
    });

    isLoading.value = false;

    await Utils.getCurrentLocation().then((value) {
      Constant.currentLocation = value;
    });
    await placemarkFromCoordinates(Constant.currentLocation!.latitude,
            Constant.currentLocation!.longitude)
        .then((value) {
      Placemark placeMark = value[0];

      currentLocation.value =
          "${placeMark.name}, ${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.administrativeArea}";
    }).catchError((error) {
      debugPrint("------>${error.toString()}");
    });
  }

  getLocation() async {
    Constant.currentLocation = await Utils.getCurrentLocation();
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        Constant.currentLocation!.latitude,
        Constant.currentLocation!.longitude);
    Constant.country = placeMarks.first.country;

    await FireStoreUtils().getTaxList().then((value) {
      if (value != null) {
        Constant.taxList = value;
      }
    });

    isLoading.value = false;

    String token = await NotificationService.getToken();
    await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid())
        .then((value) {
      UserModel userModel = value!;
      userModel.fcmToken = token;
      FireStoreUtils.updateUser(userModel);
    });
    log("------>${placeMarks.first.country}");
  }

  RxInt selectedDrawerIndex = 0.obs;

  onSelectItem(int index) async {
    if (index == 11) {
      await FirebaseAuth.instance.signOut();
      Get.offAll(const LoginScreen());
    } else {
      selectedDrawerIndex.value = index;
    }
    Get.back();
  }

  Rx<DateTime> currentBackPressTime = DateTime.now().obs;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime.value) >
        const Duration(seconds: 2)) {
      currentBackPressTime.value = now;
      ShowToastDialog.showToast("Double press to exit",
          position: EasyLoadingToastPosition.center);
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class DrawerItem {
  String title;
  String icon;

  DrawerItem(this.title, this.icon);
}
