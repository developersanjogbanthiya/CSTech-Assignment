import 'dart:async';

import 'package:assignment/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final ValueNotifier<int> _countdownNotifier = ValueNotifier<int>(60); // Initial countdown value
  late Timer _timer;
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);
  int minute = 0;
  int seconds = 0;

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());

  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_countdownNotifier.value > 0) {
        _countdownNotifier.value -= 1;
      } else {
        _timer.cancel();
        _isButtonEnabled.value = true;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.phone_android_outlined,
              size: 64,
            ),
            Gap(20),
            Text(
              'OTP Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(16),
            Text('We have sent a unique OTP number \n to your mobile ${widget.phoneNumber}'),
            Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) {
                  return Container(
                    width: 24,
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      focusNode: _focusNodes[index],
                      controller: _controllers[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.length == 1 && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                      decoration: InputDecoration(
                        counterText: '',
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
                  );
                },
              ),
            ),
            Gap(24),
            ElevatedButton(
                onPressed: () {
                  if (int.parse(_controllers[0].text) == 9 &&
                      int.parse(_controllers[1].text) == 8 &&
                      int.parse(_controllers[2].text) == 7 &&
                      int.parse(_controllers[3].text) == 9) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => HomeScreen()));
                  }
                },
                child: Text('Verify')),
            Gap(24),
            ValueListenableBuilder(
              valueListenable: _countdownNotifier,
              builder: (context, value, child) {
                return Text('Resend OTP in $value seconds');
              },
            ),
            Gap(12),
            ValueListenableBuilder(
                valueListenable: _isButtonEnabled,
                builder: (context, value, child) {
                  return TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: value ? Color.fromARGB(255, 193, 52, 42) : Color.fromARGB(127, 193, 52, 42),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Send again'),
                  );
                })
          ],
        ),
      ),
    );
  }
}
