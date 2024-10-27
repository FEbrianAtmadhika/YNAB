import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:ynab/app/Bloc/Auth/auth_bloc.dart';
import 'package:ynab/app/routes/app_pages.dart';

import '../controllers/splash_screen_controller.dart';

import 'package:lottie/lottie.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Future.delayed(const Duration(seconds: 2), (() {
              Get.offAllNamed(Routes.BOTTOMNAVIGATION);
            }));
          }
          if (state is AuthInitial) {
            Future.delayed(const Duration(seconds: 2), (() {
              Get.offAllNamed(Routes.SIGNIN);
            }));
          }
          if (state is AuthFailed) {
            Future.delayed(const Duration(seconds: 2), (() {
              Get.offAllNamed(Routes.SIGNIN);
            }));
          }
        },
        child: Center(
          child: Container(
            width: Get.width,
            height: Get.height,
            child: Lottie.asset('assets/lottie/hello.json'),
          ),
        ),
      ),
    );
  }
}
