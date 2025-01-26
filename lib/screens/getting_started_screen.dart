import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class GettingStartedScreen extends StatelessWidget {
  GettingStartedScreen({super.key});

  final ValueNotifier<bool> isLoginScreen = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(96),
              child: SizedBox(
                height: 128,
                width: 128,
                child: Image.asset('assets/images/logo.jpg'),
              ),
            ),
            Text(
              'DealsDray',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            Gap(24),
            ValueListenableBuilder(
              valueListenable: isLoginScreen,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => isLoginScreen.value = true,
                      child: Container(
                        width: 128,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: value ? Color.fromARGB(255, 193, 52, 42) : Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => isLoginScreen.value = false,
                      child: Container(
                        width: 128,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: value ? Colors.grey : Color.fromARGB(255, 193, 52, 42),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: isLoginScreen,
              builder: (context, value, child) {
                if (value) return LoginScreen();
                return SignUpScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}
