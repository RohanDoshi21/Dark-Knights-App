import 'package:flutter/material.dart';

class FileHome extends StatelessWidget {
  const FileHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    //final deviceWidth = MediaQuery.of(context).size.width;

    const List<Tab> tabs = <Tab>[
      Tab(text: 'My Documents'),
      Tab(text: 'CA issued Documents'),
    ];

    const List<String> _myDocs = [
      'Aadhar Card',
      'PAN Card',
    ];
    const List<String> _caDocs = [
      'Balance Sheet',
      'Loan Application',
    ];
    bool showFab = true;

    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
            print(tabController.index);
            if (tabController.index == 1) {
              showFab = true;
            } else {
              showFab = false;
            }
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
              return SizedBox(
                height: deviceHeight,
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 30),
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Preview',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            tabController.index == 1
                                ? _myDocs[index]
                                : _caDocs[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    );
                  },
                  itemCount: tabController.index == 1
                      ? _myDocs.length
                      : _caDocs.length,
                ),
              );
            }).toList(),
          ),
          floatingActionButton: showFab
              ? FloatingActionButton.extended(
                  onPressed: () {},
                  label: const Text('Upload'),
                  icon: const Icon(
                    Icons.upload,
                  ),
                )
              : null,
        );
      }),
    );
  }
}
