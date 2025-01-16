import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Evdashboard extends StatelessWidget {
  const Evdashboard({super.key});

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
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(color: Colors.black, fontSize: 10),
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
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          );
                        },
                        interval: 1, // Set interval for X-axis
                      ),
                    ),
                  ),
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
