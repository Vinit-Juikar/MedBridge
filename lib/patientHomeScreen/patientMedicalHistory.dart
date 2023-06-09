import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medbridge/patientHomeScreen/patientMedicalHistoryAdder.dart';

import '../login/firebase/auth.dart';

class PatientMedicalHistory extends StatelessWidget {
  PatientMedicalHistory({super.key});

  List DateTime = [
    " March 18, 2023 Saturday ",
    " March 11, 2023 Saturday ",
    " March 4, 2023 Saturday ",
    " February 25, 2023 Saturday ",
  ];
  List Doctor = [
    "Dr. Ayesha Khan",
    "Dr. Sanjay Sharma",
    "Dr. Ritu Patel",
    "Dr. Prakash Singh",
  ];
  List Profession = [
    "Endocrinologist",
    "Pulmonologist",
    "Gastroenterologist",
    "Cardiologist",
  ];
  List Disease = [
    "Diabetes",
    "Asthma",
    "Inflammatory bowel disease",
    "Artery disease",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Medical History',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Your History',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: PatientMedicalHistoryfull()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF797EE4),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PatientMedicalHistoryAdder(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PatientMedicalHistoryfull extends StatelessWidget {
  PatientMedicalHistoryfull({super.key});
  var myList = [];
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
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
        myList = documentSnapshot.get('reports');
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
              Expanded(
                child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (BuildContext context, int index) {
                      print('done');
                      return medicalHistorySpecific(myList[index]);
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

class medicalHistorySpecific extends StatelessWidget {
  var appId;
  medicalHistorySpecific(this.appId, {super.key});
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
    () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    var drName = '';
    var specialist = '';
    var disease = '';
    var date = '';
    var image = '';
    CollectionReference users =
        FirebaseFirestore.instance.collection('medicalHistory');
    DocumentReference docRef = users.doc(appId);
    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        drName = documentSnapshot.get('doctorName');
        image = documentSnapshot.get('report');
        disease = documentSnapshot.get('disease');
        specialist = documentSnapshot.get('specialization');
        date = documentSnapshot.get('date');
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF555DE5),
                ),
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(content: Image.network(image));
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF797EE4),
                        ),
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Center(
                          child: Text(
                            'Date: $date',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text(
                        'Doctor Name: $drName',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text(
                        'Specialization: $specialist',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text(
                        'Disease Name: $disease',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ],
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
