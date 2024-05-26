import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:readwell_app/registerpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readwell_app/splash.dart';

// void googleLogin() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) {
//         // The user canceled the sign-in
//         return;
//       }

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await _auth.signInWithCredential(credential);
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const Splash(),
//           ));
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(error.toString()),
//       ));
//     }
//   }

final _firebase = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController(text: "");
  TextEditingController controllerPassword = TextEditingController(text: "");
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  bool _passwordVisible = false;
  var _isauthenticating = false;

  final _form = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  
  var widgetChild;
  
  

  // void googleLogin() async {
  //   String userName = "";
  //   String userEmail = "";
  //   GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
  //   await _auth.signInWithProvider(_googleAuthProvider);

  //   //shorten the _auth.currentUser! syntax
  // }
  void googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Splash(),
          ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    }
  }

  void _submit() async {
    final isvalid = _form.currentState!.validate();
    print("kontHFVBSDIFVBPIDSBJLHSF : $_isLogin:");
    if (!isvalid) {
      print("kontHFVBSDIFVBPIDSBJLHSF - !isvalid");
      return;
    }
    _form.currentState!.save();
    try {
      print("kontHFVBSDIFVBPIDSBJLHSF - try");
      setState(() {
        _isauthenticating = true;
        print("kontHFVBSDIFVBPIDSBJLHSF - isauth true");
      });
      if (_isLogin) {
        print("kontHFVBSDIFVBPIDSBJLHSF - enter isLogin");
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print("kontHFVBSDIFVBPIDSBJLHSF - past userCred");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Splash(),
            ));
      } else {
        print("kontHFVBSDIFVBPIDSBJLHSF - else");
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      }
    } on FirebaseAuthException catch (error) {
      print("kontHFVBSDIFVBPIDSBJLHSF - catch error");
      if (error.code == 'email-already-in-use') {
        print("kontHFVBSDIFVBPIDSBJLHSF - email in use");
        ///
      }
      
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? 'Authentication failed'),
      ));
      setState(() {
        _isauthenticating = false;
      });
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
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      child: Text(
                        'Register',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    'Email',
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
                    keyboardType: TextInputType.emailAddress,
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
                    controller: controllerEmail,
                  ),
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
                          borderRadius: BorderRadius.circular(25),
                        ),
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
                  height: 30,
                ),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 360,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          print("button pressed");
                          // add sign in with google here
                          googleLogin();
                        },
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage('asset/images/LogoGoogle.png'),
                            ),
                            const SizedBox(
                              width: 65,
                            ),
                            Text(
                              'Log In with Google',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                if(_isauthenticating)
                  const Center(child: CircularProgressIndicator()),
                if(!_isauthenticating)
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 360,
                      child: 
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff605553),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: () {
                            _submit();
                          },
                          child: 
                          
                          Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )
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

  // void loadingButton(bool isauthenticating , child ) {

  // }

}
