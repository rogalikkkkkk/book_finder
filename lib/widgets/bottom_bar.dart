import 'package:book_finder/variables/routes.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final Routes screen;
  const BottomBar(this.screen, {Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _selectedPageIndex = routeNumber[widget.screen]!;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    Navigator.of(context).pushNamedAndRemoveUntil(routeString[routeNumber.keys.elementAt(index)]!, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Find book',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Library',
        ),
      ],
      currentIndex: _selectedPageIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
