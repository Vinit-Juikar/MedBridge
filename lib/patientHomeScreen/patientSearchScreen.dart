import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medbridge/patientHomeScreen/patient_appointment_booking.dart';

TextEditingController search = TextEditingController();

class PatientSearchScreen extends StatefulWidget {
  const PatientSearchScreen({super.key});

  @override
  State<PatientSearchScreen> createState() => _PatientSearchScreenState();
}

class _PatientSearchScreenState extends State<PatientSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  controller: search,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Search',
                      hintText: 'Search For Doctors ',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 25, 85, 134))),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("doctor").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final userSnapshot = snapshot.data?.docs;
              if (userSnapshot!.isEmpty) {
                return const Center(child: Text("no data"));
              }
              return ListView.builder(
                  itemCount: userSnapshot.length,
                  itemBuilder: (context, index) {
                    String sear = search.text;
                    if (userSnapshot[index]["fName"].toString().toLowerCase() ==
                            sear.toLowerCase().trim() ||
                        userSnapshot[index]["specialization"]
                                .toString()
                                .toLowerCase() ==
                            sear.toLowerCase().trim()) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientSideAppointment(
                                      userSnapshot[index].id),
                                ));
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 209, 208, 208)),
                                  borderRadius: BorderRadius.circular(25)),
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/login/doctor.png',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${'Name: ' + userSnapshot[index]["fName"]} ' +
                                            userSnapshot[index]["lName"],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        'Gender: ' +
                                            userSnapshot[index]["gender"],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        'Specialization: ' +
                                            userSnapshot[index]
                                                ["specialization"],
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center();
                    }
                  });
            },
          ),
        ));
  }
}
