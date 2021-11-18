import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class FileHome extends StatefulWidget {
  const FileHome({Key? key}) : super(key: key);

  @override
  State<FileHome> createState() => _FileHomeState();
}

class _FileHomeState extends State<FileHome> {
  @override
  Widget build(BuildContext context) {
    bool showFab = true;

    Widget _getFAB() {
      if (showFab) {
        return FloatingActionButton.extended(
          onPressed: () async {
            await selectFile();
            await uploadFile();
          },
          label: const Text('Upload'),
          icon: const Icon(
            Icons.upload,
          ),
        );
      } else {
        return Container();
      }
    }

    // final deviceHeight = MediaQuery.of(context).size.height;
    //final deviceWidth = MediaQuery.of(context).size.width;

    const List<Tab> tabs = <Tab>[
      Tab(text: 'My Documents'),
      Tab(text: 'CA issued Documents'),
    ];

    // const List<String> _myDocs = [
    //   'Aadhar Card',
    //   'PAN Card',
    // ];
    // const List<String> _caDocs = [
    //   'Balance Sheet',
    //   'Loan Application',
    // ];

    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          // Your code goes here.
          // To get index of current tab use tabController.index
          if (tabController.index == 0) {
            setState(() {
              showFab = true;
            });
          } else {
            setState(() {
              showFab = false;
            });
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text('Documents'),
            bottom: const TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(userUID)
                      .collection("Documents")
                      .snapshots(),
                  builder: (ctx, AsyncSnapshot documentSnapshots) {
                    if (documentSnapshots.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final _document = documentSnapshots.data!.docs;
                    return ListView.builder(
                      itemCount: _document.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          child: _document[index]['Type'] == 'UserDocument' &&
                                  tabController.index == 0
                              ? InkWell(
                                  onTap: () {
                                    _launchURL(_document[index]['URL']);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            _document[index]['Name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.blueAccent,
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: _document[index]['Type'] ==
                                              'CADocument' &&
                                          tabController.index == 1
                                      ? InkWell(
                                          onTap: () {
                                            _launchURL(_document[index]['URL']);
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 30),
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    _document[index]['Name'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Colors.blueAccent,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                        );
                      },
                    );
                  });
            }).toList(),
          ),
          floatingActionButton: tabController.index == 0 ? _getFAB() : null,
        );
      }),
    );
  }
}
