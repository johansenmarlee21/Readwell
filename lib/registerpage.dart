// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final _firebase = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});



  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerEmail = TextEditingController(text: "");
  TextEditingController controllerPassword = TextEditingController(text: "");
  TextEditingController controllereFullName = TextEditingController(text: "");

  var _isLogin = false;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredFullName = '';
  var _isauthenticating = false;

  late bool _passwordVisible;

  final _form = GlobalKey<FormState>();
  void _submit() async {
    final isvalid = _form.currentState!.validate();

    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        _isauthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
              'username': _enteredFullName,
              'email': _enteredEmail,
              'password': _enteredPassword
            });
        
         Navigator.pop(context);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        ///
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? 'Authentication failed'),
      ));
    }
  }

  @override
    void initState() {
      super.initState();
      _passwordVisible = false;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff232229),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: const Image(
                        image: AssetImage("asset/images/readwellLogo.png")),
                  ),
                ),
                const SizedBox(height:40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Register',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    'Full Name',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: const Color(0xffD9D9D9),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                      validator: (value) {
                        if (value == null || value.trim().length < 3) {
                          return 'Full Name must be at least 3 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredFullName = value!;
                      },
                      obscureText: false,
                      //used when entering password
                      maxLength: 30, // or maxLines
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: controllereFullName),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    'Email',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: const Color(0xffD9D9D9),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                      },
                      onSaved: (value) {
                        _enteredEmail = value!;
                      },
                      obscureText: false,
                      //used when entering password
                      maxLength: 30, // or maxLines
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: controllerEmail),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    'Password',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: const Color(0xffD9D9D9),
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Colors.black38,
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                      obscureText: !_passwordVisible,
                      //used when entering password
                      maxLength: 30, // or maxLines
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: controllerPassword),
                ),
                const SizedBox(
                  height: 15,
                ),
                if(_isauthenticating)
                  const Center(child: CircularProgressIndicator()),
                if(!_isauthenticating)
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 360,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff605553),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        onPressed: () {
                          _submit();
                        },
                        child: Text(
                          'Create Account',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
