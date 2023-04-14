import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DoctorPhone extends StatefulWidget {
  static String verify = '';

  const DoctorPhone({Key? key}) : super(key: key);

  @override
  State<DoctorPhone> createState() => _DoctorPhoneState();
}

class _DoctorPhoneState extends State<DoctorPhone> {
  TextEditingController countryCode = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  var phone = '';

  @override
  void initState() {
    // TODO: implement initState
    countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/login/signIn.json'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Phone Verification  ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.call,
                    size: 30,
                    color: Colors.green,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter your phone number in order to register.",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: ((value) {
                        phone = value;
                      }),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hoverColor: Colors.green,
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countryCode.text + phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          DoctorPhone.verify = verificationId;
                          Navigator.pushNamed(context, 'verify');
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: const Text(
                      "Send the code",
                      style: TextStyle(fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
