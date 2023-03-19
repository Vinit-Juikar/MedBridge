import 'package:flutter/material.dart';
import 'package:medbridge/doctorHomeScreen/doctorAppointment.dart';
import 'package:medbridge/doctorHomeScreen/doctor_medhistory.dart';

import '../login/firebase/auth.dart';

class DoctorNavBar extends StatefulWidget {
  const DoctorNavBar({super.key});

  @override
  State<DoctorNavBar> createState() => _DoctorNavBarState();
}

class _DoctorNavBarState extends State<DoctorNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: const Center(
        child: Text('Doctor Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Auth().signOut();
        },
        child: const Icon(Icons.add),
      ),
    ),
    const Center(
      child: Text('Search'),
    ),
    DoctorsAppointmentss(),
    DoctorsAppointments()
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
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Medical History',
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
