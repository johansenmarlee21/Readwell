import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final thisformKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController controllerPasswordOld = TextEditingController(text: "");
  TextEditingController controllerPasswordNew = TextEditingController(text: "");
  bool _passwordVisibleOld = false;
  bool _passwordVisibleNew = false;
  String newContent = "";
  String userPassword = "";
  var _enteredPassword = '';

  void getCurrentUserPassword() async{
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    setState(() {
      userPassword = userData.data()!['password'];
    });
  }

  void changeData() async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'password': newContent});
  }

  void _press() async{
    final isvalid = thisformKey.currentState!.validate();
    if(!isvalid){
      return;
    }
    thisformKey.currentState!.save();
    try{
      if(_enteredPassword == userPassword){
        print(newContent);
        thisformKey.currentState!.save();
        changeData();
        user.updatePassword(newContent);
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch(error){
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? 'Authentication failed'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisibleOld = false;
    _passwordVisibleNew = false;
    getCurrentUserPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0DED5),
      appBar: AppBar(
        backgroundColor: const Color(0xffE0DED5),
        elevation: 0,
        title: Text(
          "Change Password",
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
        child: SingleChildScrollView(
          child: Form(
            key: thisformKey,
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
                        Text(
                          "Please insert your old password.",
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: const Color(0xffD9D9D9),
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisibleOld = !_passwordVisibleOld;
                                  });
                                },
                                icon: Icon(_passwordVisibleOld
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                color: Colors.black38,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              } 
                              if(value != userPassword){
                                return 'Password doesn\'t match old password.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                            obscureText: !_passwordVisibleOld,
                            //used when entering password
                            maxLength: 30, // or maxLines
                            onChanged: (value) {
                              setState(() {});
                            },
                            controller: controllerPasswordOld,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Please insert a new password.",
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
                          child: TextFormField(
                            decoration: InputDecoration(
                                fillColor: const Color(0xffD9D9D9),
                                filled: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisibleNew = !_passwordVisibleNew;
                                    });
                                  },
                                  icon: Icon(_passwordVisibleNew
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                      color: Colors.black38,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              } 
                              if (value == userPassword){
                                return 'New password must not be similar to old password';
                              }
                              return null;
                            },
                            onSaved: (newValue) { 
                              newContent = newValue!;
                            },
                            obscureText: !_passwordVisibleNew,
                            //used when entering password
                            maxLength: 30, // or maxLines
                            onChanged: (value) {
                              setState(() {});
                            },
                            controller: controllerPasswordNew,
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
                              onPressed: 
                              // () {
                              //   print("password: , $newContent");
                              //   if (thisformKey.currentState!.validate()) {
                              //     thisformKey.currentState!.save();
                              //     changeData();
                              //     user.updatePassword(newContent);
                              //     Navigator.pop(context);
                              //   }
                              // },
                              _press,
                              child: Text(
                                'Create Account',
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
