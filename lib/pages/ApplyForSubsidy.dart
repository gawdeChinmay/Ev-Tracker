import 'package:ev_tracker/pages/WebViewScreen.dart';
import 'package:flutter/material.dart';

class ApplyScreen extends StatefulWidget {
  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  String? selectedState;

  final Map<String, String> stateLinks = {
    'Odisha': 'https://odtransportmis.nic.in/EVCell/#/dashboard/register',
    'Uttar Pradesh': 'https://upevsubsidy.in/register?disclaimer=true',
    'Bihar': 'https://odtransportmis.nic.in/EVBihar/#/dashboard/register',
    'Goa': 'https://goaev.in/form',
    'Harayana': 'https://egrashry.nic.in/WebPages/SubsidyOnEVehicle',
    'Gujarat': 'https://gogreenglwb.gujarat.gov.in/indexGLWB.aspx?ServiceID=9',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details required to apply for EV subsidy.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              '1. Scan copy of first page of Vehicle Owner\'s Bank Passbook.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              '2. OTP & other communication will be sent via SMS to your Mobile Number linked with your RC.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              '3. Vehicle number.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              '4. Chasis Number.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),

            /// 🔽 Dropdown for selecting state
            SizedBox(
              height: 60, // Set desired height here
              child: DropdownButton<String>(
                hint: const Text('Select your state'),
                value: selectedState,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedState = newValue;
                  });
                },
                items: stateLinks.keys.map((String state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
              ),
            ),

            const Spacer(),

            /// 🔘 Apply button
            Container(
              margin:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 86.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 6.0,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  if (selectedState != null) {
                    String link = stateLinks[selectedState]!;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(url: link),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a state')),
                    );
                  }
                },
                child: const Center(
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
