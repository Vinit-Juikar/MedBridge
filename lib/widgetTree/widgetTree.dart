import 'package:flutter/material.dart';
import 'package:medbridge/widgetTree/auth_users.dart';
import 'package:medbridge/widgetTree/doc_or_patient.dart';

import '../login/firebase/auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const AuthUsers();
        } else {
          return const DoctorOrPatient();
          // return MaterialApp(
          //   debugShowCheckedModeBanner: false,
          //   initialRoute: 'information',
          //   routes: {
          //     'information': (context) => const LoginOrRegister(),
          //     'phone': (context) => const MyPhone(),
          //     'verify': (context) => const MyVerify(),
          //   },
          // );
        }
      },
    );
  }
}
