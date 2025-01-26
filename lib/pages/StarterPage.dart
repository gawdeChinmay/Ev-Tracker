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
                  'Discover Electric Vehicle Insights',
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Add start and end margins
                child: Text(
                  'Access authentic EV data, sourced directly from Indias government platform, data.gov.in.',
                  style: GoogleFonts.roboto(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0), // Add margin at start and end
                        child: ElevatedButton(
                          onPressed: _onTap,
                          style: ElevatedButton.styleFrom(
                            elevation:
                                10, // Optional: Reduce elevation for a smaller appearance
                            shadowColor: Colors.black,
                            backgroundColor:
                                const Color.fromARGB(255, 204, 255, 0),
                            minimumSize: const Size(
                                double.infinity, 40), // Adjusted size
                          ),
                          child: Text(
                            "Start",
                            style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 14, 67, 1),
                              fontSize: 18, // Reduced font size
                            ),
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
