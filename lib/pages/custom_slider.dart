import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    this.height = 200,
    this.width = 90,
  });

  final double height;
  final double width;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final GlobalKey _key = LabeledGlobalKey("main_slider");

  bool _showPercentage = false;
  double _dragPosition = 0;
  double _dragPercentage = 0.5;

  void _onDragStart(DragStartDetails details) {
    if (_key.currentContext == null) return;

    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final localOffset = renderBox.globalToLocal(details.globalPosition);
    _onDrag(localOffset);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_key.currentContext == null) return;

    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final localOffset = renderBox.globalToLocal(details.globalPosition);
    _onDrag(localOffset);
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _showPercentage = false;
    });
  }

  void _onDrag(Offset offset) {
    double tempDragPosition = 0;
    if (offset.dy <= 0) {
      tempDragPosition = 0;
    } else if (offset.dy >= widget.height) {
      tempDragPosition = widget.height;
    } else {
      tempDragPosition = offset.dy;
    }

    setState(() {
      _dragPosition = tempDragPosition;
      _dragPercentage =
          1 - (_dragPosition / widget.height); // Reverse percentage
      if (!_showPercentage) _showPercentage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 180),
          const Text(
            "Energy requirement due to EV's",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            "${(100 + (_dragPercentage * (52604 - 100))).floor()} MU",
            style: TextStyle(
              fontSize: 60, // Adjust the font size
              fontWeight: FontWeight.bold, // Make the text bold
              color: Colors.black, // Set the text color
            ),
          ),
          const SizedBox(height: 100), // Add some spacing below the text
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: widget.height,
                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("2029-30", style: TextStyle(color: Colors.black)),
                      Text("2028-29", style: TextStyle(color: Colors.black)),
                      Text("2027-28", style: TextStyle(color: Colors.black)),
                      Text("2026-27", style: TextStyle(color: Colors.black)),
                      Text("2025-26", style: TextStyle(color: Colors.black)),
                      Text("2024-25", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedOpacity(
                      opacity: _showPercentage ? 1 : 0,
                      duration: const Duration(milliseconds: 100),
                      child: Text(
                        "${(_dragPercentage * 100).floor()}%",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onVerticalDragStart: _onDragStart,
                      onVerticalDragUpdate: _onDragUpdate,
                      onVerticalDragEnd: _onDragEnd,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Battery Cap
                          Positioned(
                            top:
                                -10, // Position the cap slightly above the container
                            left:
                                widget.width / 4, // Center the cap horizontally
                            child: Container(
                              height: 10, // Height of the cap
                              width: widget.width / 2, // Width of the cap
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400, // Color of the cap
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Battery Body
                          Container(
                            key: _key,
                            height: widget.height,
                            width: widget.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 2, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipPath(
                              clipper: PercentagePainter(
                                  percentage: _dragPercentage),
                              child: Container(
                                height: widget.height,
                                width: widget.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 0, 255, 166),
                                      Color.fromARGB(255, 208, 255, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PercentagePainter extends CustomClipper<Path> {
  final double percentage;

  PercentagePainter({this.percentage = 0});

  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height * percentage;

    // Draw the clipping path
    path.moveTo(0, size.height - height); // Start at the calculated height
    path.lineTo(0, size.height); // Bottom left
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(size.width, size.height - height); // Top right
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true; // Always reclip when percentage changes
  }
}
