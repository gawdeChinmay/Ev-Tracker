import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ev_tracker/pages/EvDashBoard.dart';
import 'package:ev_tracker/pages/calculateEvCost.dart';
import 'package:ev_tracker/pages/statesWiseEv.dart';
import 'package:ev_tracker/pages/subsidyEv.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Evdashboard(),
    const StateswiseEv(),
    const SubsidyEv(),
    const CalculateEvCost(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Color.fromARGB(255, 204, 255, 0),
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            Icon(Icons.home),
            Icon(Icons.settings),
            Icon(Icons.map),
            Icon(Icons.calculate),
          ]),
    );
  }
}
