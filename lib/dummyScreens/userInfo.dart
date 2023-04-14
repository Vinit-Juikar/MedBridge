import 'package:flutter/material.dart';

import '../login/firebase/auth.dart';

class UserInfor extends StatelessWidget {
  const UserInfor({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Auth().currentUser;
    user?.updateDisplayName('rohit');
    return const Scaffold(
      body: Center(child: Text('User Information')),
    );
  }
}
