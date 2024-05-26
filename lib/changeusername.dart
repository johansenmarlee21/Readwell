import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readwell_app/navbar.dart';


class ChangeUsernamePage extends StatefulWidget {
  const ChangeUsernamePage({super.key});

  @override
  State<ChangeUsernamePage> createState() => _ChangeUsernamePageState();
}

class _ChangeUsernamePageState extends State<ChangeUsernamePage> {
  final thisformKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  String newContent = "";

  TextEditingController controllerUsername = TextEditingController(text: "");

  void changeData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'username': newContent});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0DED5),
      appBar: AppBar(
        backgroundColor: const Color(0xffE0DED5),
        elevation: 0,
        title: Text(
          "Change Username",
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
                height: 250,
                padding: const EdgeInsets.fromLTRB(10, 65, 10, 10),
                decoration: BoxDecoration(
                  color: const Color(0xff605553),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "Please insert a new username.",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffE0DED5),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 320,
                      height: 60,
                      child: Form(
                        key: thisformKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: const Color(0xffD9D9D9),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().length < 3) {
                              return 'Please enter a new username.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            // print("newValue: $newValue");
                            newContent = newValue!;
                            // print("newContent $newContent");
                          },
                          obscureText: false,
                          //used when entering password
                          maxLength: 30, // or maxLines
                          controller: controllerUsername,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 320,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffD9D9D9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: () {
                            print("uname: , $newContent");
                            if (thisformKey.currentState!.validate()) {
                              thisformKey.currentState!.save();
                              changeData();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => navbarall(),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Color(0xff605553),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
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
