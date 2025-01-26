import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ev_tracker/pages/ApplyForSubsidy.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Evdashboard extends StatefulWidget {
  const Evdashboard({super.key});

  @override
  State<Evdashboard> createState() => _EvdashboardState();
}

class _EvdashboardState extends State<Evdashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String annotationText = "73%"; // Initial annotation text
  double pointerValue = 50; // Initial pointer value
  String clickedAxis = "";
  final GlobalKey _gaugeKey = GlobalKey();
  String tappedColor = "";

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    )..repeat(reverse: false); // Continuously loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _detectAxisTap(Offset localPosition, Size size) {
    print(" local clicked = $localPosition $size");

    // Calculate tap position relative to the center of the gauge
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final double dx = localPosition.dx - centerX;
    final double dy = localPosition.dy - centerY;

    // Calculate distance from the center
    final double distance = (dx * dx + dy * dy);

    // Check for specific radius ranges to determine the axis clicked
    if (localPosition.dx >= 252 && localPosition.dy < 722) {
      setState(() {
        clickedAxis = "Axis 1 (Amber)";
      });
    } else if (distance >= 130 && distance < 180) {
      setState(() {
        clickedAxis = "Axis 2 (Red)";
      });
    } else if (distance >= 180 && distance < 230) {
      setState(() {
        clickedAxis = "Axis 3 (Green)";
      });
    } else if (distance >= 230 && distance < 280) {
      setState(() {
        clickedAxis = "Axis 4 (Blue)";
      });
    } else {
      setState(() {
        clickedAxis = "Outside Axes";
      });
    }
  }

  Future<void> _getColorAtTap(Offset localPosition) async {
    try {
      print("in color");

      final renderObject =
          _gaugeKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

      // Capture the widget as an image
      final ui.Image image = await renderObject.toImage();
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.rawRgba);

      if (byteData != null) {
        final int pixelOffset = (localPosition.dy.toInt() * image.width +
                localPosition.dx.toInt()) *
            4;

        // Extract RGBA values
        final int red = byteData.getUint8(pixelOffset);
        final int green = byteData.getUint8(pixelOffset + 1);
        final int blue = byteData.getUint8(pixelOffset + 2);

        print("in color green $green ");
        print("in color red $red ");
        print("in color blue $blue  ");

        setState(() {
          // tappedColor = "R: $red, G: $green, B: $blue";
          if (red == 255 && blue == 7) {
            tappedColor = "5.28 %";
          } else if (green == 219) {
            tappedColor = "52.41 %";
          } else if (red == 219) {
            tappedColor = "2.09 %";
          } else if (blue == 243) {
            tappedColor = "1.99 %";
          }
        });
      }
    } catch (e) {
      setState(() {
        tappedColor = "Error detecting color: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Apply for Subsidy',
                  style: TextStyle(
                    color: Colors.black, // Base text color
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildCard(
                    title: "Two Wheelers 2kWh",
                    description: "Incentive amt paid \n15000/- per kWh",
                    icon: Icons.electric_bike,
                    color: Colors.amber,
                    gradientColors: [
                      const Color.fromARGB(255, 255, 255, 255),
                      const Color.fromARGB(255, 255, 255, 255)
                    ],
                    controller: _controller // Example icon
                    ),
                const SizedBox(height: 16),
                _buildCard(
                    title: "Four Wheelers 15kWh",
                    description: "Incentive amt paid \n10000/- per kWh",
                    icon: Icons.electric_car_outlined,
                    color: const Color.fromARGB(255, 0, 174, 255),
                    gradientColors: [
                      Colors.black,
                      const Color.fromARGB(255, 0, 208, 255)
                    ],
                    controller: _controller // Example icon
                    ),
                const SizedBox(height: 16),
                _buildCard(
                    title: "EV - Buses 250kWh",
                    description: "Incentive amt paid \n20000/- per kWh",
                    icon: Icons.directions_bus_sharp,
                    color: const Color.fromARGB(255, 222, 31, 31),
                    gradientColors: [
                      Colors.black,
                      const Color.fromARGB(255, 220, 19, 19)
                    ],
                    controller: _controller // Example icon
                    ),
                _buildCard(
                    title: "3 Wheelers kWh",
                    description: "Incentive amt paid \n10000/- per kWh",
                    icon: Icons.electric_rickshaw,
                    color: const Color.fromARGB(255, 12, 229, 59),
                    gradientColors: [
                      const Color.fromARGB(255, 0, 0, 0),
                      const Color.fromARGB(255, 30, 197, 14)
                    ],
                    controller: _controller // Example icon
                    ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Most Sold Ev:',
                  style: TextStyle(
                    color: Colors.black, // Base text color
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 27,
                      height: 13,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "2ev",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 27,
                      height: 13,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 182, 245),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "4ev",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 27,
                      height: 13,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 42, 236, 52),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "3ev",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 27,
                      height: 13,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 231, 28, 28),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "busev",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                //here
                GestureDetector(
                    onTapDown: (details) {
                      //   final RenderBox renderBox =
                      //       context.findRenderObject() as RenderBox;
                      //   final Offset localPosition =
                      //       renderBox.globalToLocal(details.globalPosition);

                      //   // Detect the axis based on the tap position
                      //   _detectAxisTap(localPosition, renderBox.size);
                      final RenderBox box = _gaugeKey.currentContext
                          ?.findRenderObject() as RenderBox;
                      final Offset localPosition =
                          box.globalToLocal(details.globalPosition);

                      _getColorAtTap(localPosition);
                    },
                    child: RepaintBoundary(
                      key: _gaugeKey,
                      child: SfRadialGauge(
                        axes: [
                          RadialAxis(
                            radiusFactor: 0.65,
                            axisLineStyle: AxisLineStyle(
                                thickness: 25, color: Colors.grey.shade200),
                            startAngle: 270,
                            endAngle: 270,
                            showLabels: false,
                            showTicks: false,
                            annotations: [
                              GaugeAnnotation(
                                widget: Text(
                                  // clickedAxis,
                                  tappedColor,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Colors.black),
                                ),
                                angle: 270,
                                positionFactor: 0.1,
                              )
                            ],
                          ),
                          RadialAxis(
                            radiusFactor: 0.8,
                            pointers: const [
                              RangePointer(
                                value: 5.28,
                                color: Colors.amber,
                                width: 50,
                              )
                            ],
                            startAngle: 59,
                            endAngle: 59,
                            showLabels: false,
                            showTicks: false,
                            showAxisLine: false,
                          ),
                          RadialAxis(
                            radiusFactor: 0.8,
                            pointers: const [
                              RangePointer(
                                value: 2.0,
                                color: Color.fromARGB(255, 219, 19, 19),
                                width: 50,
                              )
                            ],
                            startAngle: 78,
                            endAngle: 78,
                            showLabels: false,
                            showTicks: false,
                            showAxisLine: false,
                          ),
                          RadialAxis(
                            radiusFactor: 0.8,
                            pointers: const [
                              RangePointer(
                                value: 52,
                                color: Color.fromARGB(255, 32, 219, 19),
                                width: 50,
                              )
                            ],
                            startAngle: 90,
                            endAngle: 90,
                            showLabels: false,
                            showTicks: false,
                            showAxisLine: false,
                          ),
                          RadialAxis(
                            radiusFactor: 0.8,
                            pointers: const [
                              RangePointer(
                                value: 1.99,
                                color: Colors.blue,
                                width: 50,
                              )
                            ],
                            startAngle: 85,
                            endAngle: 85,
                            showLabels: false,
                            showTicks: false,
                            showAxisLine: false,
                          )
                        ],
                      ),
                    ))
                //here
              ])))
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    final List<Color> gradiantColors = [Colors.white, Colors.black];

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total EVs Registered',
              style: GoogleFonts.roboto(
                color: Colors.white.withOpacity(0.5),
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                '1681127',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 200, // Set the height of the chart
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false), // Show grid lines
                  titlesData: FlTitlesData(
                      show: true,
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            );
                          },
                          interval: 5000, // Set interval for Y-axis
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '202${value.toInt()}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            );
                          },
                          interval: 1, // Set interval for X-axis
                        ),
                      ),
                      rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: false,
                      )),
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false))),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6, // 12 months (0-11)
                  minY: 0,
                  maxY: 2081127, // Maximum value for Y-axis
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(-1, 103604),
                        FlSpot(0, 173604),
                        FlSpot(1, 142383),
                        FlSpot(2, 459058),
                        FlSpot(3, 1183341),
                        FlSpot(4, 1681127),
                      ],
                      isCurved: true,
                      color: Color.fromARGB(255, 204, 255, 0),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Colors.black,
                      //     Color.fromARGB(255, 204, 255, 0), // Start color
                      //     // End color
                      //   ],
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),

                      barWidth: 4,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 204, 255, 0).withOpacity(0.4),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          // Highlight the first and last points
                          if (index == 0 || index == barData.spots.length - 1) {
                            return FlDotCirclePainter(
                              radius: 6, // Size of the highlighted dots
                              color:
                                  Colors.white, // Color of the highlighted dots
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            );
                          }
                          return FlDotCirclePainter(
                            radius: 4, // Default size for other points
                            color: Color.fromARGB(255, 204, 255, 0),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget _buildCard({
//   required String title,
//   required String description,
//   required IconData icon,
//   required Color color,
//   required List<Color> gradientColors,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: gradientColors,
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       borderRadius: BorderRadius.circular(12), // Match the card shape
//     ),
//     margin: const EdgeInsets.symmetric(vertical: 8.0),
//     child: Card(
//       color: Colors.transparent, // Set card color to transparent
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Icon(icon, size: 40, color: color), // Adjust icon color
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white, // Match text color to gradient
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     description,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70, // Slightly lighter text color
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

Widget _buildCard({
  required String title,
  required String description,
  required IconData icon,
  required Color color,
  required List<Color> gradientColors,
  required AnimationController controller,
}) {
  return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: gradientColors,
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        borderRadius: BorderRadius.circular(12), // Match the card shape
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: const Color.fromARGB(255, 243, 241, 241),
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  // Calculate the shimmer position
                  final gradientPosition = controller.value;

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6.0,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplyScreen()));
                    },
                    // child: ShaderMask(
                    //   blendMode: BlendMode.srcATop,
                    //   shaderCallback: (bounds) {
                    //     return LinearGradient(
                    //       colors: [
                    //         Colors.white.withOpacity(0.2),
                    //         Colors.white,
                    //         Colors.white.withOpacity(0.2),
                    //       ],
                    //       stops: const [0.0, 0.5, 1.0],
                    //       begin: Alignment.centerRight,
                    //       end: Alignment.centerLeft,
                    //       transform:
                    //           GradientRotation(gradientPosition * 2 * 3.14),
                    //     ).createShader(bounds);
                    //   },
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white, // Base text color
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      // ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ));
}
