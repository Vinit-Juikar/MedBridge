import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../login/firebase/auth.dart';

class PatientViewAppointment extends StatelessWidget {
  var appId;
  PatientViewAppointment(this.appId, {super.key});
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );

  var doctorName;
  var specialist;
  var hospital;
  var docId;
  @override
  Widget build(BuildContext context) {
    _dateInput.text = '';
    DocumentReference<Map<String, dynamic>> doctor =
        FirebaseFirestore.instance.collection('appointments').doc(appId);
    doctor.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        doctorName = documentSnapshot.get('doctorName');
        specialist = documentSnapshot.get('specialist');
        hospital = documentSnapshot.get('hospital');
        docId = documentSnapshot.get('docId');
        print(docId);
      } else {
        String name = '';
        String address = '';
        print('Document does not exist');
      }
    });

    var report = [];
    final User? user = Auth().currentUser;
    var number = '';
    number = user?.phoneNumber ?? 'User email';
    CollectionReference users =
        FirebaseFirestore.instance.collection('patient');
    DocumentReference docRef = users.doc(number);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        report = documentSnapshot.get('reports');
        print('report $report');
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
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    title: const Text(
                      'Appointment',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    automaticallyImplyLeading: false,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  body: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 242, 233, 233),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/profile1.png',
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'Name: ',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 99, 99),
                                            fontSize: 18),
                                      ),
                                      Text(
                                        'Dr. $doctorName',
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 18),
                                      ),
                                      const Text(
                                        'Specialization: ',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 99, 99),
                                            fontSize: 18),
                                      ),
                                      Text(
                                        '$specialist',
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 18),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          giveAcess(appId, report);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 200,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color.fromARGB(
                                                  255, 85, 93, 229)),
                                          child: Row(
                                            children: const [
                                              SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    'Send Access',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.white),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 60,
                          width: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 85, 93, 229)),
                          child: const Text(
                            'Hospital: D.Y.Patil',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 23),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 200,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 242, 233, 233)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Route:',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                'assets/map.png',
                                height: 150,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 60,
                          width: 150,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 85, 93, 229)),
                          child: Row(
                            children: const [
                              Text(
                                'Pre-Prescription:',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25),
                              ),
                              Spacer(
                                flex: 3,
                              ),
                              Icon(
                                Icons.add,
                                size: 27,
                                color: Colors.white,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 60,
                          width: 150,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 85, 93, 229)),
                          child: Row(
                            children: const [
                              Text(
                                'Medicine:',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25),
                              ),
                              Spacer(
                                flex: 3,
                              ),
                              Icon(
                                Icons.add,
                                size: 27,
                                color: Colors.white,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 60,
                          width: 150,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 85, 93, 229)),
                          child: Row(
                            children: const [
                              Text(
                                'Symptoms:',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25),
                              ),
                              Spacer(
                                flex: 3,
                              ),
                              Icon(
                                Icons.add,
                                size: 27,
                                color: Colors.white,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

void giveAcess(String docId, List report) {
  final drId = FirebaseFirestore.instance.collection('appointments').doc(docId);
  drId.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      drId.update({
        'medicine': report,
      });
      drId.update({
        'historyaccess': true,
      });
    } else {}
  });
}

void createUser(
  String patientId,
  String docId,
  String patientName,
  String doctorName,
  String specialist,
  String schedule,
) async {
  final User? user = Auth().currentUser;
  var number = '';
  number = user?.phoneNumber ?? 'User email';

  //Provider Request
  final appoinmentId =
      FirebaseFirestore.instance.collection('appointments').doc();

  final userProfile = UserProfile(
    patientId: patientId,
    docId: docId,
    patientName: patientName,
    doctorName: doctorName,
    specialist: specialist,
    schedule: schedule,
    id: appoinmentId.id,
  );
  final json = userProfile.toJson();
  await appoinmentId.set(json);

  //Seeker Update
  final patId = FirebaseFirestore.instance.collection('patient').doc(patientId);
  patId.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      patId
          .update({
            'appointments': FieldValue.arrayUnion([appoinmentId.id])
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });

  //Provider Or User Update
  final drId = FirebaseFirestore.instance.collection('doctor').doc(docId);
  drId.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      drId
          .update({
            'appointments': FieldValue.arrayUnion([appoinmentId.id])
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });
}

class UserProfile {
  final String patientId;
  final String docId;
  final String patientName;
  final String doctorName;
  final String specialist;
  final String schedule;
  final String id;

  UserProfile({
    required this.patientId,
    required this.docId,
    required this.patientName,
    required this.doctorName,
    required this.specialist,
    required this.schedule,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'patientId': patientId,
        'docId': docId,
        'patientName': patientName,
        'doctorName': doctorName,
        'specialist': specialist,
        'route': 'assets/map.png',
        'schedule': schedule,
        'chatting': [],
        'historyaccess': false,
        'pre_prescription': [],
        'medicine': [],
        'symptoms': [],
      };
}

TextEditingController _dateInput = TextEditingController();

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateInput,
      //editing controller of this TextField
      decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Color.fromARGB(255, 25, 85, 134)),
          icon: Icon(
            Icons.calendar_today,
            color: Colors.white,
          ), //icon of text field
          labelText: "Enter Date" //label text of field
          ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          setState(() {
            _dateInput.text =
                formattedDate; //set output date to TextField value.
          });
        } else {}
      },
    );
  }
}
