import 'package:flutter/material.dart';
import 'package:medbridge/login/firebase/auth.dart';
import 'package:medbridge/login/patient/patient_information.dart';
import 'package:medbridge/patientHomeScreen/patientNavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../doctorHomeScreen/doctor_navbar.dart';
import '../login/doctor/doctor_information.dart';
import '../shared_p.dart';

class AuthUsers extends StatelessWidget {
  const AuthUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserDisplayName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return NextScreen(displayName: snapshot.data!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<String> getUserDisplayName() async {
    SharedPreferences prefs = await getSharedPreferencesInstance();
    String myString = prefs.getString('option') ?? '';
    return myString;
  }
}

class NextScreen extends StatelessWidget {
  final String displayName;

  const NextScreen({super.key, required this.displayName});

  @override
  Widget build(BuildContext context) {
    if (displayName == 'patientLogin') {
      return const PatientNavBar();
    } else if (displayName == 'patientRegister') {
      return const PatientInformation();
      // return Scaffold(
      //   body: const Center(
      //     child: Text('patientRegister'),
      //   ),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Auth().signOut();
      //     },
      //     child: const Icon(Icons.add),
      //   ),
      // );
    } else if (displayName == 'doctorLogin') {
      return const DoctorNavBar();
    } else {
      return const DoctorInformation();
    }
  }
}
