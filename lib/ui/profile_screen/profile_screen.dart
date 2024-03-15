import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/themes/text_field_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Account Settings',
              style: TextStyle(
                color: Color(0xFF1D2939),
                fontSize: 20,
                fontFamily: 'Instrument Sans',
                fontWeight: FontWeight.w600,
                letterSpacing: -0.20,
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: const BackButton(
              color: Colors.black,
            ),
          ),
          body: Column(
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: '',
                  fit: BoxFit.fill,
                  height: Responsive.width(30, context),
                  width: Responsive.width(30, context),
                  placeholder: (context, url) => Constant.loader(),
                  errorWidget: (context, url, error) => Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF367367),
                          shape: OvalBorder(),
                        ),
                        child: const Center(
                          child: Text(
                            'full name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64,
                              fontFamily: 'Instrument Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            buildBottomSheet(
                              context,
                            );
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  'assets/icons/ic_edit_profile.svg',
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFieldThem.buildTextFiled(context,
                                    hintText: 'Full name'.tr,
                                    controller: TextEditingController()),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    validator: (value) =>
                                        value != null && value.isNotEmpty
                                            ? null
                                            : 'Required',
                                    keyboardType: TextInputType.number,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: TextEditingController(),
                                    textAlign: TextAlign.start,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: AppColors.darkTextField,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12),
                                        prefixIcon: CountryCodePicker(
                                          onChanged: (value) {},
                                          dialogBackgroundColor:
                                              AppColors.background,
                                          comparator: (a, b) => b.name!
                                              .compareTo(a.name.toString()),
                                          flagDecoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2)),
                                          ),
                                        ),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.darkTextFieldBorder,
                                              width: 1),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.darkTextFieldBorder,
                                              width: 1),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.darkTextFieldBorder,
                                              width: 1),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.darkTextFieldBorder,
                                              width: 1),
                                        ),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.darkTextFieldBorder,
                                              width: 1),
                                        ),
                                        hintText: "Phone number".tr)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldThem.buildTextFiled(context,
                                    hintText: 'Email'.tr,
                                    controller: TextEditingController(),
                                    enable: false),
                                SizedBox(
                                  height: Responsive.height(30, context),
                                ),
                                ButtonThem.buildButton(
                                  context,
                                  title: "Update Profile".tr,
                                  btnHeight: 50,
                                  onPress: () async {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  buildBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              height: Responsive.height(22, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Please Select".tr,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text("Camera".tr),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.photo_library_sharp,
                                  size: 32,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text("Gallery".tr),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }
}
