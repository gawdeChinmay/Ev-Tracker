import 'package:ev_tracker/animations/FadeAnimation.dart';
import 'package:ev_tracker/main.dart';
import 'package:ev_tracker/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Starterpage extends StatefulWidget {
  const Starterpage({super.key});

  @override
  State<Starterpage> createState() => _StarterpageState();
}

class _StarterpageState extends State<Starterpage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _buttonScale;

  bool _textVisible = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400), // Animation duration
    );

    _buttonScale = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _textVisible = false;
    });

    // Start the button scaling animation
    _animationController.forward().then((_) {
      _animationController.reverse().then((_) {
        Navigator.push(
          context,
          PageTransition(type: PageTransitionType.fade, child: Homepage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 190), // Space from the top
            Container(
              width: 380, // Icon width
              height: 380, // Icon height
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/ev-tracker-high-resolution-logo-transparent.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30), // Space below the icon
            Padding(
              padding: const EdgeInsets.all(15),
              child: Fadeanimation(
                Text(
                  'Get " EV " Insights',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                0.5,
              ),
            ),
            Fadeanimation(
              Text(
                'All the information about ev \is from government data.gov.in website',
                style: GoogleFonts.roboto(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              0.5,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Fadeanimation(
                AnimatedBuilder(
                  animation: _buttonScale,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _buttonScale.value, // Apply scaling
                      child: ElevatedButton(
                        onPressed: _onTap,
                        style: ElevatedButton.styleFrom(
                          elevation: 50,
                          shadowColor: Colors.black,
                          backgroundColor:
                              const Color.fromARGB(255, 145, 255, 0),
                          minimumSize: const Size(double.infinity, 60),
                        ),
                        child: Text(
                          "Start",
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 14, 67, 1),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                0.5,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
