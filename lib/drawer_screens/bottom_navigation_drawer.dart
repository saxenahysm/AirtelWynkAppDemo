import 'package:airtel_wynk_template/utils/snackbar_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationDrawer extends StatefulWidget {
  const BottomNavigationDrawer({Key? key}) : super(key: key);

  @override
  _BottomNavigationDrawerState createState() => _BottomNavigationDrawerState();
}

class _BottomNavigationDrawerState extends State<BottomNavigationDrawer> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFFBD520A),
        unselectedItemColor: Color(0xFF5F5C5C),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          onBottomItemTapped;
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Music List'),
            icon: Icon(Icons.music_note_outlined),
          ),
          BottomNavigationBarItem(
            title: Text('Podcasts'),
            icon: Icon(Icons.podcasts),
          ),
          BottomNavigationBarItem(
            title: Text('Settings'),
            icon: Icon(Icons.settings_outlined),
          ),
        ],
        currentIndex: selectedIndex,
        elevation: 4,
      ),
    );
  }

  void onBottomItemTapped(int index) {
    setState() {
      selectedIndex = index;
      showSnackBar(context, index.toString());
    }
  }
}
