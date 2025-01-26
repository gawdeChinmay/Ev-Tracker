import 'dart:convert';

import 'package:ev_tracker/Config/api_config.dart';
import 'package:ev_tracker/map/StateDecorator.dart';
import 'package:ev_tracker/map/state-clippers/ap.dart';
import 'package:ev_tracker/map/state-clippers/arp.dart';
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
import 'package:ev_tracker/model/StatePcStationInIndiaGetResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
  // Map<String, dynamic> stateDetails = {};

  final String apiUrl =
      "${ApiConfig.baseUrl}203a82ce-9b00-4e3a-b18d-daf85e16684f?api-key=${ApiConfig.apiKey}&format=json&limit=100";

  Map<String, dynamic> stateDetails =
      {}; // Declare stateDetails globally or in your widget's state

  Future<void> fetchStateData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl'));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final parsedJson = jsonDecode(jsonString);
        final evResponse = EVChargingStationsResponse.fromJson(parsedJson);

        // Update the stateDetails map
        setState(() {
          stateDetails.clear(); // Clear previous data
          for (var record in evResponse.records) {
            stateDetails[record.stateOrUt] = {
              "stations": record.pcsCount,
            };
          }
        });

        // Debugging
        print('State details updated: $stateDetails');
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void onStateTapped(String state, double xShift, double yShift) async {
    setState(() {
      selectedState = state;
      selectedXShift = xShift;
      selectedYShift = yShift;
    });

    await fetchStateData();

    final details = stateDetails[state] ?? {"stations": "N/A"};

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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text("EV station count: ${details['stations']}"),
              // You can update this with real data later
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: <Widget>[
          StateDecorator(
            xShift: 65, yShift: 215, stateClipper: JKClipper(),
            isSelected:
                selectedState == "Jammu and Kashmir", // Highlight if selected
            onTap: () => onStateTapped("Jammu and Kashmir", 65, 215),
          ),
          StateDecorator(
            xShift: 106, yShift: 281, stateClipper: HPClipper(),
            isSelected:
                selectedState == " Himachal Pradesh", // Highlight if selected
            onTap: () => onStateTapped(" Himachal Pradesh", 106, 281),
          ),
          StateDecorator(
            xShift: 133, yShift: 311, stateClipper: UTclipper(),
            isSelected: selectedState == "Uttarakhand", // Highlight if selected
            onTap: () => onStateTapped("Uttarakhand", 133, 311),
          ),
          StateDecorator(
            xShift: 82, yShift: 292, stateClipper: PBClipper(),
            isSelected: selectedState == "Punjab", // Highlight if selected
            onTap: () => onStateTapped("Punjab", 82, 292),
          ),
          StateDecorator(
            xShift: 121, yShift: 322, stateClipper: CHClipper(),
            isSelected: selectedState == "CH", // Highlight if selected
            onTap: () => onStateTapped("CH", 121, 322),
          ),
          StateDecorator(
            xShift: 90, yShift: 320, stateClipper: HRClipper(),
            isSelected: selectedState == "Haryana", // Highlight if selected
            onTap: () => onStateTapped("Haryana", 90, 320),
          ),
          StateDecorator(
            xShift: 123, yShift: 353, stateClipper: DLClipper(),
            isSelected: selectedState == "DL", // Highlight if selected
            onTap: () => onStateTapped("DL", 123, 353),
          ),
          StateDecorator(
            xShift: 126, yShift: 328, stateClipper: UPClipper(),
            isSelected:
                selectedState == "Uttar Pradesh", // Highlight if selected
            onTap: () => onStateTapped("Uttar Pradesh", 126, 328),
          ),
          StateDecorator(
            xShift: 21, yShift: 332, stateClipper: RJClipper(),
            isSelected: selectedState == "Rajasthan", // Highlight if selected
            onTap: () => onStateTapped("Rajasthan", 21, 332),
          ),
          StateDecorator(
            xShift: 84, yShift: 385, stateClipper: MPClipper(),
            isSelected:
                selectedState == "Madhya Pradesh", // Highlight if selected
            onTap: () => onStateTapped("Madhya Pradesh", 84, 385),
          ),
          StateDecorator(
            xShift: 8, yShift: 420, stateClipper: GJClipper(),
            isSelected: selectedState == "Gujarat", // Highlight if selected
            onTap: () => onStateTapped("Gujarat", 8, 420),
          ), //to modify
          StateDecorator(
            xShift: 38, yShift: 477, stateClipper: DDClipper(),
            isSelected:
                selectedState == "Daman and Diu", // Highlight if selected
            onTap: () => onStateTapped("Daman and Diu", 38, 477),
          ),
          StateDecorator(
            xShift: 65, yShift: 461, stateClipper: MHClipper(),
            isSelected: selectedState == "Maharashtra", // Highlight if selected
            onTap: () => onStateTapped("Maharashtra", 65, 461),
          ),
          StateDecorator(
            xShift: 79, yShift: 555, stateClipper: GAClipper(),
            isSelected: selectedState == "Goa", // Highlight if selected
            onTap: () => onStateTapped("Goa", 79, 555),
          ),
          StateDecorator(
            xShift: 85, yShift: 515, stateClipper: KAClipper(),
            isSelected: selectedState == "Karnataka", // Highlight if selected
            onTap: () => onStateTapped("Karnataka", 85, 515),
          ),
          StateDecorator(
            xShift: 129, yShift: 493, stateClipper: TGClipper(),
            isSelected: selectedState == "Telangana", // Highlight if selected
            onTap: () => onStateTapped("Telangana", 129, 493),
          ),
          StateDecorator(
            xShift: 122, yShift: 505, stateClipper: APClipper(),
            isSelected:
                selectedState == "Andhra Pradesh", // Highlight if selected
            onTap: () => onStateTapped("Andhra Pradesh", 122, 505),
          ),
          StateDecorator(
            xShift: 96, yShift: 599, stateClipper: KLClipper(),
            isSelected: selectedState == "Kerala", // Highlight if selected
            onTap: () => onStateTapped("Kerala", 96, 599),
          ),
          StateDecorator(
            xShift: 115, yShift: 588, stateClipper: TNClipper(),
            isSelected: selectedState == "Tamil Nadu", // Highlight if selected
            onTap: () => onStateTapped("Tamil Nadu", 115, 588),
          ),
          StateDecorator(
            xShift: 156.3, yShift: 649.12, stateClipper: TNIClipper(),
            isSelected: selectedState == "TNI", // Highlight if selected
            onTap: () => onStateTapped("TNI", 156.3, 649.12),
          ),
          StateDecorator(
            xShift: 170, yShift: 429, stateClipper: CTClipper(),
            isSelected:
                selectedState == "Chhattisgarh", // Highlight if selected
            onTap: () => onStateTapped("Chhattisgarh", 170, 429),
          ),
          StateDecorator(
            xShift: 186, yShift: 453, stateClipper: ORClipper(),
            isSelected: selectedState == "Odisha", // Highlight if selected
            onTap: () => onStateTapped("Odisha", 186, 453),
          ),
          StateDecorator(
            xShift: 260, yShift: 480, stateClipper: ORIClipper(),
            isSelected: selectedState == "ORI", // Highlight if selected
            onTap: () => onStateTapped("ORI", 260, 480),
          ),
          StateDecorator(
            xShift: 213, yShift: 410, stateClipper: JHClipper(),
            isSelected: selectedState == "Jharkhand", // Highlight if selected
            onTap: () => onStateTapped("Jharkhand", 213, 410),
          ),
          StateDecorator(
            xShift: 213, yShift: 375, stateClipper: BRClipper(),
            isSelected: selectedState == "Bihar", // Highlight if selected
            onTap: () => onStateTapped("Bihar", 213, 375),
          ),
          StateDecorator(
            xShift: 247,
            yShift: 380,
            stateClipper: WBClipper(),
            isSelected: selectedState == "West Bengal", // Highlight if selected
            onTap: () => onStateTapped("West Bengal", 247, 380),
          ), //add subpart
          StateDecorator(
            xShift: 278, yShift: 365, stateClipper: SKClipper(),
            isSelected: selectedState == "Sikkim", // Highlight if selected
            onTap: () => onStateTapped("Sikkim", 278, 365),
          ),
          StateDecorator(
            xShift: 301, yShift: 368, stateClipper: ASClipper(),
            isSelected: selectedState == "Assam", // Highlight if selected
            onTap: () => onStateTapped("Assam", 301, 368),
          ),
          StateDecorator(
            xShift: 303, yShift: 397, stateClipper: MLClipper(),
            isSelected: selectedState == "Meghalaya", // Highlight if selected
            onTap: () => onStateTapped("Meghalaya", 303, 397),
          ),
          StateDecorator(
            xShift: 351, yShift: 383, stateClipper: NLClipper(),
            isSelected: selectedState == "Nagaland", // Highlight if selected
            onTap: () => onStateTapped("Nagaland", 351, 383),
          ),
          StateDecorator(
            xShift: 346, yShift: 404, stateClipper: MNClipper(),
            isSelected: selectedState == "Manipur", // Highlight if selected
            onTap: () => onStateTapped("Manipur", 346, 404),
          ),
          StateDecorator(
            xShift: 336, yShift: 422, stateClipper: MZClipper(),
            isSelected: selectedState == "MZ", // Highlight if selected
            onTap: () => onStateTapped("MZ", 336, 422),
          ),
          StateDecorator(
            xShift: 321, yShift: 422, stateClipper: TRClipper(),
            isSelected: selectedState == "Tripura", // Highlight if selected
            onTap: () => onStateTapped("Tripura", 321, 422),
          ),
          StateDecorator(
            xShift: 69, yShift: 486, stateClipper: DNClipper(),
            isSelected: selectedState == "DN", // Highlight if selected
            onTap: () => onStateTapped("DN", 69, 486),
          ),
          StateDecorator(
            xShift: 163, yShift: 625, stateClipper: PYClipper(),
            isSelected: selectedState == "PY", // Highlight if selected
            onTap: () => onStateTapped("PY", 163, 625),
          ),
          StateDecorator(
            xShift: 162, yShift: 610, stateClipper: PYIClipper(),
            isSelected: selectedState == "PYI", // Highlight if selected
            onTap: () => onStateTapped("PYI", 162, 610),
          ),
          StateDecorator(
            xShift: 197, yShift: 540, stateClipper: PYIIClipper(),
            isSelected: selectedState == "PYII", // Highlight if selected
            onTap: () => onStateTapped("PYII", 197, 540),
          ),
          StateDecorator(
            xShift: 500, yShift: 400, stateClipper: ARPClipper(),
            isSelected: selectedState == "ARP", // Highlight if selected
            onTap: () => onStateTapped("ARP", 197, 540),
          )
        ],
      ),
    );
  }
}
