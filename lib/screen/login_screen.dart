import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testslogreg/bloc/login/login_logic.dart';
import 'package:testslogreg/bloc/login/login_state.dart';
import 'package:testslogreg/screen/page_one.dart';
import 'package:testslogreg/screen/register_screen.dart';
import 'package:testslogreg/widget/custom_text.dart';
import 'package:testslogreg/widget/show_snack_bar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var email1 = TextEditingController();
  var password1 = TextEditingController();
  bool isLoading = false;
  bool passwordVisb = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginLogic(),
      child: BlocConsumer<LoginLogic, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return PageOne();
            }));
            isLoading = false;
          } else if (state is LoginFailure) {
          showsnackbar(context, state.errorMessage);
          isLoading = false;
        }
        },
        builder: (context, state) {
          LoginLogic logobj = BlocProvider.of(context);

          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      Colors.blue,
                      Colors.blueAccent,
                      Colors.lightBlue,
                      Colors.lightBlueAccent
                    ])),
                child: Center(
                  child: Column(children: [
                    const SizedBox(
                      height: 120,
                    ),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      'Enter your credential login',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Customtext(
                      controller: email1,
                      hintext: 'Email.....',
                      icon: Icons.person,
                    ),
                    Customtext(
                      controller: password1,
                      hintext: 'Password.....',
                      color: Colors.white,
                      icon: Icons.password,
                      icon1: passwordVisb
                          ? Icons.visibility
                          : Icons.visibility_off,
                      on: () {
                        passwordVisb = !passwordVisb;
                      },
                      obscureText: passwordVisb,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          minWidth: 350,
                          height: 60,
                          onPressed: () async{
                            logobj.loginUser(
                                Email: email1.text, Password: password1.text);
                          },
                          color: const Color.fromARGB(255, 20, 127, 214),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          })),
                          child: const Text(
                            '\tSign Up',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 175,
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
