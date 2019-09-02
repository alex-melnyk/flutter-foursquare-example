import 'dart:convert';
import 'package:foursquaretest/models/Place.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:app_settings/app_settings.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PogioCardScreen extends StatefulWidget {
  @override
  _PogioCardScreenState createState() => _PogioCardScreenState();
}

class _PogioCardScreenState extends State<PogioCardScreen>
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

  Future<bool> _claimRewards() async {
    PermissionStatus permission = await LocationPermissions().checkPermissionStatus();

    if (permission == PermissionStatus.unknown) {
      permission = await LocationPermissions().requestPermissions();
    }

    if (permission == PermissionStatus.granted) {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      var lat = position.latitude;
      var lng = position.longitude;

      const clientId = '<CLIENT_ID>';
      const clientSecret = '<CLIENT_SECRET>';

      final reqUrl = 'https://api.foursquare.com/v2/venues/explore?client_id=$clientId&client_secret=$clientSecret&v=20180323&limit=1&ll=$lat,$lng';

      final resp = await http.get(reqUrl);
      final data = List.from(json.decode(resp.body)['response']['groups']).map((p) => Place.fromMap(p)).toList();

      return data.length > 0;
    } else {
      showDialog(context: context, builder: (context) =>
          AlertDialog(title: Text('Foursquare Test'),
              content: Text(
                  'Please allow getting your location in the settings.'),
              actions: [
                FlatButton(child: Text('Open Settings'), onPressed: () {
                  AppSettings.openAppSettings();
                }),
                FlatButton(child: Text('Later'), onPressed: () {
                  Navigator.of(context).pop();
                })
              ]));

      return false;
    }
  }

  _showDialog() async  {
    var result = await _claimRewards();

    if (!result) {
      return;
    }

    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
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
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
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
          title: Text('Pogiocard'),
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
                              padding: const EdgeInsets.all(50.0),
                              child: Center(
                                  child: Text(
                                    'Pogio,™️',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange),
                                  )),
                            )),
                      ),
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
                              )),
                          RaisedButton(
                            child: Text('Claim Reward'),
                            onPressed: _showDialog,
                          ),
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
