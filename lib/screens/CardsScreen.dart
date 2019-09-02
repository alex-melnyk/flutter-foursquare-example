import 'package:flutter/material.dart';
import 'package:foursquaretest/models/CardModel.dart';

import 'CardNameScreen.dart';
import 'PogioCardScreen.dart';

class CardsScreen extends StatefulWidget {
  final List<CardModel> cards = [
    CardModel('My Pogio', 'Digital Card'),
    CardModel('Lidl', 'Loyalty Card'),
    CardModel('Card/Company Name', 'Stampcard')
  ];

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  _cardClicked(int index) {
    switch(index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => PogioCardScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => CardNameScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: widget.cards.length,
            itemBuilder: (context, index) {
              return Card(
                  child: InkWell(
                    onTap: () {
                      _cardClicked(index);
                    },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.credit_card,
                          size: 80,
                          color: Colors.black38,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.cards[index].label,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(widget.cards[index].subLabel),
                        ],
                      )),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                ),
              ));
            }));
  }
}
