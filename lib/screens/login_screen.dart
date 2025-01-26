import 'package:assignment/screens/otp_screen.dart';
import 'package:assignment/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController();

    ValueNotifier<bool> isError = ValueNotifier(false);
    ValueNotifier<String> errorMessage = ValueNotifier<String>('');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(32),
        Text(
          'Glad to see you!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8),
        Text(
          'Please provide your phone number',
          style: TextStyle(color: const Color.fromARGB(255, 106, 106, 106)),
        ),
        Gap(32),
        SizedBox(
          width: 256,
          child: TextField(
            controller: phoneNumberController,
            cursorColor: Color.fromARGB(255, 193, 52, 42),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: 'Phone',
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
        ),
        Gap(32),
        SizedBox(
          width: 256,
          child: ElevatedButton(
            onPressed: () async {
              if (phoneNumberController.text.length == 10) {
                final responseData = await HttpService().sendOtpRequest(phoneNumberController.text);
                if (responseData['status'] == 1 && responseData['data']['message'] == 'OTP send successfully ') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => OtpScreen(
                            phoneNumber: phoneNumberController.text,
                          )));
                } else {
                  errorMessage.value = responseData['error'];
                  isError.value = true;
                }
              } else {
                errorMessage.value = 'Invalid Phone Number';
                isError.value = true;
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 193, 52, 42),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16)),
            child: Text(
              'SEND CODE',
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
    );
  }
}
