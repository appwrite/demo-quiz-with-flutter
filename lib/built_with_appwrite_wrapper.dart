import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class BuiltWithAppwriteWrapper extends StatelessWidget {
  const BuiltWithAppwriteWrapper({Key? key, required this.child})
      : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Expanded(
            child: child,
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
              onTap: () {
                try {
                  launchUrl(Uri.parse('https://appwrite.io'));
                } catch (e) {}
              },
              child: SvgPicture.asset('assets/built-with-appwrite-hr.svg')),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
