// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class LawsAndActs extends StatelessWidget {
  const LawsAndActs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff010413),
        title: const Text(
          'Laws & Acts',
          style: TextStyle(
              color: Color(0xff5ad0b5),
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        color: const Color(0xff010413),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Documents")
              .orderBy('Name')
              .snapshots(),
          builder: (ctx, AsyncSnapshot documentSnapshots) {
            if (documentSnapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final _document = documentSnapshots.data!.docs;
            return ListView.builder(
              itemCount: _document.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    _launchURL(_document[index]['URL']);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: Row(
                      children: [
                        //Image
                        if (_document[index]['Name'].split(".").last == 'jpg' ||
                            _document[index]['Name'].split(".").last == 'jepg')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            child: Image.asset(
                              'assets/images/jpg_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last == 'doc')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.only(
                              right: 2,
                            ),
                            child: Image.asset(
                              'assets/images/doc_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last == 'pdf')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.only(
                              right: 2,
                            ),
                            child: Image.asset(
                              'assets/images/pdf_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last == 'docx')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.only(
                              right: 2,
                            ),
                            child: Image.asset(
                              'assets/images/docx_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last == 'xls')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            child: Image.asset(
                              'assets/images/xls_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last == 'xlsx')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.only(
                              right: 2,
                            ),
                            child: Image.asset(
                              'assets/images/xlsx_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last == 'csv')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.only(
                              right: 2,
                            ),
                            child: Image.asset(
                              'assets/images/csv_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last == 'ppt')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.only(
                              right: 2,
                            ),
                            child: Image.asset(
                              'assets/images/ppt_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last == 'pptx')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.only(
                              right: 2,
                            ),
                            child: Image.asset(
                              'assets/images/pptx_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),
                        if (_document[index]['Name'].split(".").last != 'jpg' &&
                            _document[index]['Name'].split(".").last !=
                                'jepg' &&
                            _document[index]['Name'].split(".").last != 'pdf' &&
                            _document[index]['Name'].split(".").last !=
                                'docx' &&
                            _document[index]['Name'].split(".").last != 'doc' &&
                            _document[index]['Name'].split(".").last != 'xls' &&
                            _document[index]['Name'].split(".").last !=
                                'xlsx' &&
                            _document[index]['Name'].split(".").last != 'csv' &&
                            _document[index]['Name'].split(".").last !=
                                'pptx' &&
                            _document[index]['Name'].split(".").last != 'ppt')
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            padding: const EdgeInsets.only(
                              right: 2,
                            ),
                            child: Image.asset(
                              'assets/images/file_icon.png',
                              // fit: BoxFit.cover, //default
                            ),
                          ),

                        //********** */
                        //pdf, jpg, jepg, docx/doc, xlsx/csv/xls, ppt/pptx
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  _document[index]['Name'].split(".").first,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Lato',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Text(
                                '.${_document[index]['Name'].split(".").last} file',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato',
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xff403ffc),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
