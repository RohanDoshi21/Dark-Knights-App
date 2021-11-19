import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer {
  final String name;
  final String image;
  final Color color;
  final String linkedUrl;
  final String gitHubUrl;
  final String instagramUrl;
  final String emailUrl;
  final String section;

  const Developer({
    required this.linkedUrl,
    required this.gitHubUrl,
    required this.emailUrl,
    required this.name,
    required this.image,
    required this.instagramUrl,
    required this.color,
    required this.section,
  });
}

class Developers extends StatefulWidget {
  @override
  _DevelopersState createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  final _pageController = PageController(viewportFraction: 0.78);
  final _pageNotifier = ValueNotifier(0.0);
  List developerList = [
    const Developer(
        name: 'Rohan Doshi',
        image: 'assets/images/Rohan.jpeg',
        gitHubUrl: "https://github.com/RohanDoshi21",
        linkedUrl: "https://www.linkedin.com/in/rohan-doshi21/",
        emailUrl: "rohan.doshi02@gmail.com",
        instagramUrl: "https://www.instagram.com/rohan.doshi02",
        section: "SE-01",
        color: Colors.transparent),
    const Developer(
        name: 'Sharvi Endait',
        image: 'assets/images/Sharvi.jpeg',
        gitHubUrl: "https://github.com/SharviE29",
        linkedUrl: "https://www.linkedin.com/in/sharvi-endait-b889b1212/",
        emailUrl: "sharviendait@gmail.com",
        instagramUrl: " ",
        section: "SE-02",
        color: Colors.transparent),
    const Developer(
        name: 'Dinesh Nehete',
        image: 'assets/images/Dinesh.jpg',
        gitHubUrl: "https://github.com/dineshNehete",
        linkedUrl: "https://www.linkedin.com/in/dinesh-nehete/",
        emailUrl: "dinesh.g.nehete@gmail.com",
        instagramUrl: "https://www.instagram.com/dinesh.nehete_/",
        section: "SE-01",
        color: Colors.transparent),
    const Developer(
        name: 'Atharv Bhadange',
        image: 'assets/images/Atharv.jpeg',
        gitHubUrl: "https://github.com/atharv-bhadange",
        linkedUrl: "https://www.linkedin.com/in/atharv-bhadange-9817521ba/",
        emailUrl: "bhadange.atharv@gmail.com",
        instagramUrl: "https://www.instagram.com/the_lonely_owl/",
        section: "SE-01",
        color: Colors.transparent),
  ];

  void _listener() {
    _pageNotifier.value = _pageController.page!;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff010413),
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 20,
          shadowColor: Colors.black,
          title: const Text(
            'Developers',
            style: TextStyle(
                color: Color(0xff5ad0b5),
                fontSize: 25,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xff010413),
        ),
        body: Container(
          child: builder(),
        ),
      ),
    );
  }

  ListView builder() {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemCount: developerList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          height: size.height * 0.7,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size.width * 0.90,
                height: size.height * 0.7,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff010413),
                  border:
                      Border.all(color: const Color(0xff5ad0b5), width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Container(
                            alignment: const Alignment(0.0, 2.5),
                            child: Container(
                              child: Image.asset(
                                developerList[index].image.toString(),
                                fit: BoxFit.cover,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: const Color(0xff5ad0b5), width: 5.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          developerList[index].name,
                          style: const TextStyle(
                              fontSize: 25.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "PICT, Pune",
                          style: TextStyle(
                              fontSize: 18.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          developerList[index].section.toString(),
                          style: const TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Flutter Developer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300),
                        ),
                        Card(
                          color: const Color(0xff010413),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: IconButton(
                                          onPressed: () {
                                            _launchURL(
                                                developerList[index].gitHubUrl);
                                          },
                                          icon: Image.asset(
                                            "assets/images/github.png",
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: IconButton(
                                          onPressed: () {
                                            _launchURL(developerList[index]
                                                .instagramUrl);
                                          },
                                          icon: Image.asset(
                                            "assets/images/instagram.png",
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: IconButton(
                                          onPressed: () {
                                            _launchURL(
                                                developerList[index].linkedUrl);
                                          },
                                          icon: Image.asset(
                                            "assets/images/linkedin.png",
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: IconButton(
                                          onPressed: () {
                                            launchMailto(
                                                developerList[index].emailUrl);
                                          },
                                          icon: Image.asset(
                                            "assets/images/gmail.png",
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _launchURL(String url) {
    launch(url);
  }

  launchMailto(String email) {
    final mailtoLink = Mailto(
      to: [email],
      cc: [],
      subject: 'App Review',
      body: "",
    );
    launch('$mailtoLink');
  }
}
