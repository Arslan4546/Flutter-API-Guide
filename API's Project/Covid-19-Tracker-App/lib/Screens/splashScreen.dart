import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'worldStats.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


  late final AnimationController _controller = AnimationController(

      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.push(context,
            MaterialPageRoute(builder: (context)=>const WorldStats())));

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation:_controller ,
                child: Container(
                  height: 250,
                  width: 250,
                  child: const Center(
                    child: Image(
                      image: AssetImage("images/virus.png"),
                    ),
                  ),
                ),
                builder:(BuildContext context, Widget? child ){
                  return Transform.rotate(
                    angle:_controller.value*2.0*math.pi,
                    child: child,
                  );
                }),
            const  SizedBox(height: 50,),
             Align(
              alignment: Alignment.center,
              child: Text("   Covid-19\nTracker App",style:GoogleFonts.archivoBlack(
                textStyle: const  TextStyle(
                 fontSize: 22,
                )
              ),),
            )
          ],
        ),
      ),
    );
  }
}
