import 'package:driver/controller/dash_board_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveOrderController extends GetxController {
  DashBoardController dashboardController = Get.put(DashBoardController());
  Rx<TextEditingController> otpController = TextEditingController().obs;
}
