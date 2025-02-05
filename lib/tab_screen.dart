import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinhala_short_stories/favorite_screen.dart';
import 'package:sinhala_short_stories/home.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _pages = [Home(), FavoriteScreen()];

  var _pageSelected = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            label: 'සියලුම කතා',
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            label: 'ප්‍රියතම කතා',
            icon: Icon(Icons.star),
          ),
        ],
        activeColor: Color(0xff5b5858),
        currentIndex: _pageSelected,
        onTap: (ind) {
          setState(() {
            _pageSelected = ind;
          });
        },
      ),
      tabBuilder: (context, i) {
        return CupertinoTabView(builder: (context) {
          return _pages[i];
        });
      },
    );
  }
}
