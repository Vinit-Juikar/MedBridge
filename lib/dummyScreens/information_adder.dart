import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final TextEditingController _controllerName = TextEditingController();
final TextEditingController _controllerWork = TextEditingController();
final TextEditingController _controllerAddress = TextEditingController();
final TextEditingController _controllerPhone = TextEditingController();
final TextEditingController _controllerRate = TextEditingController();
final TextEditingController _controllerGender = TextEditingController();

class Createdb extends StatelessWidget {
  const Createdb({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < 25; i++) {
                    createData();
                  }
                },
                child: const Text('Do it'),
              ),
            )),
      ),
    );
  }
}

void createData() {
  List firstNames = [
    "Aaradhya",
    "Ananya",
    "Anjali",
    "Diya",
    "Gauri",
    "Isha",
    "Jiya",
    "Kavya",
    "Khushi",
    "Krisha",
    "Mahi",
    "Mira",
    "Neha",
    "Palak",
    "Pooja",
    "Rhea",
    "Riya",
    "Sakshi",
    "Sana",
    "Sanjana",
    "Shreya",
    "Simran",
    "Sneha",
    "Suhani",
    "Tanvi",
    "Tanya",
    "Trisha",
    "Urvi",
    "Vaishnavi",
    "Vidhi",
    "Zoya"
  ];
  List surnames = [
    "Agarwal",
    "Bhalla",
    "Chopra",
    "Dutta",
    "Gupta",
    "Jain",
    "Kapoor",
    "Kumar",
    "Mahajan",
    "Malhotra",
    "Mehta",
    "Mehra",
    "Mishra",
    "Nair",
    "Patel",
    "Rana",
    "Rao",
    "Reddy",
    "Sethi",
    "Shah",
    "Sharma",
    "Singh",
    "Tandon",
    "Thakur",
    "Verma",
    "Yadav",
    "Zaveri",
    "Zutshi"
  ];
  List specialization = [
    'neurologist',
    'cardiologist',
    'oncologist',
    'pediatrics',
    'dermatologist',
    'gynecologist',
    'orthopedist',
    'psychiatrist'
  ];
  List address = [
    "1, Shanti Nagar, Mumbai",
    "10, Rajiv Chowk, Delhi",
    "23, Park Street, Kolkata",
    "5, MG Road, Bangalore",
    "12, Civil Lines, Jaipur",
    "8, Race Course Road, Chennai",
    "15, Shivaji Nagar, Pune",
    "9, Karol Bagh, Delhi",
    "4, Adarsh Colony, Lucknow",
    "17, Lajpat Nagar, Delhi",
    "7, Gandhi Road, Ahmedabad",
    "2, Ganga Vihar, Varanasi",
    "3, Sarojini Nagar, Lucknow",
    "18, Cantonment Area, Hyderabad",
    "14, Juhu Beach, Mumbai",
    "6, Fraser Road, Patna",
    "11, Park Lane, Hyderabad",
    "22, Residency Road, Pune",
    "20, MG Marg, Allahabad",
    "19, Jawahar Nagar, Jaipur",
    "16, Connaught Place, Delhi",
    "25, Jayanagar, Bangalore",
    "13, Kankarbagh, Patna",
    "27, Kothrud, Pune",
    "24, Anna Nagar, Chennai",
    "21, Banjara Hills, Hyderabad",
    "29, Sector 17, Chandigarh",
    "30, Vijay Nagar, Indore",
    "26, Andheri West, Mumbai",
    "28, Salt Lake City, Kolkata"
  ];
  List male = [
    'Aarav',
    'Akash',
    'Amit',
    'Anil',
    'Arjun',
    'Ashok',
    'Bharat',
    'Dhruv',
    'Gaurav',
    'Gopal',
    'Hari',
    'Harish',
    'Jatin',
    'Kunal',
    'Manish',
    'Mohan',
    'Naveen',
    'Nikhil',
    'Pradeep',
    'Prakash',
    'Rahul',
    'Rajesh',
    'Rakesh',
    'Ramesh',
    'Sanjay',
    'Santosh',
    'Sarvesh',
    'Shankar',
    'Siddharth',
    'Vikram',
    'Yash'
  ];
  List phone = [
    "9876543210",
    "9812345678",
    "9898989898",
    "9999999999",
    "9867676767",
    "9834567890",
    "9865321470",
    "9876549876",
    "9856321470",
    "9812345678",
    "9898989898",
    "9999999999",
    "9867676767",
    "9834567890",
    "9865321470",
    "9876549876",
    "9856321470",
    "9812345678",
    "9898989898",
    "9999999999",
    "9867676767",
    "9834567890",
    "9865321470",
    "9876549876",
    "9856321470",
    "9812345678",
    "9898989898",
    "9999999999",
    "9867676767",
    "9834567890"
  ];
  List<String> hospitals = [
    'All India Institute of Medical Sciences, New Delhi',
    'Apollo Hospitals, Chennai',
    'Fortis Hospital, Mumbai',
    'Max Super Speciality Hospital, New Delhi',
    'Lilavati Hospital and Research Centre, Mumbai',
    'Christian Medical College and Hospital, Vellore',
    'Artemis Hospital, Gurgaon',
    'Kokilaben Dhirubhai Ambani Hospital and Medical Research Institute, Mumbai',
    'Tata Memorial Hospital, Mumbai',
    'Sri Ramachandra Medical Centre, Chennai',
    'Manipal Hospital, Bangalore',
    'Wockhardt Hospitals, Mumbai',
    'Global Hospital, Chennai',
    'Narayana Health, Bangalore',
    'Care Hospitals, Hyderabad',
    'Asian Heart Institute, Mumbai',
    'Gleneagles Global Hospitals, Chennai',
    'KIMS Hospital, Thiruvananthapuram',
    'Medanta - The Medicity, Gurgaon',
    'Sir Ganga Ram Hospital, New Delhi'
  ];
  List<String> emails = [
    'rajesh.kumar@gmail.com',
    'priya.singh@yahoo.com',
    'mukesh.verma@rediffmail.com',
    'anjali.sharma@hotmail.com',
    'rohan.shah@outlook.com',
    'shalini.gupta@gmail.com',
    'amit.jain@yahoo.co.in',
    'sonali.thakur@indiatimes.com',
    'rajeev.aggarwal@vsnl.com',
    'meera.patel@icloud.com'
  ];
  List<String> qualifications = [
    'MBBS',
    'MD',
    'MS',
    'DM',
    'MCh',
    'DNB',
    'BAMS',
    'BHMS',
    'BUMS',
    'BDS',
    'MDS',
    'BPT',
    'MPT',
    'BPharm',
    'MPharm',
    'PhD',
    'DSc',
    'DPhil',
    'FRCS',
    'MRCS'
  ];
  String Fname = getRandomElement(firstNames);
  String Mname = getRandomElement(male);
  String Lname = getRandomElement(surnames);
  String workN = getRandomElement(specialization);
  String hospital = getRandomElement(hospitals);
  String addressP = getRandomElement(address);
  String Phone = getRandomElement(phone);
  String email = getRandomElement(emails);
  String qualification = getRandomElement(qualifications);
  final random = Random();
  int years = random.nextInt(40);
  int phonenum = random.nextInt(1294967296) + 8000000000;
  createUser(
    Fname,
    Mname,
    Lname,
    addressP,
    workN,
    '+91$phonenum',
    email,
    years.toString(),
    hospital,
    qualification,
  );
}

getRandomElement(List list) {
  final random = Random();
  var i = random.nextInt(list.length);
  return list[i];
}

void createUser(
    String fname,
    String mname,
    String lname,
    String address,
    String specialization,
    String phone,
    String email,
    String experienceYears,
    String hospital,
    String qualification) async {
  final docUser = FirebaseFirestore.instance.collection('doctor').doc(phone);

  final userProfile = UserProfile(
    fname: fname,
    mname: mname,
    lname: lname,
    address: address,
    specialization: specialization,
    phone: phone,
    email: email,
    experienceYears: experienceYears,
    hospital: hospital,
    qualification: qualification,
    id: docUser.id,
  );
  final json = userProfile.toJson();
  await docUser.set(json);
}

class UserProfile {
  final String fname;
  final String mname;
  final String lname;
  final String address;
  final String specialization;
  final String phone;
  final String email;
  final String experienceYears;
  final String hospital;
  final String qualification;
  final String id;

  UserProfile({
    required this.fname,
    required this.mname,
    required this.lname,
    required this.address,
    required this.specialization,
    required this.phone,
    required this.email,
    required this.experienceYears,
    required this.hospital,
    required this.qualification,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        'fName': fname,
        'mName': mname,
        'lName': lname,
        'image':
            'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Fpremium-vector%2Fdoctor-profile-with-medical-service-icon_26439792.htm&psig=AOvVaw2ec7YUC8FplNdEzBLpa5mK&ust=1679252297402000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLCWxbeU5v0CFQAAAAAdAAAAABAE',
        'address': address,
        'gender': 'Female',
        'email': email,
        'specialization': specialization,
        'experienceYears': experienceYears,
        'hospital': hospital,
        'qualification': qualification,
        'id': id,
        'history': [],
        'appointments': [],
        'grading': 'A',
        'roadMap':
            'https://www.google.com/url?sa=i&url=https%3A%2F%2Fsnazzymaps.com%2Fstyle%2F213288%2Fwhite-and-black-roadmap&psig=AOvVaw1wTonuDKlbkrLqogC91e9K&ust=1679253605855000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCPC3qKeZ5v0CFQAAAAAdAAAAABAR',
        'currentPatients': [],
        'patientWithHistory': [],
      };
}
