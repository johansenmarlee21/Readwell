import 'package:flutter/material.dart';
import 'package:readwell_app/navbar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(seconds: 1), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => navbarall()));
  }

  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xffE0DED5),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Center(
                      child: Image(
                    image: AssetImage('asset/images/readwell-high-resolution-logo.png'),
                    fit: BoxFit.fill,
                    width: 400,
                  ))),
            )
          ],
        ));
  }
}
