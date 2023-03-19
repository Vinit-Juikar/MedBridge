import 'package:medbridge/widgetTree/widgetTree.dart';

import '../../widgetTree/doc_or_patient.dart';
import '../firebase/auth.dart';
import 'patient_phone.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class PatientVerify extends StatefulWidget {
  const PatientVerify({Key? key}) : super(key: key);

  @override
  State<PatientVerify> createState() => _PatientVerifyState();
}

class _PatientVerifyState extends State<PatientVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var code = '';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/img1.png',
              //   width: 150,
              //   height: 150,
              // ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                child: Lottie.asset('assets/login/otp.json'),
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter the OTP sent to your mobile number.",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // onLongPress: () {
                //   Fluttertoast.showToast(
                //       msg: "This is a toast message",
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.BOTTOM,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor: Colors.grey[600],
                //       textColor: Colors.white,
                //       fontSize: 16.0);
                // },
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,
                onChanged: (value) {
                  code = value;
                },
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: PaitentPhone.verify,
                                smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);
                      } catch (e) {
                        print(e);
                      }
                      final user = Auth().currentUser;
                      user?.updateDisplayName(choosedOption);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WidgetTree(),
                          ));
                    },
                    child: const Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'phone',
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
