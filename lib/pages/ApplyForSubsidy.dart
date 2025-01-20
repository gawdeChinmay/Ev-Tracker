import 'package:ev_tracker/pages/WebViewScreen.dart';
import 'package:flutter/material.dart';

class ApplyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details required to apply for EV subsidy.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
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
              '3. Vehicle number:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              '4. Chasis Number:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(
                left: 16.0, // marginStart
                right: 16.0, // marginEnd
                bottom: 86.0, // marginBottom
              ),
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
                  // Handle apply button action
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Application Submitted')),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebViewScreen()),
                  );
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
