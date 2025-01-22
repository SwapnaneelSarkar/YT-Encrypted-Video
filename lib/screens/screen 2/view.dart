import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';

class SecondPage extends StatelessWidget {
  final String youtubeUrl;

  SecondPage({required this.youtubeUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorConstant.backgroundColor,
                  ColorConstant.backgroundColorDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Foreground Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildVideoPlayerUI(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayerUI(BuildContext context) {
    final iframe = html.IFrameElement()
      ..width = '100%'
      ..height = '100%'
      ..src = '$youtubeUrl?autoplay=1&mute=1'
      ..style.border = 'none';

    // Use HtmlElementView to embed the iframe
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Enjoy the Experience",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: ColorConstant.accentColor,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Embedded YouTube Video
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.accentColor.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: HtmlElementView(
              viewType: 'youtube-iframe',
              onPlatformViewCreated: (int viewId) {
                html.document
                    .getElementById('flutter-view-$viewId')
                    ?.append(iframe);
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.accentColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            "Go Back",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
