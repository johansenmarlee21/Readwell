
import 'package:flutter/material.dart';
import 'package:readwell_app/favoritepage.dart';
import 'package:readwell_app/homepage.dart';
import 'package:readwell_app/profilepage.dart';

class navbarall extends StatefulWidget {
  const navbarall({super.key});

  @override
  State<navbarall> createState() => _navbarallState();
}

class _navbarallState extends State<navbarall> {

  var current_index = 0;

  Widget? current_screen;

  void checkSection(){
    setState(() {
      if(current_index == 0){
        current_screen = HomePage();
      }
      else if(current_index == 2){
        current_screen = ProfilePage();
      }
      else if(current_index == 1){
        current_screen = FavoritePage();
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    checkSection();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color(0xffE0DED5),
        elevation: 0,
        title: const Center(
            child: Image(
                image: AssetImage('asset/images/readwell-high-resolution-logo.png'),
                width: 500,
                height: 65)),
        leading: null,
        automaticallyImplyLeading: false,
      ),

      body: current_screen,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xffE0DED5),
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0xff605553),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
        currentIndex: current_index,
        onTap: (value){
          setState(() {
            current_index = value;
            checkSection();
          });
        },
      ),
    );
  }
}