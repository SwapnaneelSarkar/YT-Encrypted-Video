import 'dart:html' as html;
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/color_constant.dart';
import '../../router/router.dart';
import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  late html.VideoElement _videoElement;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _videoElement = html.VideoElement()
      ..src = 'assets/matrix.mp4'
      ..autoplay = true
      ..loop = true
      ..muted = true
      ..style.position = 'absolute'
      ..style.top = '0'
      ..style.left = '0'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover'
      ..style.zIndex = '-1'
      ..style.opacity = '0.3';

    html.document.body?.append(_videoElement);

    _animationController.forward();
  }

  @override
  void dispose() {
    _videoElement.remove();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(),
                );
              },
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushNamed(context, AppRouter.secondScreen);
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid Code')),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Futuristic title with glow
                      Text(
                        'Access Terminal',
                        style: TextStyle(
                          fontFamily: 'Orbitron', // Add futuristic font
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: ColorConstant.accentColor,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Enter your access code to proceed.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 30),

                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorConstant.accentColor.withOpacity(0.5),
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: ColorConstant.accentColor,
                              width: 1.5,
                            ),
                          ),
                          child: TextField(
                            controller: TextEditingController(),
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter Code',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Animated button with gradient glow
                      GestureDetector(
                        onTap: () {
                          // Log button press
                          print("Submit button pressed.");

                          // Navigate to the second page with the YouTube URL as an argument
                          Navigator.pushNamed(
                            context,
                            '/second', // Route for the second page
                            arguments: {
                              'youtubeUrl':
                                  'https://www.youtube.com/watch?v=gkD7TbavRwA', // Pass the YouTube URL
                            },
                          );
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorConstant.accentColor,
                                  ColorConstant.accentColor.withOpacity(0.8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstant.accentColor.withOpacity(
                                    0.6,
                                  ),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Loading animation
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return SpinKitFadingCircle(
                              color: ColorConstant.accentColor,
                              size: 50.0,
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
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
