import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:medbridge/patientHomeScreen/patientNavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_p.dart';
import '../firebase/auth.dart';

bool male = true;
bool female = true;
TextEditingController _firstName = TextEditingController();
TextEditingController _middleName = TextEditingController();
TextEditingController _lastName = TextEditingController();
TextEditingController _address = TextEditingController();
TextEditingController _dateInput = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _aadhar = TextEditingController();
TextEditingController _bloodGroup = TextEditingController();
TextEditingController _height = TextEditingController();
TextEditingController _weight = TextEditingController();
TextEditingController _profileDownload = TextEditingController();

class PatientInformation extends StatelessWidget {
  const PatientInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    var number = user?.phoneNumber ?? '9876543210';
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 1150,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 1050,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        color: Color.fromARGB(255, 135, 140, 245)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                              TextFormField(
                                controller: _firstName,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'First Name',
                                    hintText: 'Rohit ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _middleName,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Middle Name',
                                    hintText: 'Baban ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _lastName,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Last Name',
                                    hintText: 'Bagade ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _address,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Address',
                                    hintText: 'Sec 5, Byculla ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Gender',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              const GenderSelection(),
                              const SizedBox(
                                height: 10,
                              ),
                              const DatePicker(),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _email,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Email',
                                    hintText: 'abc@gmail.com ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _aadhar,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Aadhaar Card Number',
                                    hintText: '1234-5678-9012 ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _bloodGroup,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Blood Group',
                                    hintText: 'B- ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _height,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Height',
                                    hintText: '172 cm ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _weight,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Weight',
                                    hintText: '72 Kgs ',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 25, 85, 134))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_firstName.text == '' ||
                                      _middleName.text == '' ||
                                      _lastName.text == '' ||
                                      _address.text == '' ||
                                      male == true && female == true ||
                                      _dateInput.text == '' ||
                                      _email.text == '' ||
                                      _aadhar.text == '' ||
                                      _bloodGroup.text == '' ||
                                      _height.text == '' ||
                                      _weight.text == '' ||
                                      _profileDownload.text == '') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Fill All Requirement")));
                                  } else {
                                    print('User Created');
                                    createUser(
                                        _firstName.text,
                                        _middleName.text,
                                        _lastName.text,
                                        _profileDownload.text,
                                        _address.text,
                                        _dateInput.text,
                                        _email.text,
                                        _aadhar.text,
                                        _bloodGroup.text,
                                        _height.text,
                                        _weight.text,
                                        number);
                                    SharedPreferences prefs =
                                        await getSharedPreferencesInstance();
                                    prefs.setString('option', 'patientLogin');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PatientNavBar(),
                                        ));
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
                                        color: Colors.white,
                                      ),
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Color.fromARGB(
                                                255, 85, 93, 229)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const ImagePickerSS()
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

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ChoiceChip(
          avatar: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/login/male_profile.jpg')),
          elevation: 2,
          label: Text(
            'Male',
            style: TextStyle(
                color: male ? Colors.black : Colors.white, fontSize: 20),
          ),
          backgroundColor:
              male ? Colors.grey : const Color.fromARGB(255, 163, 197, 238),
          selected: male,
          onSelected: (newboolvalue) {
            male = !male;
            female = true;
            setState(() {});
          },
        ),
        ChoiceChip(
          avatar: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/login/female_profile.jpg')),
          elevation: 2,
          label: Text(
            'Female',
            style: TextStyle(
                color: female ? Colors.black : Colors.white, fontSize: 20),
          ),
          backgroundColor:
              female ? Colors.grey : const Color.fromARGB(255, 163, 197, 238),
          selected: female,
          onSelected: (newboolvalue) {
            female = !female;
            male = true;
            setState(() {});
          },
        ),
      ],
    );
  }
}

//Image Section

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
        mainAxisAlignment: MainAxisAlignment.end,
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
                      Icons.person_outlined,
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
    String fName,
    String mName,
    String lName,
    String profileLink,
    String address,
    String dob,
    String email,
    String aadhar,
    String bloodgroup,
    String height,
    String weight,
    String number) async {
  final docUser = FirebaseFirestore.instance.collection('patient').doc(number);
  String gender;
  if (male) {
    gender = 'felmale';
  } else {
    gender = 'male';
  }

  final userProfile = UserProfile(
    fName: fName,
    mName: mName,
    lName: lName,
    profileLink: profileLink,
    address: address,
    gender: gender,
    dob: dob,
    email: email,
    aadhar: aadhar,
    bloodgroup: bloodgroup,
    height: height,
    weight: weight,
    id: docUser.id,
  );
  final json = userProfile.toJson();
  print(json);
  await docUser.set(json);
  print('Done');
}

class UserProfile {
  final String fName;
  final String mName;
  final String lName;
  final String profileLink;
  final String address;
  final String gender;
  final String dob;
  final String email;
  final String aadhar;
  final String bloodgroup;
  final String height;
  final String weight;
  final String id;

  UserProfile({
    required this.fName,
    required this.mName,
    required this.lName,
    required this.profileLink,
    required this.address,
    required this.gender,
    required this.dob,
    required this.email,
    required this.aadhar,
    required this.bloodgroup,
    required this.height,
    required this.weight,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        'fName': fName,
        'mName': mName,
        'lName': lName,
        'image': profileLink,
        'address': address,
        'gender': gender,
        'dob': dob,
        'email': email,
        'aadhar': aadhar,
        'bloodgroup': bloodgroup,
        'height': height,
        'weight': weight,
        'id': id,
        'diseaseList': [],
        'medicineList': [],
        'currentTreatment': '',
        'emergencyContact': '',
        'reports': [],
        'prebloodDonation': '',
        'healthInsurance': '',
        'mediclaim': '',
        'appointments': [],
        'doctorWithHistory': [],
        'BMI': '',
      };
}
