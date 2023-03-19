import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  File? image;
  UploadTask? uploadTask;
  Future uploadFile() async {
    const path = 'user/adasdas.jpg';
    final file = File(image!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link $urlDownload');
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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              uploadFile();
            },
            child: const Text('Upload'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImage();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
