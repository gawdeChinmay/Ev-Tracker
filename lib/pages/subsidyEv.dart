import 'package:ev_tracker/pages/custom_slider.dart';
import 'package:flutter/material.dart';

class SubsidyEv extends StatelessWidget {
  const SubsidyEv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomSlider(),
      ),
    );
  }
}
