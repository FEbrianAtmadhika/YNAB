import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ynab/app/Bloc/Auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ynab/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/logo/logo.png'),
          onPressed: () {},
        ),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                Get.offAllNamed(Routes.SIGNIN);
              }
              if (state is AuthFailed) {
                showSnackbar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthSuccess) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogout(state.user));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    "Keluar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: const Center(
        child: Text(
          'HomeView',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
