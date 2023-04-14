import 'package:flutter/material.dart';

import 'doc_or_patient.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
// there will be  list of one for the image, other for some text
  List<String> imagesForOnboarding = [
    "assets/onBoardingScreenImages/first_image.png",
    "assets/onBoardingScreenImages/second_image.png",
    "assets/onBoardingScreenImages/third_image.png",
  ];
  List<String> descriptionName = [
    "Medical History",
    "Secured Data",
    "Data Sharing",
  ];

  List<String> description = [
    "This information is crucial for healthcare providers to make informed decisions regarding the patient's current and future healthcare needs.",
    "It is essential to ensure the privacy and confidentiality of this sensitive data to maintain trust between patients and healthcare providers.",
    "It must be carried out with strict adherence to privacy and security regulations to safeguard patient confidentiality and protect against potential harm or discrimination.",
  ];

  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                itemCount: 3,
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 25),
                        child: SizedBox(
                          // color: Colors.amber,
                          height: MediaQuery.of(context).size.height / 5,
                          width: double.infinity,
                          child: Image.asset(
                            imagesForOnboarding[i].toString(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            descriptionName[i].toString(),
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                        width: double.infinity,
                        // color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            description[i].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imagesForOnboarding.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                height: 60,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    if (currentIndex == imagesForOnboarding.length - 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DoctorOrPatient()));
                    }
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.bounceInOut);
                  },

                  //
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF555DE5)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  child: Text(
                    currentIndex == imagesForOnboarding.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: const TextStyle(fontSize: 20, color: Colors.amber),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 20 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange,
      ),
    );
  }
}
