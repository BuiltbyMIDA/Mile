import 'dart:convert';

import 'package:driver/model/on_boarding_model.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  var selectedPageIndex = 0.obs;

  bool get isLastPage => selectedPageIndex.value == onBoardingList.length - 1;
  var pageController = PageController();

  @override
  void onInit() {
    // TODO: implement onInit
    getOnBoardingData();
    super.onInit();
  }

  RxBool isLoading = true.obs;
  static const String onBoardingListJson = '''
    [
      {"image": "assets/images/onboarding_car1.png", "description": "Our commitment to safety ensures your peace of mind, while our competitive pricing keeps your wallet happy. Your journey with us is not only secure but also budget-friendly.", "id": "1", "title": "Make income riding"},
      {"image": "assets/images/onboarding_3.png", "description": "Turn your daily commutes into a rewarding experience. Every mile you travel with Mile Cab-Hailing earns you Mile Tokens, which can be redeemed for exciting rewards. It's time to get more out of your rides – both in terms of experience and benefits", "id": "2", "title": "Earn as you ride!"}
    ]
  ''';

  RxList<OnBoardingModel> onBoardingList = <OnBoardingModel>[].obs;

  getOnBoardingData() {
    List<dynamic> jsonList = json.decode(onBoardingListJson);
    onBoardingList.value =
        jsonList.map((json) => OnBoardingModel.fromJson(json)).toList();
    isLoading.value = false;
    update();
  }
}
