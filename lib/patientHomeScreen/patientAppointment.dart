import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medbridge/patientHomeScreen/patient_appointment.dart';

import '../login/firebase/auth.dart';

class PatientsAppointments extends StatelessWidget {
  PatientsAppointments({super.key});
  var myList = [];
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 5),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = '';
    number = user?.phoneNumber ?? 'User email';
    CollectionReference users =
        FirebaseFirestore.instance.collection('patient');
    DocumentReference docRef = users.doc(number);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        myList = documentSnapshot.get('appointments');
        print(myList);
      } else {}
    });
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 1,
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Today\'s Appointment',
                      style: TextStyle(
                          color: Color.fromARGB(255, 33, 30, 22),
                          decoration: TextDecoration.none,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (BuildContext context, int index) {
                      print('done');
                      return AppointmentSpecific(myList[index]);
                    }),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

class AppointmentSpecific extends StatelessWidget {
  var appId;
  AppointmentSpecific(this.appId, {super.key});
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    var drName = '';
    var specialist = '';
    var date = '';
    CollectionReference users =
        FirebaseFirestore.instance.collection('appointments');
    DocumentReference docRef = users.doc(appId);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        drName = documentSnapshot.get('doctorName');
        specialist = documentSnapshot.get('specialist');
        date = documentSnapshot.get('schedule');
        print('$drName $specialist $date');
      } else {}
    });
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: _calculation, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientViewAppointment(appId),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 85, 93, 229),
                          borderRadius: BorderRadius.circular(20)),
                      height: 200,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/profile1.png',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dr. $drName',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                  Text(specialist,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ],
                              ))
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 121, 126, 228),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.date_range,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    date,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const Icon(
                                    Icons.schedule,
                                    color: Colors.white,
                                  ),
                                  const Text(
                                    '11:00-12:00',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ))
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
