import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  bool isLoading = true; // Flag to show loader

  @override
  void initState() {
    super.initState();
    // Initialize WebViewController when the widget is created
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://odtransportmis.nic.in/EVCell/#/dashboard/register'));

    // Listen to the page load events to control the loader
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        setState(() {
          isLoading = true; // Show loader when page starts loading
        });
      },
      onPageFinished: (url) {
        setState(() {
          isLoading = false; // Hide loader when page finishes loading
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EV Registration"),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller, // Use the WebViewController here
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(), // Show loading indicator
            ),
        ],
      ),
    );
  }
}
