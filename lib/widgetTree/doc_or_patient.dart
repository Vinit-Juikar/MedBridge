import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medbridge/login/doctor/doctor_phone.dart';
import 'package:medbridge/login/doctor/doctor_verify.dart';
import 'package:medbridge/login/patient/patient_phone.dart';
import 'package:medbridge/login/patient/patient_verify.dart';

import '../login/doctor/doctor_login_or_register.dart';
import '../login/patient/login_or_register.dart';

String choosedOption = '';
bool doctor = true;
bool patient = true;

class DoctorOrPatient extends StatelessWidget {
  const DoctorOrPatient({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Lottie.asset('assets/login/docOrpatient.json', height: 300),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color.fromARGB(150, 85, 93, 229),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome !!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Now it is easier to connect patients to doctors \nthrough a tap on the screen ',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Choose',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ChoiceChips(),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (doctor == true && patient == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Choose One Option")));
                              return;
                            } else if (!doctor) {
                              choosedOption = 'doctor';
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DoctorsLoginScreens(),
                                ),
                              );
                            } else {
                              choosedOption = 'patient';
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PatientsLoginScreens(),
                                ),
                              );
                            }
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              height: 50,
                              width: 200,
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 85, 93, 229)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChoiceChips extends StatefulWidget {
  const ChoiceChips({super.key});

  @override
  State<ChoiceChips> createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ChoiceChip(
          avatar: Image.asset('assets/login/doctor.png'),
          elevation: 2,
          padding: const EdgeInsets.all(4),
          label: Text(
            'Doctor',
            style: TextStyle(
                color: doctor ? Colors.black : Colors.white, fontSize: 23),
          ),
          backgroundColor:
              doctor ? Colors.grey : const Color.fromARGB(255, 163, 197, 238),
          selected: doctor,
          onSelected: (newboolvalue) {
            doctor = !doctor;
            patient = true;
            setState(() {});
          },
        ),
        ChoiceChip(
          avatar: Image.asset(
            'assets/login/patient.png',
          ),
          elevation: 2,
          label: Text(
            'Patient',
            style: TextStyle(
                color: patient ? Colors.black : Colors.white, fontSize: 23),
          ),
          backgroundColor:
              patient ? Colors.grey : const Color.fromARGB(255, 163, 197, 238),
          selected: patient,
          onSelected: (newboolvalue) {
            patient = !patient;
            doctor = true;
            setState(() {});
          },
        ),
      ],
    );
  }
}

class DoctorsLoginScreens extends StatelessWidget {
  const DoctorsLoginScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'information',
      routes: {
        'information': (context) => const DoctorLoginOrRegister(),
        'phone': (context) => const DoctorPhone(),
        'verify': (context) => const DoctorVerify(),
      },
    );
  }
}

class PatientsLoginScreens extends StatelessWidget {
  const PatientsLoginScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'information',
      routes: {
        'information': (context) => const LoginOrRegister(),
        'phone': (context) => const PaitentPhone(),
        'verify': (context) => const PatientVerify(),
      },
    );
  }
}
