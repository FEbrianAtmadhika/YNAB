import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:ynab/app/Bloc/Auth/auth_bloc.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrent()),
        )
      ],
      child: GetMaterialApp(
        title: "Application",
        initialRoute: Routes.SPLASH_SCREEN,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
