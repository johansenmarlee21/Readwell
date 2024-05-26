import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ChangePicturePage extends StatefulWidget {
  const ChangePicturePage({super.key});

  @override
  State<ChangePicturePage> createState() => _ChangePicturePageState();
}

class _ChangePicturePageState extends State<ChangePicturePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0DED5),
      appBar: AppBar(
        backgroundColor: const Color(0xffE0DED5),
        elevation: 0,
        title: Text(
          "Change Profile Picture",
          style: GoogleFonts.poppins(
            color: const Color(0xff333333),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),

              //TextFormField

              Container(
                margin: const EdgeInsets.only(top: 60),
                width: 380,
                height: 360,
                padding: const EdgeInsets.fromLTRB(10, 65, 10, 10),
                decoration: BoxDecoration(
                  color: const Color(0xff605553),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox accountButton(String settingName, Widget settingScreen) {
    return SizedBox(
      width: 350,
      height: 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff605553),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Row(children: [
            Text(
              settingName,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ]),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => settingScreen));
          }),
    );
  }
}
