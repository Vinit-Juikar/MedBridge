import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../login/firebase/auth.dart';

TextEditingController _dateInput = TextEditingController();
TextEditingController _profileDownload = TextEditingController();
TextEditingController _doctorName = TextEditingController();
TextEditingController _specialization = TextEditingController();
TextEditingController _disease = TextEditingController();

class PatientMedicalHistoryAdder extends StatelessWidget {
  const PatientMedicalHistoryAdder({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = user?.phoneNumber ?? '9876543210';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF555DE5),
        title: const Text('Add Medical Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const DatePicker(),
            TextFormField(
              controller: _doctorName,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Doctor Name',
                  hintText: 'Dr. Roshan Nakate ',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 25, 85, 134))),
            ),
            TextFormField(
              controller: _specialization,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Specialization',
                  hintText: 'Neurologist ',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 25, 85, 134))),
            ),
            TextFormField(
              controller: _disease,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Disease',
                  hintText: 'Meningioma ',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 25, 85, 134))),
            ),
            const ImagePickerSS(),
            GestureDetector(
              onTap: () {
                if (_doctorName.text == '' ||
                    _specialization.text == '' ||
                    _disease.text == '' ||
                    _dateInput.text == '' ||
                    _profileDownload.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill All Requirement")));
                } else {
                  createUser(
                      _doctorName.text,
                      _specialization.text,
                      _disease.text,
                      _profileDownload.text,
                      _dateInput.text,
                      number);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Updated Successfully")));
                  Navigator.pop(context);
                }
              },
              child: Container(
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color.fromARGB(255, 85, 93, 229),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            color: Color.fromARGB(255, 0, 0, 0),
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

class ImagePickerSS extends StatefulWidget {
  const ImagePickerSS({super.key});

  @override
  State<ImagePickerSS> createState() => _ImagePickerSSState();
}

class _ImagePickerSSState extends State<ImagePickerSS> {
  var number = '9876543210';
  File? image;
  UploadTask? uploadTask;
  Future uploadFile() async {
    final path = 'patient/$number/profileImage.jpg';
    final file = File(image!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link $urlDownload');
    _profileDownload.text = urlDownload;
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    final tempImage = File(image.path);
    setState(() {
      this.image = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    number = user?.phoneNumber ?? '9876543210';
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              pickImage();
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 85, 93, 229),
                  borderRadius: BorderRadius.circular(25)),
              child: image == null
                  ? const Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                      size: 50,
                    )
                  : Image.file(image!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                uploadFile();
              },
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25)),
                  child: const Text(
                    'Upload',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void createUser(
  String doctorName,
  String specialization,
  String disease,
  String report,
  String date,
  String number,
) async {
  final docUser = FirebaseFirestore.instance.collection('medicalHistory').doc();

  final userProfile = UserProfile(
    doctorName: doctorName,
    specialization: specialization,
    disease: disease,
    report: report,
    date: date,
    id: docUser.id,
  );

  final patId = FirebaseFirestore.instance.collection('patient').doc(number);
  patId.get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      patId
          .update({
            'reports': FieldValue.arrayUnion([docUser.id])
          })
          .then((value) => print('Field updated successfully'))
          .catchError((error) => print('Failed to update field: $error'));
    } else {}
  });

  final json = userProfile.toJson();
  print(json);
  await docUser.set(json);
  print('Done');
}

class UserProfile {
  final String doctorName;
  final String specialization;
  final String disease;
  final String report;
  final String date;
  final String id;

  UserProfile({
    required this.doctorName,
    required this.specialization,
    required this.disease,
    required this.report,
    required this.date,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        'doctorName': doctorName,
        'specialization': specialization,
        'disease': disease,
        'report': report,
        'date': date,
        'id': id,
        'doctorWithHistory': [],
      };
}
