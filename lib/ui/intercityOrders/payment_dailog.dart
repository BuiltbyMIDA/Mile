import 'package:customer/themes/button_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

paymentMethodDialog(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context1) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: StatefulBuilder(builder: (context1, setState) {
            return Obx(
              () => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                              visible: true,
                              child: Obx(
                                () => InkWell(
                                  onTap: () {},
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
                                        const Expanded(
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                              color: Color(0xFF64748B),
                                              fontSize: 14,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.20,
                                            ),
                                          ),
                                        ),
                                        Radio(
                                          value: 'group',
                                          groupValue: const ['group'],
                                          activeColor: const Color(0xFF0A0A0A),
                                          onChanged: (value) {},
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
                              visible: true,
                              child: Obx(
                                () => InkWell(
                                  onTap: () {},
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
                                        const Expanded(
                                          child: Text(
                                            'wallet name',
                                            style: TextStyle(
                                              color: Color(0xFF64748B),
                                              fontSize: 14,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.20,
                                            ),
                                          ),
                                        ),
                                        Radio(
                                          value: 'name',
                                          groupValue: const ['name'],
                                          activeColor: const Color(0xFF0A0A0A),
                                          onChanged: (value) {},
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
                              visible: true,
                              child: InkWell(
                                onTap: () {},
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
                                      const Expanded(
                                        child: Text(
                                          'name',
                                          style: TextStyle(
                                            color: Color(0xFF64748B),
                                            fontSize: 14,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.20,
                                          ),
                                        ),
                                      ),
                                      Radio(
                                        value: 'name',
                                        groupValue: 'name',
                                        activeColor: const Color(0xFF0A0A0A),
                                        onChanged: (value) {},
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                                thickness: 1, color: Color(0xFFD9D9D9)),
                            Visibility(
                              visible: true,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              'assets/images/flutterwave.png',
                                              scale: 2,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              'name',
                                              style: TextStyle(
                                                color: Color(0xFF64748B),
                                                fontSize: 14,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: -0.20,
                                              ),
                                            ),
                                          ),
                                          Radio(
                                            value: 'name',
                                            groupValue: 'name',
                                            activeColor:
                                                const Color(0xFF0A0A0A),
                                            onChanged: (value) {},
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
