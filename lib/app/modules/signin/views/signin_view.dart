import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ynab/app/Bloc/Auth/auth_bloc.dart';
import 'package:ynab/app/model/signinmodel.dart';
import 'package:ynab/app/routes/app_pages.dart';

class SigninView extends StatefulWidget {
  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  String? email;
  String? password;
  bool isPasswordVisible = false;

  // Function to show loading overlay
  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Function to hide the loading overlay
  void hideLoading(BuildContext context) {}

  // Function to show a snackbar for errors or messages
  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator when in loading state
            showLoading(context);
          } else if (state is AuthSuccess) {
            // Hide loading indicator and navigate to BottomNavbar on success
            Navigator.of(context).pop();
            Get.offAllNamed(Routes.BOTTOMNAVIGATION);
          } else if (state is AuthFailed) {
            // Hide loading indicator and show error snackbar on failure
            Navigator.of(context).pop();
            showSnackbar(context, state.message);
          }
        },
        child: ListView(
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
                      'Masuk',
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
                      'Silahkan masuk untuk lanjut ke aplikasi',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(24, 125, 132, 141),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(24, 125, 132, 141),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      obscureText: !isPasswordVisible,
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 13, 16, 0),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle forgot password action
                        },
                        child: Text(
                          'Lupa Password?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF7029),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (email == null ||
                            email!.isEmpty ||
                            password == null ||
                            password!.isEmpty) {
                          showSnackbar(
                              context, 'Email dan password harus diisi.');
                        } else {
                          // Dispatch the AuthLogin event to the AuthBloc
                          context.read<AuthBloc>().add(AuthLogin(
                              SignInFormModel(
                                  email: email!, password: password!)));
                        }
                      },
                      child: Text(
                        'Masuk',
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
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                        'Belum punya akun? ',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to signup page
                          print("Navigate to Signup Page");
                        },
                        child: Text(
                          'Daftar',
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
      ),
    );
  }
}
