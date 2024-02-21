import 'package:crud_firebase/constants/constants.dart';
import 'package:crud_firebase/controllers/auth_service.dart';
import 'package:crud_firebase/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:pinput/pinput.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              Constants.VERIFY_PHONE,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            ),
            const Gap(20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Constants.ENTER_CODE,
                style: TextStyle(color: Color(0xff6750a4)),
              ),
            ),
            const Gap(20),
            Pinput(
              controller: otpController,
              length: 6,
            ),
            const Gap(20),
            GestureDetector(
              onTap: () {
                AuthService.loginWithOtp(otpController.text).then((value) {
                  if (value == "Sucess") {
                    Get.to(const HomePage());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          Constants.ERROR_SENDING_OTP,
                        ),
                      ),
                    );
                  }
                });
              },
              child: Container(
                height: 40,
                width: 115,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0XFF6750A4),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  Constants.VERIFY,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
