import 'package:ev_tracker/map/StateDecorator.dart';
import 'package:ev_tracker/map/state-clippers/ap.dart';
import 'package:ev_tracker/map/state-clippers/as.dart';
import 'package:ev_tracker/map/state-clippers/br.dart';
import 'package:ev_tracker/map/state-clippers/ch.dart';
import 'package:ev_tracker/map/state-clippers/ct.dart';
import 'package:ev_tracker/map/state-clippers/dd.dart';
import 'package:ev_tracker/map/state-clippers/dl.dart';
import 'package:ev_tracker/map/state-clippers/dn.dart';
import 'package:ev_tracker/map/state-clippers/ga.dart';
import 'package:ev_tracker/map/state-clippers/gj.dart';
import 'package:ev_tracker/map/state-clippers/hp.dart';
import 'package:ev_tracker/map/state-clippers/hr.dart';
import 'package:ev_tracker/map/state-clippers/jh.dart';
import 'package:ev_tracker/map/state-clippers/jk.dart';
import 'package:ev_tracker/map/state-clippers/ka.dart';
import 'package:ev_tracker/map/state-clippers/kl.dart';
import 'package:ev_tracker/map/state-clippers/mh.dart';
import 'package:ev_tracker/map/state-clippers/ml.dart';
import 'package:ev_tracker/map/state-clippers/mn.dart';
import 'package:ev_tracker/map/state-clippers/mp.dart';
import 'package:ev_tracker/map/state-clippers/mz.dart';
import 'package:ev_tracker/map/state-clippers/nl.dart';
import 'package:ev_tracker/map/state-clippers/or.dart';
import 'package:ev_tracker/map/state-clippers/ori.dart';
import 'package:ev_tracker/map/state-clippers/pb.dart';
import 'package:ev_tracker/map/state-clippers/py.dart';
import 'package:ev_tracker/map/state-clippers/pyi.dart';
import 'package:ev_tracker/map/state-clippers/pyii.dart';
import 'package:ev_tracker/map/state-clippers/rj.dart';
import 'package:ev_tracker/map/state-clippers/sk.dart';
import 'package:ev_tracker/map/state-clippers/tg.dart';
import 'package:ev_tracker/map/state-clippers/tn.dart';
import 'package:ev_tracker/map/state-clippers/tn_i.dart';
import 'package:ev_tracker/map/state-clippers/tr.dart';
import 'package:ev_tracker/map/state-clippers/up.dart';
import 'package:ev_tracker/map/state-clippers/ut.dart';
import 'package:ev_tracker/map/state-clippers/wb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StateswiseEv extends StatefulWidget {
  const StateswiseEv({super.key});

  @override
  State<StateswiseEv> createState() => _StateswiseEvState();
}

class _StateswiseEvState extends State<StateswiseEv> {
  // String svgData = '';
  String? selectedState;
  double? selectedXShift;
  double? selectedYShift;

  void onStateTapped(String state, double xShift, double yShift) {
    setState(() {
      selectedState = state;
      selectedXShift = xShift;
      selectedYShift = yShift;
    });

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
                // Text("EV station count : ${details['stations']}"),
                Text("Ev cars : 12333"),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: <Widget>[
          StateDecorator(
            xShift: 65, yShift: 215, stateClipper: JKClipper(),
            isSelected: selectedState == "JK", // Highlight if selected
            onTap: () => onStateTapped("JK", 65, 215),
          ),
          StateDecorator(
            xShift: 106, yShift: 281, stateClipper: HPClipper(),
            isSelected: selectedState == "HP", // Highlight if selected
            onTap: () => onStateTapped("HP", 65, 215),
          ),
          StateDecorator(
            xShift: 133, yShift: 311, stateClipper: UTclipper(),
            isSelected: selectedState == "UT", // Highlight if selected
            onTap: () => onStateTapped("UT", 65, 215),
          ),
          StateDecorator(
            xShift: 82, yShift: 292, stateClipper: PBClipper(),
            isSelected: selectedState == "PB", // Highlight if selected
            onTap: () => onStateTapped("PB", 65, 215),
          ),
          StateDecorator(
            xShift: 121, yShift: 322, stateClipper: CHClipper(),
            isSelected: selectedState == "CH", // Highlight if selected
            onTap: () => onStateTapped("CH", 65, 215),
          ),
          StateDecorator(
            xShift: 90, yShift: 320, stateClipper: HRClipper(),
            isSelected: selectedState == "HR", // Highlight if selected
            onTap: () => onStateTapped("HR", 65, 215),
          ),
          StateDecorator(
            xShift: 123, yShift: 353, stateClipper: DLClipper(),
            isSelected: selectedState == "DL", // Highlight if selected
            onTap: () => onStateTapped("DL", 65, 215),
          ),
          StateDecorator(
            xShift: 126, yShift: 328, stateClipper: UPClipper(),
            isSelected: selectedState == "UP", // Highlight if selected
            onTap: () => onStateTapped("UP", 65, 215),
          ),
          StateDecorator(
            xShift: 21, yShift: 332, stateClipper: RJClipper(),
            isSelected: selectedState == "RJ", // Highlight if selected
            onTap: () => onStateTapped("RJ", 65, 215),
          ),
          StateDecorator(
            xShift: 84, yShift: 385, stateClipper: MPClipper(),
            isSelected: selectedState == "MP", // Highlight if selected
            onTap: () => onStateTapped("MP", 65, 215),
          ),
          StateDecorator(
            xShift: 8, yShift: 420, stateClipper: GJClipper(),
            isSelected: selectedState == "GJ", // Highlight if selected
            onTap: () => onStateTapped("GJ", 65, 215),
          ), //to modify
          StateDecorator(
            xShift: 38, yShift: 477, stateClipper: DDClipper(),
            isSelected: selectedState == "DD", // Highlight if selected
            onTap: () => onStateTapped("DD", 65, 215),
          ),
          StateDecorator(
            xShift: 65, yShift: 461, stateClipper: MHClipper(),
            isSelected: selectedState == "MH", // Highlight if selected
            onTap: () => onStateTapped("MH", 65, 215),
          ),
          StateDecorator(
            xShift: 79, yShift: 555, stateClipper: GAClipper(),
            isSelected: selectedState == "GA", // Highlight if selected
            onTap: () => onStateTapped("GA", 65, 215),
          ),
          StateDecorator(
            xShift: 85, yShift: 515, stateClipper: KAClipper(),
            isSelected: selectedState == "KA", // Highlight if selected
            onTap: () => onStateTapped("KA", 65, 215),
          ),
          StateDecorator(
            xShift: 129, yShift: 493, stateClipper: TGClipper(),
            isSelected: selectedState == "TG", // Highlight if selected
            onTap: () => onStateTapped("TG", 65, 215),
          ),
          StateDecorator(
            xShift: 122, yShift: 505, stateClipper: APClipper(),
            isSelected: selectedState == "AP", // Highlight if selected
            onTap: () => onStateTapped("AP", 65, 215),
          ),
          StateDecorator(
            xShift: 96, yShift: 599, stateClipper: KLClipper(),
            isSelected: selectedState == "KL", // Highlight if selected
            onTap: () => onStateTapped("KL", 65, 215),
          ),
          StateDecorator(
            xShift: 115, yShift: 588, stateClipper: TNClipper(),
            isSelected: selectedState == "TN", // Highlight if selected
            onTap: () => onStateTapped("TN", 65, 215),
          ),
          StateDecorator(
            xShift: 156.3, yShift: 649.12, stateClipper: TNIClipper(),
            isSelected: selectedState == "TNI", // Highlight if selected
            onTap: () => onStateTapped("TNI", 65, 215),
          ),
          StateDecorator(
            xShift: 170, yShift: 429, stateClipper: CTClipper(),
            isSelected: selectedState == "CT", // Highlight if selected
            onTap: () => onStateTapped("CT", 65, 215),
          ),
          StateDecorator(
            xShift: 186, yShift: 453, stateClipper: ORClipper(),
            isSelected: selectedState == "OR", // Highlight if selected
            onTap: () => onStateTapped("OR", 65, 215),
          ),
          StateDecorator(
            xShift: 260, yShift: 480, stateClipper: ORIClipper(),
            isSelected: selectedState == "ORI", // Highlight if selected
            onTap: () => onStateTapped("ORI", 65, 215),
          ),
          StateDecorator(
            xShift: 213, yShift: 410, stateClipper: JHClipper(),
            isSelected: selectedState == "JH", // Highlight if selected
            onTap: () => onStateTapped("JH", 65, 215),
          ),
          StateDecorator(
            xShift: 213, yShift: 375, stateClipper: BRClipper(),
            isSelected: selectedState == "BR", // Highlight if selected
            onTap: () => onStateTapped("BR", 65, 215),
          ),
          StateDecorator(
            xShift: 247,
            yShift: 380,
            stateClipper: WBClipper(),
            isSelected: selectedState == "WB", // Highlight if selected
            onTap: () => onStateTapped("WB", 65, 215),
          ), //add subpart
          StateDecorator(
            xShift: 278, yShift: 365, stateClipper: SKClipper(),
            isSelected: selectedState == "SK", // Highlight if selected
            onTap: () => onStateTapped("SK", 65, 215),
          ),
          StateDecorator(
            xShift: 301, yShift: 368, stateClipper: ASClipper(),
            isSelected: selectedState == "AS", // Highlight if selected
            onTap: () => onStateTapped("AS", 65, 215),
          ),
          StateDecorator(
            xShift: 303, yShift: 397, stateClipper: MLClipper(),
            isSelected: selectedState == "ML", // Highlight if selected
            onTap: () => onStateTapped("ML", 65, 215),
          ),
          StateDecorator(
            xShift: 351, yShift: 383, stateClipper: NLClipper(),
            isSelected: selectedState == "NL", // Highlight if selected
            onTap: () => onStateTapped("NL", 65, 215),
          ),
          StateDecorator(
            xShift: 346, yShift: 404, stateClipper: MNClipper(),
            isSelected: selectedState == "MN", // Highlight if selected
            onTap: () => onStateTapped("MN", 65, 215),
          ),
          StateDecorator(
            xShift: 336, yShift: 422, stateClipper: MZClipper(),
            isSelected: selectedState == "MZ", // Highlight if selected
            onTap: () => onStateTapped("MZ", 65, 215),
          ),
          StateDecorator(
            xShift: 321, yShift: 422, stateClipper: TRClipper(),
            isSelected: selectedState == "TR", // Highlight if selected
            onTap: () => onStateTapped("TR", 65, 215),
          ),
          StateDecorator(
            xShift: 69, yShift: 486, stateClipper: DNClipper(),
            isSelected: selectedState == "DN", // Highlight if selected
            onTap: () => onStateTapped("DN", 65, 215),
          ),
          StateDecorator(
            xShift: 163, yShift: 625, stateClipper: PYClipper(),
            isSelected: selectedState == "PY", // Highlight if selected
            onTap: () => onStateTapped("PY", 65, 215),
          ),
          StateDecorator(
            xShift: 162, yShift: 610, stateClipper: PYIClipper(),
            isSelected: selectedState == "PYI", // Highlight if selected
            onTap: () => onStateTapped("PYI", 65, 215),
          ),
          StateDecorator(
            xShift: 197, yShift: 540, stateClipper: PYIIClipper(),
            isSelected: selectedState == "PYII", // Highlight if selected
            onTap: () => onStateTapped("PYII", 65, 215),
          ),
        ],
      ),
    );
  }
}
