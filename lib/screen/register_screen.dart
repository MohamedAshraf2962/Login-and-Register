import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testslogreg/bloc/register/register_logic.dart';
import 'package:testslogreg/bloc/register/register_state.dart';
import 'package:testslogreg/screen/login_screen.dart';
import 'package:testslogreg/screen/page_one.dart';
import 'package:testslogreg/widget/custom_text.dart';
import 'package:testslogreg/widget/show_snack_bar.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  bool isLoading = false;
  bool passwordVis = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterLogic(),
      child: BlocConsumer<RegisterLogic, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            isLoading = true;
          } else if (state is RegisterSucces) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return PageOne();
            }));
            isLoading = false;
          } else if (state is RegisterFailure) {
          showsnackbar(context, state.errorMessage);
          isLoading = false;
        }
        },
        builder: (context, state) {
          RegisterLogic reglogonj = BlocProvider.of(context);

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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      const Text(
                        'Sign up',
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
                        'Create Your Account',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Customtext(
                          controller: name,
                          icon: Icons.person,
                          color: Colors.white,
                          hintext: 'name....'),
                      Customtext(
                          controller: email,
                          icon: Icons.email,
                          color: Colors.white,
                          hintext: 'Email....'),
                      Customtext(
                        controller: phone,
                        icon: Icons.phone_android,
                        color: Colors.white,
                        hintext: 'Number....',
                        keybo: TextInputType.phone,
                      ),
                      Customtext(
                        controller: password,
                        icon: Icons.password,
                        hintext: 'Password....',
                        color: Colors.white,
                        icon1: passwordVis
                            ? Icons.visibility
                            : Icons.visibility_off,
                        on: () {
                          passwordVis = !passwordVis;
                        },
                        obscureText: passwordVis,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                            minWidth: 350,
                            height: 60,
                            onPressed: ()  {
                              reglogonj.registerUser(
                                Name: name.text,
                                  Email: email.text,
                                  Phone: phone.text,
                                  Password: password.text);
                            },
                            color: const Color.fromARGB(255, 20, 127, 214),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                            height: 36,
                          )),
                          Text(
                            'OR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            color: Colors.white,
                            height: 36,
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.facebook,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.alternate_email,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            })),
                            child: const Text(
                              '\tLogin',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 120,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
