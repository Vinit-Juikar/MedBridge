import 'package:flutter/material.dart';
import 'package:medbridge/login/firebase/auth.dart';
import 'package:medbridge/patientHomeScreen/patientAppointment.dart';
import 'package:medbridge/patientHomeScreen/patientMedicalHistory.dart';
import 'package:medbridge/patientHomeScreen/patientSearchScreen.dart';
import 'package:medbridge/patientHomeScreen/patient_appointment_booking.dart';

class PatientNavBar extends StatefulWidget {
  const PatientNavBar({super.key});

  @override
  State<PatientNavBar> createState() => _PatientNavBarState();
}

class _PatientNavBarState extends State<PatientNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Auth().signOut();
        },
        child: const Icon(Icons.add),
      ),
    ),
    const PatientSearchScreen(),
    PatientsAppointments(),
    PatientMedicalHistory()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('Value Changes');
  }

  @override
  Widget build(BuildContext context) {
    print("Number of times build");
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'News',
          ),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: const Color.fromARGB(255, 11, 53, 126),
        selectedItemColor: const Color.fromARGB(255, 0, 174, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
