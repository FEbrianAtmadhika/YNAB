import 'package:get/get.dart';
import 'package:ynab/app/modules/budget/views/budget_view.dart';
import 'package:ynab/app/modules/goal/views/goal_view.dart';
import 'package:ynab/app/modules/home/views/home_view.dart';
import 'package:ynab/app/modules/profile/views/profile_view.dart';
import 'package:ynab/app/modules/transaction/bindings/transaction_binding.dart';
import 'package:ynab/app/modules/transaction/views/transaction_view.dart';

class BottomnavigationController extends GetxController {
  //TODO: Implement BottomnavigationController
  RxInt CurrentIndex = 0.obs;

  final screens = [
    HomeView(),
    TransactionView(),
    GoalView(),
    BudgetView(),
    ProfileView(),
  ];

  SetIndex(int index) {
    if (index >= 0 && index < screens.length) {
      CurrentIndex.value = index;
      if (index == 1) {
        TransactionBinding().dependencies(); // Ensure controller is available
      }
      update();
    } else {
      print("Invalid index: $index");
    }
  }
}
