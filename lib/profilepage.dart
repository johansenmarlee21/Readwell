// import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readwell_app/changepassword.dart';
import 'package:readwell_app/changeusername.dart';
import 'package:readwell_app/loginpage.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final auth = FirebaseAuth.instance;
  String userName = '';

  void getCurrentUserData() async{
    final users = FirebaseFirestore.instance.collection('users');
    final userData = await users.doc(user.uid).get();
    setState(() {
      userName = userData.data()!['username'];
    });
  }

  // void deleteAccount() async {
  //   final auth = FirebaseAuth.instance;
    
  // }


  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0DED5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 120),
                    width: 380,
                    height: 500,
                    padding: const EdgeInsets.fromLTRB(10, 65, 10, 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff605553),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Hello, $userName",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffE0DED5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        profileButton("Username", Icons.abc,
                            ChangeUsernamePage()),
                        const SizedBox(height: 15),
                        profileButton("Password", Icons.lock, ChangePasswordPage()),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffE0DED5),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.logout,
                                  color: Color(0xff545454),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Sign Out",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff333333),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            onPressed: () {
                              auth.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffE0DED5),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.delete,
                                  color: Color(0xff545454),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Delete Account",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff333333),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            onPressed: () {
                              auth.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage("asset/images/profile image.jpg"),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox profileButton(
      String buttonName, IconData buttonIcon, Widget navigationScreen) {
    return SizedBox(
      width: 350,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffE0DED5),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Row(children: [
            Icon(
              buttonIcon,
              color: const Color(0xff545454),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              buttonName,
              style: GoogleFonts.poppins(
                  color: const Color(0xff333333),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ]),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => navigationScreen));
          }),
    );
  }
}
