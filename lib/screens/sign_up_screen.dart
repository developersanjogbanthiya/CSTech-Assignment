import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController referralController = TextEditingController();
    ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);
    ValueNotifier<bool> isError = ValueNotifier(false);
    ValueNotifier<String> errorMessage = ValueNotifier<String>('');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(32),
        Text(
          'Let\'s Begin!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8),
        Text(
          'Please enter your credentials to proceed',
          style: TextStyle(color: const Color.fromARGB(255, 106, 106, 106)),
        ),
        Gap(12),
        SizedBox(
          width: 256,
          child: Column(
            children: [
              TextField(
                controller: emailController,
                cursorColor: Color.fromARGB(255, 193, 52, 42),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 193, 52, 42),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 193, 52, 42),
                    ),
                  ),
                ),
              ),
              Gap(12),
              ValueListenableBuilder(
                  valueListenable: isObscure,
                  builder: (context, value, child) {
                    return TextField(
                      controller: passwordController,
                      cursorColor: Color.fromARGB(255, 193, 52, 42),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: value,
                      decoration: InputDecoration(
                        hintText: 'Create Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              isObscure.value = !isObscure.value;
                            },
                            icon: value ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 193, 52, 42),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 193, 52, 42),
                          ),
                        ),
                      ),
                    );
                  }),
              Gap(12),
              TextField(
                controller: referralController,
                cursorColor: Color.fromARGB(255, 193, 52, 42),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Referral Code (Optional)',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 193, 52, 42),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 193, 52, 42),
                    ),
                  ),
                ),
              ),
              Gap(32),
              SizedBox(
                width: 256,
                child: ElevatedButton(
                  onPressed: () async {
                    errorMessage.value = '';
                    if (emailController.text.isNotEmpty || passwordController.text.length > 7) {
                      final responseData = await HttpService()
                          .singUpRequest(emailController.text, passwordController.text, referralController.text);

                      if (responseData['data']['message'] == "Email exists") {
                        errorMessage.value = 'Email exists. Please Login!';
                        isError.value = true;
                      } else if (responseData['data']['message'] == "Referral does not exist") {
                        errorMessage.value = "Referral does not exist";
                        isError.value = true;
                      } else if (responseData['data']['message'] == "User Not Found") {
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => HomeScreen()));
                      }
                    } else {
                      errorMessage.value = 'Fill details properly';
                      isError.value = true;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 193, 52, 42),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16)),
                  child: Text(
                    'Lets go',
                  ),
                ),
              ),
              Gap(12),
              ValueListenableBuilder(
                  valueListenable: isError,
                  builder: (context, value, child) {
                    if (value) return Text(errorMessage.value);
                    return Text('');
                  })
            ],
          ),
        ),
      ],
    );
  }
}
