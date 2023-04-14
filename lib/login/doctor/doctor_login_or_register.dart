import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_p.dart';

class DoctorLoginOrRegister extends StatelessWidget {
  const DoctorLoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(200, 85, 93, 229),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Material(
              elevation: 10,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.elliptical(200, 200),
                  bottomRight: Radius.elliptical(200, 200)),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(200, 200),
                      bottomRight: Radius.elliptical(200, 200)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.width / 1.2,
                child: Center(
                  child: Lottie.asset(
                    'assets/login/patientLoginOrSignUp.json',
                    width: MediaQuery.of(context).size.width / 1.4,
                    repeat: true,
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              alignment: Alignment.center,
              child: AnimatedTextKit(
                pause: const Duration(seconds: 4),
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText(
                    'MedBridge',
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
              child: Text(
                'Easy Profile Setup With Us,',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            // Container(
            //   child: GestureDetector(
            //     onTap: (){
            //       Navigator.pushNamedAndRemoveUntil(
            //                 context, 'phone', (route) => false);
            //     },
            //     child: Material(
            //       elevation: 8,
            //       borderRadius: BorderRadius.circular(22),
            //       child: Container(
            //         alignment: Alignment.center,
            //         width: 200,
            //         height: 50,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(22),
            //           color: Colors.white,
            //         ),
            //         child: const Text(
            //           'Provider',
            //           style: TextStyle(
            //               fontSize: 24, color: Color.fromARGB(255, 25, 85, 134)),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await getSharedPreferencesInstance();
                prefs.setString('option', 'doctorLogin');
                Navigator.pushNamedAndRemoveUntil(
                    context, 'phone', (route) => false);
              },
              child: Container(
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 85, 93, 229)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await getSharedPreferencesInstance();
                prefs.setString('option', 'doctorRegister');
                Navigator.pushNamedAndRemoveUntil(
                    context, 'phone', (route) => false);
              },
              child: Container(
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 85, 93, 229)),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Copyright©| SkillBridge',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
