import 'package:country_code_picker/country_code_picker.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/text_field_them.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset("assets/images/login_image.png", width: Responsive.width(100, context)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 53),
                      child: Text(
                        "Sign up".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Instrument Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'A journey of a thousand MILE, begins with one click.'
                            .tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Full name'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFieldThem.buildTextFiled(context,
                        hintText: 'Enter full name'.tr,
                        controller: TextEditingController()),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Email '.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFieldThem.buildTextFiled(context,
                        hintText: 'Enter email address'.tr,
                        controller: TextEditingController(),
                        enable: true),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Phone number'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : 'Required',
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.sentences,
                        controller: TextEditingController(),
                        textAlign: TextAlign.start,
                        enabled: true,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: AppColors.textField,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                            prefixIcon: CountryCodePicker(
                              onChanged: (value) {},
                              dialogBackgroundColor: AppColors.background,
                              // initialSelection: 'NGN',
                              comparator: (a, b) =>
                                  b.name!.compareTo(a.name.toString()),
                              flagDecoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                              ),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: AppColors.textFieldBorder, width: 1),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: AppColors.textFieldBorder, width: 1),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: AppColors.textFieldBorder, width: 1),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: AppColors.textFieldBorder, width: 1),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: AppColors.textFieldBorder, width: 1),
                            ),
                            hintText: "Phone number".tr)),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Referral code (optional)'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFieldThem.buildTextFiled(context,
                        hintText: 'Enter referral code'.tr,
                        controller: TextEditingController(),
                        enable: true),
                    const SizedBox(
                      height: 60,
                    ),
                    ButtonThem.buildButton(
                      context,
                      title: 'Signup'.tr,
                      onPress: () async {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
