import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/constant/show_toast_dialog.dart';
import 'package:driver/controller/vehicle_information_controller.dart';
import 'package:driver/model/driver_user_model.dart';
import 'package:driver/model/service_model.dart';
import 'package:driver/model/vehicle_type_model.dart';
import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/button_them.dart';
import 'package:driver/themes/responsive.dart';
import 'package:driver/themes/text_field_them.dart';
import 'package:driver/utils/DarkThemeProvider.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dashboard_screen.dart';

class VehicleInformationScreen extends StatelessWidget {
  const VehicleInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetX<VehicleInformationController>(
      init: VehicleInformationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: Responsive.height(3, context),
                width: Responsive.width(100, context),
              ),
              Expanded(
                child: Container(
                  child: controller.isLoading.value
                      ? Constant.loader(context)
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: Responsive.height(18, context),
                                  child: ListView.builder(
                                    itemCount: controller.serviceList.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      ServiceModel serviceModel =
                                          controller.serviceList[index];
                                      return Obx(
                                        () => InkWell(
                                          onTap: () async {
                                            if (controller.driverModel.value
                                                    .serviceId ==
                                                null) {
                                              controller.selectedServiceId
                                                  .value = serviceModel.id;
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              width:
                                                  Responsive.width(28, context),
                                              decoration: BoxDecoration(
                                                  color: controller
                                                              .selectedServiceId
                                                              .value ==
                                                          serviceModel.id
                                                      ? AppColors.primary
                                                      : controller.colors[
                                                          index %
                                                              controller.colors
                                                                  .length],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(20),
                                                  )),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: AppColors
                                                                .background,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  20),
                                                            )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl: serviceModel
                                                            .image
                                                            .toString(),
                                                        fit: BoxFit.contain,
                                                        height:
                                                            Responsive.height(
                                                                8, context),
                                                        width: Responsive.width(
                                                            18, context),
                                                        placeholder:
                                                            (context, url) =>
                                                                Constant.loader(
                                                                    context),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.network(
                                                                'https://firebasestorage.googleapis.com/v0/b/mile-e1045.appspot.com/o/placeholderImages%2Fuser-placeholder.jpeg?alt=media&token=34a73d67-ba1d-4fe4-a29f-271d3e3ca115'),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      serviceModel.title
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.manrope(
                                                              color: controller
                                                                          .selectedServiceId
                                                                          .value! ==
                                                                      serviceModel
                                                                          .id
                                                                  ? themeChange
                                                                          .getThem()
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white
                                                                  : themeChange
                                                                          .getThem()
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Please fill in your vehicle information',
                                  style: TextStyle(
                                    color: Color(0xFF1D2939),
                                    fontSize: 14,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFieldThem.buildTextFiled(context,
                                    hintText: 'Vehicle Number'.tr,
                                    controller: controller
                                        .vehicleNumberController.value),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Constant.selectDate(context)
                                        .then((value) {
                                      if (value != null) {
                                        controller.selectedDate.value = value;
                                        controller.registrationDateController
                                                .value.text =
                                            DateFormat("dd-MM-yyyy")
                                                .format(value);
                                      }
                                    });
                                  },
                                  child: TextFieldThem
                                      .buildTextFiledWithSuffixIcon(context,
                                          hintText: 'Registration Date'.tr,
                                          controller: controller
                                              .registrationDateController.value,
                                          enable: false,
                                          suffixIcon:
                                              const Icon(Icons.calendar_month)),
                                  // TextFieldThem.buildTextFiled(context,
                                  //     hintText: 'Registration Date'.tr,
                                  //     controller: controller
                                  //         .registrationDateController.value,
                                  //     enable: false),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField<VehicleTypeModel>(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.textField,
                                      contentPadding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                    value:
                                        controller.selectedVehicle.value.id ==
                                                null
                                            ? null
                                            : controller.selectedVehicle.value,
                                    onChanged: (value) {
                                      controller.selectedVehicle.value = value!;
                                    },
                                    hint: Text("Select vehicle type".tr),
                                    items: controller.vehicleList.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item.name.toString()),
                                      );
                                    }).toList()),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:  AppColors.textField,
                                      contentPadding: EdgeInsets.only(
                                          left: 10, right: 10),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                    value:
                                        controller.selectedColor.value.isEmpty
                                            ? null
                                            : controller.selectedColor.value,
                                    onChanged: (value) {
                                      controller.selectedColor.value = value!;
                                    },
                                    hint: Text("Select vehicle color".tr),
                                    items: controller.carColorList.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item.toString()),
                                      );
                                    }).toList()),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.textField,
                                      contentPadding: EdgeInsets.only(
                                          left: 10, right: 10),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            color: AppColors.textFieldBorder,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                    value: controller
                                            .seatsController.value.text.isEmpty
                                        ? null
                                        : controller.seatsController.value.text,
                                    onChanged: (value) {
                                      controller.seatsController.value.text =
                                          value!;
                                    },
                                    hint: Text("How Many Seats".tr),
                                    items: controller.sheetList.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item.toString()),
                                      );
                                    }).toList()),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 28),
                                  child: Text(
                                    'Set your rules'.tr,
                                    style: const TextStyle(
                                      color: Color(0xFF1D2939),
                                      fontSize: 14,
                                      fontFamily: 'Instrument Sans',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.20,
                                    ),
                                  ),
                                ),
                                ListBody(
                                  children: controller.driverRulesList
                                      .map((item) => CheckboxListTile(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                            checkColor: Colors.white,
                                            value: controller
                                                        .selectedDriverRulesList
                                                        .indexWhere((element) =>
                                                            element.id ==
                                                            item.id) ==
                                                    -1
                                                ? false
                                                : true,
                                            title: Text(
                                              item.name.toString(),
                                              style: const TextStyle(
                                                color: Color(0xFF1D2939),
                                                fontSize: 14,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.14,
                                              ),
                                            ),
                                            onChanged: (value) {
                                              if (value == true) {
                                                controller
                                                    .selectedDriverRulesList
                                                    .add(item);
                                              } else {
                                                controller
                                                    .selectedDriverRulesList
                                                    .removeAt(controller
                                                        .selectedDriverRulesList
                                                        .indexWhere((element) =>
                                                            element.id ==
                                                            item.id));
                                              }
                                            },
                                          ))
                                      .toList(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: ButtonThem.buildButton(
                                    context,
                                    title: "Save".tr,
                                    onPress: () async {
                                      ShowToastDialog.showLoader(
                                          "Please wait".tr);

                                      if (controller
                                          .selectedServiceId.value!.isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please select service".tr);
                                      } else if (controller
                                          .vehicleNumberController
                                          .value
                                          .text
                                          .isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please enter Vehicle number".tr);
                                      } else if (controller
                                          .registrationDateController
                                          .value
                                          .text
                                          .isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please select registration date"
                                                .tr);
                                      } else if (controller
                                                  .selectedVehicle.value.id ==
                                              null ||
                                          controller.selectedVehicle.value.id!
                                              .isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please enter Vehicle type".tr);
                                      } else if (controller
                                          .selectedColor.value.isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please enter Vehicle color".tr);
                                      } else if (controller
                                          .seatsController.value.text.isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please enter seats".tr);
                                      } else {
                                        if (controller
                                                .driverModel.value.serviceId ==
                                            null) {
                                          controller
                                                  .driverModel.value.serviceId =
                                              controller
                                                  .selectedServiceId.value;
                                          await FireStoreUtils.updateDriverUser(
                                              controller.driverModel.value);
                                        }

                                        controller
                                                .driverModel.value.vehicleInformation =
                                            VehicleInformation(
                                                registrationDate:
                                                    Timestamp
                                                        .fromDate(
                                                            controller
                                                                .selectedDate
                                                                .value!),
                                                vehicleColor:
                                                    controller
                                                        .selectedColor.value,
                                                vehicleNumber:
                                                    controller
                                                        .vehicleNumberController
                                                        .value
                                                        .text,
                                                vehicleType: controller
                                                    .selectedVehicle.value.name,
                                                vehicleTypeId: controller
                                                    .selectedVehicle.value.id,
                                                seats: controller
                                                    .seatsController.value.text,
                                                driverRules: controller.selectedDriverRulesList);

                                        print(controller.driverModel.value
                                            .vehicleInformation!
                                            .toJson());
                                        await FireStoreUtils.updateDriverUser(
                                                controller.driverModel.value)
                                            .then((value) {
                                          ShowToastDialog.closeLoader();
                                          if (value == true) {
                                            ShowToastDialog.showToast(
                                                "Information update successfully"
                                                    .tr);

                                            Get.offAll(const DashBoardScreen());
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                    "You can not change once you select one service type if you want to change please contact to administrator "
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                                  
                                                  fontFamily: 'Manrope',
                                                
                                               
                                                ),),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
