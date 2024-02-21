import 'package:crud_firebase/controllers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'verify_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            'Continue with Phone',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              prefixText: "+91",
              labelText: "Mobile Number",
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              // Get.to(() => const VerifyPage());
              AuthService.sendOtp(
                  phone: phoneController.text,
                  errorStep: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Error in sending OTP',
                          ),
                        ),
                      ),
                  nextStep: () {
                    print('next page');
                    Get.to(const VerifyPage());
                  });
            },
            child: Container(
              height: 40,
              width: 115,
              decoration: BoxDecoration(
                color: const Color(0XFF6750A4),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(
                child: Text(
                  'CONTINUE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
