import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  var currentIdCategory = Rxn<int>();
  //TODO: Implement TransactionController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCurrentIdCategory(int? id) {
    currentIdCategory.value = id; // Update the observable
  }

  void increment() => count.value++;
}
