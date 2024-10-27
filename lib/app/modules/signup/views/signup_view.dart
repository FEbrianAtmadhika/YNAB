import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ynab/app/modules/signin/views/signin_view.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Silahkan daftar untuk melanjutkan aplikasi',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(24, 125, 132, 141),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        hintText: 'Nama'),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(24, 125, 132, 141),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        hintText: 'Email'),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(24, 125, 132, 141),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 13, 16, 0),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(24, 125, 132, 141),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 13, 16, 0),
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Password terdiri dari 8 karakter'),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                    onPressed: () {
                      print('button tapped');
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF33CC33),
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(SigninView());
                      },
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFF7029),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
