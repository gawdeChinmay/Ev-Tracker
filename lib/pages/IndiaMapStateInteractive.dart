import 'package:ev_tracker/pages/statesWiseEv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IndiamapInteractive extends StatefulWidget {
  const IndiamapInteractive({super.key});

  @override
  _IndiamapInteractiveState createState() => _IndiamapInteractiveState();
}

class _IndiamapInteractiveState extends State<StateswiseEv> {
  String svgData = '';

  @override
  void initState() {
    super.initState();
    loadSvg();
  }

  Future<void> loadSvg() async {
    //load your SVG file
    svgData = await DefaultAssetBundle.of(context)
        .loadString('assets/images/india.svg');
    setState(() {});
  }

  void onStateTap(String state) {
    final stateDetails = {
      "Maharashtra": {"stations": 1200}
    };

    final details = stateDetails[state] ?? {"stations": 0};

    // Show popup with state details
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Details for $state',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("EV station count : ${details['stations']}"),
                Text("Ev cars : 12333"),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (svgData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("India map"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("India ev map"),
        ),
        body: GestureDetector(
          onTapDown: (TapDownDetails details) {
            onStateTap("Maharashtra");
          },
          child: SvgPicture.string(
            svgData,
            fit: BoxFit.contain,
            semanticsLabel: "India map",
          ),
        ));
  }
}


// SvgPicture.asset(
//           // 'assets/images/india.svg',
//           svgData,
//           semanticsLabel: "India map",
//           fit: BoxFit.contain,
//           clipBehavior: Clip.hardEdge,
//           alignment: Alignment.center,
//           allowDrawingOutsideViewBox: true,
//           matchTextDirection: true,
//           colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
//           key: ValueKey(svgData),
//         )