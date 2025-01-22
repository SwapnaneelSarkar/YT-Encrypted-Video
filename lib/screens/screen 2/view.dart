import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/color_constant.dart';
import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  static const String iframeViewType = 'youtube-iframe';
  html.IFrameElement? iframe;

  @override
  void initState() {
    super.initState();
    _createIframe();
    _disableRightClick();
  }

  @override
  void dispose() {
    _removeIframe();
    super.dispose();
  }

  static bool _isIframeRegistered = false;

  void _createIframe() {
    iframe = html.IFrameElement()
      ..src =
          'https://www.youtube.com/embed/gkD7TbavRwA?autoplay=1&mute=0&controls=0&modestbranding=1'
      ..style.border = 'none'
      ..style.pointerEvents = 'none' // Completely disable pointer events
      ..width = '100%'
      ..height = '100%'
      ..allow = 'autoplay; encrypted-media;'
      ..setAttribute(
          'sandbox', 'allow-scripts allow-same-origin allow-presentation');

    if (!_isIframeRegistered) {
      ui.platformViewRegistry.registerViewFactory(
        iframeViewType,
        (int viewId) => iframe!,
      );
      _isIframeRegistered = true; // Mark it as registered
    }
  }

  void _removeIframe() {
    iframe?.remove();
    iframe = null;
  }

  void _disableRightClick() {
    html.document.addEventListener('contextmenu', (event) {
      event.preventDefault(); // Disable right-click globally
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SecondPageBloc()..add(LoadVideoEvent()),
      child: Scaffold(
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
            // Foreground content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: BlocBuilder<SecondPageBloc, SecondPageState>(
                  builder: (context, state) {
                    if (state is VideoLoadingState) {
                      return _buildLoadingUI();
                    } else if (state is VideoLoadedState) {
                      return _buildVideoPlayerUI();
                    } else if (state is VideoErrorState) {
                      return _buildErrorUI(state.errorMessage);
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Loading Video...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.accentColor),
        ),
      ],
    );
  }

  Widget _buildVideoPlayerUI() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Embedded YouTube Video with thick border
        Container(
          height: 650,
          width: 1200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ColorConstant.accentColor,
              width: 15, // Thick border on the edge
            ),
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
            child: HtmlElementView(viewType: iframeViewType),
          ),
        ),
        // Floating widget to hide the YouTube logo
        Positioned(
          bottom: 15,
          right: 15,
          child: Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.purpleAccent,
                  Colors.blueAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purpleAccent.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              "06",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Floating widget to hide the top-left text
        Positioned(
          top: 15,
          left: 15,
          child: Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.orangeAccent,
                  Colors.redAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orangeAccent.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              "Code",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Transparent blocking layer to disable interactions
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque, // Fully block interactions
            onTap: () {}, // Do nothing on tap
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorUI(String errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorMessage,
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<SecondPageBloc>(context).add(LoadVideoEvent());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.accentColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text("Retry"),
        ),
      ],
    );
  }
}
