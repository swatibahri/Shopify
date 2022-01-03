import 'package:flutter/material.dart';
import 'package:store_app/consts/app_icons.dart';
import 'package:store_app/screens/cart/cart.dart';
import 'package:store_app/screens/feeds.dart';
import 'package:store_app/screens/home.dart';
import 'package:store_app/screens/search.dart';
import 'package:store_app/screens/user.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
      },
      {
        'page': FeedsScreen(),
      },
      {
        'page': SearchScreen(),
      },
      {
        'page': CartScreen(),
      },
      {
        'page': UserScreen(),
      },
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(_pages[_selectedIndex]['title']),
      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration:
                BoxDecoration(border: Border(top: BorderSide(width: 0.5, color: Colors.grey)), color: Colors.white),
            child: BottomNavigationBar(
              onTap: _selectedPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.purple,
              currentIndex: _selectedIndex,
              selectedLabelStyle: TextStyle(fontSize: 14),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.home),
                  tooltip: 'Home',
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.rss),
                  tooltip: 'Feeds',
                  label: 'Feeds',
                ),
                BottomNavigationBarItem(
                  activeIcon: null,
                  icon: Icon(null),
                  tooltip: 'Search',
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.bag),
                  tooltip: 'Cart',
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.user),
                  tooltip: 'User',
                  label: 'User',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: Icon(AppIcons.search),
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          }),
    );
  }
}
