import 'package:assignment/screens/getting_started_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(96),
              child: SizedBox(
                height: 200,
                width: 200,
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
            Gap(20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => GettingStartedScreen()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 193, 52, 42), foregroundColor: Colors.white),
              child: Text('Let\'s get started'),
            ),
          ],
        ),
      ),
    );
  }
}
