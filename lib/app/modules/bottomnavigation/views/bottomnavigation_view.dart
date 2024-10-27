// bottomnavigation_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bottomnavigation_controller.dart';

class BottomnavigationView extends GetView<BottomnavigationController> {
  const BottomnavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: controller.CurrentIndex.value >= 0 &&
                  controller.CurrentIndex.value < controller.screens.length
              ? controller.screens[controller.CurrentIndex.value]
              : Center(child: Text('Halaman tidak ditemukan')),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(
            color: Color(0xFF33CC33),
          ),
          unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
          selectedItemColor: Color(0xFF33CC33),
          unselectedItemColor: Colors.grey[400],
          currentIndex: controller.CurrentIndex.value,
          onTap: (index) => controller.SetIndex(index),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(controller.CurrentIndex.value == 0
                        ? 'assets/icons/icons_home_active.png'
                        : 'assets/icons/icons_home.png'),
                  ),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(controller.CurrentIndex.value == 1
                        ? 'assets/icons/icons_transaction_active.png'
                        : 'assets/icons/icons_transaction.png'),
                  ),
                ),
              ),
              label: 'Transaksi',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(controller.CurrentIndex.value == 2
                        ? 'assets/icons/icons_goal_active.png'
                        : 'assets/icons/icons_goal.png'),
                  ),
                ),
              ),
              label: 'Goal',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(controller.CurrentIndex.value == 3
                        ? 'assets/icons/icons_budget_active.png'
                        : 'assets/icons/icons_budget.png'),
                  ),
                ),
              ),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(controller.CurrentIndex.value == 4
                        ? 'assets/icons/icons_profile_active.png'
                        : 'assets/icons/icons_profile.png'),
                  ),
                ),
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
