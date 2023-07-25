import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/about_page.dart';
import 'screen/contact_page.dart';
import 'screen/home_page.dart';
import 'screen/register_page.dart';

// ...

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  bool _shouldShowRegisterOption = true;
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _loadRegisterOptionVisibility();
    // Initialize _screens here
    _screens = [
      HomePage(),
      AboutPage(),
      ContactPage(),
      RegisterPage(
        // Pass the callback function as a parameter to the RegisterPage
        onRegisterPressed: _onRegisterButtonPressed,
      ),
    ];
  }

  _loadRegisterOptionVisibility() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showOption = prefs.getBool('showRegisterOption') ?? true;
    setState(() {
      _shouldShowRegisterOption = showOption;
    });
  }

  Future<void> _onRegisterButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showRegisterOption', false);
    // Call the callback function to update the _shouldShowRegisterOption in this class
    _updateRegisterOptionVisibility(false);
  }

  // Create a callback function to be passed to the RegisterPage
  void _updateRegisterOptionVisibility(bool shouldShow) {
    setState(() {
      _shouldShowRegisterOption = shouldShow;
    });
  }

  void _onItemSelected(int index) {
    if (index >= 0 && index < _screens.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //   final _screens = [
    //   HomePage(),
    //   AboutPage(),
    //   ContactPage(),
    //   RegisterPage(
    //     // Pass the callback function as a parameter to the RegisterPage
    //     onRegisterPressed: _onRegisterButtonPressed,
    //   ),

    // ];
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      // height: 60,
      // margin: const EdgeInsets.symmetric(horizontal: 10),
      child: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        elevation: 0,
        // showSelectedLabels: false,
        // showUnselectedLabels: true,
        backgroundColor: const Color(0xFFB4E1DE),
        selectedItemColor: Colors.amber,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black45,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        currentIndex: _selectedIndex,
        onTap: (value) {
          _onItemSelected(value);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessible_outlined),
            label: "About",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_missed),
            label: "Contact",
          ),
          if (_shouldShowRegisterOption) // Show Register option conditionally
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: "Register",
            ),
        ],
      ),
    );
  }
}
