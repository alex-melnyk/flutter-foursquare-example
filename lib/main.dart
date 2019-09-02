import 'package:flutter/material.dart';

import 'bloc/ApplicationBloc.dart';
import 'bloc/BlocProvider.dart';
import 'screens/CardsScreen.dart';
import 'screens/EmptyScreen.dart';

const MaterialColor MAIN_COLOR = Colors.pink;

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: MaterialApp(home: MaterialApp(
        title: '4 Square Test',
        home: MainContainer(),
        theme: ThemeData(
            buttonTheme: ButtonThemeData(
                colorScheme: ColorScheme.fromSwatch(primarySwatch: MAIN_COLOR),
                textTheme: ButtonTextTheme.primary),
            primarySwatch: MAIN_COLOR),
      )),
    );
  }
}

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final List<String> _screenTitles = ['Map', 'My Cards', 'Shops', 'My Savings'];

  final List<Widget> _tabScreens = [
    EmptyScreen(label: 'Map'),
    CardsScreen(),
    EmptyScreen(label: 'Shops'),
    EmptyScreen(label: 'My Saving'),
  ];

  int _selectedTabIndex;

  @override
  void initState() {
    super.initState();

    _selectedTabIndex = 1;
  }

  void _onItemChanged(int tabIndex) {
    setState(() {
      _selectedTabIndex = tabIndex;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_screenTitles.elementAt(_selectedTabIndex)),
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
        body: _tabScreens.elementAt(_selectedTabIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map')),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_travel), title: Text('Cards')),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text('Shops')),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text('Savings')),
          ],
          currentIndex: _selectedTabIndex,
          unselectedItemColor: Colors.black26,
          selectedItemColor: MAIN_COLOR,
          onTap: _onItemChanged,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ));
  }
}
