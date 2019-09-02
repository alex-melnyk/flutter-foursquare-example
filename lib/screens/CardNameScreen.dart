import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardNameScreen extends StatefulWidget {
  @override
  _CardNameScreenState createState() => _CardNameScreenState();
}

class _CardNameScreenState extends State<CardNameScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: Container(
                    child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_border, color: Colors.black38),
                        Icon(
                          Icons.star_border,
                          size: 100,
                          color: Colors.black54,
                        ),
                        Icon(Icons.star_border, color: Colors.black38)
                      ]),
                ),
                Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'You\'ve complited your first task.\nYou got:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('100'), Icon(Icons.star)]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('100'), Icon(Icons.star)]),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    child: Text('Collect'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Card Name'),
          actions: [
            FlatButton(
              child: Text('Details'),
              onPressed: () {},
              textColor: Colors.white,
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Column(children: [
                      SizedBox(
                          width: 250,
                          child: Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.check_circle),
                                            Icon(Icons.crop_square),
                                            Icon(Icons.crop_square),
                                            Icon(Icons.crop_square)
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(Icons.crop_square),
                                            Icon(Icons.crop_square),
                                            Icon(Icons.crop_square),
                                            Icon(Icons.star)
                                          ]),
                                    )
                                  ])))),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Notes on a rewards',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ]),
                  )),
              TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black38,
                  tabs: [Tab(text: 'Check in'), Tab(text: 'Add Purchase')]),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Container(
                      child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Center(
                        child: QrImage(
                            size: 200,
                            version: QrVersions.auto,
                            data: 'https://foursquare.com/'),
                      ))
                    ],
                  )),
                  Icon(Icons.credit_card, size: 250, color: Colors.black38)
                ]),
              )
            ],
          ),
        ));
  }
}
